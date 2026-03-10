.PHONY: build up down terminal logs format lint lock clean help

## Build the image (only needed when dependencies change)
build:
	@echo "Building image..."
	docker compose build app

# ── app container targets ─────────────────────────────────────
## Start the app container
up:
	docker compose up -d app

## Stop the app container
down:
	docker compose stop app

## Enter the app container terminal
terminal:
	docker compose exec -it app /bin/bash

## View the app container logs
logs:
	docker compose logs -f app

## Format code inside the app container
format:
	docker compose exec -it app ruff format .

## Lint code inside the app container
lint:
	docker compose exec -it app ruff check . --fix

# ── shared utilities ──────────────────────────────────────────
## Generate / update uv.lock (run once after first build, then rebuild for reproducible builds)
lock:
	@echo "Updating uv.lock..."
	docker compose run --rm app uv lock

## Clean up all Docker resources
clean:
	@echo "Cleaning up..."
	docker compose down -v --remove-orphans

## Display this help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
