FROM debian:buster

# 1) Update and install packages
RUN apt-get update && apt-get install -y \
    wget curl mariadb-client \
    php7.3 php7.3-fpm php7.3-mysql \ 
    # You can add php7.3-xml, php7.3-zip, etc. if WP plugins need them
    && rm -rf /var/lib/apt/lists/*

# 2) Copy our php-fpm pool config
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# 3) Create /run/php (pid/sock) and /var/www/html
RUN mkdir -p /run/php /var/www/html

# 4) Copy the startup script
COPY tools/setup-wordpress.sh /usr/local/bin/setup-wordpress.sh
RUN chmod +x /usr/local/bin/setup-wordpress.sh

WORKDIR /var/www/html

# 5) Expose port 9000
EXPOSE 9000

# 6) By default, run the setup script
ENTRYPOINT [ "setup-wordpress.sh" ]
