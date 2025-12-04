FROM debian:bullseye

# 安装必要软件
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y vim mariadb-server && \
    apt clean && rm -rf /var/lib/apt/lists/*

# 创建并设置 MariaDB 运行目录权限 运行目录重启就没有了 和存储数据的目录不是一个ie var/lib/mysql是真正存储数据的
RUN mkdir -p /run/mysqld && \    
    chmod 755 /run/mysqld && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

# 拷贝配置文件并设置权限 644 owner can rw others only r 
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf  

# 拷贝 MariaDB 启动脚本并设置权限
COPY tools/mariadb-setup.sh /var/mariadb_setup/mariadb-setup.sh
RUN chmod 755 /var/mariadb_setup/mariadb-setup.sh && \
    chown -R mysql:mysql /var/mariadb_setup/mariadb-setup.sh

EXPOSE 3306

CMD ["bash", "/var/mariadb_setup/mariadb-setup.sh"]


#socket就是让maridab和wordpress或者mysql命令行直接本地通信 比如用mysql -u root -p就可链接到数据库的.sock文件 而不是通过网络（端口或ip）通信