#!/bin/bash
set -e

echo "🚀 Bootstrapping AI RAG Platform..."

# Check prerequisites
echo "Checking prerequisites..."
command -v docker >/dev/null 2>&1 || { echo "Docker is required but not installed. Aborting." >&2; exit 1; }
command -v docker-compose >/dev/null 2>&1 || { echo "Docker Compose is required but not installed. Aborting." >&2; exit 1; }

# Create .env if not exists
if [ ! -f .env ]; then
    echo "Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please update .env with your API keys before proceeding"
fi

# Create data directories
echo "Creating data directories..."
mkdir -p data/raw-documents
mkdir -p data/processed
mkdir -p data/embeddings
mkdir -p data/golden-dataset
mkdir -p data/sample-events

# Pull Docker images
echo "Pulling Docker images (this may take a while)..."
docker-compose pull

# Start infrastructure
echo "Starting infrastructure services..."
docker-compose up -d postgres redis kafka zookeeper

# Wait for services
echo "Waiting for services to be ready..."
sleep 10

# Check Postgres
until docker exec rag-postgres pg_isready -U rag_user; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

# Check Kafka
until docker exec rag-kafka kafka-broker-api-versions --bootstrap-server localhost:9092 > /dev/null 2>&1; do
  echo "Waiting for Kafka..."
  sleep 2
done

# Create Kafka topics
echo "Creating Kafka topics..."
docker exec rag-kafka kafka-topics --create --if-not-exists \
  --bootstrap-server localhost:9092 \
  --topic documents.raw \
  --partitions 3 \
  --replication-factor 1

docker exec rag-kafka kafka-topics --create --if-not-exists \
  --bootstrap-server localhost:9092 \
  --topic embeddings.ready \
  --partitions 3 \
  --replication-factor 1

docker exec rag-kafka kafka-topics --create --if-not-exists \
  --bootstrap-server localhost:9092 \
  --topic events.live \
  --partitions 3 \
  --replication-factor 1

docker exec rag-kafka kafka-topics --create --if-not-exists \
  --bootstrap-server localhost:9092 \
  --topic rag.query.logs \
  --partitions 3 \
  --replication-factor 1

echo "✅ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "1. Update .env with your API keys"
echo "2. Start remaining services: make up"
echo "3. Run services (see docs/runbooks/local-development.md)"
echo ""
echo "Access points:"
echo "  - Grafana: http://localhost:3000 (admin/admin)"
echo "  - Prometheus: http://localhost:9090"
echo "  - Jaeger: http://localhost:16686"
