import db from '../utils/db.js';

export default {
    async countAll(table){
        return db(table).count('*');
    }
}