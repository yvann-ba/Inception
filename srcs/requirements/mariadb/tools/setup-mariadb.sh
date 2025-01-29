#!/bin/bash

# 1) Start MariaDB service (temporary background daemon)
service mysql start

# 2) Secure the installation (optional, but typical)
#    e.g. remove anonymous users, disallow root remote login, etc.
#    Here we’ll do a simple approach by setting root password & removing test db.
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

# 3) Create a new DB + user if not already existing
mysql -u root -p"${SQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
    FLUSH PRIVILEGES;
EOSQL

# 4) Shut down the temporary daemon
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# 5) Finally, run MariaDB in foreground so container stays up
exec mysqld
