NAME = .inception
DOMAIN_NAME = ebang.42.fr

all : $(NAME)

$(NAME): 
	@touch $(NAME)
	if ! grep -e '^127.0.0.1\s\+$(DOMAIN_NAME)' /etc/hosts; then \
		echo "--- Add domain name i hosts"; \
		sudo sh -c 'echo "127.0.0.1    $(DOMAIN_NAME)" >>  /etc/hosts'; \
	fi
	mkdir -p /home/ebang/data/wordpress;
	mkdir -p /home/ebang/data/mariadb;
	cd ./srcs && docker-compose up --build

down	: 
	cd ./srcs && docker-compose down
	@rm -rf $(NAME)

clean	:
	make down
	docker system prune -a

fclean	:
	make clean
	docker volume rm -f srcs_db srcs_wp
	cd /home/ebang/data && sudo rm -rf *
	sudo rm -rf /home/ebang/data/wordpress
	sudo rm -rf /home/ebang/data/mariadb

re		:
	make fclean
	make all

em	:
	docker exec -it mariadb bash

en	:
	docker exec -it nginx bash

ew	:
	docker exec -it wordpress bash

.PHONY	: up down rmi clean fclean re em en ew