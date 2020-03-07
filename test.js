/* 测试数据库连接池 */

const pool = require('./pool')
// console.log(pool)

pool.query('select * from collect', (err, result) => {
  if (err) throw err
  console.log(result)
})