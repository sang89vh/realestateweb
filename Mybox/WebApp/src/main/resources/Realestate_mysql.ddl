CREATE SCHEMA `realestate` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
##drop
DROP TABLE IF EXISTS sys_user_role;
DROP TABLE IF EXISTS sys_user;
DROP TABLE IF EXISTS sys_para;
DROP TABLE IF EXISTS sys_menu;

##create

CREATE TABLE sys_user_role (user_role_id bigint(19) NOT NULL AUTO_INCREMENT, user_id bigint(19) NOT NULL, user_name varchar(255), role varchar(255), PRIMARY KEY (user_role_id));
CREATE TABLE sys_user (user_id bigint(19) NOT NULL AUTO_INCREMENT, user_name varchar(255) NOT NULL, password varchar(255) NOT NULL, enabled tinyint(1) DEFAULT b'1', PRIMARY KEY (user_id));
CREATE TABLE sys_para (sys_para_id bigint(19) NOT NULL AUTO_INCREMENT, code varchar(255) NOT NULL, value text NOT NULL, `GROUP` varchar(255), PRIMARY KEY (sys_para_id));
CREATE TABLE sys_menu (menu_id bigint(19) NOT NULL AUTO_INCREMENT, title varchar(255), path varchar(255), url varchar(255), parent_id bigint(19), PRIMARY KEY (menu_id));
