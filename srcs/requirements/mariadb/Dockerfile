FROM debian:bookworm

# 1) Update + install MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# 2) Copy our custom config to override defaults
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# 3) Copy the startup script
COPY tools/setup-mariadb.sh /usr/local/bin/setup-mariadb.sh
RUN chmod +x /usr/local/bin/setup-mariadb.sh

# 4) Expose port 3306 (internally accessible)
EXPOSE 3306

# 5) Default command: run our setup script, which starts MariaDB in foreground
ENTRYPOINT [ "setup-mariadb.sh" ]
