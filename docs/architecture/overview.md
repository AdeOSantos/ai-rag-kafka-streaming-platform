# Architecture Overview

## System Components

### 1. Ingestion Layer
- **Ingestion Service (Go)**: Handles document upload, parsing, and initial processing
- **Kafka Streaming**: Real-time event distribution across services
- **Schema Registry**: Manages data schemas and evolution

### 2. Embedding & Vector Layer
- **Embedding Service (Python)**: Generates vector embeddings using transformer models
- **Vector Database**: Stores and indexes embeddings (pgvector or Milvus)
- **Batch Processing**: Handles large-scale embedding generation

### 3. RAG Gateway Layer
- **RAG API (Java Spring Boot)**: Main API gateway for copilot queries
- **LLM Orchestration**: Manages calls to OpenAI/Anthropic/Bedrock
- **Context Assembly**: Retrieves and ranks relevant context
- **Response Synthesis**: Generates answers with citations

### 4. Agent Layer
- **Agent Service (Python)**: Tool-using autonomous agents
- **Planning Engine**: Multi-step reasoning and task decomposition
- **Guardrails**: Safety filters and output validation

### 5. Infrastructure Layer
- **Redis Cache**: Query caching and rate limiting
- **Observability Stack**: OpenTelemetry, Prometheus, Grafana, Jaeger
- **Kubernetes**: Container orchestration and scaling

## Data Flow

1. Documents ingested via API → Kafka topic `documents.raw`
2. Embedding service consumes, generates vectors → Vector DB
3. User query → RAG API retrieves top-k vectors
4. Context + Query → LLM → Answer with sources
5. All interactions logged and traced

## Technology Decisions

See [Design Decisions](../design-decisions/) for detailed ADRs.
