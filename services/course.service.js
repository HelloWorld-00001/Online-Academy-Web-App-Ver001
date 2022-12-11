import db from '../utils/db.js';

export default {
    async findTop10MostViewCourse() {
        const sql = `select * from khoahoc
                     ORDER BY LuotXem DESC`;
        const ret = await db.raw(sql);
        const result = ret[0];
        const temp1 = [];
        const temp2 = [];
        const temp3 = [];
        const temp4 = [];
        const res = [];
        for (let i = 1; i <= 10; i++) {
            if (i < 4)
                temp1.push(result[i]);
            if (i >=4 && i < 7)
                temp2.push(result[i]);
            if (i >= 7 && i < 10)
                temp3.push(result[i]);
            if (i == 10)
                temp4.push(result[i]);
        }
        res.push(temp1);
        res.push(temp2);
        res.push(temp3);
        res.push(temp4);
        return res;
    }
}