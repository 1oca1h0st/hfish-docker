CREATE DATABASE IF NOT EXISTS `hfish` DEFAULT CHARSET=utf8mb4;
USE `hfish`;

CREATE TABLE IF NOT EXISTS `users` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `username` VARCHAR(64) NOT NULL COMMENT '用户名',
    `nickname` VARCHAR(64) DEFAULT '' COMMENT '昵称',
    `role` INT(3) DEFAULT 0 COMMENT '角色',
    `country_code` VARCHAR(8) DEFAULT '' COMMENT '国家码',
    `phone` VARCHAR(32) DEFAULT '' COMMENT '手机号',
    `wechat` VARCHAR(32) DEFAULT '' COMMENT '微信号',
    `email` VARCHAR(32) DEFAULT '' COMMENT '邮箱',
    `password` VARCHAR(64) DEFAULT '' COMMENT '密码',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    `last_login_time` DATETIME COMMENT '最后登陆时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_key` (`username`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `clients` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `node_id` VARCHAR(32) NOT NULL COMMENT '节点包ID',
    `client_id` VARCHAR(32) NOT NULL COMMENT '节点ID',
    `client_name` VARCHAR(32) DEFAULT '' COMMENT '节点名称',
    `client_arch` VARCHAR(32) NOT NULL COMMENT '节点架构',
    `client_ip` VARCHAR(1024) DEFAULT '' COMMENT '节点IP',
    `client_version` VARCHAR(32) DEFAULT '' COMMENT '节点版本',
    `location` VARCHAR(32) DEFAULT '' COMMENT '部署位置',
    `server_addr` VARCHAR(32) NOT NULL COMMENT '部署位置',
    `mould_id` VARCHAR(32) DEFAULT '' COMMENT '模板ID',
    `services` TEXT COMMENT '节点服务',
    `mould_status` VARCHAR(1024) DEFAULT '' COMMENT '服务状态',
    `bait_status` INT(2) DEFAULT 0 COMMENT '蜜饵状态',
    `client_status` INT(2) DEFAULT 1 COMMENT '节点状态',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    `report_time` DATETIME COMMENT '上报时间',
    `install_time` DATETIME COMMENT '部署时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_client_id` (`client_id`),
    UNIQUE KEY `index_client_name` (`client_name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `hosts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `client_id` VARCHAR(32) NOT NULL COMMENT '节点ID',
    `host_id` VARCHAR(64) NOT NULL COMMENT '主机ID',
    `platform` VARCHAR(64) DEFAULT '' COMMENT '平台信息',
    `os_arch`  VARCHAR(32) DEFAULT '' COMMENT '系统架构',
    `time_zone` VARCHAR(32) DEFAULT '' COMMENT '时区信息',
    `cpu_num` INT(11) DEFAULT 0 COMMENT 'CPU个数',
    `mem_total` BIGINT(22) DEFAULT 0 COMMENT '内存大小',
    `mem_used` BIGINT(22) DEFAULT 0 COMMENT '内存使用',
    `disk_total` BIGINT(22) DEFAULT 0 COMMENT '磁盘大小',
    `disk_used` BIGINT(22) DEFAULT 0 COMMENT '磁盘使用',
    `net_info` VARCHAR(1024) DEFAULT '' COMMENT '网络信息',
    `dns_info` VARCHAR(256) DEFAULT '' COMMENT 'DNS信息',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_key` (`client_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `flows` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `client_id` VARCHAR(64) NOT NULL COMMENT '节点ID',
    `bytes_send` BIGINT(22) DEFAULT 0 COMMENT '出口字节大小',
    `bytes_recv` BIGINT(22) DEFAULT 0 COMMENT '入口字节大小',
    `package_send` BIGINT(22) DEFAULT 0 COMMENT '出口包数量',
    `package_recv` BIGINT(22) DEFAULT 0 COMMENT '入口包数量',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `index_key` (`client_id`) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `moulds` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `mould_id` VARCHAR(64) NOT NULL COMMENT '模板ID',
    `mould_name` VARCHAR(64) NOT NULL COMMENT '模板名称',
    `services` TEXT COMMENT '模板服务',
    `describe` TEXT COMMENT '模板描述',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_id` (`mould_id`),
    UNIQUE KEY `index_name` (`mould_name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `services` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `type` VARCHAR(64) NOT NULL COMMENT '服务类型',
    `name` VARCHAR(64) NOT NULL COMMENT '模板名称',
    `class` VARCHAR(64) DEFAULT '' COMMENT '模板大类',
    `level` VARCHAR(64) DEFAULT '' COMMENT '交互级别',
    `fish` INT(2) DEFAULT 0 COMMENT '是否配置蜜饵',
    `custom` INT(2) DEFAULT 0 COMMENT '是否自定义',
    `port` VARCHAR(256) DEFAULT '' COMMENT '开放端口',
    `command` VARCHAR(128) DEFAULT '' COMMENT '服务命令',
    `describe` TEXT COMMENT '服务描述',
    `status` INT(2) DEFAULT 0 COMMENT '服务状态',
    `err_desc` TEXT COMMENT '错误描述',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_type` (`type`),
    UNIQUE KEY `index_name` (`name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `infos` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `info_id` VARCHAR(20) NOT NULL COMMENT '消息ID',
    `client_id` VARCHAR(32) NOT NULL COMMENT '客户端ID',
    `service` VARCHAR(20) DEFAULT '' COMMENT '蜜罐类型',
    `project` VARCHAR(32) DEFAULT '' COMMENT '项目名称',
    `source_ip` VARCHAR(32) DEFAULT '' COMMENT '源IP',
    `source_port` VARCHAR(32) DEFAULT '' COMMENT '源端口',
    `dest_ip` VARCHAR(32) DEFAULT '' COMMENT '目的IP',
    `dest_port` VARCHAR(32) DEFAULT '' COMMENT '目的端口',
    `info` TEXT COMMENT '攻击数据',
    `info_len` INT(11) DEFAULT 0 COMMENT '数据长度',
    `collected` INT(2) DEFAULT 0 COMMENT '是否被收藏',
    `describe` TEXT COMMENT '攻击描述',
    `create_time` DATETIME NOT NULL COMMENT '攻击时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_key` (`client_id`,`info_id`),
    KEY `info_index_1` (`info_id`) USING BTREE,
    KEY `info_index_2` (`client_id`) USING BTREE,
    KEY `info_index_3` (`service`) USING BTREE,
    KEY `info_index_4` (`source_ip`) USING BTREE,
    KEY `info_index_5` (`dest_ip`) USING BTREE,
    KEY `info_index_6` (`collected`) USING BTREE,
    KEY `info_index_7` (`create_time`) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ipaddress` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `ip` VARCHAR (32) NOT NULL COMMENT '攻击IP',
    `marked` INT(2) DEFAULT '0' COMMENT '是否被标记',
    `intranet` INT(2) DEFAULT '0' COMMENT '是否内网IP',
    `domain` VARCHAR (64) DEFAULT '' COMMENT '域名',
    `country` VARCHAR(24) DEFAULT '' COMMENT '国家',
    `region` VARCHAR(24) DEFAULT '' COMMENT '地区',
    `city` VARCHAR(24) DEFAULT '' COMMENT '城市',
    `asn` VARCHAR(255) DEFAULT '' COMMENT 'ASN信息',
    `severity` VARCHAR(16) DEFAULT '' COMMENT '危险等级',
    `labels` TEXT COMMENT '威胁情报标签',
    `labels_cn` TEXT COMMENT '威胁情报标签中文',
    `custom` TEXT COMMENT '自定义情报',
    `person` TEXT COMMENT '关联人信息',
    `describe` TEXT COMMENT 'IP地址描述',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_key` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `intelligences` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `ip` VARCHAR(32) NOT NULL COMMENT '攻击IP',
    `source` VARCHAR(32) NOT NULL COMMENT '情报来源',
    `detail` TEXT COMMENT '情报详情',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_key` (`ip`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `settings` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `name` VARCHAR(50) NOT NULL COMMENT '名称',
    `config` TEXT COMMENT '配置',
    `example` TEXT COMMENT '示例',
    `describe` TEXT COMMENT '描述',
    `status` INT(2) DEFAULT 0 COMMENT '状态',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_key` (`name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `policies` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `policy_id` VARCHAR(32) NOT NULL COMMENT '告警ID',
    `policy_name` VARCHAR(64) NOT NULL COMMENT '告警名称',
    `alert_type` VARCHAR(32) NOT NULL COMMENT '告警类型',
    `level` VARCHAR(32) DEFAULT '' COMMENT '告警级别',
    `method` VARCHAR(64) NOT NULL COMMENT '告警方式',
    `config` TEXT COMMENT '告警配置',
    `status` INT(2) DEFAULT 0 COMMENT '状态',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_policy_id` (`policy_id`),
    UNIQUE KEY `index_policy_name` (`policy_name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `passwords` (
     `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
     `client_id` VARCHAR(32) NOT NULL COMMENT '节点ID',
     `service` VARCHAR(24) NOT NULL COMMENT '服务类型',
     `source_ip` VARCHAR(64) DEFAULT '' COMMENT '源IP',
     `source_port` VARCHAR(32) DEFAULT '' COMMENT '源端口',
     `dest_ip` VARCHAR(64) DEFAULT '' COMMENT '目的IP',
     `dest_port` VARCHAR(32) DEFAULT '' COMMENT '目的端口',
     `username` VARCHAR(64) NOT NULL COMMENT '用户名',
     `password` VARCHAR(64) DEFAULT '' COMMENT '密码',
     `create_time` DATETIME NOT NULL COMMENT '创建时间',
     `update_time` DATETIME NOT NULL COMMENT '更新时间',
     PRIMARY KEY (`id`),
     KEY `pass_index_1` (`client_id`) USING BTREE,
     KEY `pass_index_2` (`service`) USING BTREE,
     KEY `pass_index_3` (`source_ip`) USING BTREE,
     KEY `pass_index_4` (`dest_ip`) USING BTREE,
     KEY `pass_index_5` (`username`) USING BTREE,
     KEY `pass_index_6` (`password`) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `baits` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` INT(11) NOT NULL COMMENT '用户ID',
    `username` VARCHAR(64) NOT NULL COMMENT '用户名',
    `password` VARCHAR(64) NOT NULL COMMENT '密码',
    `ip_list` TEXT COMMENT '主机IP列表',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_username` (`username`),
    UNIQUE KEY `uni_password` (`password`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nodes` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `node_id` VARCHAR(32) NOT NULL COMMENT '节点ID',
    `node_arch` VARCHAR(32) NOT NULL COMMENT '节点架构',
    `node_addr` TEXT COMMENT '节点回连地址',
    `location` VARCHAR(32) DEFAULT '' COMMENT '部署位置',
    `mould_id` VARCHAR(32) DEFAULT '' COMMENT '模板ID',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uni_node_id` (`node_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `scanners` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `client_id` VARCHAR(32) NOT NULL COMMENT '节点ID',
    `scan_type` VARCHAR(32) NOT NULL COMMENT '扫描类型',
    `source_mac` VARCHAR(64) DEFAULT '' COMMENT '源MAC',
    `source_ip` VARCHAR(64) NOT NULL COMMENT '源IP',
    `source_port` VARCHAR(32) DEFAULT '' COMMENT '源端口',
    `dest_mac` VARCHAR(64) DEFAULT '' COMMENT '目的MAC',
    `dest_ip` VARCHAR(64) NOT NULL COMMENT '目的IP',
    `dest_port` VARCHAR(32) DEFAULT '' COMMENT '目的端口',
    `detail` TEXT COMMENT '扫描详情',
    `length` INT(11) DEFAULT 0 COMMENT '详情长度',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `scan_index_1` (`client_id`,`scan_type`,`source_ip`,`dest_ip`) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `scans` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `client_id` VARCHAR(32) NOT NULL COMMENT '节点ID',
    `scan_type` VARCHAR(32) NOT NULL COMMENT '扫描类型',
    `source_mac` VARCHAR(64) DEFAULT '' COMMENT '源MAC',
    `source_ip` VARCHAR(64) NOT NULL COMMENT '源IP',
    `source_port` TEXT COMMENT '源端口',
    `dest_mac` VARCHAR(64) DEFAULT '' COMMENT '目的MAC',
    `dest_ip` VARCHAR(64) NOT NULL COMMENT '目的IP',
    `dest_port` TEXT COMMENT '目的端口',
    `scan_count` INT(11) DEFAULT 0 COMMENT '扫描次数',
    `scan_time` INT(11) DEFAULT 0 COMMENT '扫描持续时间',
    `create_time` DATETIME NOT NULL COMMENT '创建时间',
    `update_time` DATETIME NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `scan_index_1` (`client_id`,`scan_type`,`source_ip`,`dest_ip`) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('threat','{"source":"plt","plt":{"addr":"https://api.threatbook.cn","apikey":""},"tip":{"addr":"","apikey":""}}','','威胁情报配置',NOW(),NOW());
INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('whiteIp','','','白名单配置',NOW(),NOW());
INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('syslog','[]','{"threat":"title: HFish Threat Alert, client: linux64测试机, type: SSH, name: SSH蜜罐, ip: 141.98.81.141, geo: 美国/加州/堪萨斯, time: 2021-03-16 13:37:15, info: dsfs&&fff, labels: 扫描,未启用IP","system":"title: HFish System Alert, host: hfish+8c01a551-829f-4caa-9736-0e8aa0465e10, mem: 19, cpu: 3, disk: 14, time: 2021-02-10 02:42:22"}','Syslog服务器配置',NOW(),NOW());
INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('email','{}','{"threat":"您正在使用HFish Vx.x.x 蜜罐服务，附件内容是您最近十分钟遭到的攻击数据，请查收。本邮件来自系统自动发送，请勿回复。","system":"您正在使用的HFish Vx.x.x 蜜罐服务，检测到本机系统 CPU使用率超过 70%, 请您紧急处理，否则可能会影响到机器正常使用。本邮件来自系统自动发送，请勿回复。","clear":"您正在使用的HFish Vx.x.x 蜜罐服务，检测到系统攻击数据超出3000000，为了系统的稳定性与您的使用体验，请您及时清理。如果需要该历史数据，请您下载留存。本邮件来自系统自动发送，请勿回复。"}','邮件服务器配置',NOW(),NOW());
INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('webhook','[]','{"threat":{"msgtype":"text","text":{"content":"title: HFish Threat Alert, client: linux64测试机, type: SSH, name: SSH蜜罐, ip: 141.98.81.141, geo: 美国/加州/堪萨斯, time: 2021-03-16 13:37:15, info: ddd&&fff, labels: 扫描,未启用IP"}},"system":{"msgtype":"text","text":{"content":"title: HFish System Alert, host: hfish+8c01a551-829f-4caa-9736-0e8aa0465e10, mem: 19,cpu: 3, disk: 14, time: 2021-02-10 02:42:22"}}}','WebHook服务器配置',NOW(),NOW());
INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('keyword','[]','','关键字配置',NOW(),NOW());
INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('isScan','1','1','是否开启扫描',NOW(),NOW());
INSERT IGNORE INTO `settings` (`name`, `config`, `example`, `describe`, `create_time`, `update_time`) VALUES('isInnerNodeOpen','1','1','是否开启内置节点',NOW(),NOW());

INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('SSH', 'SSH蜜罐', '基础服务', 'low', 0, 'TCP/22', 'ssh', '提供虚假的SSH服务端，常见于办公、生产、互联网场景，默认使用TCP/22端口。SSH是Secure Shell的缩写，SSH是专为远程登录会话和其他网络服务提供安全性的协议，目前几乎所有的基于Linux、BSD、Unix的操作系统和IoT都支持使用SSH远程登录，因此SSH也成为最常见的网络服务。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('FTP', 'FTP蜜罐', '基础服务', 'low', 0, 'TCP/21', 'ftp', '提供虚假的FTP服务端，该服务常见于办公、生产、互联网场景，安全性能较差，多用于内部系统、公开平台、临时使用或IoT系统。FTP服务默认使用TCP/21端口。FTP全称为File Transfer Protocol，即文件传输协议，是用于在网络上进行文件传输的一套标准协议。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('TFTP', 'TFTP蜜罐', '基础服务', 'low', 0, 'TCP/69', 'tftp', '提供虚假的TFTP服务端。TFTP即简单文件传输协议，常见于办公、生产和IoT场景, 默认使用TCP/69端口。 TFTP用来在客户机与服务器之间进行简单文件传输的协议，提供不复杂、开销不大的文件传输服务。常用于路由器、交换机等硬件设备更新固件。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('TELNET', 'Telnet蜜罐', '基础服务', 'low', 0, 'TCP/23', 'telnet', '提供虚假的Telnet服务端，一般只用于内部系统、路由交换等IoT设备，该服务常见于办公场景，默认使用TCP/23端口。Telnet非常古老，是Internet远程登录服务的标准协议和主要方式，由于Telnet协议采用明文传输，安全性能较差，常被攻击者探测。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('VNC', 'VNC蜜罐', '基础服务', 'low', 0, 'TCP/5900', 'vnc', '提供虚假的VNC服务端，常见于办公、生产、互联网场景，默认使用TCP/5900端口。VNC是一款远程控制工具软件，该服务其可用于远程控制维护Linux、Windows、Mac环境，真实VNC一旦被攻破有较大危险。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('HTTP', 'HTTP代理蜜罐', 'WEB服务', 'low', 0, 'TCP/80', 'http', '提供虚假的HTTP服务端，该服务常见于办公、生产、互联网场景，HTTP服务默认使用TCP/80端口。 HTTP全称为HyperText Transfer Protocol，即超文本传输协议，是互联网上应用最为广泛的一种网络协议。HTTP蜜罐模拟了一个虚假的HTTP服务端，可以接收所有访问到该服务端口的网络请求，并解析该请求的URL和客户端地址 ，以及请求信息。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('WORDPRESS', 'WordPress仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9090', 'wordpress', '提供虚假的WordPress后台登录Web界面，常见于互联网场景，默认使用TCP/9090端口。可以记录下来黑客的攻击信息。WordPress是一款非常著名的开源免费的个人博客和CMS系统。WordPress本身安全性较好，但其灵活的三方插件存在大量安全问题，很多攻击者都会优先扫描WordPress后台。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('OA', '通用OA系统仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9096', 'oa', '提供虚假的办公OA后台登录Web界面(通达网络智能办公系统)，常见于互联网场景，默认使用TCP/9096端口，可以记录下黑客对办公系统的攻击信息。OA办公系统是为了满足更高效地实现一个组织目标而发明的应用系统。本页面提供的通用OA系统无任何公司标记。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('MYSQL', 'MYSQL蜜罐', '数据库服务', 'low', 0, 'TCP/3306', 'mysql', '提供虚假的 MySQL 服务端。MySQL 是一种关系型数据库管理系统，默认使用TCP/3306端口，其所倡导的 SQL语言已成为访问数据库的最常用标准化语言。MySQL 蜜罐提供了与原始 MySql 服务端相同的界面，可捕获黑客的攻击信息。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('REDIS', 'REDIS蜜罐', '数据库服务', 'low', 0, 'TCP/6379', 'redis', '提供虚假的Redis服务端，常见于生产、互联网场景，默认使用TCP/6379端口。Redis全称为Remote Dictionary Server，即远程字典服务，是一个使用ANSI C语言编写的开源的、支持网络、可基于内存亦可持久化的日志型、Key-Value高性能的数据库。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('MEMCACHE', 'MEMCACHE蜜罐', '数据库服务', 'low', 0, 'TCP/11211', 'memcache', '提供虚假的Memcache服务端，常见于生产、互联网场景，默认使用TCP/11211端口。Memcache是一个高性能的分布式的内存对象缓存系统，通过在内存里维护一个统一的巨大的哈希表，它能够用来存储各种格式的数据，包括图像、视频、文件以及数据库检索的结果等。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('ES', 'Elasticsearch蜜罐', '数据库服务', 'low', 0, 'TCP/9200', 'es', '提供虚假的 Elasticsearch 服务端。Elasticsearch 是一个企业级分布式全文搜索引擎，该服务常见于大数据生产、互联网场景，默认使用 TCP/9200端口。 Elasticsearch 通常与数据收集套件 Logstash、前端可视化展示组件 Kibana 配合，统称为ELK。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('CUSTOM', 'CUSTOM蜜罐', '自定义服务', 'low', 0, 'TCP/8989', 'custom', '提供自定义的插件服务，可以直接对接其他产品，比如我们使用其他蜜罐捕获到了数据，想要传输到本系统，就可以部署CUSTOM服务，在其他蜜罐上面对接CUSTOM服务的API接口即可。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('TCP', 'TCP端口监听', '端口监听', 'low', 0, 'TCP/135,TCP/139,TCP/445,TCP/3389', 'tcp', 'TCP协议是一种面向连接的、可靠的、基于字节流的传输层通信协议。设置TCP监听端口，可以动态监听各端口被连接情况。当前默认环境135、139、445、3389端口，以上为微步在线情报提供的勒索软件常见探测端口。', NOW(), NOW());
UPDATE `services` set status = 1 where custom = 0 and status > 0;
UPDATE `services` set name = 'HTTP代理蜜罐' where type = 'HTTP';

INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('ARUBA', 'Aruba无线AP蜜罐', 'WEB服务', 'low', 0, 'TCP/9101', 'aruba', '该蜜罐仿真了Aruba无线AP的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内网办公环境。Aruba成立于2002年，总部位于加州的桑尼维尔市，专注于企业基础无线网络的建设，提供无缝的统一的接入网络，该系统在企业中常被定义为核心IT运维系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('GITLAB', 'GitLab仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9093', 'gitlab', '提供虚假的GitLab后台登录Web界面，常见于互联网场景，默认使用TCP/9093，可以记录下黑客对代码托管的攻击信息。GitLab是一个利用 Ruby on Rails 实现的开源的自托管Git项目仓库，其可通过Web界面进行访问公开的或者私人项目。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('ESXI', 'ESXi系统蜜罐', 'WEB服务', 'low', 0, 'TCP/9190', 'esxi', '该蜜罐仿真了虚拟化管理平台ESXi的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内外网运维环境。ESXi是著名虚拟化厂商VMware出品的基于Linux的虚拟化管理平台，该系统在企业环境中常用于核心运维系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('IIS', 'IIS服务蜜罐', 'WEB服务', 'low', 0, 'TCP/9199', 'iis', '该蜜罐仿真了微软 IIS 默认主页，可用于记录探测和攻击行为，建议部署在外网生产环境。微软IIS 服务器是由微软公司提供的基于运行Microsoft Windows的互联网 Web 服务器，该系统在企业中常被用于 Web 应用服务器，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('NAGIOS', 'Nagios监控系统蜜罐', 'WEB服务', 'low', 0, 'TCP/9191', 'nagios', '该蜜罐仿真了网络监控平台Nagios的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内外网运维环境。Nagios是开源免费网络监视工具，能有效监控Windows、Linux、Unix主机、交换机路由器等网络设备的运行状态，该系统在企业环境中常用于核心运营系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('JIRA', 'Jira系统蜜罐', 'WEB服务', 'low', 0, 'TCP/9292', 'jira', '该蜜罐仿真了项目管理平台Jira的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内外网运维环境。Jira是Atlassian公司出品的项目与事务跟踪工具，被广泛应用于缺陷跟踪、客户服务、需求收集、流程审批、任务跟踪、项目跟踪和敏捷管理等工作领域，该系统在企业环境中常用于核心运营系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('SYNOLOGY_NAS', '群晖NAS蜜罐', 'WEB服务', 'low', 0, 'TCP/9194', 'synology_nas', '该蜜罐仿真了群晖NAS的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内网办公环境。群晖群晖科技（Synology Inc.）创立于 2000 年，自始便专注智能存储领域，是全球少数几家以单纯的提供网络存储解决方案的华人企业，常被用于存储大量资料，该系统在家庭和中小型环境中常用于核心运营系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('RUIJIE_SWITCH', '锐捷交换机蜜罐', 'WEB服务', 'low', 0, 'TCP/9196', 'ruijie_switch', '该蜜罐仿真了锐捷交换机的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内网办公环境。锐捷成立于2000年1月，原名实达网络，2003年更名，其产品涵盖了交换、无线、路由器、安全、出口网关，该系统在企业中常被定义为核心IT运维系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('TPLINK', 'TP-LINK路由器仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9197', 'tplink', '该蜜罐仿真了TP-LINK路由器的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内网办公环境。TP-LINK是普联技术有限公司旗下的品牌，成立于1996年，专门从事网络与通信终端设备研发和制造，该系统在企业中常被定义为核心IT运维系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('WEBSPHERE', 'Websphere蜜罐', 'WEB服务', 'low', 0, 'TCP/9080', 'websphere', '该蜜罐仿真了IBM WebSphere的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在外网生产环境。WebSphere 是 IBM 的软件平台，它包含了编写、运行和监视全天候的工业强度的随需应变 Web 应用程序和跨平台、跨产品解决方案所需要的整个中间件基础设施，该系统在企业中常被用于Web应用服务器，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('TOMCAT', 'Tomcat蜜罐', 'WEB服务', 'low', 0, 'TCP/9198', 'tomcat', '该蜜罐仿真了 Tomcat 默认主页，可用于记录账号暴力破解和攻击行为，建议部署在外网生产环境。Tomcat 服务器是一个免费的开放源代码的 Web 应用服务器，属于轻量级应用服务器，在中小型系统和并发访问用户不是很多的场合下被普遍使用，该系统在企业中常被用于 Web 应用服务器，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('ZABBIX', 'Zabbix监控系统蜜罐', 'WEB服务', 'low', 0, 'TCP/9192', 'zabbix', '该蜜罐仿真了网络监控平台Zabbix的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内外网运维环境。Zabbix是一个基于WEB界面的提供分布式系统监视以及网络监视功能的企业级的开源解决方案，该系统在企业环境中常用于核心运营系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('NGINX', 'Nginx蜜罐', 'WEB服务', 'low', 0, 'TCP/9291', 'nginx', '该蜜罐仿真了Nginx 默认主页，可用于记录探测和攻击行为，建议部署在外网生产环境。Nginx 是一个高性能的HTTP和反向代理 Web 服务器，该系统在企业中常被用于 Web 应用服务器，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('CONFLUENCE', 'Confluence系统蜜罐', 'WEB服务', 'low', 0, 'TCP/9293', 'confluence', '该蜜罐仿真了项目管理平台Confluence的Web登陆界面，可用于记录账号暴力破解和攻击行为，建议部署在内外网运维环境。Confluence是Atlassian公司出品的专业的企业知识管理与协同软件，也可以用于构建企业wiki，帮助团队成员之间共享信息、文档协作、集体讨论，信息推送，该系统在企业环境中常用于核心运营系统，对攻击者有极大诱惑力。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('COREMAIL', 'Coremail仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9094', 'coremail', '提供虚假的Coremail后台登陆Web界面，常见于互联网场景，默认使用TCP/9094端口，可以记录下黑客对邮件系统的攻击信息。Coremail邮件系统产品是目前国内邮箱使用用户最多的邮件系统，为网易（126、163、yeah）、移动，联通等知名运营商，以及石油、钢铁、电力、政府、金融、教育、尖端制造企业等用户提供邮件系统软件和反垃圾服务。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('EXCHANGE', 'Exchange仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9095', 'exchange', '提供虚假的Microsoft Exchange后台登陆Web界面，常见于互联网场景，默认使用TCP/9095端口，可以记录下黑客对邮件系统的攻击信息。Exchange Server 是微软公司的一套电子邮件服务组件，是个消息与协作系统，常用来构架应用于企业、学校的邮件系统。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('OA-GOV', '政务OA系统仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9098', 'oa-gov', '提供虚假的政务OA系统后台登陆Web界面，常见于互联网场景，默认使用TCP/9098端口，可以记录下黑客对政务OA系统后台的攻击信息。政务OA后台登陆Web界面作为政府部门内部管理平台，辅助管理政府部门内部信息，有较高的信息价值。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('OA-TONGDA', '通达OA系统仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9099', 'oa-tongda', '提供虚假的通达OA后台登陆Web界面(通达网络智能办公系统)，常见于互联网场景，默认使用TCP/9099端口，可以记录下黑客对办公系统的攻击信息。通达OA网络智能办公系统目前被许多企事业单位使用。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('H3C', 'H3C仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9092', 'h3c', '提供虚假的H3C路由器后台登陆Web界面，常见于内网场景，默认使用TCP/9092端口。路由器能连接两个或多个网络的硬件设备，在网络间起网关的作用。H3C是全球路由器领域产品系列最全、解决方案最完善的领先者之一，在国内有大范围的应用，符合大多数企业现有环境，可以与本地环境高度仿真。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('QZSEC', '齐治堡垒机仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9193', 'qzsec', '提供虚假的齐治堡垒机仿真登陆Web界面，常见于安全管理中心，默认使用TCP/10005，可以记录下黑客对齐治堡垒机的攻击信息。齐治是专注运维操作管理领域的厂商，其堡垒机产品在市面被广泛采用。', NOW(), NOW());
INSERT INTO `services` (`type`, `name`, `class`, `level`, `fish`, `port`, `command`, `describe`, `create_time`, `update_time`) VALUES ('IOT-HIKCAM', '海康摄像头仿真登陆蜜罐', 'WEB服务', 'low', 0, 'TCP/9082', 'iot-hikcam', '提供虚假的海康微视摄像头后台登陆Web界面，常见于IOT场景，默认使用TCP/9082端口，可以记录下黑客对IOT设备的攻击信息。摄像头往往布置在生产环境中，属于机密信息。海康威视是领先的安防产品及行业解决方案提供商，其摄像头被广泛使用。', NOW(), NOW());