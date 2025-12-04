NAME = inception

all:
	docker compose -f srcs/docker-compose.yml up -d --build

$(NAME): all


#if no modif in dockerfiles no need to rebuild image. like after make stop
start:
	docker compose -f srcs/docker-compose.yml up -d

stop:
	docker compose -f srcs/docker-compose.yml down -v

clean:
	make stop
	docker system prune -af

fclean: clean
	docker system prune -af --volumes

re: clean all

.PHONY: all start stop clean re