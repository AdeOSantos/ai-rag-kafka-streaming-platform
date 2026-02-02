# RAG API Gateway (Java Spring Boot)

Enterprise-grade RAG API built with Java 21 and Spring Boot 3.

## Features
- RESTful API for copilot queries
- Multiple LLM provider support (OpenAI, Anthropic, Bedrock)
- Redis caching layer
- Rate limiting
- Observability (metrics, tracing, logging)
- Guardrails and safety filters

## Tech Stack
- Java 21
- Spring Boot 3.2+
- Spring AI / LangChain4j
- PostgreSQL / Milvus
- Redis
- Micrometer + OpenTelemetry

## API Endpoints

### Query Copilot
```bash
POST /api/v1/query
Content-Type: application/json

{
  "question": "What are the key features of our product?",
  "context_limit": 5,
  "stream": false
}

Response:
{
  "answer": "Based on the documentation...",
  "sources": [
    {"title": "Product Guide", "chunk": "...", "score": 0.89}
  ],
  "latency_ms": 245,
  "tokens_used": 350
}
```

### Streaming Response
```bash
POST /api/v1/query/stream
Content-Type: application/json

{
  "question": "Explain RAG in detail",
  "stream": true
}
```

## Configuration
See `src/main/resources/application.yml`:
```yaml
rag:
  llm:
    provider: openai
    model: gpt-4
  vector:
    type: pgvector
    top-k: 5
  cache:
    enabled: true
    ttl: 3600
```

## Building
```bash
./mvnw clean package
./mvnw spring-boot:run
```

## Testing
```bash
./mvnw test
./mvnw verify  # Integration tests
```
