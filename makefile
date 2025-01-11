start:  ## arranca el proyecto
	docker compose -f deploys/develop/docker-compose.yaml up -d 
	docker compose -f deploys/develop/docker-compose.yaml logs -f

stop:   ## para todos los servicios
	docker compose -f deploys/develop/docker-compose.yaml down --remove-orphans

cleanup:  ## limpia el contexto
	docker rm -f $$(docker ps -qa)

build:  ## construye las compilaciones
	docker compose -f deploys/develop/docker-compose.yaml build

ng:   ## ejecuta el cliente de angular
	docker compose -f deploys/develop/docker-compose.tools.yaml run --user 1000 --rm angular-cli

install: ## instala dependencias
	docker compose -f deploys/develop/docker-compose.yaml run --user 1000 --rm frontend bash -c "npm i"

resolve: ## valida el servicio
	@read -p "Enter service name: " SERVICE; \
	COMPOSE_IGNORE_ORPHANS=true	docker compose -f deploys/develop/docker-compose.tools.yaml run --rm busybox ping -4 -c1 -q $$SERVICE | head -1 | grep -Eo '[0-9.]{4,}'


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
