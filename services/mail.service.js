import nodemailer from 'nodemailer';
import hbs from 'nodemailer-express-handlebars';
import path from 'path';
import emailValidator from 'deep-email-validator';

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'khongtontai231@gmail.com',			//email ID
        pass: 'bowprpfhvoxswtzp'				//Password 
    }
});

const handlebarOptions = {
    viewEngine: {
        extname: '.hbs',
        partialsDir: path.resolve('./views/vwAccount/'),
        defaultLayout: false
    },
    viewPath: path.resolve('./views/vwAccount/'),
    extName: '.hbs'
};

transporter.use('compile', hbs(handlebarOptions));

export default {
    sendMail(email , otp){
        const details = {
            from: ' "IGE Online Course" <khongtontai231@gmail.com>', // sender address same as above
            to: email, 					// Receiver's email id
            subject: 'Code OTP', // Subject of the mail.
            template: 'email',
            context: {
                otp: otp,
                email: email
            }
        };
        transporter.sendMail(details, function (error, data) {
            if(error)
                console.log(error);
            // else
                // console.log(data);
        });
    },  

    async isEmailValid(email) {
        return await emailValidator.validate(email);
    }
}