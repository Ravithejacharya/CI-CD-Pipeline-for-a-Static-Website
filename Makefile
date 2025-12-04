# Makefile for common development tasks

.PHONY: help install build dev test lint docker-build docker-run clean

help:
	@echo "Available commands:"
	@echo "  make install       - Install dependencies"
	@echo "  make build         - Build production bundle"
	@echo "  make dev           - Run development server"
	@echo "  make test          - Run tests"
	@echo "  make test-watch    - Run tests in watch mode"
	@echo "  make coverage      - Generate coverage report"
	@echo "  make lint          - Run ESLint"
	@echo "  make docker-build  - Build Docker image"
	@echo "  make docker-run    - Run Docker container"
	@echo "  make docker-stop   - Stop Docker container"
	@echo "  make clean         - Clean build artifacts"

install:
	npm install

build:
	npm run build

dev:
	npm run dev

test:
	npm test

test-watch:
	npm run test:watch

coverage:
	npm run test:coverage

lint:
	npm run lint

docker-build:
	npm run docker:build

docker-run:
	npm run docker:run

docker-stop:
	docker stop $$(docker ps -q --filter "ancestor=static-website:latest") || true

clean:
	rm -rf dist/
	rm -rf coverage/
	rm -rf node_modules/
	rm -rf .nyc_output/
