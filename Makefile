up		: 
	cd ./srcs && docker-compose up

down	: 
	cd ./srcs && docker-compose down

rmi		:
	docker image prune -a

clean	:
	make down
	docker system prune -a

fclean	:
	make clean
	cd /home/ebang/data && sudo rm -rf *

re		:
	make fclean
	make up

em	:
	docker exec -it mariadb bash

en	:
	docker exec -it nginx bash

ew	:
	docker exec -it wordpress bash

.PHONY	: up down rmi clean fclean re em en ew