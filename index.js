/* 入口模块 */
const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')
const session = require('express-session')
const errorHandler = require('errorhandler')
const pool = require('./pool')
// let router=express.Router()
// module.exports = router

// web服务器监听的端口
let port = 8080;
let app = express();
app.listen(port, () => {
  console.log('Server Listrening on port ' + port)
});

// 添加请求处理中间件
// 1. 使用cors中间件 所有的响应消息都添加头部 access-control-allow-origin
app.use(cors({
  origin: ['http://127.0.0.1:8081', 'http://192.168.31.200:8081', "http://www.zxfei.info:8081"],
  credentials: true
}));

// 2. 使用 session 中间件, 所有响应消息中都会有 Cookie 头部: connect-sid
app.use(session({
  secret: 'zxfblog',  // 使用此密钥对 session-id 进行加密
  saveUninitialized: true,  // 是否保存从未初始化过的 session 数据
  resave: false  // 是否自动存储所有的会话, 即使没有更新
}))

// 3. 使用body-parser中间件, 使服务器端获得请求消息主题数据被解析到req.body
app.use(bodyParser.urlencoded({
  extended: false  // 不适用第三方扩展工具解析请求主体(Node.js 自带即可)
}))

// 创建处理各种get请求的路由(API比较少, 不需要路由器)
// 收藏
app.get('/collect', (req, res, next) => {
  let output = {};
  let sql = 'SELECT cid,title,curl,intr FROM collect';
  pool.query(sql, (err, result) => {
    console.log('调用了 /collect');
    if (err) next(err);
    output.code = 200;
    output.msg = 'query collect success';
    output.data = result;
    res.send(output);
  })
})

// 笔记
app.get('/note', (req, res, next) => {
  let output = {};
  let sql = 'SELECT nid,title,content,pub_time FROM note';
  pool.query(sql, (err, result) => {
    console.log('调用了 /note');
    if (err) next(err);
    output.code = 200;
    output.msg = 'query note sucess';
    output.data = result;
    res.send(output);
  })
})

// 随笔
app.get('/jotting', (req, res, next) => {
  let output = {};
  let sql = 'SELECT jid,title,content,pub_time FROM jotting';
  pool.query(sql, (err, result) => {
    console.log('调用了 /jotting');
    if (err) next(err);
    output.code = 200;
    output.msg = 'query jotting sucess';
    output.data = result;
    res.send(output);
  })
})

// 心情
app.get('/mood', (req, res, next) => {
  let output = {};
  let sql = 'SELECT mid,content,mdate FROM mood';
  pool.query(sql, (err, result) => {
    console.log('调用了 /mood');
    if (err) next(err);
    output.code = 200;
    output.msg = 'query mood sucess';
    output.data = result;
    res.send(output);
  })
})

// post请求, 主要是用来写笔记, 加收藏等功能
// 写笔记的post请求
app.post('/addnote', (req, res, next) => {
  let output = {};
  let title = req.body.title;
  if (!title) {
    output.code = 401;
    output.msg = 'title required';
    res.send(output);
    return;
  }
  let content = req.body.content;
  if (!content) {
    output.code = 402;
    output.msg = 'content required';
    res.send(output);
    return;
  }
  let pub_time = req.body.pub_time;
  if (!pub_time) {
    output.code = 403;
    output.msg = 'puttime required';
    res.send(output);
    return;
  }
  let sql = 'INSERT INTO note VALUES(NULL,?,?,?)';
  pool.query(sql, [title, content, pub_time], (err, result) => {
    if (err) next(err);
    if (result.affectedRows > 0) {
      output.code = 200;
      output.msg = 'add note success';
      res.send(output);
      return
    }
  })
})

//写心情的post请求
app.post('/addmood', (req, res, next) => {
  let output = {};
  let content = req.body.content;
  if (!content) {
    output.code = 401;
    output.msg = "content required";
    res.send(output);
    return;
  }
  let mdate = req.body.mdate;
  if (!mdate) {
    output.code = 402;
    output.msg = "mdate required";
    res.send(output);
    return;
  }
  let sql = 'INSERT INTO mood VALUES(NULL,?,?)';
  pool.query(sql, [content, mdate], (err, result) => {
    if (err) next(err);
    if (result.affectedRows > 0) {
      output.code = 200;
      output.msg = 'add mood success';
      res.send(output);
      return
    }
  })
})