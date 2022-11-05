start:
	docker compose -f deploys/develop/docker-compose.yaml up -d ; \
	docker compose -f deploys/develop/docker-compose.yaml logs -f

stop:
	docker compose -f deploys/develop/docker-compose.yaml down --remove-orphans

cleanup:
	docker rm -f $$(docker ps -qa)

build:
	docker compose -f deploys/develop/docker-compose.yaml up -d --build

ng:
	docker compose -f deploys/develop/docker-compose.tools.yaml run --user 1000 --rm angular-cli

install:
	docker compose -f deploys/develop/docker-compose.yaml run --user 1000 --rm frontend bash -c "npm i"
