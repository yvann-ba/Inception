FROM debian:bullseye

# 1) Update & Install NGINX + OpenSSL
RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# 2) Create a directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# 3) Generate a self-signed SSL certificate
#    We'll use environment variables from .env if you want the CN to be $DOMAIN_NAME,
#    but generally you can hardcode or pass it in. For demonstration, we'll just do:
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=City/L=Angouleme/O=42/OU=42/CN=ybarbot.42.fr"

# 4) Copy your custom nginx.conf
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# 5) Expose port 443
EXPOSE 443

# 6) Launch NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
