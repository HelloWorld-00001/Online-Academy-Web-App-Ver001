import express from 'express';
import passport from 'passport';
import fbStrategy from 'passport-facebook';
import ggStrategy from 'passport-google-oauth2';
import db from '../utils/db.js';
import accountService from '../services/account.service.js';

const router = express.Router();

const FacebookStrategy = fbStrategy.Strategy;
passport.serializeUser(function(user, done) {
    done(null, user);
  });
  
passport.deserializeUser(function(obj, done) {
    done(null, obj);
});

passport.use(new FacebookStrategy({
    clientID: '1340924226692802',
    clientSecret: 'ced77a3d68f12ff78ed7516d57d60838',
    callbackURL: 'http://localhost:3000/auth/facebook/callback',
    profileFields: ['email', 'displayName']
  }, function (accessToken, refreshToken, profile, done) {
    return done(null, profile);
  }
));

router.get('/facebook', passport.authenticate('facebook', {
    scope: ['public_profile', 'email']
}));

router.get('/facebook/callback',
  passport.authenticate('facebook', {
      successRedirect: '/auth/profile/facebook',
      failureRedirect: '/'
  })
);

router.get('/profile/facebook', async function (req, res) {
    const NewUser = {
        Username: req.user.id,
        Password: '',
        Name: req.user.displayName,
        DOB: '',
        Email: req.user._json.email,
        LoaiTaiKhoan: 'Học Viên'
    }
    const check = await accountService.findByUsername(req.user.id);

    if(check === null)
        db('TaiKhoan').insert(NewUser);
    
    req.session.auth = true;
    req.session.authUser = NewUser;
    res.locals.auth = true;
    res.locals.authUser = NewUser;

    res.redirect('/account/profile');
});

const GoogleStrategy = ggStrategy.Strategy;
passport.use(new GoogleStrategy({
    clientID:"537127959178-7pe55mt6bp9qd5vp6rqv8tr0hgbcipdm.apps.googleusercontent.com", // Your Credentials here.
    clientSecret:"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", // Your Credentials here.
    callbackURL:"http://localhost:3000/auth/google/callback",
    passReqToCallback:true
  },
  function(request, accessToken, refreshToken, profile, done) {
    console.log(profile);
    return done(null, profile);
  }
));

router.get('/google', passport.authenticate('google', {
    scope: ['profile', 'email']
}));
router.get('/google/callback',
  passport.authenticate('google', {
      successRedirect: '/auth/profile/google',
      failureRedirect: '/'
  })
);

router.get('/profile/google', async function (req, res) {
    const NewUser = {
        Username: req.user.id,
        Password: '',
        Name: req.user.displayName,
        DOB: req.user.birthday,
        Email: req.user.email,
        LoaiTaiKhoan: 'Học Viên'
    }
    const check = await accountService.findByUsername(req.user.id);
    if(check === null)
        await db('TaiKhoan').insert(NewUser);
    
    req.session.auth = true;
    req.session.authUser = NewUser;
    res.locals.auth = true;
    res.locals.authUser = NewUser;

    res.redirect('/account/profile');
});
export default router;