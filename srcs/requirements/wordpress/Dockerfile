FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    mariadb-client \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-xml \
    php7.4-zip \
    php7.4-mbstring \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 -C /var/www/html && \
    rm latest.tar.gz
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php /var/www/html
COPY tools/setup-wordpress.sh /usr/local/bin/setup-wordpress.sh
RUN chmod +x /usr/local/bin/setup-wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/setup-wordpress.sh"]
