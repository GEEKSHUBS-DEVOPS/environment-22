start:
	docker compose -f deploys/develop/docker-compose.yaml up -d 
	docker compose -f deploys/develop/docker-compose.yaml logs -f

stop:
	docker compose -f deploys/develop/docker-compose.yaml down --remove-orphans

cleanup:
	docker rm -f $$(docker ps -qa)

build:
	docker compose -f deploys/develop/docker-compose.yaml build

ng:
	docker compose -f deploys/develop/docker-compose.tools.yaml run --user 1000 --rm angular-cli

install:
	docker compose -f deploys/develop/docker-compose.yaml run --user 1000 --rm frontend bash -c "npm i"

resolve:
	@read -p "Enter service name: " SERVICE; \
	COMPOSE_IGNORE_ORPHANS=true	docker compose -f deploys/develop/docker-compose.tools.yaml run --rm busybox ping -4 -c1 -q $$SERVICE | head -1 | grep -Eo '[0-9.]{4,}'