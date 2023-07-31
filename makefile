VERSION := $(shell git log --pretty=format:'' | wc -l)

build:
	docker build -t web-tools:$(VERSION) . -f ./web/Dockerfile

run:
	docker-compose up --build

stop:
	docker compose --file 'docker-compose.yml' --project-name 'utils-web-tools' stop

clean: stop
	docker compose --file 'docker-compose.yml' --project-name 'utils-web-tools' down

status:
	@if docker images | grep -q web-tools; then \
        echo "Web-tools Builded"; \
	else \
		echo "No Image Builded"; \
    fi