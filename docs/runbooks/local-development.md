# Local Development Guide

## Prerequisites
- Docker & Docker Compose
- Go 1.21+
- Python 3.11+
- Java 21
- Make

## Quick Start

### 1. Clone and Bootstrap
```bash
git clone <repo-url>
cd ai-rag-kafka-streaming-platform
make bootstrap
```

### 2. Configure Environment
```bash
cp .env.example .env
# Edit .env with your API keys
```

### 3. Start Infrastructure
```bash
make up
```

This starts:
- PostgreSQL (port 5432)
- Kafka (port 9092)
- Redis (port 6379)
- Milvus (port 19530)
- Prometheus (port 9090)
- Grafana (port 3000)
- Jaeger (port 16686)

### 4. Run Services

**Embedding Service:**
```bash
cd services/embedding-python
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8001
```

**RAG API:**
```bash
cd services/rag-api-java
./mvnw spring-boot:run
```

**Ingestion Service:**
```bash
cd services/ingestion-go
go run cmd/api/main.go
```

### 5. Test Query
```bash
curl -X POST http://localhost:8080/api/v1/query \
  -H "Content-Type: application/json" \
  -d '{"question": "What is RAG?"}'
```

## Development Workflow

### Running Tests
```bash
make test
```

### Monitoring
- Grafana: http://localhost:3000 (admin/admin)
- Prometheus: http://localhost:9090
- Jaeger: http://localhost:16686

### Troubleshooting

**Issue: Kafka not starting**
```bash
docker-compose logs kafka
# Check if ZooKeeper is healthy
docker-compose ps
```

**Issue: Vector DB connection failed**
```bash
docker-compose restart postgres
psql -h localhost -U rag_user -d rag_platform
# Check pgvector extension
SELECT * FROM pg_extension WHERE extname = 'vector';
```

## Cleanup
```bash
make down
make clean
```
