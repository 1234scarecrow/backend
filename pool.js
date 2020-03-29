/* MySQL 数据库连接池 */
const mysql = require('mysql')

// 创建连接池
let pool = mysql.createPool({
  host: '45.76.151.126',
  port: '3306',
  user: 'root',
  pwd: 'root',
  database: 'blog',
  connectionLimit: 5
})

// 当前模块中导出连接池
module.exports = pool
