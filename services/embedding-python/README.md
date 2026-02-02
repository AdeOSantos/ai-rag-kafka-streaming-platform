# Embedding Service (Python)

FastAPI-based service for generating vector embeddings and managing vector database operations.

## Features
- Sentence transformer embeddings
- Batch processing support
- Kafka consumer for real-time processing
- Vector database integration (pgvector/Milvus)
- OpenTelemetry instrumentation

## Tech Stack
- Python 3.11+
- FastAPI
- Sentence Transformers
- PostgreSQL with pgvector
- Kafka Python client

## API Endpoints

### Generate Embeddings
```bash
POST /api/v1/embed
Content-Type: application/json

{
  "texts": ["Sample text to embed", "Another text"],
  "model": "all-MiniLM-L6-v2"
}
```

### Search Similar
```bash
POST /api/v1/search
Content-Type: application/json

{
  "query": "What is machine learning?",
  "top_k": 5,
  "threshold": 0.7
}
```

## Supported Models
- `sentence-transformers/all-MiniLM-L6-v2` (default)
- `sentence-transformers/all-mpnet-base-v2`
- OpenAI `text-embedding-ada-002`

## Configuration
See `.env` file:
- `EMBEDDING_MODEL` - Model name
- `BATCH_SIZE` - Processing batch size
- `VECTOR_DB_TYPE` - pgvector or milvus

## Development
```bash
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8001
```

## Testing
```bash
pytest tests/
```
