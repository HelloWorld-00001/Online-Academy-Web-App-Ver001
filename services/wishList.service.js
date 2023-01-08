import db from '../utils/db.js';

export default {
    async getWishList() {
        return  db('wishlist');
    },
 
    del(id, user) {
        return  db('wishlist').where({
            MaKhoaHoc: id,
            Username: user
        }).del();
    },

    add(wl) {
        return db('wishList').insert({
            MaKhoaHoc: wl.MaKhoaHoc, Username: wl.Username
        });
    }
}