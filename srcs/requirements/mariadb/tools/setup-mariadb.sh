#!/bin/bash
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
echo "[i] Starting temporary MariaDB..."
mysqld_safe --skip-networking &
until mysqladmin ping --silent; do
    echo "[i] Waiting for mysqld to be up..."
    sleep 1
done
echo "[i] MariaDB is up!"
mysql -u root <<-EOSQL
    UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'root';
    DELETE FROM mysql.user WHERE User='';
    DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
    FLUSH PRIVILEGES;
EOSQL

mysql -u root <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

mysql -u root -p"${SQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
    FLUSH PRIVILEGES;
EOSQL
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
exec mysqld
