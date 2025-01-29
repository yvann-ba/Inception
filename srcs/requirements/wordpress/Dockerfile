FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    mariadb-client \
    php7.3 \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-xml \
    php7.3-zip \
    && rm -rf /var/lib/apt/lists/*

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN mkdir -p /run/php /var/www/html

COPY tools/setup-wordpress.sh /usr/local/bin/setup-wordpress.sh
RUN chmod +x /usr/local/bin/setup-wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000
ENTRYPOINT [ "setup-wordpress.sh" ]
