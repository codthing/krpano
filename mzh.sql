/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : mzh

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-10-29 10:35:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for eacoo_about
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_about`;
CREATE TABLE `eacoo_about` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '公司名称',
  `security_tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '保安电话',
  `recruit_tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '人员招聘',
  `complaint_tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '投诉电话',
  `server_tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '业务服务电话',
  `command_tel` varchar(255) DEFAULT '0' COMMENT '指挥中心电话',
  `email` varchar(255) NOT NULL DEFAULT '0' COMMENT '官方邮箱',
  `weixing_icon` int(10) NOT NULL DEFAULT '0' COMMENT '官方微信图片',
  `address` varchar(255) NOT NULL DEFAULT '0' COMMENT '公司地址',
  `fax` varchar(255) NOT NULL DEFAULT '0' COMMENT '传真',
  `work_time` varchar(255) NOT NULL DEFAULT '0' COMMENT '工作时间',
  `qq` varchar(255) NOT NULL DEFAULT '0' COMMENT 'qq号',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='公司地址信息';

-- ----------------------------
-- Records of eacoo_about
-- ----------------------------
INSERT INTO `eacoo_about` VALUES ('1', '重庆市江北保安服务有限责任公司', '023-67705011 ', '023-67705011', '023-67703455', '023-67776009', '023-67851475', 'jiangbeibaoan@weldon.cn', '175', '重庆市江北区建兴东路251号万丰花园丰登楼5楼', '023-67851475', '(9:00am-18:00pm)', '343647620', '1559804305', '1569225396');

-- ----------------------------
-- Table structure for eacoo_action
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_action`;
CREATE TABLE `eacoo_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(30) NOT NULL COMMENT '行为唯一标识（组合控制器名+操作名）',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '来源类型。0系统,1module，2plugin，3theme',
  `depend_flag` varchar(16) NOT NULL DEFAULT '' COMMENT '所属模块名',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` varchar(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` varchar(255) NOT NULL DEFAULT '' COMMENT '行为规则',
  `log` varchar(255) NOT NULL DEFAULT '' COMMENT '日志规则',
  `action_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '执行类型。1自定义操作，2记录操作',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='系统行为表';

-- ----------------------------
-- Records of eacoo_action
-- ----------------------------
INSERT INTO `eacoo_action` VALUES ('1', 'login_index', '1', 'admin', '登录后台', '用户登录后台', '', '[user|get_nickname]在[time|time_format]登录了后台', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('2', 'update_config', '1', 'admin', '更新配置', '新增或修改或删除配置', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('3', 'update_channel', '1', 'admin', '更新导航', '新增或修改或删除导航', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('4', 'update_category', '1', 'admin', '更新分类', '新增或修改或删除分类', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('5', 'database_export', '1', 'admin', '数据库备份', '后台进行数据库备份操作', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('6', 'database_optimize', '1', 'admin', '数据表优化', '数据库管理-》数据表优化', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('7', 'database_repair', '1', 'admin', '数据表修复', '数据库管理-》数据表修复', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('8', 'database_delbackup', '1', 'admin', '备份文件删除', '数据库管理-》备份文件删除', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('9', 'database_import', '1', 'admin', '数据库完成', '数据库管理-》数据还原', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('10', 'delete_actionlog', '1', 'admin', '删除行为日志', '后台删除用户行为日志', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('11', 'user_register', '1', 'admin', '注册', '', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('12', 'action_add', '1', 'admin', '添加行为', '', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('13', 'action_edit', '1', 'admin', '编辑用户行为', '', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('14', 'action_dellog', '1', 'admin', '清空日志', '清空所有行为日志', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('15', 'setstatus', '1', 'admin', '改变数据状态', '通过列表改变了数据的status状态值', '', '', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_action` VALUES ('16', 'modules_delapp', '1', 'admin', '删除模块', '删除整个模块的时候记录', '', '', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for eacoo_action_log
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_action_log`;
CREATE TABLE `eacoo_action_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL COMMENT '行为ID',
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否后台操作。0否，1是',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id（管理员用户）',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `request_method` varchar(20) NOT NULL DEFAULT '' COMMENT '请求类型',
  `url` varchar(120) NOT NULL DEFAULT '' COMMENT '操作页面',
  `data` varchar(300) NOT NULL DEFAULT '0' COMMENT '相关数据,json格式',
  `ip` varchar(18) NOT NULL COMMENT 'IP',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `user_agent` varchar(360) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `idx_uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8 COMMENT='系统行为日志表';

-- ----------------------------
-- Records of eacoo_action_log
-- ----------------------------
INSERT INTO `eacoo_action_log` VALUES ('42', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 08:58:04');
INSERT INTO `eacoo_action_log` VALUES ('43', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 11:58:53');
INSERT INTO `eacoo_action_log` VALUES ('44', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 12:00:54');
INSERT INTO `eacoo_action_log` VALUES ('45', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 12:01:15');
INSERT INTO `eacoo_action_log` VALUES ('46', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 13:23:32');
INSERT INTO `eacoo_action_log` VALUES ('47', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 13:24:49');
INSERT INTO `eacoo_action_log` VALUES ('48', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 13:36:44');
INSERT INTO `eacoo_action_log` VALUES ('49', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/auth/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 14:10:20');
INSERT INTO `eacoo_action_log` VALUES ('50', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-18 14:27:44');
INSERT INTO `eacoo_action_log` VALUES ('51', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-22 15:44:45');
INSERT INTO `eacoo_action_log` VALUES ('52', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-22 15:46:20');
INSERT INTO `eacoo_action_log` VALUES ('53', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-29 10:32:06');
INSERT INTO `eacoo_action_log` VALUES ('54', '13', '1', '1', 'admin', 'GET', '/admin.php/admin/action/edit.html', '{\"param\":[]}', '127.0.0.1', '编辑用户行为', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-29 17:06:35');
INSERT INTO `eacoo_action_log` VALUES ('55', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-29 17:11:56');
INSERT INTO `eacoo_action_log` VALUES ('56', '13', '1', '1', 'admin', 'GET', '/admin.php/admin/action/edit.html', '{\"param\":[]}', '127.0.0.1', '编辑用户行为', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-29 17:12:18');
INSERT INTO `eacoo_action_log` VALUES ('57', '1', '1', '1', 'admin', 'GET', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-29 17:38:49');
INSERT INTO `eacoo_action_log` VALUES ('58', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-30 09:01:29');
INSERT INTO `eacoo_action_log` VALUES ('59', '1', '1', '1', 'admin', 'GET', '/admin.php?s=/admin/login/index', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-30 09:03:05');
INSERT INTO `eacoo_action_log` VALUES ('60', '1', '1', '1', 'admin', 'GET', '/admin.php?s=/admin/login/index', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-30 09:06:00');
INSERT INTO `eacoo_action_log` VALUES ('61', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-05-31 15:15:41');
INSERT INTO `eacoo_action_log` VALUES ('62', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-03 09:04:38');
INSERT INTO `eacoo_action_log` VALUES ('63', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/member/setstatus/status/resume.html?model=Member', '{\"param\":{\"model\":\"Member\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-03 10:22:21');
INSERT INTO `eacoo_action_log` VALUES ('64', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/member/setstatus/status/resume.html?model=Member', '{\"param\":{\"model\":\"Member\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-03 10:22:36');
INSERT INTO `eacoo_action_log` VALUES ('65', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/member/setstatus/status/forbid.html?model=Member', '{\"param\":{\"model\":\"Member\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-03 10:51:13');
INSERT INTO `eacoo_action_log` VALUES ('66', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/member/setstatus/status/resume.html?model=Member', '{\"param\":{\"model\":\"Member\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-03 10:51:30');
INSERT INTO `eacoo_action_log` VALUES ('67', '1', '1', '1', 'admin', 'GET', '/admin.php?s=/admin/login/index', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-04 11:34:03');
INSERT INTO `eacoo_action_log` VALUES ('68', '1', '1', '1', 'admin', 'GET', '/admin.php?s=/admin/login/index', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-04 11:34:17');
INSERT INTO `eacoo_action_log` VALUES ('69', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-05 13:52:57');
INSERT INTO `eacoo_action_log` VALUES ('70', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-06 10:20:20');
INSERT INTO `eacoo_action_log` VALUES ('71', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-06 10:41:39');
INSERT INTO `eacoo_action_log` VALUES ('72', '1', '1', '1', 'admin', 'GET', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-06 10:42:06');
INSERT INTO `eacoo_action_log` VALUES ('73', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-06 10:45:13');
INSERT INTO `eacoo_action_log` VALUES ('74', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-06 10:45:30');
INSERT INTO `eacoo_action_log` VALUES ('75', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-06 17:33:31');
INSERT INTO `eacoo_action_log` VALUES ('76', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-10 09:24:00');
INSERT INTO `eacoo_action_log` VALUES ('77', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-10 11:22:22');
INSERT INTO `eacoo_action_log` VALUES ('78', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '2019-06-10 11:46:41');
INSERT INTO `eacoo_action_log` VALUES ('79', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-02 10:01:36');
INSERT INTO `eacoo_action_log` VALUES ('80', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-02 10:03:20');
INSERT INTO `eacoo_action_log` VALUES ('81', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-04 15:28:48');
INSERT INTO `eacoo_action_log` VALUES ('82', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-05 09:04:50');
INSERT INTO `eacoo_action_log` VALUES ('83', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-05 10:08:44');
INSERT INTO `eacoo_action_log` VALUES ('84', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_type/setstatus/status/forbid/ids/1.html?model=ServiceType', '{\"param\":{\"model\":\"ServiceType\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-05 10:13:14');
INSERT INTO `eacoo_action_log` VALUES ('85', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_type/setstatus/status/resume/ids/1.html?model=ServiceType', '{\"param\":{\"model\":\"ServiceType\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-05 10:13:25');
INSERT INTO `eacoo_action_log` VALUES ('86', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_type/setstatus/status/forbid/ids/1.html?model=ServiceType', '{\"param\":{\"model\":\"ServiceType\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-05 10:15:01');
INSERT INTO `eacoo_action_log` VALUES ('87', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_type/setstatus/status/resume/ids/1.html?model=ServiceType', '{\"param\":{\"model\":\"ServiceType\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-05 10:15:06');
INSERT INTO `eacoo_action_log` VALUES ('88', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-05 14:56:40');
INSERT INTO `eacoo_action_log` VALUES ('89', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-09 10:01:21');
INSERT INTO `eacoo_action_log` VALUES ('90', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/forbid/ids/1.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-09 10:43:02');
INSERT INTO `eacoo_action_log` VALUES ('91', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/resume/ids/1.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-09 10:43:06');
INSERT INTO `eacoo_action_log` VALUES ('92', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/resume/ids/1.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-09 10:57:12');
INSERT INTO `eacoo_action_log` VALUES ('93', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-11 09:32:47');
INSERT INTO `eacoo_action_log` VALUES ('94', '1', '1', '1', 'admin', 'GET', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-11 10:17:38');
INSERT INTO `eacoo_action_log` VALUES ('95', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/1.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-11 14:44:15');
INSERT INTO `eacoo_action_log` VALUES ('96', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/1.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-11 14:44:50');
INSERT INTO `eacoo_action_log` VALUES ('97', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 11:29:22');
INSERT INTO `eacoo_action_log` VALUES ('98', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 14:35:12');
INSERT INTO `eacoo_action_log` VALUES ('99', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 14:38:37');
INSERT INTO `eacoo_action_log` VALUES ('100', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/resume/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 14:38:44');
INSERT INTO `eacoo_action_log` VALUES ('101', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 14:39:50');
INSERT INTO `eacoo_action_log` VALUES ('102', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/resume/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 14:39:55');
INSERT INTO `eacoo_action_log` VALUES ('103', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 15:04:20');
INSERT INTO `eacoo_action_log` VALUES ('104', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/resume/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 15:04:25');
INSERT INTO `eacoo_action_log` VALUES ('105', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 15:05:44');
INSERT INTO `eacoo_action_log` VALUES ('106', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/service_class/setstatus/status/forbid/ids/14.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 15:05:56');
INSERT INTO `eacoo_action_log` VALUES ('107', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/service_class/setstatus/status/delete.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 15:06:04');
INSERT INTO `eacoo_action_log` VALUES ('108', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/service_class/setstatus/status/delete.html?model=service_class', '{\"param\":{\"model\":\"service_class\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-07-12 15:23:56');
INSERT INTO `eacoo_action_log` VALUES ('109', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-08-27 13:40:11');
INSERT INTO `eacoo_action_log` VALUES ('110', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-08-27 15:12:27');
INSERT INTO `eacoo_action_log` VALUES ('111', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-08-28 09:53:02');
INSERT INTO `eacoo_action_log` VALUES ('112', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-03 13:50:39');
INSERT INTO `eacoo_action_log` VALUES ('113', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-04 09:45:48');
INSERT INTO `eacoo_action_log` VALUES ('114', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-06 09:33:29');
INSERT INTO `eacoo_action_log` VALUES ('115', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-09 11:04:27');
INSERT INTO `eacoo_action_log` VALUES ('116', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-10 10:46:17');
INSERT INTO `eacoo_action_log` VALUES ('117', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-10 16:13:16');
INSERT INTO `eacoo_action_log` VALUES ('118', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-10 16:13:46');
INSERT INTO `eacoo_action_log` VALUES ('119', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-11 09:49:13');
INSERT INTO `eacoo_action_log` VALUES ('120', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-12 10:45:15');
INSERT INTO `eacoo_action_log` VALUES ('121', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-16 09:01:59');
INSERT INTO `eacoo_action_log` VALUES ('122', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/article/setstatus/status/forbid/ids/2.html?model=Article', '{\"param\":{\"model\":\"Article\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-16 09:35:21');
INSERT INTO `eacoo_action_log` VALUES ('123', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/article/setstatus/status/forbid/ids/2.html?model=Article', '{\"param\":{\"model\":\"Article\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-16 09:36:12');
INSERT INTO `eacoo_action_log` VALUES ('124', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/comment/setstatus/status/forbid/ids/2.html?model=Comment', '{\"param\":{\"model\":\"Comment\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-16 09:41:52');
INSERT INTO `eacoo_action_log` VALUES ('125', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/comment/setstatus/status/resume/ids/2.html?model=Comment', '{\"param\":{\"model\":\"Comment\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-16 09:41:57');
INSERT INTO `eacoo_action_log` VALUES ('126', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-17 09:44:32');
INSERT INTO `eacoo_action_log` VALUES ('127', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-18 10:58:17');
INSERT INTO `eacoo_action_log` VALUES ('128', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-18 14:41:45');
INSERT INTO `eacoo_action_log` VALUES ('129', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-18 15:59:00');
INSERT INTO `eacoo_action_log` VALUES ('130', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 09:21:00');
INSERT INTO `eacoo_action_log` VALUES ('131', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 09:22:29');
INSERT INTO `eacoo_action_log` VALUES ('132', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 09:50:37');
INSERT INTO `eacoo_action_log` VALUES ('133', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/course/setstatus/status/forbid/ids/5.html?model=Course', '{\"param\":{\"model\":\"Course\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 10:53:43');
INSERT INTO `eacoo_action_log` VALUES ('134', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/course/setstatus/status/resume/ids/5.html?model=Course', '{\"param\":{\"model\":\"Course\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 10:53:47');
INSERT INTO `eacoo_action_log` VALUES ('135', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/article/setstatus/status/forbid/ids/6.html?model=Article', '{\"param\":{\"model\":\"Article\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 11:27:04');
INSERT INTO `eacoo_action_log` VALUES ('136', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/article/setstatus/status/resume/ids/6.html?model=Article', '{\"param\":{\"model\":\"Article\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 11:27:08');
INSERT INTO `eacoo_action_log` VALUES ('137', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 13:54:07');
INSERT INTO `eacoo_action_log` VALUES ('138', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 14:22:00');
INSERT INTO `eacoo_action_log` VALUES ('139', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 15:48:52');
INSERT INTO `eacoo_action_log` VALUES ('140', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 15:58:54');
INSERT INTO `eacoo_action_log` VALUES ('141', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 16:44:18');
INSERT INTO `eacoo_action_log` VALUES ('142', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/menu/setstatus/status/resume/ids/5.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 18:32:43');
INSERT INTO `eacoo_action_log` VALUES ('143', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/menu/setstatus/status/resume/ids/10.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-19 18:35:28');
INSERT INTO `eacoo_action_log` VALUES ('144', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 08:54:21');
INSERT INTO `eacoo_action_log` VALUES ('145', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/forbid/ids/14.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 09:14:12');
INSERT INTO `eacoo_action_log` VALUES ('146', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/resume/ids/14.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 09:14:16');
INSERT INTO `eacoo_action_log` VALUES ('147', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/business/setstatus/status/forbid/ids/16.html?model=Business', '{\"param\":{\"model\":\"Business\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 09:18:10');
INSERT INTO `eacoo_action_log` VALUES ('148', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/business/setstatus/status/resume/ids/16.html?model=Business', '{\"param\":{\"model\":\"Business\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 09:18:15');
INSERT INTO `eacoo_action_log` VALUES ('149', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 10:46:14');
INSERT INTO `eacoo_action_log` VALUES ('150', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/menu/setstatus/status/resume/ids/43.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 10:46:23');
INSERT INTO `eacoo_action_log` VALUES ('151', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 10:46:41');
INSERT INTO `eacoo_action_log` VALUES ('152', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/menu/setstatus/status/forbid/ids/43.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 10:48:52');
INSERT INTO `eacoo_action_log` VALUES ('153', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 11:58:56');
INSERT INTO `eacoo_action_log` VALUES ('154', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 12:03:05');
INSERT INTO `eacoo_action_log` VALUES ('155', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 12:04:35');
INSERT INTO `eacoo_action_log` VALUES ('156', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 13:33:02');
INSERT INTO `eacoo_action_log` VALUES ('157', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 13:38:51');
INSERT INTO `eacoo_action_log` VALUES ('158', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/forbid/ids/17.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 14:59:46');
INSERT INTO `eacoo_action_log` VALUES ('159', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/ad/setstatus/status/forbid/ids/1.html?model=Ad', '{\"param\":{\"model\":\"Ad\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 16:04:54');
INSERT INTO `eacoo_action_log` VALUES ('160', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/ad/setstatus/status/resume/ids/1.html?model=Ad', '{\"param\":{\"model\":\"Ad\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 16:04:57');
INSERT INTO `eacoo_action_log` VALUES ('161', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 16:08:53');
INSERT INTO `eacoo_action_log` VALUES ('162', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/forbid.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-20 16:09:42');
INSERT INTO `eacoo_action_log` VALUES ('163', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-23 09:31:57');
INSERT INTO `eacoo_action_log` VALUES ('164', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-24 08:59:06');
INSERT INTO `eacoo_action_log` VALUES ('165', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-09-25 10:33:00');
INSERT INTO `eacoo_action_log` VALUES ('166', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-14 17:06:17');
INSERT INTO `eacoo_action_log` VALUES ('167', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-15 17:08:13');
INSERT INTO `eacoo_action_log` VALUES ('168', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/menu/setstatus/status/delete.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-15 17:10:33');
INSERT INTO `eacoo_action_log` VALUES ('169', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 09:10:39');
INSERT INTO `eacoo_action_log` VALUES ('170', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/forbid/ids/26.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 10:40:58');
INSERT INTO `eacoo_action_log` VALUES ('171', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/resume/ids/26.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 10:41:39');
INSERT INTO `eacoo_action_log` VALUES ('172', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 10:41:57');
INSERT INTO `eacoo_action_log` VALUES ('173', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 10:45:54');
INSERT INTO `eacoo_action_log` VALUES ('174', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/category/setstatus/status/forbid/ids/20.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 11:25:59');
INSERT INTO `eacoo_action_log` VALUES ('175', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 11:31:00');
INSERT INTO `eacoo_action_log` VALUES ('176', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 11:31:42');
INSERT INTO `eacoo_action_log` VALUES ('177', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 11:36:12');
INSERT INTO `eacoo_action_log` VALUES ('178', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 11:49:23');
INSERT INTO `eacoo_action_log` VALUES ('179', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 13:56:23');
INSERT INTO `eacoo_action_log` VALUES ('180', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 13:56:51');
INSERT INTO `eacoo_action_log` VALUES ('181', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 13:57:44');
INSERT INTO `eacoo_action_log` VALUES ('182', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 15:12:48');
INSERT INTO `eacoo_action_log` VALUES ('183', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/category/setstatus/status/delete.html?model=Category', '{\"param\":{\"model\":\"Category\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 15:13:00');
INSERT INTO `eacoo_action_log` VALUES ('184', '15', '1', '1', 'admin', 'GET', '/admin.php/admin/menu/setstatus/status/forbid/ids/54.html?model=auth_rule', '{\"param\":{\"model\":\"auth_rule\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 15:24:13');
INSERT INTO `eacoo_action_log` VALUES ('185', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/ad/setstatus/status/delete.html?model=Ad', '{\"param\":{\"model\":\"Ad\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 15:51:44');
INSERT INTO `eacoo_action_log` VALUES ('186', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 17:15:51');
INSERT INTO `eacoo_action_log` VALUES ('187', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 17:16:43');
INSERT INTO `eacoo_action_log` VALUES ('188', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 17:17:47');
INSERT INTO `eacoo_action_log` VALUES ('189', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 17:18:29');
INSERT INTO `eacoo_action_log` VALUES ('190', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 17:38:57');
INSERT INTO `eacoo_action_log` VALUES ('191', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-16 18:24:00');
INSERT INTO `eacoo_action_log` VALUES ('192', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-17 09:16:38');
INSERT INTO `eacoo_action_log` VALUES ('193', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-17 09:17:02');
INSERT INTO `eacoo_action_log` VALUES ('194', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-17 09:24:03');
INSERT INTO `eacoo_action_log` VALUES ('195', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-19 09:05:11');
INSERT INTO `eacoo_action_log` VALUES ('196', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '192.168.0.110', '登录后台', 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko Core/1.70.3719.400 QQBrowser/10.5.3715.400', '2019-10-19 11:05:08');
INSERT INTO `eacoo_action_log` VALUES ('197', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-19 11:10:27');
INSERT INTO `eacoo_action_log` VALUES ('198', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-19 13:46:00');
INSERT INTO `eacoo_action_log` VALUES ('199', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-19 14:07:38');
INSERT INTO `eacoo_action_log` VALUES ('200', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-19 14:19:15');
INSERT INTO `eacoo_action_log` VALUES ('201', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-21 09:26:10');
INSERT INTO `eacoo_action_log` VALUES ('202', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/plotting_details/setstatus/status/delete.html?model=PlottingDetails', '{\"param\":{\"model\":\"PlottingDetails\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-21 10:07:10');
INSERT INTO `eacoo_action_log` VALUES ('203', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '192.168.0.116', '登录后台', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Mobile Safari/537.36', '2019-10-21 10:08:00');
INSERT INTO `eacoo_action_log` VALUES ('204', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-21 10:08:15');
INSERT INTO `eacoo_action_log` VALUES ('205', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/plotting_details/setstatus/status/delete.html?model=PlottingDetails', '{\"param\":{\"model\":\"PlottingDetails\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-21 11:44:59');
INSERT INTO `eacoo_action_log` VALUES ('206', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/attachment/setstatus/status/delete/model/attachment.html', '{\"param\":[]}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-21 11:52:12');
INSERT INTO `eacoo_action_log` VALUES ('207', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-22 16:53:11');
INSERT INTO `eacoo_action_log` VALUES ('208', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-23 09:21:12');
INSERT INTO `eacoo_action_log` VALUES ('209', '15', '1', '1', 'admin', 'POST', '/admin.php/admin/plotting_details/setstatus/status/delete.html?model=PlottingDetails', '{\"param\":{\"model\":\"PlottingDetails\"}}', '127.0.0.1', '改变数据状态', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-23 15:29:36');
INSERT INTO `eacoo_action_log` VALUES ('210', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-24 09:14:25');
INSERT INTO `eacoo_action_log` VALUES ('211', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-25 15:30:23');
INSERT INTO `eacoo_action_log` VALUES ('212', '1', '1', '1', 'admin', 'POST', '/admin.php/admin/login/index.html', '{\"param\":[]}', '127.0.0.1', '登录后台', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36', '2019-10-28 09:24:21');

-- ----------------------------
-- Table structure for eacoo_ad
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_ad`;
CREATE TABLE `eacoo_ad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '1' COMMENT '分类id',
  `icon` int(11) NOT NULL DEFAULT '0' COMMENT 'banner图片',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='广告';

-- ----------------------------
-- Records of eacoo_ad
-- ----------------------------
INSERT INTO `eacoo_ad` VALUES ('1', '1', '180', '1', '1568966687', '1571221945');
INSERT INTO `eacoo_ad` VALUES ('2', '1', '180', '1', '1568966687', '1571221918');
INSERT INTO `eacoo_ad` VALUES ('3', '1', '180', '1', '1568966687', '1571212355');
INSERT INTO `eacoo_ad` VALUES ('4', '1', '180', '1', '1568966750', '1571212362');

-- ----------------------------
-- Table structure for eacoo_admin
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_admin`;
CREATE TABLE `eacoo_admin` (
  `uid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员UID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(150) NOT NULL DEFAULT '' COMMENT '用户头像，相对于uploads/avatar目录',
  `sex` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '个人介绍',
  `login_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '最后登录时间',
  `activation_auth_sign` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `bind_uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '绑定前台用户ID（可选）',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '注册时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '用户状态 0：禁用； 1：正常 ；2：待验证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uniq_username` (`username`) USING BTREE,
  KEY `idx_email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员用户表';

-- ----------------------------
-- Records of eacoo_admin
-- ----------------------------
INSERT INTO `eacoo_admin` VALUES ('1', 'admin', '031c9ffc4b280d3e78c750163d07d275', '创始人', 'admin@admin.com', '', 'http://cdn.eacoo.xin/attachment/static/assets/img/default-avatar.png', '0', '', '0', '127.0.0.1', '2019-10-28 09:24:21', '29f0c8e1f9ee2395fcd3bf816f82686321edf3e7', '1', '2019-05-18 08:57:43', '2019-05-18 08:57:43', '1');

-- ----------------------------
-- Table structure for eacoo_article
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_article`;
CREATE TABLE `eacoo_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型：1公司简介 2荣誉资质 3视频展示 4组织结构 5业务介绍 6 下载中心上传文件',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '标题',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '当type为5业务介绍时，pid就是category的分类id',
  `content_brief` varchar(6000) NOT NULL DEFAULT '0' COMMENT '业务介绍简介',
  `content` text NOT NULL COMMENT '内容',
  `void` int(11) NOT NULL DEFAULT '0' COMMENT '视频id',
  `void_top` tinyint(4) NOT NULL DEFAULT '0' COMMENT '视频首页推荐:1推荐 0不推荐',
  `void_time` varchar(50) NOT NULL DEFAULT '0' COMMENT '视频时长',
  `icon` int(11) NOT NULL DEFAULT '0' COMMENT '图片id',
  `file_icon` int(11) NOT NULL DEFAULT '0' COMMENT '文件路径id',
  `file_icon_path` varchar(255) NOT NULL DEFAULT '0' COMMENT '文件封面图路径',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  `browse` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='内容表';

-- ----------------------------
-- Records of eacoo_article
-- ----------------------------
INSERT INTO `eacoo_article` VALUES ('2', '1', '重庆市江北保安服务有限公司', '0', '0', '<p>&nbsp; &nbsp; &nbsp; &nbsp;重庆市江北保安服务有限责任公司（简称“江北保安”），于1988年5月成立，是重庆保安行业成立最早、保安队伍规模最大的保安公司之一；是中国保安协会理事单位；是重庆乃至西部片区保安行业的领军</p><p>企业。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;2013年11月，按照保安企业体制机制改革要求，公司从区公安分局划转分离，由区国资委接管。2017年12月，在“国企改制”的大背景下，在江北区委、区政府，区国资委的指导和支持下，公司完成混合所</p><p>有制改革，上海英盾安防集团控股85%，国资委管理重点企业宏融集团控股15%，进一步整合了优质资源，提升了现代化企业管理水平。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;经过30年发展，现拥有保安队员约5000人、优质客户单位600多家，成为西部人防队伍规模最大的一家保安公司。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;江北保安是重庆市最先取得IS0：9001质量管理体系的企业，也是重庆首家全国优秀保安企业。公司三个执勤点被中华全国总工会、共青团中央、公安部授予青年文明号执勤点。多名保安员被评为“全国先进</p><p>保安员”。</p><p><br/></p>', '0', '0', '0', '176', '0', '0', '1', '1568600069', '1568600069', '6');
INSERT INTO `eacoo_article` VALUES ('3', '2', '中国保安协会理事单位', '0', '0', '', '12', '0', '0', '145', '0', '0', '1', '1568863550', '1568863550', '0');
INSERT INTO `eacoo_article` VALUES ('4', '2', '质量管理体系认证证书', '0', '0', '', '12', '0', '0', '144', '0', '0', '1', '1568863357', '1568863357', '0');
INSERT INTO `eacoo_article` VALUES ('5', '2', '中国保安协会会员单位', '0', '0', '', '0', '0', '0', '147', '0', '0', '1', '1568863600', '1568863600', '0');
INSERT INTO `eacoo_article` VALUES ('6', '2', '中国保安协会会员单位', '0', '0', '', '0', '0', '0', '146', '0', '0', '1', '1568863616', '1568863616', '0');
INSERT INTO `eacoo_article` VALUES ('7', '3', '江北保安团队展示', '0', '0', '', '152', '0', '00:16', '0', '0', '0', '1', '1568882694', '1568882694', '0');
INSERT INTO `eacoo_article` VALUES ('8', '3', '公司新年祝福', '0', '0', '', '152', '0', '00:16', '0', '0', '0', '1', '1568882827', '1568882827', '0');
INSERT INTO `eacoo_article` VALUES ('9', '3', '公司年会奖金现场', '0', '0', '', '152', '1', '00:16', '0', '0', '0', '1', '1569217140', '1569217140', '0');
INSERT INTO `eacoo_article` VALUES ('10', '4', '机构设置', '0', '0', '', '0', '0', '0', '153', '0', '0', '1', '1568882861', '1568882861', '0');
INSERT INTO `eacoo_article` VALUES ('13', '5', '0', '11', '我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务', '<p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 人防服务</strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"http://127.0.0.1:8080/uploads/picture/2019-09-20/5d842442eea88.png\"/></strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 人防服务<br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><span style=\"font-size: 16px;\">&nbsp; &nbsp; &nbsp; 我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务。&nbsp;</span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 重庆市保盛防范技术工程有限公司是经重庆市公安局安防办批准的一级安防工程公司.自公司成立以来,立足于高科技,在</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公安机关各领导的支持下,依托高等学府,设计院的研发实务和雄厚的人才优势,技术优势,建立了广泛的合作网络和庞大的客户</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;群。公司倡导“以人为本”的企业精神，聚集了一大批具有奉献精神，敬业守道的人才，可随时为有需要的客户提供一流的</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术协助和支持，形成了一套科学实用的设计施工体系，拥有一套完善的售后服务体系。</p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span><br/></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp; &nbsp; &nbsp;</span><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p>', '0', '0', '0', '0', '0', '0', '1', '1569207818', '1569207818', '0');
INSERT INTO `eacoo_article` VALUES ('14', '5', '0', '12', '我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务', '<p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 技防服务</strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"http://127.0.0.1:8080/uploads/picture/2019-09-20/5d842442eea88.png\"/></strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 技防服务<br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><span style=\"font-size: 16px;\">&nbsp; &nbsp; &nbsp; 我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务。&nbsp;</span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 重庆市保盛防范技术工程有限公司是经重庆市公安局安防办批准的一级安防工程公司.自公司成立以来,立足于高科技,在</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公安机关各领导的支持下,依托高等学府,设计院的研发实务和雄厚的人才优势,技术优势,建立了广泛的合作网络和庞大的客户</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;群。公司倡导“以人为本”的企业精神，聚集了一大批具有奉献精神，敬业守道的人才，可随时为有需要的客户提供一流的</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术协助和支持，形成了一套科学实用的设计施工体系，拥有一套完善的售后服务体系。</p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span><br/></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp; &nbsp; &nbsp;</span><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p>', '0', '0', '0', '0', '0', '0', '1', '1569207809', '1569207809', '0');
INSERT INTO `eacoo_article` VALUES ('15', '5', '0', '13', '我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务', '<p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 亮点服务</strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"http://127.0.0.1:8080/uploads/picture/2019-09-20/5d842442eea88.png\"/></strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 亮点服务<br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><span style=\"font-size: 16px;\">&nbsp; &nbsp; &nbsp; 我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务。&nbsp;</span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 重庆市保盛防范技术工程有限公司是经重庆市公安局安防办批准的一级安防工程公司.自公司成立以来,立足于高科技,在</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公安机关各领导的支持下,依托高等学府,设计院的研发实务和雄厚的人才优势,技术优势,建立了广泛的合作网络和庞大的客户</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;群。公司倡导“以人为本”的企业精神，聚集了一大批具有奉献精神，敬业守道的人才，可随时为有需要的客户提供一流的</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术协助和支持，形成了一套科学实用的设计施工体系，拥有一套完善的售后服务体系。</p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span><br/></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp; &nbsp; &nbsp;</span><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p>', '0', '0', '0', '0', '0', '0', '1', '1569207802', '1569207802', '0');
INSERT INTO `eacoo_article` VALUES ('16', '5', '0', '14', '我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务', '<p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 培训服务</strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"http://127.0.0.1:8080/uploads/picture/2019-09-20/5d842442eea88.png\"/></strong></span></p><p><span style=\"font-size: 18px;\"><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp; &nbsp; 培训服务<br/></strong></span></p><p><span style=\"font-size: 18px;\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><span style=\"font-size: 16px;\">&nbsp; &nbsp; &nbsp; 我们致力于将先进高科技和安全防范理念有机整合,人技结合,双轨并行,为社会及公众提供全方位的安全服务。&nbsp;</span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 重庆市保盛防范技术工程有限公司是经重庆市公安局安防办批准的一级安防工程公司.自公司成立以来,立足于高科技,在</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公安机关各领导的支持下,依托高等学府,设计院的研发实务和雄厚的人才优势,技术优势,建立了广泛的合作网络和庞大的客户</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;群。公司倡导“以人为本”的企业精神，聚集了一大批具有奉献精神，敬业守道的人才，可随时为有需要的客户提供一流的</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术协助和支持，形成了一套科学实用的设计施工体系，拥有一套完善的售后服务体系。</p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span><br/></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\"><br/></span></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp; &nbsp; &nbsp;</span><strong><br/></strong></span></p><p><span style=\"font-size: 18px;\"><span style=\"font-size: 16px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></span></span></p>', '0', '0', '0', '0', '0', '0', '1', '1569207793', '1569207793', '0');
INSERT INTO `eacoo_article` VALUES ('17', '6', '测试文件', '0', '0', '', '0', '0', '0', '0', '159', '/static/assets/img/file-doc.png', '1', '1568957965', '1568957965', '0');

-- ----------------------------
-- Table structure for eacoo_attachment
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_attachment`;
CREATE TABLE `eacoo_attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否后台用户上传',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '文件链接（暂时无用）',
  `location` varchar(15) NOT NULL DEFAULT '' COMMENT '文件存储位置(或驱动)',
  `path_type` varchar(20) DEFAULT 'picture' COMMENT '路径类型，存储在uploads的哪个目录中',
  `ext` char(4) NOT NULL DEFAULT '' COMMENT '文件类型',
  `mime_type` varchar(60) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `alt` varchar(255) DEFAULT NULL COMMENT '替代文本图像alt',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件sha1编码',
  `download` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '上传时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `sort` mediumint(8) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_paty_type` (`path_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COMMENT='附件表';

-- ----------------------------
-- Records of eacoo_attachment
-- ----------------------------
INSERT INTO `eacoo_attachment` VALUES ('1', '1', '1', 'preg_match_imgs.jpeg', '/uploads/Editor/Picture/2016-06-12/575d4bd8d0351.jpeg', '', 'local', 'editor', 'jpeg', '', '19513', '', '4cf157e42b44c95d579ee39b0a1a48a4', 'dee76e7b39f1afaad14c1e03cfac5f6031c3c511', '0', '2018-09-30 12:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('2', '1', '1', 'gerxiangimg200x200.jpg', '/uploads/Editor/Picture/2016-06-12/575d4bfb09961.jpg', '', 'local', 'editor', 'jpg', '', '5291', 'gerxiangimg200x200', '4db879c357c4ab80c77fce8055a0785f', '480eb2e097397856b99b373214fb28c2f717dacf', '0', '2018-09-30 13:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('3', '1', '1', 'oraclmysqlzjfblhere.jpg', '/uploads/Editor/Picture/2016-06-12/575d4c691e976.jpg', '', 'local', 'editor', 'jpg', '', '23866', 'mysql', '5a3a5a781a6d9b5f0089f6058572f850', 'a17bfe395b29ba06ae5784486bcf288b3b0adfdb', '0', '2018-09-30 14:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('4', '1', '1', 'logo.png', '/logo.png', '', 'local', 'picture', 'jpg', '', '40000', 'eacoophp-logo', '', '', '0', '2018-09-30 15:12:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('10', '1', '1', '苹果短信-三全音 - 铃声', '/uploads/file/2016-07-27/579857b5aca95.mp3', '', 'local', 'file', 'mp3', '', '19916', null, 'bab00edb8d6a5cf4de5444a2e5c05009', '73cda0fb4f947dcb496153d8b896478af1247935', '0', '2018-09-30 15:15:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `eacoo_attachment` VALUES ('12', '1', '1', 'music', '/uploads/file/2016-07-28/57995fe9bf0da.mp3', '', 'local', 'file', 'mp3', '', '160545', null, '935cd1b8950f1fdcd23d47cf791831cf', '73c318221faa081544db321bb555148f04b61f00', '0', '2018-09-30 15:16:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('13', '1', '1', '7751775467283337', '/uploads/picture/2016-09-26/57e8dc9d29b01.jpg', '', 'local', 'picture', 'jpg', '', '70875', null, '3e3bfc950aa0b6ebb56654c15fe8e392', 'c75e70753eaf36aaee10efb3682fdbd8f766d32d', '0', '2018-09-30 15:17:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `eacoo_attachment` VALUES ('94', '1', '1', 'eacoophp-watermark-banner-1', 'http://cdn.eacoophp.com/static/demo-eacoophp/eacoophp-watermark-banner-1.jpg', 'http://cdn.eacoophp.com/static/demo-eacoophp/eacoophp-watermark-banner-1.jpg', 'link', 'picture', 'jpg', 'image', '171045', 'eacoophp-watermark-banner-1', '', '', '0', '2018-09-30 22:32:23', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('95', '1', '1', 'eacoophp-banner-3', 'http://cdn.eacoophp.com/static/demo-eacoophp/eacoophp-banner-3.jpg', 'http://cdn.eacoophp.com/static/demo-eacoophp/eacoophp-banner-3.jpg', 'link', 'picture', 'jpg', 'image', '356040', 'eacoophp-banner-3', '', '', '0', '2018-09-30 22:32:24', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('96', '1', '1', 'eacoophp-watermark-banner-2', 'http://cdn.eacoophp.com/static/demo-eacoophp/eacoophp-watermark-banner-2.jpg', 'http://cdn.eacoophp.com/static/demo-eacoophp/eacoophp-watermark-banner-2.jpg', 'link', 'picture', 'jpg', 'image', '356040', 'eacoophp-watermark-banner-2', '', '', '0', '2018-09-30 22:32:25', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('179', '0', '0', 'toux', '/static/uploads/2019-10-15\\min916c8296f42805e313859236a7f49b6d.png', '/static/uploads/2019-10-15\\20191015\\916c8296f42805e313859236a7f49b6d.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('180', '1', '1', 'banner', '/uploads/picture/2019-10-16/5da6cc283a92f.png', '/uploads/picture/2019-10-16/5da6cc283a92f.png', 'local', 'picture', 'png', 'image', '133776', 'banner', '57276683254ab6e4cda3e65531884328', '09ba7c03acaac50ea04206e3b6af91440c9546c2', '0', '2019-10-16 15:52:08', '2019-10-16 15:52:08', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('181', '1', '1', '商品图1', '/uploads/picture/2019-10-16/5da6d59f73a30.png', '/uploads/picture/2019-10-16/5da6d59f73a30.png', 'local', 'picture', 'png', 'image', '336853', '商品图1', 'be7c684f02329c3ac83e6fe7db6e39bf', '5938c398e0344c5f3a7778d9413cc13aa3881ade', '0', '2019-10-16 16:32:31', '2019-10-16 16:32:31', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('182', '1', '1', '商品图2', '/uploads/picture/2019-10-16/5da6d70107d5e.png', '/uploads/picture/2019-10-16/5da6d70107d5e.png', 'local', 'picture', 'png', 'image', '265387', '商品图2', '576ca2fa607b3b9529b2949129c383d3', 'f780ed37d4c88482490ad9c4d04dad37a6892096', '0', '2019-10-16 16:38:25', '2019-10-16 16:38:25', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('183', '1', '1', '商品图4', '/uploads/picture/2019-10-16/5da6e1cb8123e.png', '/uploads/picture/2019-10-16/5da6e1cb8123e.png', 'local', 'picture', 'png', 'image', '207581', '商品图4', '1cdb5979883872e6c67e1eba16f6cb56', '2c9539b855c5ade7b2f08c403712d9e8b7e54dd0', '0', '2019-10-16 17:24:27', '2019-10-16 17:24:27', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('188', '1', '1', '商品图5', '/uploads/picture/2019-10-17/5da7c12a4581b.png', '/uploads/picture/2019-10-17/5da7c12a4581b.png', 'local', 'picture', 'png', 'image', '114167', '商品图5', '29eafe6d676eebe0434d9070e3e8cc26', '03f3e0d6fa7e8016652baa4ebc658bc6f43cf235', '0', '2019-10-17 09:17:30', '2019-10-17 09:17:30', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('189', '1', '1', '商品图3', '/uploads/picture/2019-10-17/5da7c1e9842c2.png', '/uploads/picture/2019-10-17/5da7c1e9842c2.png', 'local', 'picture', 'png', 'image', '200089', '商品图3', 'a8cafb13262a0d751395f05059830236', 'de02ff13f4a2983cee35f0b6df929ae83405a5a8', '0', '2019-10-17 09:20:41', '2019-10-17 09:20:41', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('191', '1', '1', '123', '/uploads/picture/2019-10-17/5da7c2f103f51.png', '/uploads/picture/2019-10-17/5da7c2f103f51.png', 'local', 'picture', 'png', 'image', '32036240', '123', 'e943be715ec26a31de9eaf2fbc9e0a01', 'b429183acc46d2a4db0689705b6aa4998e410be2', '0', '2019-10-17 09:25:05', '2019-10-17 09:25:05', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('198', '0', '0', 'toux', '/upload_3dpic/2019-10-17\\mina38fdd02068ac5de4573566c0d1d8e77.png', '/upload_3dpic/2019-10-17\\20191017\\a38fdd02068ac5de4573566c0d1d8e77.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('206', '0', '0', 'toux', '/upload_3dpic/2019-10-19\\min205d18540686d8eaa72b3fe95cb5c7e8.png', '/upload_3dpic/2019-10-19\\20191019\\205d18540686d8eaa72b3fe95cb5c7e8.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('209', '1', '1', '中島健太郎 - Looming Dread', '/uploads/file/2019-10-19/5daaa8d9bc4aa.mp3', '/uploads/file/2019-10-19/5daaa8d9bc4aa.mp3', 'local', 'file', 'mp3', 'audio', '5748868', '中島健太郎 - Looming Dread', '1b7ab45dd8fb970f04fb1cbfc2993f3b', 'ddd934aebf7d1e2be497119cb9df5c2a22383da3', '0', '2019-10-19 14:10:33', '2019-10-19 14:10:33', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('211', '0', '0', 'toux', '/upload_3dpic/2019-10-19\\minb22e9b63faddf572752defa9427e0f38.png', '/upload_3dpic/2019-10-19\\20191019\\b22e9b63faddf572752defa9427e0f38.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('217', '0', '0', 'toux', '/upload_3dpic/2019-10-21\\minba98a7fd88d3aac2edfa4832d6d5184e.png', '/upload_3dpic/2019-10-21\\20191021\\ba98a7fd88d3aac2edfa4832d6d5184e.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('218', '1', '1', 'IMG_1729拷贝3@2x', '/uploads/picture/2019-10-23/5dafab2e3564c.png', '/uploads/picture/2019-10-23/5dafab2e3564c.png', 'local', 'picture', 'png', 'image', '15239', 'IMG_1729拷贝3@2x', 'fbfd82c31be7f59257734c7a2844962f', '61b58dcb82789e3337c946664ecbffa95ed504f3', '0', '2019-10-23 09:21:50', '2019-10-23 09:21:50', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('219', '1', '1', '款式', '/uploads/picture/2019-10-23/5dafab3c1f165.png', '/uploads/picture/2019-10-23/5dafab3c1f165.png', 'local', 'picture', 'png', 'image', '6995', '款式', '546425c11062c270a048516716fff1e4', '4cc54dcaa926eb1fca305f7b994b50ef4874972c', '0', '2019-10-23 09:22:04', '2019-10-23 09:22:04', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('220', '1', '1', '风格', '/uploads/picture/2019-10-23/5dafab4b93cf9.png', '/uploads/picture/2019-10-23/5dafab4b93cf9.png', 'local', 'picture', 'png', 'image', '6453', '风格', '048adbd8e5b5c495d0f8a3792c3e7f54', '0ec646e9404909323331c2eb94ac3b2e69de2017', '0', '2019-10-23 09:22:19', '2019-10-23 09:22:19', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('221', '0', '0', 'toux', '/upload_3dpic/2019-10-23\\min6620962ecaff38b30b7cde97529bfd51.png', '/upload_3dpic/2019-10-23\\20191023\\6620962ecaff38b30b7cde97529bfd51.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('222', '0', '0', 'toux', '/upload_3dpic/2019-10-23\\min2f9bc0e9f2e40822db156e0c80ba30a4.png', '/upload_3dpic/2019-10-23\\20191023\\2f9bc0e9f2e40822db156e0c80ba30a4.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('223', '0', '0', 'toux', '/upload_3dpic/2019-10-23\\min6d56e9dc742305972cac5f3fcb8b66eb.png', '/upload_3dpic/2019-10-23\\20191023\\6d56e9dc742305972cac5f3fcb8b66eb.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('224', '0', '0', 'toux', '/upload_3dpic/2019-10-25\\min4af640195ee9b8b3e71e781611412f0e.png', '/upload_3dpic/2019-10-25\\20191025\\4af640195ee9b8b3e71e781611412f0e.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('225', '0', '0', 'toux', '/upload_3dpic/2019-10-25\\minf05a5434ed1a4f61c53acad24fb04a38.png', '/upload_3dpic/2019-10-25\\20191025\\f05a5434ed1a4f61c53acad24fb04a38.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('226', '0', '0', 'toux', '/upload_3dpic/2019-10-25\\min0221cfa816f52d74604a60a5bbdffc72.png', '/upload_3dpic/2019-10-25\\20191025\\0221cfa816f52d74604a60a5bbdffc72.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');
INSERT INTO `eacoo_attachment` VALUES ('227', '0', '0', 'toux', '/upload_3dpic/2019-10-25\\min1ea7b44c4f859906c192ec34a591dfac.png', '/upload_3dpic/2019-10-25\\20191025\\1ea7b44c4f859906c192ec34a591dfac.png', '', 'picture', '', '', '0', null, '', '', '0', '0000-00-00 00:00:00', '0001-01-01 00:00:00', '99', '1');

-- ----------------------------
-- Table structure for eacoo_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_auth_group`;
CREATE TABLE `eacoo_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) DEFAULT NULL COMMENT '描述信息',
  `rules` varchar(160) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1启用，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of eacoo_auth_group
-- ----------------------------
INSERT INTO `eacoo_auth_group` VALUES ('1', '超级管理员', '拥有网站的最高权限', '1,2,6,18,9,12,19,25,17,26,3,7,21,43,44,4,37,38,39,40,41,42,5,22,23,30,24,10,11,13,14,20,32,15,8,16,45,27,28,29', '1');
INSERT INTO `eacoo_auth_group` VALUES ('2', '管理员', '授权管理员', '1,6,18,12,19,26,3,7,21,44,4,37,38,39,40,41,42,5,22,23,30,24,10,11,13,14,20,15,8,16,27,28,29', '1');
INSERT INTO `eacoo_auth_group` VALUES ('3', '普通用户', '这是普通用户的权限', '1,3,8,10,11,94,95,96,97,98,99,41,42,43,44,38,39,40', '1');
INSERT INTO `eacoo_auth_group` VALUES ('4', '客服', '客服处理订单发货', '1,27,28,29,7,4,52,53,54,55', '1');

-- ----------------------------
-- Table structure for eacoo_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_auth_group_access`;
CREATE TABLE `eacoo_auth_group_access` (
  `uid` int(11) unsigned NOT NULL COMMENT '管理员用户ID',
  `group_id` mediumint(8) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否审核  2：未审核，1:启用，0：禁用，-1：删除',
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组明细表';

-- ----------------------------
-- Records of eacoo_auth_group_access
-- ----------------------------
INSERT INTO `eacoo_auth_group_access` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for eacoo_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_auth_rule`;
CREATE TABLE `eacoo_auth_rule` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '' COMMENT '导航链接',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '导航名字',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '来源类型。1module，2plugin，3theme',
  `depend_flag` varchar(30) NOT NULL DEFAULT '' COMMENT '来源标记。如：模块或插件标识',
  `type` tinyint(1) DEFAULT '1' COMMENT '是否支持规则表达式',
  `pid` smallint(6) unsigned DEFAULT '0' COMMENT '上级id',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `condition` char(200) DEFAULT '',
  `is_menu` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否菜单',
  `position` varchar(20) DEFAULT 'admin' COMMENT '菜单显示位置。如果是插件就写模块名',
  `developer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '开发者',
  `sort` smallint(6) unsigned DEFAULT '99' COMMENT '排序，值越小越靠前',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COMMENT='规则表（后台菜单）';

-- ----------------------------
-- Records of eacoo_auth_rule
-- ----------------------------
INSERT INTO `eacoo_auth_rule` VALUES ('1', 'admin/dashboard/index', '仪表盘', '1', 'admin', '1', '0', 'fa fa-tachometer', null, '1', 'admin', '0', '3', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('2', 'admin/manage', '系统管理', '1', 'admin', '1', '0', 'fa fa-cog', null, '1', 'admin', '0', '7', '2018-12-03 00:47:34', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('3', 'user/user/', '会员管理', '1', 'user', '1', '0', 'fa fa-users', null, '1', 'user', '0', '28', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('4', 'admin/attachment/index', '附件空间', '1', 'admin', '1', '0', 'fa fa-picture-o', null, '1', 'admin', '0', '28', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('5', 'admin/extend/index', '应用中心', '1', 'admin', '1', '0', 'fa fa-cloud', null, '1', 'admin', '0', '30', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('6', 'admin/navigation/index', '前台导航菜单', '1', 'admin', '1', '0', 'fa fa-leaf', null, '1', 'admin', '0', '25', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('7', 'user/user/index', '用户列表', '1', 'user', '1', '0', 'fa fa-user', null, '1', 'user', '0', '4', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('8', 'admin/AuthGroup/index', '角色组', '1', 'admin', '1', '0', '', null, '1', 'admin', '0', '10', '2018-12-03 00:49:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('9', 'admin/menu/index', '后台菜单管理', '1', 'admin', '1', '2', 'fa fa-inbox', null, '1', 'admin', '1', '31', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('10', 'tools', '工具', '1', 'admin', '1', '0', 'fa fa-gavel', null, '1', 'admin', '1', '29', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('11', 'admin/database', '安全', '1', 'admin', '1', '10', 'fa fa-database', null, '0', 'admin', '0', '32', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('12', 'admin/attachment/setting', '设置', '1', 'admin', '1', '0', '', null, '0', 'admin', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('13', 'admin/link/index', '友情链接', '1', 'admin', '1', '10', '', null, '1', 'admin', '0', '26', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('14', 'admin/link/edit', '链接编辑', '1', 'admin', '1', '13', '', null, '0', 'admin', '0', '4', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('15', 'user/auth', '权限管理', '1', 'user', '1', '0', 'fa fa-sun-o', null, '1', 'user', '0', '25', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('16', 'admin/auth/index', '规则管理', '1', 'admin', '1', '2', 'fa fa-500px', null, '1', 'admin', '0', '19', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('17', 'admin/config/edit', '配置编辑或添加', '1', 'admin', '1', '25', '', null, '0', 'admin', '0', '27', '2018-12-02 22:56:27', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('18', 'admin/navigation/edit', '导航编辑或添加', '1', 'admin', '1', '6', '', null, '0', 'admin', '0', '5', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('19', 'admin/config/website', '网站设置', '1', 'admin', '1', '0', '', null, '1', 'admin', '0', '6', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('20', 'admin/database/index', '数据库管理', '1', 'admin', '1', '10', 'fa fa-database', null, '1', 'admin', '0', '33', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('21', 'user/user/resetPassword', '修改密码', '1', 'user', '1', '0', '', '', '1', 'user', '0', '40', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('22', 'admin/theme/index', '主题', '1', 'admin', '1', '5', 'fa fa-cloud', null, '1', 'admin', '0', '22', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('23', 'admin/plugins/index', '插件', '1', 'admin', '1', '5', 'fa fa-cloud', null, '1', 'admin', '0', '20', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('24', 'admin/modules/index', '模块', '1', 'admin', '1', '5', 'fa fa-cloud', null, '1', 'admin', '0', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('25', 'admin/config/index', '配置管理', '1', 'admin', '1', '2', '', null, '1', 'admin', '1', '34', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('26', 'admin/config/group', '系统设置', '1', 'admin', '1', '2', '', null, '1', 'admin', '0', '8', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('27', 'admin/action', '行为管理', '1', 'admin', '1', '0', 'fa fa-list-alt', null, '1', 'admin', '0', '23', '2018-12-03 00:10:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('28', 'admin/action/index', '用户行为', '1', 'admin', '1', '27', '', null, '1', 'admin', '0', '11', '2018-12-03 00:08:20', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('29', 'admin/action/log', '行为日志', '1', 'admin', '1', '27', 'fa fa-address-book-o', null, '1', 'admin', '0', '21', '2018-12-03 00:08:30', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('30', 'admin/plugins/hooks', '钩子管理', '1', 'admin', '1', '23', '', null, '0', 'admin', '1', '12', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('32', 'admin/mailer/template', '邮件模板', '1', 'admin', '1', '10', null, null, '1', 'admin', '0', '24', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('37', 'admin/attachment/attachmentCategory', '附件分类', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '13', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('38', 'admin/attachment/upload', '文件上传', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '14', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('39', 'admin/attachment/uploadPicture', '上传图片', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '15', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('40', 'admin/attachment/upload_onlinefile', '添加外链附件', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '16', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('41', 'admin/attachment/attachmentInfo', '附件详情', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '17', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('42', 'admin/attachment/uploadAvatar', '上传头像', '1', 'admin', '1', '4', null, null, '0', 'admin', '0', '18', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('43', 'user/tags/index', '标签管理', '1', 'user', '1', '0', '', null, '1', 'user', '0', '22', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('44', 'user/tongji/analyze', '会员统计', '1', 'user', '1', '0', '', null, '1', 'user', '0', '27', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('45', 'admin/AdminUser/index', '管理员', '1', 'admin', '1', '0', 'fa fa-users', '', '1', 'admin', '0', '9', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('54', 'admin/about/index', '联系我们', '1', 'admin', '1', '0', 'fa fa-angellist', '', '1', 'admin', '0', '15', '2019-09-20 14:27:29', '2019-06-06 14:40:34', '0');
INSERT INTO `eacoo_auth_rule` VALUES ('57', 'admin/category', '分类管理', '1', 'admin', '1', '0', 'fa fa-align-center', '', '1', 'admin', '0', '5', '2019-09-19 09:24:13', '2019-07-09 10:03:59', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('73', 'admin/category/index', '分类列表', '1', 'admin', '1', '57', 'fa fa-adn', '', '1', 'admin', '0', '1', '2019-09-19 17:08:15', '2019-09-19 09:24:41', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('87', 'admin/ad/index', 'Banner管理', '1', 'admin', '1', '0', 'fa fa-cc-mastercard', '', '1', 'admin', '0', '15', '2019-09-20 16:02:30', '2019-09-20 16:02:30', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('89', 'admin/member/index', '商家管理', '1', 'admin', '1', '0', 'fa fa-android', '', '1', 'admin', '0', '2', '2019-10-15 17:19:50', '2019-10-15 17:19:50', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('90', 'admin/set/index', '联系客户', '1', 'admin', '1', '0', 'fa fa-angellist', '', '1', 'admin', '0', '3', '2019-10-16 15:24:54', '2019-10-16 15:24:54', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('92', 'admin/plotting', '展绘管理', '1', 'admin', '1', '0', 'fa fa-apple', '', '1', 'admin', '0', '5', '2019-10-16 16:34:43', '2019-10-16 16:34:43', '1');
INSERT INTO `eacoo_auth_rule` VALUES ('93', 'admin/plotting/index', '展绘列表', '1', 'admin', '1', '92', 'fa fa-anchor', '', '1', 'admin', '0', '1', '2019-10-16 16:35:22', '2019-10-16 16:35:22', '1');

-- ----------------------------
-- Table structure for eacoo_case
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_case`;
CREATE TABLE `eacoo_case` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型：1案例 2幸福生活',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '标题',
  `icon` int(11) NOT NULL DEFAULT '0' COMMENT '首图',
  `content` text NOT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁止',
  `course_time` int(11) NOT NULL DEFAULT '0' COMMENT '案例时间/幸福生活时间',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='案例/幸福生活';

-- ----------------------------
-- Records of eacoo_case
-- ----------------------------
INSERT INTO `eacoo_case` VALUES ('1', '1', '江北保安温暖举动获17万点赞', '177', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568908800', '1569286792', '1569286792');
INSERT INTO `eacoo_case` VALUES ('2', '1', '江北保安温暖举动获17万点赞', '177', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568944157', '1568944160', '1568944160');
INSERT INTO `eacoo_case` VALUES ('3', '1', '江北保安温暖举动获17万点赞', '177', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568944157', '1568944160', '1568944160');
INSERT INTO `eacoo_case` VALUES ('4', '1', '江北保安温暖举动获17万点赞', '177', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568944157', '1568944160', '1568944160');
INSERT INTO `eacoo_case` VALUES ('5', '1', '江北保安温暖举动获17万点赞', '177', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568944157', '1568944160', '1568944160');
INSERT INTO `eacoo_case` VALUES ('6', '1', '江北保安温暖举动获17万点赞', '177', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568944157', '1568944160', '1568944160');
INSERT INTO `eacoo_case` VALUES ('7', '2', '点赞铁血担当 为“西部铁军”打call ', '178', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568908800', '1569287761', '1569287761');
INSERT INTO `eacoo_case` VALUES ('8', '1', '江北保安温暖举动获17万点赞', '177', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '1568944157', '1568944160', '1568944160');

-- ----------------------------
-- Table structure for eacoo_category
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_category`;
CREATE TABLE `eacoo_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型：1展绘分类',
  `icon` int(11) NOT NULL DEFAULT '0' COMMENT '分类图片',
  `url` varchar(255) NOT NULL DEFAULT '0' COMMENT '跳转地址',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '导航标题',
  `content` varchar(6000) NOT NULL DEFAULT '0' COMMENT '导航简介',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='首页导航';

-- ----------------------------
-- Records of eacoo_category
-- ----------------------------
INSERT INTO `eacoo_category` VALUES ('27', '1', '220', '0', '材质', '0', '1', '1571211889', '1571793742');
INSERT INTO `eacoo_category` VALUES ('28', '1', '219', '0', '风格', '0', '1', '1571211904', '1571793728');
INSERT INTO `eacoo_category` VALUES ('29', '1', '218', '0', '款式', '0', '1', '1571211916', '1571793714');

-- ----------------------------
-- Table structure for eacoo_config
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_config`;
CREATE TABLE `eacoo_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '配置名称',
  `title` varchar(50) NOT NULL COMMENT '配置说明',
  `value` text NOT NULL COMMENT '配置值',
  `options` varchar(255) NOT NULL COMMENT '配置额外值',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `sub_group` tinyint(3) DEFAULT '0' COMMENT '子分组，子分组需要自己定义',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT '配置类型',
  `remark` varchar(500) NOT NULL COMMENT '配置说明',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
-- Records of eacoo_config
-- ----------------------------
INSERT INTO `eacoo_config` VALUES ('1', 'toggle_web_site', '站点开关', '1', '0:关闭\r\n1:开启', '1', '0', 'select', '站点关闭后将提示网站已关闭，不能正常访问', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1', '1');
INSERT INTO `eacoo_config` VALUES ('2', 'web_site_title', '网站标题', 'EacooPHP快速开发框架', '', '6', '0', 'text', '网站标题前台显示标题', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `eacoo_config` VALUES ('4', 'web_site_logo', '网站LOGO', '4', '', '6', '0', 'picture', '网站LOGO', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '4', '1');
INSERT INTO `eacoo_config` VALUES ('5', 'web_site_description', 'SEO描述', '开源框架 EacooPHP ThinkPHP', '', '6', '1', 'textarea', '网站搜索引擎描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '6', '1');
INSERT INTO `eacoo_config` VALUES ('6', 'web_site_keyword', 'SEO关键字', 'EacooPHP是基于ThinkPHP5开发的一套轻量级WEB产品开发框架，追求高效，简单，灵活。', '', '6', '1', 'textarea', '网站搜索引擎关键字', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '4', '1');
INSERT INTO `eacoo_config` VALUES ('7', 'web_site_copyright', '版权信息', 'Copyright © ******有限公司 All rights reserved.', '', '1', '0', 'text', '设置在网站底部显示的版权信息', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '7', '1');
INSERT INTO `eacoo_config` VALUES ('8', 'web_site_icp', '网站备案号', '豫ICP备14003306号', '', '6', '0', 'text', '设置在网站底部显示的备案号，如“苏ICP备1502009-2号\"', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '8', '1');
INSERT INTO `eacoo_config` VALUES ('9', 'web_site_statistics', '站点统计', '', '', '1', '0', 'textarea', '支持百度、Google、cnzz等所有Javascript的统计代码', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '9', '1');
INSERT INTO `eacoo_config` VALUES ('10', 'index_url', '首页地址', 'http://admin.tp5.com', '', '2', '0', 'text', '可以通过配置此项自定义系统首页的地址，比如：http://www.xxx.com', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('13', 'admin_tags', '后台多标签', '1', '0:关闭\r\n1:开启', '2', '0', 'radio', '', '2018-09-30 22:32:26', '2018-12-02 23:00:29', '99', '1');
INSERT INTO `eacoo_config` VALUES ('14', 'admin_page_size', '后台分页数量', '12', '', '2', '0', 'number', '后台列表分页时每页的记录数', '2018-09-30 22:32:26', '2018-12-02 23:01:12', '99', '1');
INSERT INTO `eacoo_config` VALUES ('15', 'admin_theme', '后台主题', 'default', 'default:默认主题\r\nblue:蓝色理想\r\ngreen:绿色生活', '2', '0', 'select', '后台界面主题', '2018-09-30 22:32:26', '2018-12-02 23:00:44', '98', '1');
INSERT INTO `eacoo_config` VALUES ('16', 'develop_mode', '开发模式', '1', '1:开启\r\n0:关闭', '3', '0', 'select', '开发模式下会显示菜单管理、配置管理、数据字典等开发者工具', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1', '1');
INSERT INTO `eacoo_config` VALUES ('17', 'app_trace', '是否显示页面Trace', '0', '1:开启\r\n0:关闭', '3', '0', 'select', '是否显示页面Trace信息', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `eacoo_config` VALUES ('18', 'auth_key', '系统加密KEY', 'vzxI=vf[=xV)?a^XihbLKx?pYPw$;Mi^R*<mV;yJh$wy(~~E?<.JA&ANdIZ#QhPq', '', '3', '0', 'textarea', '轻易不要修改此项，否则容易造成用户无法登录；如要修改，务必备份原key', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '3', '1');
INSERT INTO `eacoo_config` VALUES ('19', 'only_auth_rule', '权限仅验证规则表', '1', '1:开启\n0:关闭', '4', '0', 'radio', '开启此项，则后台验证授权只验证规则表存在的规则', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('20', 'static_domain', '静态文件独立域名', '', '', '3', '0', 'text', '静态文件独立域名一般用于在用户无感知的情况下平和的将网站图片自动存储到腾讯万象优图、又拍云等第三方服务。', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '3', '1');
INSERT INTO `eacoo_config` VALUES ('21', 'config_group_list', '配置分组', '1:基本\r\n2:系统\r\n3:开发\r\n4:安全\r\n5:数据库\r\n6:网站设置\r\n7:用户\r\n8:邮箱\r\n9:高级', '', '3', '0', 'array', '配置分组的键值对不要轻易改变', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '5', '1');
INSERT INTO `eacoo_config` VALUES ('25', 'form_item_type', '表单项目类型', 'hidden:隐藏\r\nreadonly:仅读文本\r\nnumber:数字\r\ntext:单行文本\r\ntextarea:多行文本\r\narray:数组\r\npassword:密码\r\nradio:单选框\r\ncheckbox:复选框\r\nselect:下拉框\r\nicon:字体图标\r\ndate:日期\r\ndatetime:时间\r\npicture:单张图片\r\npictures:多张图片\r\nfile:单个文件\r\nfiles:多个文件\r\nwangeditor:wangEditor编辑器\r\nueditor:百度富文本编辑器\r\neditormd:Markdown编辑器\r\ntags:标签\nselect2:高级下拉框\r\njson:JSON\r\nboard:拖', '', '3', '0', 'array', '专为配置管理设定\r\n', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('26', 'term_taxonomy', '分类法', 'post_category:分类目录\r\npost_tag:标签\r\nmedia_cat:多媒体分类', '', '3', '0', 'array', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('27', 'data_backup_path', '数据库备份根路径', '../data/backup', '', '5', '0', 'text', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('28', 'data_backup_part_size', '数据库备份卷大小', '20971520', '', '5', '0', 'number', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('29', 'data_backup_compress_level', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '5', '0', 'radio', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('30', 'data_backup_compress', '数据库备份文件压缩', '1', '0:不压缩\r\n1:启用压缩', '5', '0', 'radio', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('31', 'hooks_type', '钩子的类型', '1:视图\r\n2:控制器', '', '3', '0', 'array', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('33', 'action_type', '行为类型', '1:系统\r\n2:用户', '1:系统\r\n2:用户', '7', '0', 'array', '配置说明', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('34', 'website_group', '网站信息子分组', '0:基本信息\r\n1:SEO设置\r\n3:其它', '', '6', '0', 'array', '作为网站信息配置的子分组配置，每个大分组可设置子分组作为tab切换', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '20', '1');
INSERT INTO `eacoo_config` VALUES ('36', 'mail_reg_active_template', '注册激活邮件模板', '{\"active\":\"0\",\"subject\":\"\\u6ce8\\u518c\\u6fc0\\u6d3b\\u901a\\u77e5\"}', '', '8', '0', 'json', 'JSON格式保存除了模板内容的属性', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('37', 'mail_captcha_template', '验证码邮件模板', '{\"active\":\"0\",\"subject\":\"\\u90ae\\u7bb1\\u9a8c\\u8bc1\\u7801\\u901a\\u77e5\"}', '', '8', '0', 'json', 'JSON格式保存除了模板内容的属性', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('38', 'mail_reg_active_template_content', '注册激活邮件模板内容', '<p><span style=\"font-family: 微软雅黑; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; font-size: 14px;\">您在{$title}的激活链接为</span><a href=\"{$url}\" target=\"_blank\" style=\"font-family: 微软雅黑; font-size: 14px; white-space: normal;\">激活</a><span style=\"font-family: 微软雅黑; font-size: 14px;\">，或者请复制链接：{$url}到浏览器打开。</span></p>', '', '8', '0', 'textarea', '注册激活模板邮件内容部分，模板内容单独存放', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('39', 'mail_captcha_template_content', '验证码邮件模板内容', '<p><span style=\"font-family: 微软雅黑; font-size: 14px;\">您的验证码为{$verify}验证码，账号为{$account}。</span></p>', '', '8', '0', 'textarea', '验证码邮件模板内容部分', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('40', 'attachment_options', '附件配置选项', '{\"driver\":\"local\",\"file_max_size\":\"7340032\",\"file_exts\":\"doc,docx,xls,xlsx,ppt,pptx,pdf,wps,txt,zip,rar,gz,bz2,7z,mp3,mp4,avi\",\"file_save_name\":\"uniqid\",\"image_max_size\":\"314572800\",\"image_exts\":\"gif,jpg,jpeg,bmp,png\",\"image_save_name\":\"uniqid\",\"page_number\":\"24\",\"widget_show_type\":\"0\",\"cut\":\"1\",\"small_size\":{\"width\":\"150\",\"height\":\"150\"},\"medium_size\":{\"width\":\"320\",\"height\":\"280\"},\"large_size\":{\"width\":\"560\",\"height\":\"430\"},\"watermark_scene\":\"2\",\"watermark_type\":\"1\",\"water_position\":\"9\",\"water_img\":\"\\/logo.png\",\"water_opacity\":\"80\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2019-10-17 09:23:17', '0', '1');
INSERT INTO `eacoo_config` VALUES ('42', 'user_deny_username', '保留用户名和昵称', '管理员,测试,admin,垃圾', '', '7', '0', 'textarea', '禁止注册用户名和昵称，包含这些即无法注册,用&quot; , &quot;号隔开，用户只能是英文，下划线_，数字等', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('43', 'captcha_open', '验证码配置', 'reg,login,reset', 'reg:注册显示\r\nlogin:登陆显示\r\nreset:密码重置', '4', '0', 'checkbox', '验证码开启配置', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('44', 'captcha_type', '验证码类型', '4', '1:中文\r\n2:英文\r\n3:数字\r\n4:英文+数字', '4', '0', 'select', '验证码类型', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('45', 'web_site_subtitle', '网站副标题', '基于ThinkPHP5的开发框架', '', '6', '0', 'textarea', '用简洁的文字描述本站点（网站口号、宣传标语、一句话介绍）', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `eacoo_config` VALUES ('46', 'cache', '缓存配置', '{\"type\":\"File\",\"path\":\"\\/Library\\/WebServer\\/Documents\\/EacooPHP\\/runtime\\/cache\\/\",\"prefix\":\"\",\"expire\":\"0\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('47', 'session', 'Session配置', '{\"type\":\"\",\"prefix\":\"eacoophp_\",\"auto_start\":\"1\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('48', 'cookie', 'Cookie配置', '{\"path\":\"\\/\",\"prefix\":\"eacoophp_\",\"expire\":\"0\",\"domain\":\"\",\"secure\":\"0\",\"httponly\":\"\",\"setcookie\":\"1\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('49', 'reg_default_roleid', '注册默认角色', '4', '', '7', '0', 'select', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('50', 'open_register', '开放注册', '0', '1:是\r\n0:否', '7', '0', 'radio', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('56', 'meanwhile_user_online', '允许同时登录', '1', '1:是\r\n0:否', '7', '0', 'radio', '是否允许同一帐号在不同地方同时登录', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0', '1');
INSERT INTO `eacoo_config` VALUES ('57', 'admin_collect_menus', '后台收藏菜单', '[]', '', '2', '0', 'json', '在后台顶部菜单栏展示，可以方便快速菜单入口', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('58', 'minify_status', '开启minify', '1', '1:开启\r\n0:关闭', '2', '0', 'radio', '开启minify会压缩合并js、css文件，可以减少资源请求次数，如果不支持minify，可关闭', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('59', 'admin_allow_login_many', '同账号多人登录后台', '0', '0:不允许\r\n1:允许', '4', '0', 'radio', '允许多个人使用同一个账号登录后台。默认：不允许', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('60', 'admin_allow_ip', '仅限登录后台IP', '', '', '4', '0', 'textarea', '填写IP地址，多个IP用英文逗号隔开。默认为空，允许所有IP', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('61', 'redis', 'Redis配置', '{\"host\":\"127.0.0.1\",\"port\":\"6979\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('62', 'memcache', 'Memcache配置', '{\"host\":\"127.0.0.1\",\"port\":\"11211\"}', '', '9', '0', 'json', '以JSON格式保存', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_config` VALUES ('63', 'admin_menus_mode', '后台菜单模式', '2', '1:全局模式\r\n2:模块模式', '2', '0', 'radio', '全局模式：所有菜单都显示在后台左侧。\r\n模式模式：菜单根据模式的方式显示在顶部加载。', '2018-12-02 22:59:47', '2018-12-03 00:57:51', '20', '0');

-- ----------------------------
-- Table structure for eacoo_course
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_course`;
CREATE TABLE `eacoo_course` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '我们的历程' COMMENT '历程标题',
  `content` text NOT NULL COMMENT '内容',
  `year` varchar(11) NOT NULL DEFAULT '0' COMMENT '年',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `course_time` int(11) NOT NULL DEFAULT '0' COMMENT '历程时间',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='公司历程';

-- ----------------------------
-- Records of eacoo_course
-- ----------------------------
INSERT INTO `eacoo_course` VALUES ('1', '我们的历程', '2017年12月，在“国企改制”的大背景下，在江北区委、区政府，区国资委的指导和 支持下，公司完成混合所有制改革，上海英盾安防', '2017', '1', '1513699200', '1568860745', '1568861425');
INSERT INTO `eacoo_course` VALUES ('2', '我们的历程', '2019年12月，在“国企改制”的大背景下，在江北区委、区政府，区国资委的指导和 支持下，公司完成混合所有制改革，上海英盾安防', '2019', '1', '1576045505', '1568861495', '1568861495');
INSERT INTO `eacoo_course` VALUES ('3', '我们的历程', '2013年12月，在“国企改制”的大背景下，在江北区委、区政府，区国资委的指导和 支持下，公司完成混合所有制改革，上海英盾安防', '2013', '1', '1387335040', '1568861525', '1568861525');
INSERT INTO `eacoo_course` VALUES ('4', '我们的历程', '1997年12月，在“国企改制”的大背景下，在江北区委、区政府，区国资委的指导和 支持下，公司完成混合所有制改革，上海英盾安防', '1997', '1', '882499958', '1568861573', '1568861573');
INSERT INTO `eacoo_course` VALUES ('5', '我们的历程', '1988年12月，在“国企改制”的大背景下，在江北区委、区政府，区国资委的指导和 支持下，公司完成混合所有制改革，上海英盾安防', '1988', '1', '598503200', '1568861610', '1568861610');

-- ----------------------------
-- Table structure for eacoo_feedback
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_feedback`;
CREATE TABLE `eacoo_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '姓名',
  `tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '电话',
  `content` text NOT NULL COMMENT '反馈内容',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='前台反馈';

-- ----------------------------
-- Records of eacoo_feedback
-- ----------------------------
INSERT INTO `eacoo_feedback` VALUES ('1', '1', '小幸运', '15683408241', '你们很优秀', '1569291627', '1569291627');

-- ----------------------------
-- Table structure for eacoo_file
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_file`;
CREATE TABLE `eacoo_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of eacoo_file
-- ----------------------------

-- ----------------------------
-- Table structure for eacoo_hooks
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_hooks`;
CREATE TABLE `eacoo_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '钩子ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` varchar(300) NOT NULL DEFAULT '' COMMENT '描述',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '类型。1视图，2控制器',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1启用，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='钩子表';

-- ----------------------------
-- Records of eacoo_hooks
-- ----------------------------
INSERT INTO `eacoo_hooks` VALUES ('1', 'AdminIndex', '后台首页小工具', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('2', 'FormBuilderExtend', 'FormBuilder类型扩展Builder', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('3', 'UploadFile', '上传文件钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('4', 'PageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('5', 'PageFooter', '页面footer钩子，一般用于加载插件CSS文件和代码', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('6', 'LoginUser', '用户登录钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('7', 'SendMessage', '发送消息钩子，用于消息发送途径的扩展', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('8', 'sms', '短信插件钩子', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('9', 'RegisterUser', '用户注册钩子', '2', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('10', 'ImageGallery', '图片轮播钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('11', 'JChinaCity', '每个系统都需要的一个中国省市区三级联动插件。', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('13', 'editor', '内容编辑器钩子', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('14', 'adminEditor', '后台内容编辑页编辑器', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('15', 'ThirdLogin', '集成第三方授权登录，包括微博、QQ、微信、码云', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('16', 'comment', '实现本地评论功能，支持评论点赞', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('17', 'uploadPicture', '实现阿里云OSS对象存储，管理附件', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_hooks` VALUES ('18', 'MicroTopicsUserPost', '微话题，专注实时热点、个人兴趣、网友讨论等，包含用户等级机制，权限机制。', '1', '2019-01-06 19:08:38', '2019-01-06 19:08:38', '1');

-- ----------------------------
-- Table structure for eacoo_hooks_extra
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_hooks_extra`;
CREATE TABLE `eacoo_hooks_extra` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hook_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '钩子ID',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '应用类型。1module，2plugin，3theme',
  `depend_flag` varchar(30) NOT NULL DEFAULT '' COMMENT '应用标记。如：模块或插件标识',
  `sort` smallint(6) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1正常',
  PRIMARY KEY (`id`),
  KEY `idx_hookid_depend` (`hook_id`,`depend_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='钩子应用依赖表';

-- ----------------------------
-- Records of eacoo_hooks_extra
-- ----------------------------

-- ----------------------------
-- Table structure for eacoo_library
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_library`;
CREATE TABLE `eacoo_library` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '敏感词',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='敏感词库';

-- ----------------------------
-- Records of eacoo_library
-- ----------------------------
INSERT INTO `eacoo_library` VALUES ('1', '我日', '1', '1568612973', '1568612973');

-- ----------------------------
-- Table structure for eacoo_links
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_links`;
CREATE TABLE `eacoo_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `image` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '图标',
  `url` varchar(150) NOT NULL DEFAULT '' COMMENT '链接',
  `target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '打开方式',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `rating` int(11) unsigned NOT NULL COMMENT '评级',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1启用，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of eacoo_links
-- ----------------------------
INSERT INTO `eacoo_links` VALUES ('1', 'EacooPHP官网', '96', 'https://www.eacoophp.com', '_blank', '2', '8', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '2', '1');
INSERT INTO `eacoo_links` VALUES ('2', '社区', '89', 'https://forum.eacoophp.com', '_blank', '1', '9', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1', '1');

-- ----------------------------
-- Table structure for eacoo_login_record
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_login_record`;
CREATE TABLE `eacoo_login_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `login_time` int(11) NOT NULL DEFAULT '0' COMMENT '登录时间',
  `date_time` varchar(255) NOT NULL DEFAULT '0' COMMENT '登录日期',
  `count` int(11) NOT NULL DEFAULT '1' COMMENT '连续登陆天数',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1表示未提示 0表示已经提示过了',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT '登录完整时间搓',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='会员登录记录表';

-- ----------------------------
-- Records of eacoo_login_record
-- ----------------------------
INSERT INTO `eacoo_login_record` VALUES ('1', '1', '1567526400', '2019-09-04', '1', '0', '1567526423');
INSERT INTO `eacoo_login_record` VALUES ('3', '1', '1567612800', '2019-09-05', '2', '0', '1567612824');
INSERT INTO `eacoo_login_record` VALUES ('5', '1', '1567699200', '2019-09-06', '3', '0', '1567699225');
INSERT INTO `eacoo_login_record` VALUES ('4', '2', '1568044800', '2019-09-10', '2', '0', '1568044826');
INSERT INTO `eacoo_login_record` VALUES ('2', '2', '1567958400', '2019-09-09', '1', '1', '1567958427');
INSERT INTO `eacoo_login_record` VALUES ('6', '3', '1568044800', '2019-09-10', '1', '0', '1568044828');
INSERT INTO `eacoo_login_record` VALUES ('7', '1', '1568044800', '2019-09-10', '1', '0', '1568044829');

-- ----------------------------
-- Table structure for eacoo_member
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_member`;
CREATE TABLE `eacoo_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '用户名',
  `tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '手机号',
  `email` varchar(255) NOT NULL DEFAULT '0' COMMENT '邮箱',
  `password` varchar(255) NOT NULL DEFAULT '0' COMMENT '密码',
  `password_plaintext` varchar(255) NOT NULL DEFAULT '0' COMMENT '密码明文',
  `token` varchar(255) NOT NULL DEFAULT '0' COMMENT '会员token',
  `icon` int(11) NOT NULL DEFAULT '179' COMMENT '头像',
  `autograph` varchar(255) NOT NULL DEFAULT '0' COMMENT '个性签名',
  `integral` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `is_admin` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否是管理员，1是 0不是',
  `sex` tinyint(4) NOT NULL DEFAULT '1' COMMENT '性别：1男2女',
  `qq_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'qqunid',
  `wx_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '微信unid',
  `number` int(11) NOT NULL DEFAULT '0' COMMENT '注册序号',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `vip` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户类型：1新手 2普通用户 3管理员  -1黑名单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of eacoo_member
-- ----------------------------
INSERT INTO `eacoo_member` VALUES ('1', 'IYE6Ve0m', '15683408249', '1967963213@qq.com', 'e10adc3949ba59abbe56e057f20f883e', '123456', 'a0bb36c570d71940dc60cf4e3c069898c1068b6e', '179', '0', '0', '0', '1', '0', '0', '0', '1571105979', '1571623711', '1', '1');
INSERT INTO `eacoo_member` VALUES ('3', '王俊凯', '15683408240', '3433165077@qq.com', 'e10adc3949ba59abbe56e057f20f883e', '123456', 'f3223fd70fc1076563023bbf44530ea7579bb70f', '179', '我是一个程序员', '0', '0', '1', '0', '0', '0', '1571188837', '1571636987', '1', '1');

-- ----------------------------
-- Table structure for eacoo_modules
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_modules`;
CREATE TABLE `eacoo_modules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(31) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(63) NOT NULL DEFAULT '' COMMENT '标题',
  `description` varchar(127) NOT NULL DEFAULT '' COMMENT '描述',
  `author` varchar(31) NOT NULL DEFAULT '' COMMENT '开发者',
  `icon` varchar(120) NOT NULL DEFAULT '' COMMENT '图标',
  `version` varchar(7) NOT NULL DEFAULT '' COMMENT '版本',
  `config` text NOT NULL COMMENT '配置',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许卸载',
  `url` varchar(120) NOT NULL DEFAULT '' COMMENT '站点',
  `admin_manage_into` varchar(60) DEFAULT '' COMMENT '后台管理入口',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='模块功能表';

-- ----------------------------
-- Records of eacoo_modules
-- ----------------------------
INSERT INTO `eacoo_modules` VALUES ('1', 'admin', '系统', '后台系统模块', '心云间、凝听', 'fa fa-home', '1.0.0', '', '1', '', '', '2018-12-02 22:32:26', '2018-12-02 22:32:26', '99', '1');
INSERT INTO `eacoo_modules` VALUES ('2', 'home', 'Home模块', '一款基础前台Home模块', '心云间、凝听', 'fa fa-home', '1.0.0', '', '1', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_modules` VALUES ('3', 'user', '用户中心', '用户模块，系统核心模块，不可卸载', '心云间、凝听', 'fa fa-users', '1.0.2', '', '1', 'https://www.eacoophp.com', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');

-- ----------------------------
-- Table structure for eacoo_nav
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_nav`;
CREATE TABLE `eacoo_nav` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '标题',
  `value` varchar(120) DEFAULT '' COMMENT 'url地址',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '父级',
  `position` varchar(20) NOT NULL DEFAULT '' COMMENT '位置。头部：header，我的：my',
  `target` varchar(15) DEFAULT '_self' COMMENT '打开方式。',
  `depend_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '来源类型。0普通外链http，1模块扩展，2插件扩展，3主题扩展',
  `depend_flag` varchar(30) NOT NULL DEFAULT '' COMMENT '来源标记。如：模块或插件标识',
  `icon` varchar(120) NOT NULL DEFAULT '' COMMENT '图标',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='前台导航';

-- ----------------------------
-- Records of eacoo_nav
-- ----------------------------
INSERT INTO `eacoo_nav` VALUES ('1', '主页', '/', '0', 'header', '_self', '1', 'home', 'fa fa-home', '10', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_nav` VALUES ('2', '会员', 'user/index/index', '0', 'header', '_self', '1', 'user', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_nav` VALUES ('3', '下载', 'https://gitee.com/ZhaoJunfeng/EacooPHP/attach_files', '0', 'header', '_blank', '0', '', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_nav` VALUES ('4', '社区', 'https://forum.eacoophp.com', '0', 'header', '_blank', '0', '', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_nav` VALUES ('5', '文档', 'https://www.kancloud.cn/youpzt/eacoo', '0', 'header', '_blank', '0', '', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for eacoo_news
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_news`;
CREATE TABLE `eacoo_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `top` tinyint(4) NOT NULL DEFAULT '0' COMMENT '首页推荐：1推荐 0 不推荐',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '新闻标题',
  `icon` varchar(255) NOT NULL DEFAULT '0' COMMENT '新闻首图',
  `content` text NOT NULL COMMENT '新闻内容',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常  0禁用',
  `pid` varchar(255) NOT NULL DEFAULT '0' COMMENT '新闻标签，categroy里type为3的数据id',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='新闻';

-- ----------------------------
-- Records of eacoo_news
-- ----------------------------
INSERT INTO `eacoo_news` VALUES ('1', '1', '江北保安队员温暖举动获17万点赞', '156', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '15,16', '1569217900', '1569217900');
INSERT INTO `eacoo_news` VALUES ('2', '1', '江北保安队员温暖举动获17万点赞', '156', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '15', '1569217935', '1569217935');
INSERT INTO `eacoo_news` VALUES ('3', '1', '江北保安队员温暖举动获17万点赞', '156', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '16', '1569217908', '1569217908');
INSERT INTO `eacoo_news` VALUES ('4', '1', '江北保安队员温暖举动获17万点赞', '/uploads/picture/2019-09-25/5d8b1c578e6a7.jpg', '<p>11月29日下午5时，重庆市公安局江北分局观音桥大队协警张素权正在观音桥步行街香榭8号路口执勤......</p>', '1', '16', '1569397889', '1569397889');

-- ----------------------------
-- Table structure for eacoo_notice
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_notice`;
CREATE TABLE `eacoo_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型：1删除通知 2回复通知',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作的管理员',
  `article_id` int(11) NOT NULL DEFAULT '0' COMMENT '文章id',
  `del_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '删除类型：1举报删除 2敏感删除 3后台永久删除',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1未读 2已读',
  `content` varchar(6000) NOT NULL DEFAULT '0' COMMENT '消息类容',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='消息通知表';

-- ----------------------------
-- Records of eacoo_notice
-- ----------------------------
INSERT INTO `eacoo_notice` VALUES ('1', '1', '2', '2', '1', '1', '1', '您发布的帖子“这是一个神奇的贴...”违反了发帖规范，被多名用户举报，经核实已被管理员“admin”删除！', '1567569447', '1567569447');
INSERT INTO `eacoo_notice` VALUES ('2', '1', '2', '2', '1', '1', '1', '您发布的帖子“我的热情...”违反了发帖规范，被多名用户举报，经核实已被管理员“admin”删除！', '1568019017', '1568019017');

-- ----------------------------
-- Table structure for eacoo_partner
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_partner`;
CREATE TABLE `eacoo_partner` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '所属分类',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '合作伙伴标题',
  `icon` int(11) NOT NULL DEFAULT '0' COMMENT '合作伙伴图片',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常0禁用',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='合作伙伴';

-- ----------------------------
-- Records of eacoo_partner
-- ----------------------------
INSERT INTO `eacoo_partner` VALUES ('1', '22', '浦发银行', '165', '1', '1568965223', '1568965223');
INSERT INTO `eacoo_partner` VALUES ('2', '23', '重百超市', '166', '1', '1568965255', '1568965255');
INSERT INTO `eacoo_partner` VALUES ('3', '24', '中国工商银行', '167', '1', '1568965289', '1568965289');
INSERT INTO `eacoo_partner` VALUES ('4', '25', '中国石油', '168', '1', '1568965319', '1568965319');
INSERT INTO `eacoo_partner` VALUES ('5', '26', '中国农业银行', '169', '1', '1568965353', '1568965353');

-- ----------------------------
-- Table structure for eacoo_plotting
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_plotting`;
CREATE TABLE `eacoo_plotting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '展绘标题',
  `describe` varchar(255) NOT NULL DEFAULT '0' COMMENT '描述',
  `icon` int(11) NOT NULL DEFAULT '0' COMMENT '展绘首图',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `share` int(11) NOT NULL DEFAULT '0' COMMENT '分享量',
  `icon_number` int(11) NOT NULL DEFAULT '0' COMMENT '图片总数',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL DEFAULT '123456' COMMENT '展绘密码',
  `author` varchar(255) NOT NULL DEFAULT '门展绘' COMMENT '展绘作者',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='门展绘展绘样品';

-- ----------------------------
-- Records of eacoo_plotting
-- ----------------------------
INSERT INTO `eacoo_plotting` VALUES ('1', '3', '现代家居', '舒适、温馨的小家', '181', '1', '0', '0', '1571214757', '1571215051', '281518', '门展绘');
INSERT INTO `eacoo_plotting` VALUES ('2', '3', '中式家居', '复古感的设计', '182', '1', '0', '0', '1571215111', '1571215111', '281518', '门展绘');

-- ----------------------------
-- Table structure for eacoo_plotting_details
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_plotting_details`;
CREATE TABLE `eacoo_plotting_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plotting_id` int(11) NOT NULL DEFAULT '0' COMMENT '展绘id',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '类型id,展绘类型',
  `icon` int(11) NOT NULL DEFAULT '0' COMMENT '全景图片',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '场景名称',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  `xml_path` varchar(255) NOT NULL DEFAULT '0' COMMENT '生成全景的xml路径',
  `html_path` varchar(255) NOT NULL DEFAULT '0' COMMENT '生成全景的html路径',
  `file_icon` int(11) NOT NULL DEFAULT '0' COMMENT '音乐文件id',
  `file_icon_path` varchar(255) NOT NULL DEFAULT '0' COMMENT '文件封面',
  `watermark_icon` int(11) NOT NULL DEFAULT '223' COMMENT '水印图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='展绘全景图片';

-- ----------------------------
-- Records of eacoo_plotting_details
-- ----------------------------
INSERT INTO `eacoo_plotting_details` VALUES ('11', '1', '28', '221', '客厅', '1', '1571798139', '1571801246', '/upload_3dpic/2019-10-23\\20191023\\6620962ecaff38b30b7cde97529bfd51/tour.xml', '/upload_3dpic/2019-10-23\\20191023\\6620962ecaff38b30b7cde97529bfd51/tour.html', '209', '/static/assets/img/file-mp3.png', '223');
INSERT INTO `eacoo_plotting_details` VALUES ('12', '1', '29', '224', '饭厅', '1', '1571993231', '1571993231', '/upload_3dpic/2019-10-25\\20191025\\4af640195ee9b8b3e71e781611412f0e/tour.xml', '/upload_3dpic/2019-10-25\\20191025\\4af640195ee9b8b3e71e781611412f0e/tour.html', '209', '/static/assets/img/file-mp3.png', '225');
INSERT INTO `eacoo_plotting_details` VALUES ('13', '1', '29', '226', '客厅', '1', '1571993311', '1571993311', '/upload_3dpic/2019-10-25\\20191025\\0221cfa816f52d74604a60a5bbdffc72/tour.xml', '/upload_3dpic/2019-10-25\\20191025\\0221cfa816f52d74604a60a5bbdffc72/tour.html', '209', '/static/assets/img/file-mp3.png', '227');

-- ----------------------------
-- Table structure for eacoo_plugins
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_plugins`;
CREATE TABLE `eacoo_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '插件名或标识',
  `title` varchar(32) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text NOT NULL COMMENT '插件描述',
  `config` text COMMENT '配置',
  `author` varchar(32) NOT NULL DEFAULT '' COMMENT '作者',
  `version` varchar(8) NOT NULL DEFAULT '' COMMENT '版本号',
  `admin_manage_into` varchar(60) DEFAULT '0' COMMENT '后台管理入口',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '安装时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '修改时间',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of eacoo_plugins
-- ----------------------------

-- ----------------------------
-- Table structure for eacoo_record
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_record`;
CREATE TABLE `eacoo_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务id',
  `craftsman_id` int(11) NOT NULL DEFAULT '0' COMMENT '工匠id',
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '会员昵称',
  `tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '会员电话',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='拨打记录';

-- ----------------------------
-- Records of eacoo_record
-- ----------------------------

-- ----------------------------
-- Table structure for eacoo_report
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_report`;
CREATE TABLE `eacoo_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '举报人的id',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'l类型：1帖子 2评论',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '被举报人的id',
  `ac_id` int(11) NOT NULL DEFAULT '0' COMMENT '类容id：type为1 就是帖子id type为2就是评论id',
  `category_id` varchar(11) NOT NULL DEFAULT '0' COMMENT '分类id,举报的类型',
  `sadmin` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否管理员举报管理员：1是 0不是',
  `content` varchar(6000) NOT NULL DEFAULT '0' COMMENT '举报类容',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1未处理 2举报核实  3误报',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `admin_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '后台管理员操作：1正常 0冻结（冻结帖子就是帖子状态为0）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='举报';

-- ----------------------------
-- Records of eacoo_report
-- ----------------------------
INSERT INTO `eacoo_report` VALUES ('2', '2', '1', '1', '2', '1', '0', '我就是想举报你', '1', '1568603790', '1568603790', '1');

-- ----------------------------
-- Table structure for eacoo_rewrite
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_rewrite`;
CREATE TABLE `eacoo_rewrite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `rule` varchar(255) NOT NULL DEFAULT '' COMMENT '规则',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态：0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='伪静态表';

-- ----------------------------
-- Records of eacoo_rewrite
-- ----------------------------

-- ----------------------------
-- Table structure for eacoo_search
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_search`;
CREATE TABLE `eacoo_search` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '收搜关键字',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '收搜次数',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 2禁用',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员收搜历史记录';

-- ----------------------------
-- Records of eacoo_search
-- ----------------------------

-- ----------------------------
-- Table structure for eacoo_set
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_set`;
CREATE TABLE `eacoo_set` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment_count` int(11) NOT NULL DEFAULT '0' COMMENT '最热评论数上限',
  `customer_tel` varchar(255) NOT NULL DEFAULT '0' COMMENT '客户联系电话',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统设置表';

-- ----------------------------
-- Records of eacoo_set
-- ----------------------------
INSERT INTO `eacoo_set` VALUES ('1', '1', '023-35661324');

-- ----------------------------
-- Table structure for eacoo_set_integral
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_set_integral`;
CREATE TABLE `eacoo_set_integral` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `integral` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型：1帖子被赞，2回复被踩，3举报核销，4漏签，5被人举报核实，6签到 7举报他人核实',
  `types` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1加积分 2减积分',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='积分设置';

-- ----------------------------
-- Records of eacoo_set_integral
-- ----------------------------
INSERT INTO `eacoo_set_integral` VALUES ('1', '10', '1', '1', '1', '1567734974', '1567734974');
INSERT INTO `eacoo_set_integral` VALUES ('2', '10', '2', '2', '1', '1567735003', '1567735206');
INSERT INTO `eacoo_set_integral` VALUES ('3', '20', '3', '1', '1', '1567735231', '1567735231');
INSERT INTO `eacoo_set_integral` VALUES ('4', '4', '4', '2', '1', '1567735246', '1567735246');
INSERT INTO `eacoo_set_integral` VALUES ('5', '50', '5', '2', '1', '1567735390', '1567735390');
INSERT INTO `eacoo_set_integral` VALUES ('6', '10', '6', '1', '1', '1567735403', '1567735403');
INSERT INTO `eacoo_set_integral` VALUES ('7', '10', '7', '1', '1', '1567735403', '1567735403');

-- ----------------------------
-- Table structure for eacoo_share
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_share`;
CREATE TABLE `eacoo_share` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plotting_id` int(11) NOT NULL DEFAULT '0' COMMENT '展绘id',
  `details_id` int(11) NOT NULL DEFAULT '0' COMMENT '展绘详情id',
  `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '昵称',
  `icon_path` varchar(255) NOT NULL DEFAULT '0' COMMENT '头像',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='展绘分享记录表';

-- ----------------------------
-- Records of eacoo_share
-- ----------------------------
INSERT INTO `eacoo_share` VALUES ('1', '3', '7', '小王', '/uploads/picture/2019-10-16/5da6cc283a92f.png', '1571455783', '1571455783');

-- ----------------------------
-- Table structure for eacoo_standard
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_standard`;
CREATE TABLE `eacoo_standard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `details_id` int(11) NOT NULL DEFAULT '0' COMMENT '展绘详情id',
  `plotting_id` int(11) NOT NULL DEFAULT '0' COMMENT '展绘id',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'l类型：1场景切换 2文字 3图片',
  `ath` varchar(255) NOT NULL DEFAULT '0' COMMENT '横坐标',
  `atv` varchar(255) NOT NULL DEFAULT '0' COMMENT '纵坐标',
  `img_url` varchar(255) NOT NULL DEFAULT '0' COMMENT '锚点路径',
  `img_wide` varchar(255) NOT NULL DEFAULT '0' COMMENT '锚点宽',
  `img_height` varchar(255) NOT NULL DEFAULT '0' COMMENT '锚点高',
  `spotname` varchar(255) NOT NULL DEFAULT '0' COMMENT '绑定事件名称，唯一的',
  `pdetails_id` int(11) NOT NULL DEFAULT '0' COMMENT '场景id,当type为1 场景切换的时候就是下一个场景的id',
  `content` varchar(255) NOT NULL DEFAULT '0' COMMENT '当type为2就是标注的类容，可以是图片地址，和文字',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '锚点，标题',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='展绘全景标注表';

-- ----------------------------
-- Records of eacoo_standard
-- ----------------------------
INSERT INTO `eacoo_standard` VALUES ('1', '11', '1', '1', '-85.82121119310352', '45.40774640049409', '/static/admin2/images/leftjiantou.png', '0', '0', 'spotname_1', '0', '0', '0', '1', '1571816665', '1571816665');

-- ----------------------------
-- Table structure for eacoo_systems
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_systems`;
CREATE TABLE `eacoo_systems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '分类id',
  `icon` int(4) NOT NULL DEFAULT '0' COMMENT '内容图片',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常0禁用',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='英盾麦谷系统';

-- ----------------------------
-- Records of eacoo_systems
-- ----------------------------
INSERT INTO `eacoo_systems` VALUES ('1', '18', '161', '1', '1568963385', '1568963385');
INSERT INTO `eacoo_systems` VALUES ('2', '19', '162', '1', '1568963487', '1568963487');
INSERT INTO `eacoo_systems` VALUES ('3', '21', '163', '1', '1568963518', '1568963518');
INSERT INTO `eacoo_systems` VALUES ('4', '20', '164', '1', '1568963638', '1568963638');
INSERT INTO `eacoo_systems` VALUES ('5', '20', '164', '1', '1568963648', '1568963648');
INSERT INTO `eacoo_systems` VALUES ('6', '20', '164', '1', '1568963658', '1568963658');

-- ----------------------------
-- Table structure for eacoo_taiwan
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_taiwan`;
CREATE TABLE `eacoo_taiwan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '地址名称',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1正常 0禁用',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级id',
  `popular` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否热门城市：1是0不是',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COMMENT='台湾地址';

-- ----------------------------
-- Records of eacoo_taiwan
-- ----------------------------
INSERT INTO `eacoo_taiwan` VALUES ('1', '台北市', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('2', '基隆市', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('3', '新北市', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('4', '連江縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('5', '宜蘭縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('6', '新竹市', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('7', '新竹縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('8', '桃園縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('9', '苗栗縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('10', '台中市', '1', '0', '1');
INSERT INTO `eacoo_taiwan` VALUES ('11', '彰化縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('12', '南投縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('13', '嘉義市', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('14', '嘉義縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('15', '雲林縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('16', '台南市', '1', '0', '1');
INSERT INTO `eacoo_taiwan` VALUES ('17', '高雄市', '1', '0', '1');
INSERT INTO `eacoo_taiwan` VALUES ('18', '南海島', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('19', '澎湖縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('20', '金門縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('21', '屏東縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('22', '台東縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('23', '花蓮縣', '1', '0', '0');
INSERT INTO `eacoo_taiwan` VALUES ('24', '中正區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('25', '大同區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('26', '中山區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('27', '松山區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('28', '大安區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('29', '萬華區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('30', '信義區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('31', '士林區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('32', '北投區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('33', '內湖區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('34', '南港區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('35', '文山區', '1', '1', '0');
INSERT INTO `eacoo_taiwan` VALUES ('36', '仁愛區', '1', '2', '0');
INSERT INTO `eacoo_taiwan` VALUES ('37', '信義區', '1', '2', '0');
INSERT INTO `eacoo_taiwan` VALUES ('38', '中正區', '1', '2', '0');
INSERT INTO `eacoo_taiwan` VALUES ('39', '中山區', '1', '2', '0');
INSERT INTO `eacoo_taiwan` VALUES ('40', '安樂區', '1', '2', '0');
INSERT INTO `eacoo_taiwan` VALUES ('41', '暖暖區', '1', '2', '0');
INSERT INTO `eacoo_taiwan` VALUES ('42', '七堵區', '1', '2', '0');
INSERT INTO `eacoo_taiwan` VALUES ('43', '萬里區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('44', '金山區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('45', '板橋區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('46', '汐止區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('47', '深坑區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('48', '石碇區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('49', '瑞芳區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('50', '平溪區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('51', '雙溪區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('52', '貢寮區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('53', '新店區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('54', '坪林區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('55', '烏來區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('56', '永和區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('57', '中和區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('58', '土城區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('59', '三峽區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('60', '樹林區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('61', '鶯歌區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('62', '三重區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('63', '新莊區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('64', '泰山區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('65', '林口區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('66', '蘆洲區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('67', '五股區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('68', '新莊區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('69', '八里區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('70', '淡水區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('71', '三芝區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('72', '石門區', '1', '3', '0');
INSERT INTO `eacoo_taiwan` VALUES ('73', '南竿鄉', '1', '4', '0');
INSERT INTO `eacoo_taiwan` VALUES ('74', '北竿鄉', '1', '4', '0');
INSERT INTO `eacoo_taiwan` VALUES ('75', '莒光鄉', '1', '4', '0');
INSERT INTO `eacoo_taiwan` VALUES ('76', '東引鄉', '1', '4', '0');
INSERT INTO `eacoo_taiwan` VALUES ('77', '宜蘭市', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('78', '壯圍鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('79', '頭城鎮', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('80', '礁溪鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('81', '壯圍鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('82', '員山鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('83', '羅東鎮', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('84', '三星鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('85', '大同鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('86', '五結鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('87', '冬山鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('88', '蘇澳鎮', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('89', '南澳鄉', '1', '5', '0');
INSERT INTO `eacoo_taiwan` VALUES ('90', '東區', '1', '6', '0');
INSERT INTO `eacoo_taiwan` VALUES ('91', '北區', '1', '6', '0');
INSERT INTO `eacoo_taiwan` VALUES ('92', '香山區', '1', '6', '0');
INSERT INTO `eacoo_taiwan` VALUES ('93', '寶山鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('94', '竹北市', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('95', '湖口鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('96', '新豐鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('97', '新埔鎮', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('98', '關西鎮', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('99', '芎林鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('100', '寶山鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('101', '竹東鎮', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('102', '五峰鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('103', '橫山鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('104', '尖石鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('105', '北埔鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('106', '峨眉鄉', '1', '7', '0');
INSERT INTO `eacoo_taiwan` VALUES ('107', '中壢市', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('108', '平鎮市', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('109', '龍潭鄉', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('110', '楊梅市', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('111', '新屋鄉', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('112', '觀音鄉', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('113', '桃園市', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('114', '龜山鄉', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('115', '八德市', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('116', '大溪鎮', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('117', '復興鄉', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('118', '大園鄉', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('119', '蘆竹鄉', '1', '8', '0');
INSERT INTO `eacoo_taiwan` VALUES ('120', '竹南鎮', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('121', '頭份鎮', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('122', '三灣鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('123', '南庄鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('124', '獅潭鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('125', '後龍鎮', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('126', '通霄鎮', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('127', '苑裡鎮', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('128', '苗栗市', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('129', '造橋鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('130', '頭屋鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('131', '公館鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('132', '大湖鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('133', '泰安鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('134', '銅鑼鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('135', '三義鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('136', '西湖鄉', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('137', '卓蘭鎮', '1', '9', '0');
INSERT INTO `eacoo_taiwan` VALUES ('138', '中區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('139', '東區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('140', '南區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('141', '西區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('142', '北區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('143', '北屯區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('144', '西屯區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('145', '南屯區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('146', '太平區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('147', '大里區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('148', '霧峰區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('149', '烏日區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('150', '豐原區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('151', '后里區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('152', '石岡區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('153', '東勢區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('154', '和平區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('155', '新社區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('156', '潭子區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('157', '大雅區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('158', '神岡區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('159', '大肚區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('160', '沙鹿區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('161', '龍井區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('162', '龍井區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('163', '梧棲區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('164', '清水區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('165', '大甲區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('166', '外埔區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('167', '大安區', '1', '10', '0');
INSERT INTO `eacoo_taiwan` VALUES ('168', '彰化市', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('169', '芬園鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('170', '花壇鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('171', '秀水鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('172', '鹿港鎮', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('173', '福興鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('174', '線西鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('175', '和美鎮', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('176', '伸港鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('177', '員林鎮', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('178', '社頭鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('179', '永靖鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('180', '埔心鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('181', '溪湖鎮', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('182', '大村鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('183', '埔鹽鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('184', '田中鎮', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('185', '北斗鎮', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('186', '田尾鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('187', '埤頭鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('188', '溪州鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('189', '竹塘鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('190', '二林鎮', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('191', '大城鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('192', '芳苑鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('193', '二水鄉', '1', '11', '0');
INSERT INTO `eacoo_taiwan` VALUES ('194', '南投市', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('195', '中寮鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('196', '草屯鎮', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('197', '國姓鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('198', '埔里鎮', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('199', '仁愛鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('200', '名間鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('201', '集集鎮', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('202', '水里鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('203', '魚池鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('204', '信義鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('205', '竹山鎮', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('206', '鹿谷鄉', '1', '12', '0');
INSERT INTO `eacoo_taiwan` VALUES ('207', '西區', '1', '13', '0');
INSERT INTO `eacoo_taiwan` VALUES ('208', '東區', '1', '13', '0');
INSERT INTO `eacoo_taiwan` VALUES ('209', '番路鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('210', '梅山鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('211', '竹崎鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('212', '阿里山鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('213', '中埔鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('214', '大埔鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('215', '水上鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('216', '鹿草鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('217', '太保市', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('218', '朴子市', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('219', '東石鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('220', '六腳鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('221', '新港鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('222', '民雄鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('223', '大林鎮', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('224', '溪口鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('225', '義竹鄉', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('226', '布袋鎮', '1', '14', '0');
INSERT INTO `eacoo_taiwan` VALUES ('227', '斗南鎮', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('228', '大埤鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('229', '虎尾鎮', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('230', '土庫鎮', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('231', '褒忠鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('232', '東勢鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('233', '台西鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('234', '崙背鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('235', '麥寮鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('236', '斗六市', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('237', '林內鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('238', '古坑鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('239', '莿桐鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('240', '西螺鎮', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('241', '二崙鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('242', '北港鎮', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('243', '水林鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('244', '口湖鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('245', '四湖鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('246', '元長鄉', '1', '15', '0');
INSERT INTO `eacoo_taiwan` VALUES ('247', '中西區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('248', '東區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('249', '南區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('250', '北區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('251', '安平區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('252', '安南區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('253', '永康區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('254', '歸仁區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('255', '新化區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('256', '左鎮區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('257', '玉井區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('258', '楠西區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('259', '南化區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('260', '仁德區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('261', '關廟區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('262', '龍崎區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('263', '官田區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('264', '麻豆區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('265', '佳里區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('266', '西港區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('267', '七股區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('268', '將軍區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('269', '學甲區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('270', '北門區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('271', '新營區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('272', '後壁區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('273', '白河區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('274', '東山區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('275', '六甲區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('276', '下營區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('277', '柳營區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('278', '鹽水區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('279', '善化區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('280', '新市區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('281', '大內區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('282', '山上區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('283', '新市區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('284', '安定區', '1', '16', '0');
INSERT INTO `eacoo_taiwan` VALUES ('285', '新興區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('286', '前金區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('287', '苓雅區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('288', '鹽埕區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('289', '鼓山區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('290', '旗津區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('291', '前鎮區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('292', '三民區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('293', '楠梓區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('294', '小港區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('295', '左營區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('296', '仁武區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('297', '大社區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('298', '東沙群島', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('299', '南沙群島', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('300', '岡山區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('301', '路竹區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('302', '阿蓮區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('303', '田寮區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('304', '燕巢區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('305', '橋頭區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('306', '梓官區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('307', '彌陀區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('308', '永安區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('309', '湖內區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('310', '鳳山區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('311', '大寮區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('312', '林園區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('313', '鳥松區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('314', '大樹區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('315', '旗山區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('316', '美濃區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('317', '六龜區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('318', '內門區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('319', '杉林區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('320', '甲仙區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('321', '桃源區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('322', '那瑪夏區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('323', '茂林區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('324', '茄萣區', '1', '17', '0');
INSERT INTO `eacoo_taiwan` VALUES ('325', '東沙群島', '1', '18', '0');
INSERT INTO `eacoo_taiwan` VALUES ('326', '南沙群島', '1', '18', '0');
INSERT INTO `eacoo_taiwan` VALUES ('327', '馬公市', '1', '19', '0');
INSERT INTO `eacoo_taiwan` VALUES ('328', '西嶼鄉', '1', '19', '0');
INSERT INTO `eacoo_taiwan` VALUES ('329', '望安鄉', '1', '19', '0');
INSERT INTO `eacoo_taiwan` VALUES ('330', '七美鄉', '1', '19', '0');
INSERT INTO `eacoo_taiwan` VALUES ('331', '白沙鄉', '1', '19', '0');
INSERT INTO `eacoo_taiwan` VALUES ('332', '湖西鄉', '1', '19', '0');
INSERT INTO `eacoo_taiwan` VALUES ('333', '金沙鎮', '1', '20', '0');
INSERT INTO `eacoo_taiwan` VALUES ('334', '金湖鎮', '1', '20', '0');
INSERT INTO `eacoo_taiwan` VALUES ('335', '金寧鄉', '1', '20', '0');
INSERT INTO `eacoo_taiwan` VALUES ('336', '金城鎮', '1', '20', '0');
INSERT INTO `eacoo_taiwan` VALUES ('337', '烈嶼鄉', '1', '20', '0');
INSERT INTO `eacoo_taiwan` VALUES ('338', '烏坵鄉', '1', '20', '0');
INSERT INTO `eacoo_taiwan` VALUES ('339', '屏東市', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('340', '三地門鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('341', '霧台鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('342', '瑪家鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('343', '九如鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('344', '里港鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('345', '高樹鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('346', '鹽埔鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('347', '長治鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('348', '麟洛鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('349', '竹田鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('350', '內埔鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('351', '萬丹鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('352', '潮州鎮', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('353', '泰武鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('354', '來義鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('355', '萬巒鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('356', '崁頂鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('357', '新埤鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('358', '南州鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('359', '林邊鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('360', '東港鎮', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('361', '琉球鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('362', '佳冬鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('363', '新園鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('364', '枋寮鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('365', '枋山鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('366', '春日鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('367', '獅子鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('368', '車城鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('369', '牡丹鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('370', '恆春鎮', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('371', '滿州鄉', '1', '21', '0');
INSERT INTO `eacoo_taiwan` VALUES ('372', '台東市', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('373', '綠島鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('374', '蘭嶼鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('375', '延平鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('376', '卑南鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('377', '鹿野鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('378', '關山鎮', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('379', '海端鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('380', '池上鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('381', '東河鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('382', '成功鎮', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('383', '長濱鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('384', '太麻里鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('385', '金峰鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('386', '大武鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('387', '達仁鄉', '1', '22', '0');
INSERT INTO `eacoo_taiwan` VALUES ('388', '花蓮市', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('389', '新城鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('390', '秀林鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('391', '吉安鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('392', '壽豐鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('393', '鳳林鎮', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('394', '光復鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('395', '豐濱鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('396', '瑞穗鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('397', '萬榮鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('398', '玉里鎮', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('399', '卓溪鄉', '1', '23', '0');
INSERT INTO `eacoo_taiwan` VALUES ('400', '富里鄉', '1', '23', '0');

-- ----------------------------
-- Table structure for eacoo_terms
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_terms`;
CREATE TABLE `eacoo_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `slug` varchar(100) DEFAULT '' COMMENT '分类别名',
  `taxonomy` varchar(32) DEFAULT '' COMMENT '分类类型',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '上级ID',
  `seo_title` varchar(128) DEFAULT '' COMMENT 'seo标题',
  `seo_keywords` varchar(255) DEFAULT '' COMMENT 'seo 关键词',
  `seo_description` varchar(255) DEFAULT '' COMMENT 'seo描述',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `sort` mediumint(8) unsigned DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`term_id`),
  KEY `idx_taxonomy` (`taxonomy`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='分类';

-- ----------------------------
-- Records of eacoo_terms
-- ----------------------------
INSERT INTO `eacoo_terms` VALUES ('1', '未分类', 'nocat', 'post_category', '0', '未分类', '', '自定义分类描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_terms` VALUES ('4', '大数据', 'tag_dashuju', 'post_tag', '0', '大数据', '', '这是标签描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `eacoo_terms` VALUES ('5', '技术类', 'technology', 'post_category', '0', '技术类', '关键词', '自定义分类描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '-1');
INSERT INTO `eacoo_terms` VALUES ('7', '运营', 'yunying', 'post_tag', '0', '运营', '关键字', '自定义标签描述', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_terms` VALUES ('9', '人物', 'renwu', 'media_cat', '0', '人物', '', '聚集多为人物显示的分类', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_terms` VALUES ('10', '美食', 'meishi', 'media_cat', '0', '美食', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_terms` VALUES ('11', '图标素材', 'icons', 'media_cat', '0', '图标素材', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_terms` VALUES ('12', '风景', 'fengjin', 'media_cat', '0', '风景', '风景', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_terms` VALUES ('13', '其它', 'others', 'media_cat', '0', '其它', '', '', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '99', '1');

-- ----------------------------
-- Table structure for eacoo_term_relationships
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_term_relationships`;
CREATE TABLE `eacoo_term_relationships` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `table` varchar(60) NOT NULL COMMENT '数据表',
  `uid` int(11) unsigned DEFAULT '0' COMMENT '分类与用户关系',
  `create_time` datetime DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `sort` int(10) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`id`),
  KEY `idx_term_id` (`term_id`) USING BTREE,
  KEY `idx_object_id` (`object_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='对象分类对应表';

-- ----------------------------
-- Records of eacoo_term_relationships
-- ----------------------------
INSERT INTO `eacoo_term_relationships` VALUES ('1', '95', '9', 'attachment', '1', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_term_relationships` VALUES ('2', '94', '13', 'attachment', '1', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_term_relationships` VALUES ('3', '116', '12', 'attachment', '1', '2018-09-30 22:32:26', '99', '1');
INSERT INTO `eacoo_term_relationships` VALUES ('7', '96', '12', 'attachment', '1', '2018-09-30 22:32:26', '99', '1');

-- ----------------------------
-- Table structure for eacoo_themes
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_themes`;
CREATE TABLE `eacoo_themes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `description` varchar(127) NOT NULL DEFAULT '' COMMENT '描述',
  `author` varchar(32) NOT NULL DEFAULT '' COMMENT '开发者',
  `version` varchar(8) NOT NULL DEFAULT '' COMMENT '版本',
  `config` text COMMENT '主题配置',
  `current` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前主题类型，1PC端，2手机端。默认0',
  `website` varchar(120) DEFAULT '' COMMENT '站点',
  `sort` tinyint(4) unsigned NOT NULL DEFAULT '99' COMMENT '排序，值越小越靠前',
  `create_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='前台主题表';

-- ----------------------------
-- Records of eacoo_themes
-- ----------------------------
INSERT INTO `eacoo_themes` VALUES ('1', 'default', '默认主题', '内置于系统中，是其它主题的基础主题', '心云间、凝听', '1.0.2', '', '1', 'https://www.eacoophp.com', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_themes` VALUES ('2', 'default-mobile', '默认主题-手机端', '内置于系统中，是系统的默认主题。手机端', '心云间、凝听', '1.0.1', '', '2', '', '99', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for eacoo_users
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_users`;
CREATE TABLE `eacoo_users` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '前台用户ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `number` char(10) NOT NULL DEFAULT '' COMMENT '会员编号',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(150) NOT NULL DEFAULT '' COMMENT '用户头像，相对于uploads/avatar目录',
  `sex` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '个人描述',
  `register_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '注册IP',
  `login_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '最后登录时间',
  `activation_auth_sign` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网站',
  `score` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '金额',
  `freeze_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '冻结金额，和金币相同换算',
  `pay_pwd` char(32) NOT NULL DEFAULT '' COMMENT '支付密码',
  `reg_from` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '注册来源。1PC端，2WAP端，3微信端，4APP端，5后台添加',
  `reg_method` varchar(30) NOT NULL DEFAULT '' COMMENT '注册方式。wechat,sina,等',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '等级，关联表user_level主键',
  `p_uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '推荐人会员ID',
  `is_lock` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否锁定。0否，1是',
  `actived` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否激活，0否，1是',
  `reg_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '注册时间',
  `update_time` datetime NOT NULL DEFAULT '0001-01-01 00:00:00' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uniq_number` (`number`) USING BTREE,
  KEY `idx_username` (`username`) USING BTREE,
  KEY `idx_email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='用户会员表';

-- ----------------------------
-- Records of eacoo_users
-- ----------------------------
INSERT INTO `eacoo_users` VALUES ('1', 'admin', '5257975351', '031c9ffc4b280d3e78c750163d07d275', '站长', '981248356@qq.com', '15801182251', 'http://cdn.eacoo.xin/attachment/static/assets/img/default-avatar.png', '1', '0000-00-00', '网站创始人和超级管理员。1', '', '0', '127.0.0.1', '2018-10-30 23:37:51', 'e2847283eb09508cfe0db793e5a90ad53b1b570b', 'https://www.eacoophp.com', '100', '100.00', '0.00', 'eba6095468eb32492d20d5db6a85aa5d', '0', '', '0', '0', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('3', 'U1471610993', '9948511005', '031c9ffc4b280d3e78c750163d07d275', '陈婧', '', '', '/static/assets/img/avatar-woman.png', '2', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', 'a525c9259ff2e51af1b6e629dd47766f99f26c69', '', '0', '2.00', '0.00', '', '0', '', '0', '0', '0', '0', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('4', 'U1472438063', '9752985498', '031c9ffc4b280d3e78c750163d07d275', '妍冰', '', '', '/static/assets/img/avatar-woman.png', '2', '0000-00-00', '承接大型商业演出和传统文化学习班', '', '0', '', '2018-09-30 22:32:26', 'ed587cf103c3f100be20f7b8fdc7b5a8e2fda264', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_users` VALUES ('5', 'U1472522409', '9849571025', '031c9ffc4b280d3e78c750163d07d275', '久柳', '', '', '/static/assets/img/avatar-man.png', '1', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', '5e542dc0c77b3749f2270cb3ec1d91acc895edc8', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('8', 'U1472877421', '5497481009', '031c9ffc4b280d3e78c750163d07d275', '印文博律师', '', '', '/static/assets/img/avatar-man.png', '1', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', 'e99521af40a282e84718f759ab6b1b4a989d8eb1', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '0', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '0');
INSERT INTO `eacoo_users` VALUES ('9', 'U1472966655', '1004810149', '031c9ffc4b280d3e78c750163d07d275', '嘉伟', '', '', '/static/assets/img/avatar-man.png', '1', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', 'f1075223be5f53b9c2c1abea8288258545365d96', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('10', 'U1473304718', '9852101101', '031c9ffc4b280d3e78c750163d07d275', '鬼谷学猛虎流', '', '15801182191', '/static/assets/img/avatar-man.png', '1', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', '039fc7a3f9366adf55ee9e707c371a2459c17bd7', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('12', 'U1473396778', '5310148501', '031c9ffc4b280d3e78c750163d07d275', '董超楠', '', '', '/static/assets/img/avatar-woman.png', '2', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', '8bbf5242300e5e8e4917b287a31efcb0c9feedfd', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '1', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('14', 'U1473396839', '4853979757', '031c9ffc4b280d3e78c750163d07d275', '求真实者', '', '', '/static/assets/img/default-avatar.png', '0', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', '8f7579a85981e1c1f726704b0865320dfadbef2e', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '0', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('16', 'U1473397426', '1015057995', '031c9ffc4b280d3e78c750163d07d275', '随风而去的心情', '', '15801182190', '/static/assets/img/avatar-man.png', '1', '0000-00-00', '大师傅', '', '0', '', '2018-09-30 22:32:26', '14855b00775de46b451c8255e6a73a5c044fc188', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '0', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');
INSERT INTO `eacoo_users` VALUES ('17', 'U1474181145', '5551564851', '031c9ffc4b280d3e78c750163d07d275', '班鱼先生', '', '', '/static/assets/img/avatar-man.png', '1', '0000-00-00', '', '', '0', '', '2018-09-30 22:32:26', '86d19a7b1f15db4fd25e0b64bfc17870a70f67e2', '', '0', '0.00', '0.00', '', '0', '', '0', '0', '0', '0', '2018-09-30 22:32:26', '2018-09-30 22:32:26', '1');

-- ----------------------------
-- Table structure for eacoo_user_level
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_user_level`;
CREATE TABLE `eacoo_user_level` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '等级名称',
  `description` varchar(300) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态。0禁用，1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户等级表';

-- ----------------------------
-- Records of eacoo_user_level
-- ----------------------------

-- ----------------------------
-- Table structure for eacoo_withdrawal
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_withdrawal`;
CREATE TABLE `eacoo_withdrawal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL COMMENT '会员id',
  `price` decimal(10,0) NOT NULL COMMENT '提现金额',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1未处理 2同意提现 3拒绝提现',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL COMMENT '会员昵称',
  `bank_id` int(11) DEFAULT NULL COMMENT '绑定银行id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='会员提现';

-- ----------------------------
-- Records of eacoo_withdrawal
-- ----------------------------
INSERT INTO `eacoo_withdrawal` VALUES ('2', '2', '50', '1', '1559186874', '1559289987', '测试', '1');
INSERT INTO `eacoo_withdrawal` VALUES ('4', '2', '1', '1', '1559615918', '1559640513', '测试', null);
INSERT INTO `eacoo_withdrawal` VALUES ('5', '2', '12', '1', '1559615919', '1559640507', '测试', null);

-- ----------------------------
-- Table structure for eacoo_works
-- ----------------------------
DROP TABLE IF EXISTS `eacoo_works`;
CREATE TABLE `eacoo_works` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '作品集标题',
  `describe` varchar(255) NOT NULL DEFAULT '0' COMMENT '作品集描述',
  `icon` varchar(255) NOT NULL DEFAULT '0' COMMENT '作品集图片id：1,2,3',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：1为上架 2为下架',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `craftsman_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联的工匠id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='工匠作品集';

-- ----------------------------
-- Records of eacoo_works
-- ----------------------------
INSERT INTO `eacoo_works` VALUES ('1', '小样', '这个天气', '102,103', '1', '1562312734', '1562312734', '1');
