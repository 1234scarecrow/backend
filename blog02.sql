-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2020-04-20 04:20:09
-- 服务器版本： 10.1.28-MariaDB
-- PHP Version: 5.6.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- 表的结构 `collect`
--

CREATE TABLE `collect` (
  `cid` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `curl` varchar(128) DEFAULT NULL,
  `intr` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `collect`
--

INSERT INTO `collect` (`cid`, `title`, `curl`, `intr`) VALUES
(1, 'Git教程', 'https://www.liaoxuefeng.com/wiki/896043488029600', '史上最浅显易懂的Git教程!'),
(2, 'vue项目开发流程', 'https://www.jianshu.com/p/0ae3e3bb3082', '来自简书收藏,使用 vue-cli 快速构建项目!'),
(3, 'ECMAScript 6 入门', 'https://es6.ruanyifeng.com/', '是一本开源的 JavaScript 语言教程, 全面介绍 ECMAScript 6 新引入的语法特性 阮一峰');

-- --------------------------------------------------------

--
-- 表的结构 `jotting`
--

CREATE TABLE `jotting` (
  `jid` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `pub_time` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `jotting`
--

INSERT INTO `jotting` (`jid`, `title`, `content`, `pub_time`) VALUES
(1, '属于自己的2㎡', 'LoremLoremLoremLoremLoremLoremLoremLoremLorem', '2020-2-02');

-- --------------------------------------------------------

--
-- 表的结构 `mood`
--

CREATE TABLE `mood` (
  `mid` int(11) NOT NULL,
  `content` varchar(32) DEFAULT NULL,
  `mdate` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `mood`
--

INSERT INTO `mood` (`mid`, `content`, `mdate`) VALUES
(1, '下班好晚，回去做宵夜吃', '2020-2-22'),
(2, '明天休息，做好吃的', '2020-2-22'),
(9, '哈哈哈哈哈哈哈哈', '2020/3/26'),
(10, '哈哈哈哈哈哈哈哈', '2020/3/26');

-- --------------------------------------------------------

--
-- 表的结构 `note`
--

CREATE TABLE `note` (
  `nid` int(11) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `content` varchar(4096) DEFAULT NULL,
  `pub_time` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `note`
--

INSERT INTO `note` (`nid`, `title`, `content`, `pub_time`) VALUES
(1, 'ajax 跨域问题', '1.客户端向前端服务器发送 `get` 请求;\n\n2.前端服务器向客户端返回 `html` 页面;\n\n3.前端服务器返回的 `html` 页面里, 发了一个异步请求:\n   `this.$http.get(\'http://127.0.0.1:8080/list\').then(res=&gt;{console.log(res)})`\n   相当于一台服务器想访问另一台服务器的数据;\n\n4.后端服务器响应了一条消息: `get/list`\n   响应消息里必须有一项内容:\n   `Access-Control-Allow-Origin: * ` 访问控制来源: `*`\n   如果没有的话, 客户端会认为该资源有安全风险, 不允许使用.\n   访问控制来源为 `*` 相当于允许客户端使用这条响应.\n\n   同时, 因为这是客户端第一次访问服务器, 所以服务器还会做一个设定:\n   `Set-Cookie: connect.sid=...xxyy`\n\n5.接下来, 如果客户端再向后端服务器发送一个请求, `get/cart`\n   就要提供:\n     `Cookie: connect.sid=...xxyy`\n   同时, xhr对象要写:\n     `xhr.withCredentials=true`\n   这时, 这个异步请求就会携带有cookie了\n\n   如果不带cookie, 后端服务器会认为客户端是新来的, 重新给一个connect.sid\n\n**设置 `xhr.withCredentials=true` 后会报错**:\n`Access to XMLHttpRequest at \'http://127.0.0.1:8080/list\' from origin \'http://localhost:8081\' has been blocked by CORS policy: The value of the \'Access-Control-Allow-Origin\' header in the response must not be the wildcard \'*\' when the request\'s credentials mode is \'include\'. The credentials mode of requests initiated by the XMLHttpRequest is controlled by the withCredentials attribute.`\n\n意思是只要客户端提交了身份认证信息, 服务器响应消息中允许的来源就不能是 `*`\n所以需要设置:\n`Access-Control-Allow-Origin: http://127.0.0.1:8081 `\n后台代码:\n\n```js\napp.use(cors({\n	// 如果客户端请求携带了身份认证信息, 此处就不能设置为 * , 要写成前端子系统的域名信息\n	origin: [\'http://127.0.0.1:8081\']\n}))\n```\n\n另外, 响应消息里还必须包括:\n`Access-Control-Allow-Credentials: true `\n后台代码:\n\n```js\napp.use(cors({\n	origin: [\'http://127.0.0.1:8081\'],\n  	credentials:true  // 允许客户端请求携带身份认证信息\n}))\n```\n\n这时前后端分离就完成了\n![跨域](https://s2.ax1x.com/2020/03/05/3HWdRU.png)\n\n**面试题:**\n什么是 HTTP 简单请求和复杂请求?\n复杂请求需要必需的\"预取请求(Pre-flight Request)\"是什么意思?\n\n参考: [express中间件cors](', '2020/4/8'),
(2, 'Ubuntu 云主机安装 Nodejs', '昨晚刚斥巨资买了服务器，安装 Node.js 就踩了坑, 趁还没忘干净, 赶紧记下来\n\n##### 1. 安装 Node.js\n\n```\nsudo apt-get install nodejs\nnode -v  //查看node版本号\n```\n\n##### 2. 安装 NPM\n\n```\nsudo apt-get install npm \n```\n\n这里会有报错, 需要通过命令让 node 与 nodejs 建立软连接:\n\n```\nsidp ln -s /usr/bin/nodejs /usr/bin/node\n```\n\n然后重新安装 NPM 就哦可了, 使用 `npm -v` 就可以查看到 npm 版本号\n\n然后在网上看到有第二个坑: 用n升级node版本 `npm install -g n`, 是升级不了的.\n\n暂时还没遇到, 遇到再说.', '2020/4/8'),
(3, 'GitHub的两种上传方式', '\n##### 众所周知, GitHub 有两种上传代码的方式, 而我是个例外, 只知道一个 `git clone https://github.com/1234scarecrow/backend.git `\n\n##### 从来没注意过这儿: \n\n![use ssh](https://s2.ax1x.com/2020/03/07/3jR7rT.png)\n\n##### 刚才看了看, 略有研究, 记点笔记~\n\n---\n\n**1. 两种方式的 URL 对比:**\n\n+ https: `https://github.com/1234scarecrow/backend.git`\n\n+ ssh: `git@github.com:1234scarecrow/backend.git`\n\n**2. 代码提交方式对比:**\n\n+ https: \n\n  1. 首先 `git clone https://github.com/xxx/xxx.git`\n  2. 提交更改 `git add xxx` `git commit -m \"message\"` `git push`\n\n+ ssh:\n\n  ```bash\n  git init  // 初始化仓库\n  git remote add origin git@github.com:xxx/xxx.git  // 连接远程仓库\n  git pull --rebase origin master  // 拉取远程仓库\n  git add .  // 将本地仓库所有的文件都添加到版本控制库中\n  git commit -m \"add files\"  // 提交\n  git push -u origin master  // 推送到远程的master分支(首次)\n  git push  /推送(以后)\n  ```\n\n**ssh 方式:** 相当于一个许可, 每台电脑的许可都是固定的. 如果想往其他账户的仓库上传代码, 就需要在该账户下配置自己的ssh(获得该仓库允许)\n\nssh 方式必需添加本机的 ssh 才行\n\n[如何配置 ssh](https://www.jianshu.com/p/cb85ab83ade1)(可以不设置密码, 即密码为空直接回车)', '2020/4/8'),
(4, 'markdown 语法', 'Markdown 是一种纯文本格式的标记语言, 通过简单的标记语法, 让普通文本具有一定格式\n#### 1. 标题\n在想要设置为标题的文本前面加 # 表示\n一级标题: #\n二级标题: ##\n三级标题: ###\n四级标题: ####\n五级标题: #####\n六级标题: ######\n\n示例:\n```\n# 这是一级标题\n## 这是二级标题\n### 这是三级标题\n#### 这是四级标题\n##### 这是五级标题\n###### 这是六级标题\n```\n显示效果:\n# 这是一级标题\n## 这是二级标题\n### 这是三级标题\n#### 这是四级标题\n##### 这是五级标题\n###### 这是六级标题\n\n#### 2. 字体\n`*加粗*` **加粗**\n`*斜体*` *斜体*\n`***斜体加粗***` ***斜体加粗***\n`~~删除线~~` ~~删除线~~\n#### 3. 引用\n在引用的文字前加 &gt; (可以嵌套, 比如&gt;&gt;)\n', '2020/4/13'),
(5, 'RESTful API', '**RESTful API:** Representational State Transfer（表象层状态转变）\n这三个单词, 可以从以下几个方面理解: \n1. 每个URL代表一种资源\n2. 客户端和服务器之间, 传递这种资源的某种表现层\n3. 客户端通过四个HTTP动词, 对服务器端资源进行操作, 实现\"表现层状态转化\"\n\n#### RESTful6大原则\n##### 1. C-S架构\n数据存储在服务端, 客户端只使用, 两端彻底分离, 单独开发, 互不干扰\n##### 2. 无状态\nHTTP请求本身就是无状态的, 客户端每一次请求都带有充分的信息能够让服务端识别. 请求所需的一些信息都包含在URL的查询参数,header,div, 服务端能够根据请求的各种参数, 无需保存客户端的状态, 将相应正确返回给客户端. 提高了服务端的健壮性和可扩展性.\n缺点: 每次请求都要带上相同的信息确定自己的身份和状态, 造成传输数据的冗余(但实际对性能几乎无影响)\n##### 3. 统一的接口\nREST接口约束定义为: \n资源识别;\n请求动作;\n相应信息;\n通过uri标识出要操作的资源, 通过请求动作标识要执行的操作, 通过返回的状态码来表示这次请求的执行结果.\n##### 4. 一致的数据格式\n服务端返回的数据格式要么是XML, 要么是Json, 或者直接返回状态码.\n比如请求一条微博信息, 服务端响应信息应该包含这条微博相关的其他URL, 客户端可以进一步利用这些URL发起请求获取感兴趣的信息. 再如分页...\n##### 5. 可缓存\n响应都应隐式或显式的定义为可缓存的, 若不可缓存则要避免客户端在多次请求后用旧数据或脏数据来响应. 管理得当的缓存会部分或完全的去除客户端和服务端之间的交互, 进一步改善性能和延展性.\n##### 6. 按需编码, 可定制代码\n服务端可选择临时给客户端下发一些功能性代码让客户端来执行, 实现某些特定的功能.\n提示: REST架构中的设计准则中, 只有按需编码为可选项. 如果某个服务违反了其他任意一项准则, 严格意义上不能称之为RESTful风格.\n\n#### 最佳示例\n\n##### 1. 版本控制\n如github开放平台的API: http://developer.github.com/v3/ 可以发现, 一般的项目加版本v1, v2, v3版本号, 为的是兼容一些老版本的接口, 这个加版本估计只有大公司大项目才会去使用.\n##### 2. 参数命名规范\n可采用1驼峰命名法, 也可以采用下划线命名的方式.\n```\nhttp://example.com/api/users/today_login 获取今天登陆的用户\nhttp://example.com/api/users/today_login&sort=login_desc 获取今天登陆的用户、登陆时间降序排列\n```\n##### 3. url命名规范\nAPI命名应该采用约定俗成的方式, 简洁明了.\n在RESRful架构中, 每个url代表一种资源,所以url中不能有动词, 只能有名词, 并且名词中也应该使用复数. 实现者使用相应的HTTP动词GET,POST,PUT,PATCH,DELETE,HEAD来操作这些资源即可.\n```\n不规范的:\nhttp://example.com/api/getallUsers      //GET 获取所有用户\nhttp://example.com/api/getuser/1        //GET 获取标识为1用户信息\nhttp://example.com/api/user/delete/1    //GET/POST 删除标识为1用户信息\nhttp://example.com/api/updateUser/1     //POST 更新标识为1用户信息\nhttp://example.com/api/User/add         //POST添加新的用户\n```\n规范后的RESTful风格的url，形式固定，可读性强，根据users名词和http动词就可以操作这些资源。\n```\nhttp://example.com/api/users           //GET 获取所有用户信息\nhttp://example.com/api/users/1         //GET 获取标识为1用户信息\nhttp://example.com/api/users/1         //DELETE 删除标识为1用户信息\nhttp://example.com/api/users/1         //Patch 更新标识为1用户部分信息,包含在div中\nhttp://example.com/api/users           //POST 添加新的用户\n```\n##### 4. 统一返回数据格式\n对于合法的请求应该返回统一的数据格式.\n对于返回数据, 通常包含如下字段:\n- code: 包含一个整数类型的HTTP状态响应码\n- status: 包含文本, \"success\", \"fail\", \"error\". HTTP状态响应码在500-599之间为\"fail\", 在400-499之间为\"error\", 其它均为\"success\"(例如:响应状态码为1XX,2XX和3XX).\n- message: 当状态值为\"fail\"和\"error\"时有效, 用于显示错误信息.\n- data: 包含相应的div, 当状态值为\"fail\"或\"error\"时, data仅包含错误原因或异常名称, 或者null也是可以的.\n\n例如, 返回成功的响应json格式:\n```\n{\n  \"code\": 200,\n  \"message\": \"success\",\n  \"data\": {\n    \"userName\": \"123456\",\n    \"age\": 16,\n    \"address\": \"beijing\"\n  }\n}\n```\n返回失败的响应json格式:\n```\n{\n  \"code\": 401,\n  \"message\": \"error  message\",\n  \"data\": null\n}\n```\n##### 5. http状态码\n`1xx` 请求未成功\n`2xx` 请求成功, 表示成功处理了请求的状态码\n`3xx` 请求被重定向, 表示要完成请求, 需要进一步操作. 通常吗这些状态代码用来重定向.\n`4xx` 请求错误, 这些状态代码表示请求可能出错, 妨碍了服务器的处理.\n`5xx` 服务器错误, 这些状态代码白哦是服务器在尝试处理请求时发生内部错误. 这些错误可能是服务器本身的错误, 而不是请求错误.\n##### 6. 合理使用query parameter\n在请求数据时, 客户端经常会对数据进行过滤和分页等要求, 而这些参数推荐采用HTTP Query Parameter的方式实现.\n```\n//比如设计一个最近登陆的所有用户\nhttp://example.com/api/users?recently_login_day=3\n\n//搜索用户，并按照注册时间降序\nhttp://example.com/api/users?recently_login_day=3\n\n//搜索用户，并按照注册时间升序、活跃度降序\nhttp://example.com/api/users?q=key&sort=create_title_asc,liveness_desc\n```\n##### 7. 多表/多参数连接查询设计URL\n实际的API常常会涉及到多表连接,多条件筛选,排序等.\n比如查询一个获取在六月份的订单中大于500元的且用户地址是北京, 用户年龄在22岁到40岁,购买金额降序排列的订单列表, 接口可能如下:\n```\nhttp://example.com/api/orders?order_month=6&order_amount_greater=500&address_city=北京&sort=order_amount_desc&age_min=22&age_max=40\n```\n从这个URL上看, 参数众多, 本身非常不容易维护, 明明看起来不是很容易, 不能太长, 也不能太随意.\n\n在.net WebAPI中, 我们可以使用属性路由, 属性路由就是将路由附加到特定的控制器或操作方法上装饰Controll及其使用[Route]属性, 一种定义路由的方法称为属性路由.\n\n这种好处就是可以精准地控制URL, 而不是基于约定的路由，简直就是为这种多表查询量身定制似的的.从webapi 2开发, 现在是RESTful API开发中最推荐的路由类型.\n```\n[Route(“api/orders/{address}/{month}”)]\n```\n而Action中的查询参数就只有金额,排序,年龄. 减少了查询参数,API的可读性和可维护行增强了.\n```\nhttp://example.com/api/orders/beijing/6?order_amount_greater=500&sort=order_amount_desc&age_min=22&age_max=40\n```\n( 摘抄自: 知乎文章《[你真的了解RESTful API吗?](https://zhuanlan.zhihu.com/p/91240556)》, 作者[向治洪](https://www.zhihu.com/people/xiang-zhi-hong-87), 感谢大佬!! )', '2020/4/17');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `uid` int(11) NOT NULL,
  `uname` varchar(32) DEFAULT NULL,
  `email` varchar(32) DEFAULT NULL,
  `upwd` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`uid`, `uname`, `email`, `upwd`) VALUES
(1, '1234scarecrow', 'zhao1178862608@163.com', '1178862608@qq');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `collect`
--
ALTER TABLE `collect`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `jotting`
--
ALTER TABLE `jotting`
  ADD PRIMARY KEY (`jid`);

--
-- Indexes for table `mood`
--
ALTER TABLE `mood`
  ADD PRIMARY KEY (`mid`);

--
-- Indexes for table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`nid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `collect`
--
ALTER TABLE `collect`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `jotting`
--
ALTER TABLE `jotting`
  MODIFY `jid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `mood`
--
ALTER TABLE `mood`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `note`
--
ALTER TABLE `note`
  MODIFY `nid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
