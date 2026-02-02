#!/bin/bash
set -e

echo "🧹 Cleaning up AI RAG Platform..."

# Stop all containers
echo "Stopping Docker containers..."
docker-compose down -v

# Clean build artifacts
echo "Cleaning build artifacts..."
rm -rf services/rag-api-java/target/
rm -rf services/ingestion-go/bin/
find services/embedding-python -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find services/embedding-python -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
find services/agent-service -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true

# Clean data directories (optional)
read -p "Delete data directories? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing data directories..."
    rm -rf data/processed/*
    rm -rf data/embeddings/*
    echo "✅ Data directories cleaned"
else
    echo "Skipping data directory cleanup"
fi

echo "✅ Cleanup complete!"
