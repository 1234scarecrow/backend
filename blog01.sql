-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2020-03-29 15:53:05
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
(1, 'git学习遇到的一些问题', '关于ssh和https的提交方式，原来可以这么做', '2020-2-02'),
(2, '带session的cors设置', '改这里，改那里', '2020-2-02');

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
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `collect`
--
ALTER TABLE `collect`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `nid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
