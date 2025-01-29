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

# Create /var/www/html and download WordPress
RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 -C /var/www/html && \
    rm latest.tar.gz

# Copy PHP-FPM pool config
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# The directory /run/php is used by php-fpm for its socket/PID
RUN mkdir -p /run/php /var/www/html

# Copy your custom setup script into /usr/local/bin
COPY tools/setup-wordpress.sh /usr/local/bin/setup-wordpress.sh
RUN chmod +x /usr/local/bin/setup-wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000

# ***IMPORTANT*** Use the absolute path in ENTRYPOINT:
ENTRYPOINT ["/usr/local/bin/setup-wordpress.sh"]
