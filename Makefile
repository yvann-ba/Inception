COMPOSE_FILE	= srcs/docker-compose.yml
DOMAIN_NAME		= ybarbot.42.fr
HOST_MARIADB	= /home/ybarbot/data/mariadb
HOST_WORDPRESS	= /home/ybarbot/data/wordpress

all: up
up:
	@mkdir -p $(HOST_MARIADB)
	@mkdir -p $(HOST_WORDPRESS)
	@$(call add_host)
	@echo "===> Starting containers (build + up)..."
	@docker compose -f $(COMPOSE_FILE) up -d --build
	@echo "===> Docker Compose UP complete."
	@echo "Access your site at https://$(DOMAIN_NAME)/ (self-signed cert)"
down:
	@echo "===> Stopping containers..."
	@docker compose -f $(COMPOSE_FILE) down
	@echo "===> Docker Compose DOWN complete."
clean:
	@echo "===> Stopping and removing containers, images, volumes..."
	@docker compose -f $(COMPOSE_FILE) down -v --rmi all
	@echo "===> Removing local data in $(HOST_MARIADB) and $(HOST_WORDPRESS)"
	rm -rf $(HOST_MARIADB)/* 2>/dev/null || true
	rm -rf $(HOST_WORDPRESS)/* 2>/dev/null || true
	@echo "===> Clean complete."
fclean: clean

re: fclean all

ps:
	@docker ps

logs:
	@docker compose -f $(COMPOSE_FILE) logs -f
define add_host
    @if ! grep -q "$(DOMAIN_NAME)" /etc/hosts; then \
        echo "===> Adding '127.0.0.1 $(DOMAIN_NAME)' to /etc/hosts"; \
        echo "127.0.0.1 $(DOMAIN_NAME)" | sudo tee -a /etc/hosts >/dev/null; \
    fi
endef


.PHONY: all up down clean fclean re ps logs
