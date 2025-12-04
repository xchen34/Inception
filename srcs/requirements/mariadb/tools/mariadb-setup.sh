#!/bin/bash

SQL_ROOT_PASSWORD=$(cat "$SQL_ROOT_PASSWORD_FILE")
SQL_PASSWORD=$(cat "$SQL_PASSWORD_FILE")

service mariadb start

sleep 5

mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

mysql -u root -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

su  mysql

exec mysqld_safe

#mysql 登录mariadb  -u user -p passwrd -e execute 
#这段脚本是在 启动 MariaDB 容器时自动初始化数据库和用户的
一下是sql语法
# ✅ 第一句：

# CREATE DATABASE IF NOT EXISTS `数据库名`;

# 意思是：
# ➡️ “如果还没有这个数据库，就创建它。”
# IF NOT EXISTS 是可选的，表示不要重复创建。

# 例子：

# CREATE DATABASE IF NOT EXISTS `wordpress`;

# 这样就创建了一个叫 wordpress 的数据库。
# ✅ 第二句：

# CREATE USER IF NOT EXISTS '用户名'@'主机' IDENTIFIED BY '密码';

# 意思是：
# ➡️ “如果没有这个用户，就创建一个用户，设置密码。”

#     '用户名'@'主机' 表示这个用户 从哪可以登录。

#         '%' 表示 任何地方都能连接（比较常见）

#         'localhost' 表示只能从本机连

# 例子：

# CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY '12345';

# 这会创建一个用户 wpuser，密码是 12345，可以从任何地方连接。
# ✅ 第三句：

# GRANT 权限 ON 数据库名.* TO '用户名'@'主机';

# 意思是：
# ➡️ “给这个用户某个数据库的权限。”

# 常用的权限：

#     ALL PRIVILEGES：就是所有权限（增删改查、创建表等等）

# 例子：

# GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';

# 给 wpuser 用户在 wordpress 数据库里 所有权限。
# ✅ 最后：

# FLUSH PRIVILEGES;

# 这个是： ➡️ “刷新权限”，让你刚刚加的用户和权限马上生效。
#✅ 第四句  修改 root 用户在 localhost（本地）上的密码为 ${SQL_ROOT_PASSWORD}。

# 这段脚本：

#     启动 MariaDB 临时服务

#     创建数据库、用户、权限

#     设置 root 密码

#     然后关掉 MariaDB

#     再用安全方式启动 MariaDB

# mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# 👉 把 MariaDB 优雅地关机（为了之后用 mysqld_safe 正式启动）。

# su mysql
# exec mysqld_safe

# 👉 切换到 mysql 用户身份，然后执行 mysqld_safe 启动 MariaDB：

#     mysqld_safe 是一个更安全的启动方式，会自动重启崩溃的数据库、输出日志等。