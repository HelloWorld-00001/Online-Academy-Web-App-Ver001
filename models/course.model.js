import db from '../utils/db.js'

// knex cheetsheet : web xem 1 so syntax trut gon
export default {
    findByName(name) {

        return name;
    },

    findAll() {
        return db('Khoahoc')
    },

    async countCourseAll() {
        const list = await db('Khoahoc')
            .count({amount : 'MaKhoaHoc'});
        return list[0].amount;
    },

    async countField() {
        const list = await db('Khoahoc')
            .countDistinct({amount : 'LinhVuc'});
        return list[0].amount;
    },

    async countByField(linhVuc) {
        const list = await db('Khoahoc')
            .where('LinhVuc', linhVuc)
            .count({amount : 'MaKhoaHoc'});
        return list[0].amount;
    },

    findPageCourseAll(limit, offset) {
        return db('Khoahoc')
            .limit(limit)
            .offset(offset);
    },

    findPageByField(linhVuc, limit, offset) {
        return db('Khoahoc')
            .where('LinhVuc', linhVuc)
            .limit(limit)
            .offset(offset);
    },
}