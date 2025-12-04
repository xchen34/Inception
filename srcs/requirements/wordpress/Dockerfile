FROM debian:bullseye

# 安装 PHP 和相关依赖 
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y wget \
        php7.4 php7.4-fpm php7.4-mysql php7.4-cli &&\
    apt clean && rm -rf /var/lib/apt/lists/*

# 安装 WP-CLI 通过命令行管理 WordPress（例如安装插件、更新核心等
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

# 创建网站根目录并设置权限
RUN mkdir -p /var/www/html && \
    chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

# 拷贝 PHP 配置文件
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN chmod 755 /etc/php/7.4/fpm/pool.d && \
    chown -R www-data:www-data /etc/php/7.4/fpm/pool.d/www.conf

# 拷贝并设置自动配置脚本
RUN mkdir -p /var/wd-auto-config/
COPY /tools/auto-config.sh /var/wd-auto-config/
RUN chmod 755 /var/wd-auto-config/auto-config.sh && \
    chown -R root:root /var/wd-auto-config/auto-config.sh

# 设置工作目录
WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["bash", "/var/wd-auto-config/auto-config.sh"]

#这个 Dockerfile 本身并没有直接安装 WordPress，它只是准备了运行 WordPress 所需的环境（PHP、WP-CLI 等）。WordPress 的安装通常是在容器启动后通过 entrypoint 脚本（
