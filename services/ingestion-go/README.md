# Ingestion Service (Go)

High-performance document ingestion and processing service built with Go.

## Features
- REST API for document upload
- PDF, Markdown, and HTML parsing
- Kafka event publishing
- Chunking strategies
- Metadata extraction
- Rate limiting

## Tech Stack
- Go 1.21+
- Fiber web framework
- Kafka Go client (Sarama)
- Tika for document parsing

## API Endpoints

### Upload Document
```bash
POST /api/v1/ingest/document
Content-Type: multipart/form-data

curl -X POST http://localhost:8000/api/v1/ingest/document \
  -F "file=@document.pdf" \
  -F "source=user_upload" \
  -F "metadata={\"category\":\"technical\"}"
```

### Batch Upload
```bash
POST /api/v1/ingest/batch
Content-Type: application/json

{
  "urls": ["https://example.com/doc1.pdf", "https://example.com/doc2.md"],
  "source": "web_scrape"
}
```

## Configuration
Environment variables:
- `KAFKA_BROKERS` - Kafka bootstrap servers
- `API_PORT` - Service port (default: 8000)
- `MAX_FILE_SIZE` - Max upload size in MB
- `CHUNK_SIZE` - Text chunk size for embeddings

## Development
```bash
go mod download
go run cmd/api/main.go
```

## Testing
```bash
go test ./...
```
