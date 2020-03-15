1. 创建项目目录backend

2. 创建Node.js的项目配置文件
    `npm init`
    设置:
    ```
    package name: (backend) xfblog  // 打包名
    version: (1.0.0)  // 版本号
    description: blog backend  // 项目描述
    entry point: (index.js)  // 入口文件
    test command: node test.js  // 测试文件
    git repository: https://github.com/1234scarecrow/.github.io  // 项目仓库
    keywords: backend, blog, api, nodejs, express  // 关键词
    ```

3. code打开项目文件夹, package.json中添加启动命令:
    ```json
    "scripts": {
      "...":"...",
      "start": "node index.js"  // 项目启动文件, npm start 可以直接启动项目
    },
    ```

    新建 `index.js` `test.js`

    **新浪云服务器运行 Node.js 使用的命令： npm i && npm start**
    所以一定要在 package.json 写明第三方模块的依赖关系:
    
    ```json
    {
        
      "dependencies": {
        "body-parser": "^1.19.0",
        "cors": "^2.8.5",
        "errorhandler": "^1.5.1",
        "express": "^4.17.1",
        "express-session": "^1.17.0",
        "mysql": "^2.18.1"
      }
    }
    ```
    
4. 安装必需的第三方模块
    `npm i mysql`
    `npm i express`
    `npm i body-parser`
    `npm i cors`
    `npm i errorhandler`
    `npm i express-session`
    
5. 编写数据库连接池模块

    ```js
    /* MySQL 数据库连接池 */
    const mysql = require('mysql')
    
    // 创建连接池
    let pool = mysql.createPool({
      host: '127.0.0.1',
      port: '3306',
      user: 'root',
      pwd: '',
      database: 'blog',
      connectionLimit: 5
    })
    
    // 当前模块中导出连接池
    module.exports = pool
    ```

    测试(test.js):

    ```js
    const pool = require('./pool')
    
    pool.query('select * from collect', (err, result) => {
      if (err) throw err
      console.log(result)
    })
    ```

6. 编写应用程序的入口模块

    ```js
    /* 入口模块 */
    const express=require('express')
    const cors=require('cors')
    const bodyParser=require('body-parser')
    const session=require('express-session')
    const errorHandler=require('errorhandler')
    const pool=require('./pool')
    // let router=express.Router()
    // module.exports = router
    
    // web服务器监听的端口
    let port =8080;
    let app=express();
    app.listen(port,()=>{
      console.log('Server Listrening on port '+port)
    });
    
    // 添加请求处理中间件
    // 1. 使用cors中间件 所有的响应消息都添加头部 access-control-allow-origin
    app.use(cors());
    
    // 2. 使用 session 中间件, 所有响应消息中都会有 Cookie 头部: connect-sid
    app.use(session({
      secret:'zxfblog',  // 使用此密钥对 session-id 进行加密
      saveUninitialized: true,  // 是否保存从未初始化过的 session 数据
      resave: false  // 是否自动存储所有的会话, 即使没有更新
    }))
    
    // 3. 使用body-parser中间件, 使服务器端获得请求消息主题数据被解析到req.body
    app.use(bodyParser.urlencoded({
      extended:false  // 不适用第三方扩展工具解析请求主体(Node.js 自带即可)
    }))
    ```

7. 编写路由(index.js)

   ```js
   // 创建处理各种请求的路由(API比较少, 不需要路由器)
   // 收藏
   app.get('/collect',(req,res,next)=>{
     let output={};
     let sql='SELECT cid,title,curl,intr FROM collect';
     pool.query(sql,(err,result)=>{
       console.log("调用了 /collect");
       if(err)next(err);
       output.code=200;
       output.msg="query collect success";
       output.data=result;
       res.send(output);
     })
   })
   
   // 笔记
   app.get('/note',(req,res,next)=>{
     let output={};
     let sql='SELECT nid,title,content,pub_time FROM note';
     pool.query(sql,(err,result)=>{
       console.log("调用了 /note");
       if(err) next(err);
       output.code=200;
       output.msg='query note sucess';
       output.data=result;
       res.send(output);
     })
   })
   
   // 随笔
   app.get('/jotting',(req,res,next)=>{
     let output={};
     let sql='SELECT nid,title,content,pub_time FROM jotting';
     pool.query(sql,(err,result)=>{
       console.log("调用了 /jotting");
       if(err) next(err);
       output.code=200;
       output.msg='query jotting sucess';
       output.data=result;
       res.send(output);
     })
   })
   
   // 心情
   app.get('/mood',(req,res,next)=>{
     let output={};
     let sql='SELECT mid,content,mdate FROM mood';
     pool.query(sql,(err,result)=>{
       console.log("调用了 /mood");
       if(err) next(err);
       output.code=200;
       output.msg='query mood sucess';
       output.data=result;
       res.send(output);
     })
   })
   ```

   

浏览器访问: http://127.0.0.1:8080/note

![响应结果](https://s2.ax1x.com/2020/03/06/3OS8QU.png)