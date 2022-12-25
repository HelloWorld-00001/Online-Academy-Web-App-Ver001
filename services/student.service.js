import db from '../utils/db.js';

export default {
    async findByIDAccount(idAccount) {
        const student = await db('HocVien').where('MaTaiKhoan', idAccount);
        if(student.length === 0) 
            return null;
        return student[0];
    }
}