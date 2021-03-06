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
let port = 8081;
let app = express();
app.listen(port, () => {
  console.log('Server Listrening on port ' + port)
});

// 添加请求处理中间件
// 1. 使用cors中间件 所有的响应消息都添加头部 access-control-allow-origin
app.use(cors({
  origin: ['http://127.0.0.1:8080', 'http://192.168.31.200:8080', "http://www.zxfei.info:8080", "http://45.76.151.126:8080"],
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

// 云主机测试接口
app.get('/test', (req, res, next) => {
  let output = {};
  output.code = 200;
  output.msg = "连接成功, 鼓掌!!";
  res.send(output);
})

/**
 * 展示类get请求接口
 */

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
    console.log("拿到的数据")
    console.log(result)
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
    output.msg = 'query mood sucsess';
    output.data = result;
    res.send(output);
  })
})

// 查询笔记
app.get('/note/:id', (req, res, next) => {
  console.log('查询笔记内容');
  let id = req.params.id;
  let output = {};
  let sql = 'SELECT * FROM note WHERE nid=?'
  pool.query(sql, [id], (err, result) => {
    if (err) next(err);
    output.code = 200;
    output.msg = 'query note success'
    output.data = result[0]
    res.send(output)
  })
})

// 查询随笔
app.get('/jotting/:id', (req, res, next) => {
  console.log('查询随笔内容')
  let id = req.params.id;
  let output = {};
  let sql = "SELECT * FROM jotting WHERE jid=?";
  pool.query(sql, [id], (err, result) => {
    if (err) next(err);
    output.code = 200;
    output.msg = 'query jotting success';
    output.data = result[0];
    res.send(output)
  })
})

/**
 * 新增类post请求, 新增笔记 / 加收藏 / 写心情等
 */

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

// 写随笔的post请求
app.post('/addjotting', (req, res, next) => {
  let output = {}
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
    output.msg = 'pubtime required';
    res.send(output);
    return;
  }
  let sql = "INSERT INTO jotting VALUES(NULL,?,?,?)";
  pool.query(sql, [title, content, pub_time], (err, result) => {
    if (err) next(err);
    if (result.affectedRows > 0) {
      output.code = 200;
      output.msg = 'add note success'
      res.send(output);
      return;
    }
  })
})

//写心情的post请求
app.post('/addmood', (req, res, next) => {
  let output = {};
  let content = req.body.content;
  // console.log(req)
  console.log(req.body.content);
  console.log(req.body.mdate);
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

// 添加收藏的post请求
app.post('/addcollect', (req, res, next) => {
  let output = {}
  let title = req.body.title;
  console.log(req.body.title);
  if (!title) {
    output.code = 401;
    output.msg = 'title required';
    res.send(output);
    return
  }
  let curl = req.body.curl;
  let intr = req.body.intr;
  let sql = 'INSERT INTO collect Values(NULL,?,?,?)';
  pool.query(sql, [title, curl, intr], (err, result) => {
    if (err) next(err);
    if (result.affectedRows > 0) {
      output.code = 200;
      output.msg = 'add collect success';
      res.send(output);
      return;
    }
  })

})

/**
 * 登录(只有一个用户)
 */

app.get('/login',(req,res,next)=>{
  console.log('调用了登录接口')
  
  let output={}
  let uname=req.query.uname;
  console.log(uname)
  let email=req.query.email;
  console.log(email)
  let upwd=req.query.upwd;
  console.log(upwd);
  // 测试
  // output.code=200;
  // output.msg="登陆成功";
  // res.send(output);


  // 验证是否填写用户名或邮箱
  
  // if(!uname && !upwd){
  //   output.code=401;
  //   output.msg='uname or email required';
  //   console.log(output);
  //   res.send(output);
  //   return;
  // }

  // if(!upwd){
  //   output.code=402;
  //   output.msg='upwd required';
  //   console.log(output);
  //   res.send(output);
  //   return;
  // }
  let sql='SELECT * FROM user WHERE upwd=?';
  pool.query(sql,[upwd],(err,result)=>{
    console.log("连接数据库");
    if(err){
      next (err)
      console.log(err);
    };
    if(result.length>0){
      console.log("查到数据")
      output.code=200;
      output.msg='login success';
      output.data=result;
      console.log(output);
      res.send(output)
    }
  })
})
