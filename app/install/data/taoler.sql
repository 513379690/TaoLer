/*
Navicat MySQL Data Transfer

Source Server         : lc
Source Server Version : 50730
Source Host           : localhost:3306
Source Database       : taoler

Target Server Type    : MYSQL
Target Server Version : 50730
File Encoding         : 65001

Date: 2021-02-01 15:15:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tao_admin
-- ----------------------------
DROP TABLE IF EXISTS `tao_admin`;
CREATE TABLE `tao_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员账户',
  `nickname` varchar(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(30) NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0女1男',
  `status` enum('1','0') NOT NULL DEFAULT '0' COMMENT '1启用0禁用',
  `auth_group_id` smallint(1) NOT NULL DEFAULT '0' COMMENT '1超级管理员0是普通管理员',
  `remarks` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `last_login_ip` varchar(70) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '软删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_admin
-- ----------------------------
INSERT INTO `tao_admin` VALUES ('1', 'admin', '管理员', '95d6f8d0d0c3b45e5dbe4057da1b149e', 'taoler@qq.com', '13812345678', '1', '1', '1', '2019.1.1 新年发布新版本！', '127.0.0.1', '1612162986', '1579053025', '1578986600', '0');
INSERT INTO `tao_admin` VALUES ('2', 'test', '', '3dbfa76bd34a2a0274f5d52f5529ccb3', 'test@qq.com', '13567891236', '0', '0', '2', '', '127.0.0.1', '1578643147', '1555892325', '1576554415', '0');

-- ----------------------------
-- Table structure for tao_article
-- ----------------------------
DROP TABLE IF EXISTS `tao_article`;
CREATE TABLE `tao_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `status` enum('0','-1','1') NOT NULL DEFAULT '1' COMMENT '状态1显示0待审-1禁止',
  `cate_id` int(11) NOT NULL COMMENT '分类id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `is_top` enum('0','1') NOT NULL DEFAULT '0' COMMENT '置顶1否0',
  `is_hot` enum('0','1') NOT NULL DEFAULT '0' COMMENT '推荐1否0',
  `is_reply` enum('1','0') NOT NULL DEFAULT '1' COMMENT '0禁评1可评',
  `has_img` enum('1','0') NOT NULL DEFAULT '0' COMMENT '1有图0无图',
  `has_video` enum('1','0') NOT NULL DEFAULT '0' COMMENT '1有视频0无',
  `has_audio` enum('1','0') NOT NULL DEFAULT '0' COMMENT '1有音频0无',
  `pv` int(11) NOT NULL DEFAULT '0' COMMENT '浏览量',
  `jie` enum('1','0') NOT NULL DEFAULT '0' COMMENT '0未结1已结',
  `upzip` varchar(70) DEFAULT NULL COMMENT '文章附件',
  `downloads` int(5) NOT NULL DEFAULT '0' COMMENT '下载量',
  `tags` varchar(255) DEFAULT NULL COMMENT 'tag',
  `read_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '阅读权限0开放1回复可读2密码可读3私密',
  `art_pass` varchar(6) DEFAULT NULL COMMENT '文章加密密码',
  `title_color` varchar(10) DEFAULT NULL COMMENT '标题颜色',
  `title_font` varchar(20) DEFAULT NULL COMMENT '标题字形',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE COMMENT '文章的用户索引',
  KEY `cate_id` (`cate_id`) USING BTREE COMMENT '文章分类索引'
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_article
-- ----------------------------

-- ----------------------------
-- Table structure for tao_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `tao_auth_group`;
CREATE TABLE `tao_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '角色名称',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '拥有权限',
  `limits` varchar(255) NOT NULL DEFAULT '' COMMENT '权限范围',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT '权限描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色状态1可用0禁止',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_auth_group
-- ----------------------------
INSERT INTO `tao_auth_group` VALUES ('1', '超级管理员', '5,15,21,22,62,63,23,17,27,28,64,16,24,26,25,4,20,32,33,34,14,29,30,31,1,65,6,35,36,37,38,7,39,40,41,42,8,43,44,45,66,9,47,48,49,50,46,67,2,10,51,11,18,52,54,55,19,56,57,58,59,60,53,3,12,13', '管理所有的管理员', '所有权限', '1', '0', '1578984825', '0');
INSERT INTO `tao_auth_group` VALUES ('2', '管理员', '5,15,21,22,62,63,23,17,27,28,64,16,24,26,25,1,65,6,35,36,37,38,67,3,12,13', '所有列表的管理', '普通管理员', '1', '0', '1578984832', '0');
INSERT INTO `tao_auth_group` VALUES ('3', '帖子管理', '5,15,21,22,62,63,23,17,27,28,64,16,24,26,25', '负责帖子的审核', '文章专员', '1', '0', '1578980219', '0');
INSERT INTO `tao_auth_group` VALUES ('4', '网站维护', '2,10,51,11,18,52,54,55,19,56,57,58,59,60,53,3,12,13', '对数据进行统计', '网站维护', '1', '0', '1578980364', '0');

-- ----------------------------
-- Table structure for tao_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `tao_auth_group_access`;
CREATE TABLE `tao_auth_group_access` (
  `id` int(2) NOT NULL AUTO_INCREMENT COMMENT '用户组id',
  `uid` int(11) unsigned NOT NULL,
  `group_id` int(8) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户权限组状态0禁止1正常',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`),
  KEY `uid_group_id` (`uid`,`group_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_auth_group_access
-- ----------------------------

-- ----------------------------
-- Table structure for tao_auth_group_copy
-- ----------------------------
DROP TABLE IF EXISTS `tao_auth_group_copy`;
CREATE TABLE `tao_auth_group_copy` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '角色名称',
  `rules` char(255) NOT NULL DEFAULT '',
  `limits` varchar(255) NOT NULL DEFAULT '' COMMENT '权限范围',
  `descr` varchar(255) NOT NULL DEFAULT '' COMMENT '权限描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色状态1可用0禁止',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_auth_group_copy
-- ----------------------------
INSERT INTO `tao_auth_group_copy` VALUES ('1', '超级管理员', '5,15,21,22,62,63,23,17,27,28,64,16,24,26,25,4,20,32,33,34,14,29,30,31,1,65,6,35,36,37,38,7,39,40,41,42,8,43,44,45,66,9,47,48,49,50,46,67,2,10,51,11,18,52,54,55,19,56,57,58,59,60,53,3,12,13', '管理所有的管理员', '所有权限', '1', '0', '1578984825', '0');
INSERT INTO `tao_auth_group_copy` VALUES ('2', '管理员', '5,15,21,22,62,63,23,17,27,28,64,16,24,26,25,1,65,6,35,36,37,38,67,3,12,13', '所有列表的管理', '普通管理员', '1', '0', '1578984832', '0');
INSERT INTO `tao_auth_group_copy` VALUES ('3', '帖子管理', '5,15,21,22,62,63,23,17,27,28,64,16,24,26,25', '负责帖子的审核', '文章专员', '1', '0', '1578980219', '0');
INSERT INTO `tao_auth_group_copy` VALUES ('4', '网站维护', '5,15,21,22,62,63,23,17,27,28,64,16,24,26,25,90,2,10,51,11,18,52,54,55,19,56,57,58,59,60,53,3,12,13', '对数据进行统计', '网站维护', '1', '0', '1588065032', '0');

-- ----------------------------
-- Table structure for tao_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `tao_auth_rule`;
CREATE TABLE `tao_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限主键ID',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '权限名称',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '权限标题',
  `etitle` varchar(100) NOT NULL DEFAULT '' COMMENT '英文权限标题',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` enum('1','0') NOT NULL DEFAULT '1' COMMENT '菜单1启用,0禁用',
  `pid` smallint(5) NOT NULL DEFAULT '0' COMMENT '父级ID',
  `level` tinyint(1) NOT NULL DEFAULT '1' COMMENT '菜单层级',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `ishidden` enum('1','0') NOT NULL DEFAULT '1' COMMENT '0隐藏,1显示',
  `sort` tinyint(4) NOT NULL DEFAULT '50' COMMENT '排序',
  `condition` char(100) NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_auth_rule
-- ----------------------------
INSERT INTO `tao_auth_rule` VALUES ('1', 'admin', '管理', '', '1', '1', '0', '0', 'layui-icon-user', '1', '3', '', '0', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('2', 'set', '设置', '', '1', '1', '0', '0', 'layui-icon-set', '1', '4', '', '0', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('3', 'administrator', '账户', '', '1', '1', '0', '0', 'layui-icon-username', '1', '5', '', '0', '1578980034', '0');
INSERT INTO `tao_auth_rule` VALUES ('4', 'app', '应用', '', '1', '1', '0', '0', 'layui-icon-app', '1', '2', '', '0', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('5', 'article', '内容', '', '1', '1', '0', '0', 'layui-icon-read', '1', '0', '', '0', '1578902321', '0');
INSERT INTO `tao_auth_rule` VALUES ('6', 'admin/User/list', '用户管理', '', '1', '1', '1', '1', '', '1', '1', '', '0', '1578901015', '0');
INSERT INTO `tao_auth_rule` VALUES ('7', 'admin/Admin/index', '管理员', '', '1', '1', '1', '1', '', '1', '6', '', '0', '1578901133', '0');
INSERT INTO `tao_auth_rule` VALUES ('8', 'admin/AuthGroup/list', '角色管理', '', '1', '1', '1', '1', '', '1', '11', '', '0', '1578901282', '0');
INSERT INTO `tao_auth_rule` VALUES ('9', 'admin/AuthRule/index', '权限菜单', '', '1', '1', '2', '1', '', '1', '16', '', '0', '1611998671', '0');
INSERT INTO `tao_auth_rule` VALUES ('10', 'admin/Set/index', '网站设置', '', '1', '1', '2', '1', '', '1', '1', '', '0', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('11', 'admin/Set/server', '综合服务', '', '1', '1', '2', '1', '', '1', '3', '', '0', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('12', 'admin/Admin/info', '基本资料', '', '1', '1', '3', '1', '', '1', '50', '', '0', '1578980034', '0');
INSERT INTO `tao_auth_rule` VALUES ('13', 'admin/Admin/repass', '修改密码', '', '1', '1', '3', '1', '', '1', '51', '', '0', '1578980034', '0');
INSERT INTO `tao_auth_rule` VALUES ('15', 'admin/Forum/list', '帖子管理', '', '1', '1', '5', '1', '', '1', '1', '', '0', '1578902605', '0');
INSERT INTO `tao_auth_rule` VALUES ('16', 'admin/Forum/tags', '分类管理', '', '1', '1', '5', '1', '', '1', '11', '', '0', '1578904950', '0');
INSERT INTO `tao_auth_rule` VALUES ('17', 'admin/Forum/replys', '评论管理', '', '1', '1', '5', '1', '', '1', '7', '', '0', '1578904590', '0');
INSERT INTO `tao_auth_rule` VALUES ('18', 'admin/Slider/index', '广告投放', '', '1', '1', '93', '1', '', '1', '4', '', '0', '1611999603', '0');
INSERT INTO `tao_auth_rule` VALUES ('19', 'admin/Upgrade/index', '系统升级', '', '1', '1', '2', '1', '', '1', '8', '', '0', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('21', 'admin/Forum/listform', '编辑帖子', '', '1', '1', '15', '2', '', '0', '2', '', '0', '1611997428', '0');
INSERT INTO `tao_auth_rule` VALUES ('22', 'admin/Forum/listdel', '删除帖子', '', '1', '1', '15', '2', '', '0', '3', '', '0', '1611997448', '0');
INSERT INTO `tao_auth_rule` VALUES ('23', 'admin/Forum/check', '审核帖子', '', '1', '1', '15', '2', '', '0', '6', '', '0', '1611997474', '0');
INSERT INTO `tao_auth_rule` VALUES ('24', 'admin/Forum/addtags', '添加分类', '', '1', '1', '16', '2', '', '0', '12', '', '0', '1611997513', '0');
INSERT INTO `tao_auth_rule` VALUES ('25', 'admin/Forum/tagsform', '编辑分类', '', '1', '1', '16', '2', '', '0', '14', '', '0', '1611997535', '0');
INSERT INTO `tao_auth_rule` VALUES ('26', 'admin/Forum/tagsdelete', '删除分类', '', '1', '1', '16', '2', '', '0', '13', '', '0', '1611997523', '0');
INSERT INTO `tao_auth_rule` VALUES ('27', 'admin/Forum/replysform', '编辑评论', '', '1', '1', '17', '2', '', '0', '8', '', '0', '1611997484', '0');
INSERT INTO `tao_auth_rule` VALUES ('28', 'admin/Forum/redel', '删除评论', '', '1', '1', '17', '2', '', '0', '9', '', '0', '1611997494', '0');
INSERT INTO `tao_auth_rule` VALUES ('35', 'admin/User/userForm', '添加用户', '', '1', '1', '6', '2', '', '0', '2', '', '0', '1611997673', '0');
INSERT INTO `tao_auth_rule` VALUES ('36', 'admin/User/userEdit', '编辑用户', '', '1', '1', '6', '2', '', '0', '3', '', '0', '1611997690', '0');
INSERT INTO `tao_auth_rule` VALUES ('37', 'admin/User/delete', '删除用户', '', '1', '1', '6', '2', '', '0', '4', '', '0', '1611997701', '0');
INSERT INTO `tao_auth_rule` VALUES ('38', 'admin/User/check', '审核用户', '', '1', '1', '6', '2', '', '0', '5', '', '0', '1611997713', '0');
INSERT INTO `tao_auth_rule` VALUES ('39', 'admin/Admin/add', '添加管理员', '', '1', '1', '7', '2', '', '0', '7', '', '0', '1611997732', '0');
INSERT INTO `tao_auth_rule` VALUES ('40', 'admin/Admin/edit', '编辑管理员', '', '1', '1', '7', '2', '', '0', '8', '', '0', '1611997747', '0');
INSERT INTO `tao_auth_rule` VALUES ('41', 'admin/Admin/delete', '删除管理员', '', '1', '1', '7', '2', '', '0', '9', '', '0', '1611997760', '0');
INSERT INTO `tao_auth_rule` VALUES ('42', 'admin/Admin/check', '审核管理员', '', '1', '1', '7', '2', '', '0', '10', '', '0', '1611997772', '0');
INSERT INTO `tao_auth_rule` VALUES ('43', 'admin/AuthGroup/roleAdd', '添加角色', '', '1', '1', '8', '2', '', '0', '12', '', '0', '1611997790', '0');
INSERT INTO `tao_auth_rule` VALUES ('44', 'admin/AuthGroup/roleEdit', '编辑角色', '', '1', '1', '8', '2', '', '0', '13', '', '0', '1611997805', '0');
INSERT INTO `tao_auth_rule` VALUES ('45', 'admin/AuthGroup/roledel', '删除角色', '', '1', '1', '8', '2', '', '0', '14', '', '0', '1611997820', '0');
INSERT INTO `tao_auth_rule` VALUES ('46', 'admin/AuthRule/add', '添加权限', '', '1', '1', '9', '2', '', '0', '21', '', '0', '1611997901', '0');
INSERT INTO `tao_auth_rule` VALUES ('47', 'admin/AuthRule/edit', '编辑权限', '', '1', '1', '9', '2', '', '0', '17', '', '0', '1611997849', '0');
INSERT INTO `tao_auth_rule` VALUES ('48', 'admin/AuthRule/delete', '删除权限', '', '1', '1', '9', '2', '', '0', '18', '', '0', '1611997869', '0');
INSERT INTO `tao_auth_rule` VALUES ('49', 'admin/AuthRule/check', '审核权限', '', '1', '1', '9', '2', '', '0', '19', '', '0', '1611997884', '0');
INSERT INTO `tao_auth_rule` VALUES ('50', 'admin/AuthRule/menushow', '菜单权限', '', '1', '1', '9', '2', '', '0', '20', '', '0', '1611997929', '0');
INSERT INTO `tao_auth_rule` VALUES ('51', 'admin/Set/upload', '上传logo', '', '1', '1', '10', '2', '', '0', '2', '', '0', '1611998097', '0');
INSERT INTO `tao_auth_rule` VALUES ('52', 'admin/Slider/add', '添加广告', '', '1', '1', '18', '2', '', '0', '5', '', '0', '1611998128', '0');
INSERT INTO `tao_auth_rule` VALUES ('53', 'admin/Slider/edit', '编辑广告', '', '1', '1', '18', '2', '', '0', '14', '', '0', '1611998263', '0');
INSERT INTO `tao_auth_rule` VALUES ('54', 'admin/Slider/delete', '删除广告', '', '1', '1', '18', '2', '', '0', '6', '', '0', '1611998141', '0');
INSERT INTO `tao_auth_rule` VALUES ('55', 'admin/Slider/uploadimg', '上传广告图片', '', '1', '1', '18', '2', '', '0', '7', '', '0', '1611998156', '0');
INSERT INTO `tao_auth_rule` VALUES ('56', 'admin/Upgrade/key', '设置key', '', '1', '1', '19', '2', '', '0', '9', '', '0', '1611998178', '0');
INSERT INTO `tao_auth_rule` VALUES ('57', 'admin/Upgrade/keyedit', '修改key', '', '1', '1', '19', '2', '', '0', '10', '', '0', '1611998192', '0');
INSERT INTO `tao_auth_rule` VALUES ('58', 'admin/Upgrade/check', '升级检测', '', '1', '1', '19', '2', '', '0', '11', '', '0', '1611998214', '0');
INSERT INTO `tao_auth_rule` VALUES ('59', 'admin/Upgrade/upload', '自动升级', '', '1', '1', '19', '2', '', '0', '12', '', '0', '1611998230', '0');
INSERT INTO `tao_auth_rule` VALUES ('60', 'admin/Upgrade/uploadzip', '上传升级包', '', '1', '1', '19', '2', '', '0', '13', '', '0', '1611998245', '0');
INSERT INTO `tao_auth_rule` VALUES ('62', 'admin/Forum/top', '置顶帖子', '', '1', '1', '15', '2', '', '0', '4', '', '0', '1611997455', '0');
INSERT INTO `tao_auth_rule` VALUES ('63', 'admin/Forum/hot', '加精帖子', '', '1', '1', '15', '2', '', '0', '5', '', '0', '1611997465', '0');
INSERT INTO `tao_auth_rule` VALUES ('64', 'admin/Froum/recheck', '审核评论', '', '1', '1', '17', '2', '', '0', '10', '', '0', '1611997503', '0');
INSERT INTO `tao_auth_rule` VALUES ('65', 'admin/User/uploadImg', '上传用户头像', '', '1', '1', '6', '2', '', '0', '0', '', '0', '1611997661', '0');
INSERT INTO `tao_auth_rule` VALUES ('66', 'admin/AuthGroup/check', '审核角色', '', '1', '1', '8', '2', '', '0', '15', '', '0', '1611997835', '0');
INSERT INTO `tao_auth_rule` VALUES ('67', 'admin/Sign/signRule', '签到规则', '', '1', '1', '11', '2', '', '0', '15', '', '1585547595', '1611998427', '0');
INSERT INTO `tao_auth_rule` VALUES ('68', 'admin/Sign/add', '添加签到', '', '1', '1', '11', '2', '', '0', '16', '', '1585547705', '1611998444', '0');
INSERT INTO `tao_auth_rule` VALUES ('69', 'admin/Sign/signEdit', '编辑签到', '', '1', '1', '11', '2', '', '0', '17', '', '1585547774', '1611998457', '0');
INSERT INTO `tao_auth_rule` VALUES ('70', 'admin/Sign/delete', '删除签到', '', '1', '1', '11', '2', '', '0', '18', '', '1585547817', '1611998470', '0');
INSERT INTO `tao_auth_rule` VALUES ('71', 'admin/Vip/vipRule', '用户等级', '', '1', '1', '11', '2', '', '0', '19', '', '1585547921', '1611998481', '0');
INSERT INTO `tao_auth_rule` VALUES ('72', 'admin/Vip/add', '添加vip等级', '', '1', '1', '11', '2', '', '0', '20', '', '1585547981', '1611998492', '0');
INSERT INTO `tao_auth_rule` VALUES ('73', 'admin/Vip/vipEdit', '编辑vip等级', '', '1', '1', '11', '2', '', '0', '21', '', '1585548029', '1611998556', '0');
INSERT INTO `tao_auth_rule` VALUES ('74', 'admin/Vip/delete', '删除vip等级', '', '1', '1', '11', '2', '', '0', '22', '', '1585548077', '1611998503', '0');
INSERT INTO `tao_auth_rule` VALUES ('75', 'admin/Set/email', '邮箱设置', '', '1', '1', '10', '2', '', '0', '23', '', '1585548143', '1611998372', '0');
INSERT INTO `tao_auth_rule` VALUES ('76', 'admin/Notice/index', '发布通知', '', '1', '1', '4', '1', '', '1', '10', '', '1585618141', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('77', 'admin/Notice/add', '添加通知', '', '1', '1', '76', '2', '', '0', '11', '', '1585663336', '1611997580', '0');
INSERT INTO `tao_auth_rule` VALUES ('78', 'admin/Notice/edit', '编辑通知', '', '1', '1', '76', '2', '', '0', '12', '', '1585663366', '1611997590', '0');
INSERT INTO `tao_auth_rule` VALUES ('79', 'admin/Notice/delete', '删除通知', '', '1', '1', '76', '2', '', '0', '13', '', '1585663412', '1611997601', '0');
INSERT INTO `tao_auth_rule` VALUES ('83', 'admin/AuthAccess/index', '管理员权限', '', '1', '1', '1', '1', '', '1', '22', '', '1585794015', '0', '0');
INSERT INTO `tao_auth_rule` VALUES ('84', 'admin/AuthAccess/add', '添加管理员权限', '', '1', '1', '83', '2', '', '0', '23', '', '1585806544', '1611998012', '0');
INSERT INTO `tao_auth_rule` VALUES ('85', 'admin/AuthAccess/edit', '编辑管理员权限', '', '1', '1', '83', '2', '', '0', '24', '', '1585806592', '1611998030', '0');
INSERT INTO `tao_auth_rule` VALUES ('86', 'admin/AuthAccess/delete', '删除管理员权限', '', '1', '1', '83', '2', '', '0', '25', '', '1585806620', '1611998046', '0');
INSERT INTO `tao_auth_rule` VALUES ('87', 'admin/AuthAccess/check', '审核管理员权限', '', '1', '1', '83', '2', '', '0', '26', '', '1585806653', '1611998060', '0');
INSERT INTO `tao_auth_rule` VALUES ('88', 'admin/Set/website', '网站信息保存', '', '1', '1', '10', '2', '', '0', '24', '', '1585819936', '1611998395', '0');
INSERT INTO `tao_auth_rule` VALUES ('89', 'admin/User/auth', '设置超级用户', '', '1', '1', '6', '2', '', '0', '22', '', '1578984801', '1611997990', '0');
INSERT INTO `tao_auth_rule` VALUES ('90', 'admin/Forum/tagshot', '开启热点', '', '1', '1', '16', '2', '', '0', '15', '', '1585841826', '1611997546', '0');
INSERT INTO `tao_auth_rule` VALUES ('91', 'admin/Admin/infoSet', '资料设置', '', '1', '1', '12', '2', '', '0', '62', '', '1586245669', '1611998517', '0');
INSERT INTO `tao_auth_rule` VALUES ('92', 'admin/Admin/repassSet', '密码设置', '', '1', '1', '13', '2', '', '0', '64', '', '1586245727', '1611998534', '0');
INSERT INTO `tao_auth_rule` VALUES ('93', 'servers', '服务', '', '1', '1', '0', '0', 'layui-icon-cols', '1', '2', '', '1611286515', '1611997619', '0');
INSERT INTO `tao_auth_rule` VALUES ('94', 'admin/Database/index', '数据备份', '', '1', '1', '93', '1', '', '1', '9', '', '1611897141', '1611902589', '0');
INSERT INTO `tao_auth_rule` VALUES ('95', 'admin/Database/backup', '进行备份', '', '1', '1', '94', '2', '', '0', '10', '', '1611897285', '1611902610', '0');
INSERT INTO `tao_auth_rule` VALUES ('96', 'admin/Database/delete', '备份删除', '', '1', '1', '94', '2', '', '0', '0', '', '1611902429', '0', '0');

-- ----------------------------
-- Table structure for tao_cate
-- ----------------------------
DROP TABLE IF EXISTS `tao_cate`;
CREATE TABLE `tao_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `catename` varchar(20) NOT NULL COMMENT '导航名称',
  `ename` varchar(20) NOT NULL DEFAULT '' COMMENT '分类别名',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT '状态1启用0禁用',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0帖子1文章',
  `desc` varchar(255) NOT NULL,
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是热点',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updata_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `ename` (`ename`) COMMENT '英文名称索引'
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_cate
-- ----------------------------
INSERT INTO `tao_cate` VALUES ('1', '提问', 'ask', '1', '1', '0', 'TaoLer社区提问专栏1', '0', '0', '0', '0');
INSERT INTO `tao_cate` VALUES ('2', '分享', 'share', '2', '1', '0', '', '0', '0', '0', '0');
INSERT INTO `tao_cate` VALUES ('3', '讨论', 'talk', '3', '1', '0', '', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for tao_collection
-- ----------------------------
DROP TABLE IF EXISTS `tao_collection`;
CREATE TABLE `tao_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `auther` varchar(20) NOT NULL COMMENT '作者',
  `collect_title` varchar(80) NOT NULL COMMENT '收藏帖子标题',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='文章收藏表';

-- ----------------------------
-- Records of tao_collection
-- ----------------------------

-- ----------------------------
-- Table structure for tao_comment
-- ----------------------------
DROP TABLE IF EXISTS `tao_comment`;
CREATE TABLE `tao_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `content` text NOT NULL COMMENT '评论',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `user_id` int(11) NOT NULL COMMENT '评论用户',
  `zan` tinyint(4) NOT NULL DEFAULT '0' COMMENT '赞',
  `cai` enum('1','0') NOT NULL DEFAULT '0' COMMENT '0求解1采纳',
  `status` enum('0','-1','1') NOT NULL DEFAULT '1' COMMENT '1通过0待审-1禁止',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `aiticle_id` (`article_id`) USING BTREE COMMENT '文章评论索引',
  KEY `user_id` (`user_id`) USING BTREE COMMENT '评论用户索引'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_comment
-- ----------------------------
INSERT INTO `tao_comment` VALUES ('1', 'https://www.aieok.com', '1', '1', '0', '0', '1', '1555127897', '1578977505', '1578977505');

-- ----------------------------
-- Table structure for tao_cunsult
-- ----------------------------
DROP TABLE IF EXISTS `tao_cunsult`;
CREATE TABLE `tao_cunsult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(2) NOT NULL COMMENT '问题类型1问题资讯2提交BUG',
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT '问题',
  `content` tinytext NOT NULL COMMENT '内容',
  `poster` tinyint(4) NOT NULL COMMENT '发送人ID',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `delete_time` int(10) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_cunsult
-- ----------------------------
INSERT INTO `tao_cunsult` VALUES ('2', '2', '的', '的', '3', '1612162069', '0');

-- ----------------------------
-- Table structure for tao_friend_link
-- ----------------------------
DROP TABLE IF EXISTS `tao_friend_link`;
CREATE TABLE `tao_friend_link` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT COMMENT '友情链接id',
  `linkname` varchar(10) NOT NULL COMMENT '链接名称',
  `linksrc` varchar(60) NOT NULL COMMENT '链接地址',
  `linkimg` varchar(60) NOT NULL COMMENT '链接图片',
  `creat_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  `delete_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_friend_link
-- ----------------------------
INSERT INTO `tao_friend_link` VALUES ('1', 'taobao', 'https://www.taobao.com', '', '0', '0', '0');
INSERT INTO `tao_friend_link` VALUES ('2', 'baidu', 'https://www.baidu.com', '', '0', '0', '0');
INSERT INTO `tao_friend_link` VALUES ('3', 'tensent', 'https://www.qq.com', '', '0', '0', '0');

-- ----------------------------
-- Table structure for tao_mail_server
-- ----------------------------
DROP TABLE IF EXISTS `tao_mail_server`;
CREATE TABLE `tao_mail_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(50) NOT NULL COMMENT '邮箱设置',
  `host` varchar(50) NOT NULL COMMENT '邮箱服务地址',
  `port` tinyint(2) NOT NULL COMMENT '邮箱端口',
  `nickname` varchar(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(16) NOT NULL COMMENT '邮箱密码',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_mail_server
-- ----------------------------
INSERT INTO `tao_mail_server` VALUES ('1', 'xxxx@aliyun.com', 'smtp.aliyun.com', '25', 'user', '123456', '0');

-- ----------------------------
-- Table structure for tao_message
-- ----------------------------
DROP TABLE IF EXISTS `tao_message`;
CREATE TABLE `tao_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `title` varchar(255) NOT NULL COMMENT '消息标题',
  `content` text COMMENT '消息内容',
  `user_id` int(11) NOT NULL COMMENT '发送人ID',
  `link` varchar(255) DEFAULT NULL COMMENT '链接',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '消息类型0系统消息1普通消息',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_message
-- ----------------------------

-- ----------------------------
-- Table structure for tao_message_to
-- ----------------------------
DROP TABLE IF EXISTS `tao_message_to`;
CREATE TABLE `tao_message_to` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `send_id` int(11) NOT NULL COMMENT '发送人ID',
  `receve_id` int(11) NOT NULL COMMENT '接收人ID',
  `message_id` varchar(255) NOT NULL COMMENT '消息标题',
  `message_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '消息类型0系统消息1普通消息',
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_message_to
-- ----------------------------

-- ----------------------------
-- Table structure for tao_slider
-- ----------------------------
DROP TABLE IF EXISTS `tao_slider`;
CREATE TABLE `tao_slider` (
  `id` int(2) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `slid_name` varchar(30) NOT NULL COMMENT '幻灯名',
  `slid_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型',
  `slid_img` varchar(70) NOT NULL DEFAULT '' COMMENT '幻灯图片地址',
  `slid_href` varchar(70) NOT NULL DEFAULT '' COMMENT '链接',
  `slid_color` varchar(10) NOT NULL DEFAULT '' COMMENT '广告块颜色',
  `slid_start` int(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `slid_over` int(11) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `slid_status` enum('1','0') NOT NULL DEFAULT '1' COMMENT '1投放0仓库',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_slider
-- ----------------------------
INSERT INTO `tao_slider` VALUES ('1', 'CODING', '1', '/storage/slider/F1.jpg', '#', '', '1574870400', '1575043200', '1', '0', '0', '0');
INSERT INTO `tao_slider` VALUES ('3', '通用右栏底部广告', '2', '/storage/slider/20200101/851c0b88a72590293bcb45454bdce056.jpg', 'https://www.aieok.com', '', '1571155200', '1609344000', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for tao_system
-- ----------------------------
DROP TABLE IF EXISTS `tao_system`;
CREATE TABLE `tao_system` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `webname` varchar(20) NOT NULL COMMENT '网站名称',
  `webtitle` varchar(30) NOT NULL,
  `domain` varchar(50) NOT NULL,
  `template` varchar(30) NOT NULL DEFAULT '' COMMENT '模板',
  `logo` varchar(70) NOT NULL DEFAULT '' COMMENT '网站logo',
  `cache` tinyint(5) NOT NULL DEFAULT '0' COMMENT '缓存时间分钟',
  `upsize` int(5) NOT NULL DEFAULT '0' COMMENT '上传文件大小KB',
  `uptype` varchar(50) NOT NULL DEFAULT '' COMMENT '上传文件类型',
  `copyright` varchar(80) NOT NULL DEFAULT '' COMMENT '版权',
  `keywords` tinytext NOT NULL COMMENT '网站关键字',
  `descript` tinytext NOT NULL COMMENT '网站描述',
  `is_open` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否开启站点1开启0关闭',
  `is_comment` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否开启评论1开启0关闭',
  `is_reg` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否开放注册1开启0禁止',
  `icp` varchar(50) NOT NULL DEFAULT '' COMMENT '备案',
  `blackname` varchar(255) NOT NULL COMMENT '注册黑名单',
  `sys_version_num` varchar(5) NOT NULL COMMENT '系统版本',
  `key` varchar(60) DEFAULT NULL COMMENT 'key',
  `api_url` varchar(80) NOT NULL COMMENT 'api',
  `base_url` varchar(50) NOT NULL DEFAULT '',
  `upcheck_url` varchar(255) NOT NULL COMMENT '版本检测',
  `upgrade_url` varchar(255) NOT NULL COMMENT '升级地址',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of tao_system
-- ----------------------------
INSERT INTO `tao_system` VALUES ('1', 'TaoLer社区演示站', '轻论坛系统', 'http://www.xxx.com', 'taoler', '/storage/logo/logo.png', '10', '2048', 'png|gif|jpg|jpeg|zip|rarr', '<a href="https://www.aieok.com" target="_blank">TaoLer</a>', 'TaoLer,轻社区系统,bbs,论坛,Thinkphp6,layui,fly模板,', '这是一个Taoler轻社区论坛系统', '1', '1', '1', '0.0.0.0', '管理员|admin|审核员|超级|垃圾', '1.6.3', '', 'http://api.aieok.com', 'http://api.aieok.com/v1/cy', 'http://api.aieok.com/v1/upload/check', 'http://api.aieok.com/v1/upload/api', '1581221008', '1577419197');

-- ----------------------------
-- Table structure for tao_user
-- ----------------------------
DROP TABLE IF EXISTS `tao_user`;
CREATE TABLE `tao_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `name` varchar(16) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '手机',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `nickname` varchar(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `city` varchar(50) NOT NULL DEFAULT '' COMMENT '归属地',
  `sex` enum('0','1') NOT NULL DEFAULT '0' COMMENT '性别0男1女',
  `sign` varchar(255) NOT NULL DEFAULT '' COMMENT '签名',
  `user_img` varchar(70) NOT NULL DEFAULT '' COMMENT '头像',
  `auth` enum('1','0') NOT NULL DEFAULT '0' COMMENT '管理员权限0普通1超级',
  `point` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `area_id` int(11) DEFAULT NULL COMMENT '用户所属区域ID',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT '1启用0禁用',
  `vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'vip',
  `last_login_ip` varchar(70) NOT NULL DEFAULT '0' COMMENT '最后登陆ip',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登陆时间',
  `login_error_num` tinyint(1) NOT NULL DEFAULT '0' COMMENT '登陆错误次数',
  `login_error_time` int(11) NOT NULL DEFAULT '0' COMMENT '登陆错误时间',
  `login_error_lock` tinyint(1) NOT NULL DEFAULT '0' COMMENT '登陆锁定0正常1锁定',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE COMMENT '用户名查询用户索引',
  KEY `email` (`email`) USING BTREE COMMENT 'email查询用户索引'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_user
-- ----------------------------
INSERT INTO `tao_user` VALUES ('1', 'admin', '95d6f8d0d0c3b45e5dbe4057da1b149e', '2147483647', 'admin@qq.com', '管理员', '北京市', '1', '这是我的第一个TP5系统，2019北京。OK! OK!ok@', '/static/res/images/avatar/00.jpg', '1', '14', '1', '1', '0', '127.0.0.1', '0', '0', '0', '0', '1579053025', '1578469091', '0');

-- ----------------------------
-- Table structure for tao_user_area
-- ----------------------------
DROP TABLE IF EXISTS `tao_user_area`;
CREATE TABLE `tao_user_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `area` varchar(10) NOT NULL COMMENT '所属区域',
  `asing` varchar(2) NOT NULL COMMENT '区域简称',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  `delete_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_user_area
-- ----------------------------
INSERT INTO `tao_user_area` VALUES ('1', '北京', '京', '0', '0', '0');
INSERT INTO `tao_user_area` VALUES ('2', '上海', '沪', '0', '0', '0');
INSERT INTO `tao_user_area` VALUES ('3', '广州', '广', '0', '0', '0');
INSERT INTO `tao_user_area` VALUES ('4', '深圳', '深', '0', '0', '0');

-- ----------------------------
-- Table structure for tao_user_sign
-- ----------------------------
DROP TABLE IF EXISTS `tao_user_sign`;
CREATE TABLE `tao_user_sign` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `days` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '连续签到的天数',
  `is_share` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否分享过',
  `is_sign` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否签到过',
  `stime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '签到的时间',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户签到表';

-- ----------------------------
-- Records of tao_user_sign
-- ----------------------------

-- ----------------------------
-- Table structure for tao_user_signrule
-- ----------------------------
DROP TABLE IF EXISTS `tao_user_signrule`;
CREATE TABLE `tao_user_signrule` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `days` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '连续天数',
  `score` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '升级时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户签到积分规则';

-- ----------------------------
-- Records of tao_user_signrule
-- ----------------------------
INSERT INTO `tao_user_signrule` VALUES ('1', '1', '2', '0', '0', '0');
INSERT INTO `tao_user_signrule` VALUES ('2', '3', '3', '0', '0', '0');
INSERT INTO `tao_user_signrule` VALUES ('3', '5', '5', '0', '0', '0');

-- ----------------------------
-- Table structure for tao_user_viprule
-- ----------------------------
DROP TABLE IF EXISTS `tao_user_viprule`;
CREATE TABLE `tao_user_viprule` (
  `id` int(2) NOT NULL AUTO_INCREMENT COMMENT '用户等级ID',
  `score` varchar(255) NOT NULL DEFAULT '0' COMMENT '积分区间',
  `vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'vip等级',
  `nick` varchar(20) DEFAULT NULL COMMENT '认证昵称',
  `rules` varchar(255) DEFAULT NULL COMMENT '权限',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '升级时间',
  `delete_time` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_user_viprule
-- ----------------------------
INSERT INTO `tao_user_viprule` VALUES ('1', '0-99', '0', '游民', '', '1585476523', '1585544577', '0');
INSERT INTO `tao_user_viprule` VALUES ('2', '100-299', '1', '富农', '', '1585476551', '1585546376', '0');
INSERT INTO `tao_user_viprule` VALUES ('3', '300-500', '2', '地主', '', '1585545450', '1585546241', '0');
INSERT INTO `tao_user_viprule` VALUES ('4', '501-699', '3', '土豪', '', '1585545542', '1585569657', '0');

-- ----------------------------
-- Table structure for tao_user_zan
-- ----------------------------
DROP TABLE IF EXISTS `tao_user_zan`;
CREATE TABLE `tao_user_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '点赞主键id',
  `comment_id` int(11) NOT NULL COMMENT '评论id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '点赞时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tao_user_zan
-- ----------------------------
