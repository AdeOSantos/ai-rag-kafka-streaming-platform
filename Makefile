.PHONY: help build test clean deploy

help:
	@echo "AI RAG Streaming Platform - Available Commands:"
	@echo "  make bootstrap     - Initialize local development environment"
	@echo "  make up            - Start all services with docker-compose"
	@echo "  make down          - Stop all services"
	@echo "  make build         - Build all services"
	@echo "  make test          - Run all tests"
	@echo "  make eval          - Run RAG evaluation benchmarks"
	@echo "  make deploy-k8s    - Deploy to Kubernetes"
	@echo "  make clean         - Clean up build artifacts"

bootstrap:
	@echo "Bootstrapping local environment..."
	./scripts/bootstrap.sh

up:
	docker-compose up -d
	@echo "Services starting... Use 'docker-compose logs -f' to follow logs"

down:
	docker-compose down

build:
	@echo "Building services..."
	cd services/ingestion-go && go build -o bin/ingestion ./cmd/api
	cd services/embedding-python && pip install -r requirements.txt
	cd services/rag-api-java && ./mvnw clean package -DskipTests

test:
	@echo "Running tests..."
	cd services/ingestion-go && go test ./...
	cd services/embedding-python && pytest
	cd services/rag-api-java && ./mvnw test

eval:
	@echo "Running RAG evaluation..."
	cd eval/ragas && python run_eval.py

deploy-k8s:
	@echo "Deploying to Kubernetes..."
	./scripts/deploy_eks.sh

clean:
	@echo "Cleaning up..."
	./scripts/cleanup.sh
	cd services/rag-api-java && ./mvnw clean
	cd services/ingestion-go && rm -rf bin/
