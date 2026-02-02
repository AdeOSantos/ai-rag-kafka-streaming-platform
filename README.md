# Real-Time AI Copilot Platform (Kafka + RAG + Vector Search + LLM)

## Author

**Adalberto de Oliveira Santos**  
Staff Backend Engineer → AI Platform Engineer  
Building distributed systems at scale

- LinkedIn: https://linkedin.com/in/adalbertosantos
- GitHub: https://github.com/AdeOSantos


Production-grade **AI Engineering** showcasing how modern companies build and deploy **LLM-powered systems** with:

- **Real-time streaming ingestion (Kafka)**
- **Retrieval-Augmented Generation (RAG)**
- **Vector databases (pgvector / Milvus)**
- **LLM orchestration (LangChain / LlamaIndex)**
- **AI evaluation pipelines**
- **Kubernetes + Terraform deployment**
- **Full observability (OpenTelemetry, Grafana, Prometheus)**

This project is designed to demonstrate **AI Platform Engineering** skills.

---

## Project Goal

Build an **Enterprise AI Copilot** that can answer questions over continuously updating company knowledge.

Unlike toy chatbots, this system is:

-  Real-time  
-  Streaming-first  
-  RAG with citations  
-  Production-ready  
-  Cloud-native  
-  Observable + measurable  
-  Built like a real AI platform team would do

---

## What This Platform Does

This AI Copilot can:

- Ingest documents (PDFs, Markdown, Web pages)
- Consume live business events via Kafka
- Generate embeddings and store them in a vector DB
- Answer user questions using RAG + LLM
- Return **answers with sources**
- Continuously update knowledge in real time
- Run evaluation benchmarks automatically
- Deploy on Kubernetes with full monitoring

---


## High-Level Architecture


```mermaid
flowchart TB

%% Client Layer
subgraph CLIENT["Client Layer"]
U1["Web Chat UI"]
U2["REST Client"]
U3["gRPC Client"]
end

%% Edge / API Layer
subgraph EDGE["API Gateway Layer"]
GW["RAG Gateway API"]
AUTH["Auth (JWT / OAuth2)"]
RL["Rate Limiting (Redis)"]
end

U1 --> GW
U2 --> GW
U3 --> GW
GW --> AUTH
GW --> RL

%% AI Orchestration
subgraph AI["AI Orchestration"]
ORCH["LLM Orchestrator"]
AGENTS["Agent Layer (Tool Calling)"]
GUARD["Guardrails (Prompt Safety)"]
end

GW --> ORCH
ORCH --> AGENTS
ORCH --> GUARD

%% LLM Providers
subgraph MODELS["LLM Providers"]
OPENAI["OpenAI"]
BEDROCK["AWS Bedrock"]
LOCAL["Self-hosted LLM"]
end

ORCH --> OPENAI
ORCH --> BEDROCK
ORCH --> LOCAL

%% Retrieval Layer
subgraph RETRIEVAL["Retrieval + Vector Search"]
RETR["Retriever (Top-K Search)"]
VDB["Vector DB (pgvector / Milvus)"]
CACHE["Redis Cache (Context Cache)"]
end

ORCH --> RETR
RETR --> VDB
ORCH --> CACHE

%% Embeddings Pipeline
subgraph EMBEDDINGS["Embedding + Indexing"]
INDEX["Index Builder (Chunking)"]
EMB["Embedding Service (FastAPI)"]
end

INDEX --> EMB
EMB --> VDB

%% Kafka Backbone (GitHub-safe nodes)
subgraph STREAM["Kafka Streaming"]
K1["Topic: documents.raw"]
K2["Topic: embeddings.ready"]
K3["Topic: events.live"]
K4["Topic: rag.query.logs"]
end

%% Ingestion Services
subgraph INGEST["Ingestion Services"]
DOCS["Document Ingestor"]
EVENTS["Event Ingestor"]
ETL["Stream Processor (Optional)"]
end

DOCS --> K1
EVENTS --> K3
K1 --> ETL
ETL --> INDEX
INDEX --> K2

%% Data Layer
subgraph DATA["Enterprise Data Layer"]
PG["PostgreSQL + Metadata Store"]
OBJ["Object Storage (S3)"]
ANALYTICS["Analytics Store"]
end

VDB --> PG
DOCS --> OBJ
K4 --> ANALYTICS

%% Evaluation Layer
subgraph EVAL["Evaluation + AI Quality"]
RAGAS["RAG Evaluation Suite"]
GOLD["Golden Dataset Tests"]
HALL["Hallucination Metrics"]
end

ORCH --> RAGAS
RAGAS --> GOLD
RAGAS --> HALL

%% Observability
subgraph OBS["Observability"]
OTEL["OpenTelemetry"]
PROM["Prometheus"]
GRAF["Grafana"]
TRACE["Tracing (Jaeger)"]
ALERTS["Alerts + SLOs"]
end

GW --> OTEL
EMB --> OTEL
ETL --> OTEL

OTEL --> PROM
OTEL --> TRACE
PROM --> GRAF
GRAF --> ALERTS

%% Deployment
subgraph DEPLOY["Cloud Deployment"]
K8S["Kubernetes"]
HELM["Helm"]
TF["Terraform"]
ARGO["ArgoCD"]
end

TF --> K8S
HELM --> K8S
ARGO --> K8S

%% Security
subgraph SEC["Security + Compliance"]
VAULT["Secrets Management"]
POLICY["Policy Enforcement"]
AUDIT["Audit Logging"]
end

AUTH --> VAULT
GUARD --> POLICY
GW --> AUDIT
```


---

## Key Features

### Retrieval-Augmented Generation (RAG)
- Semantic retrieval over enterprise knowledge
- Top-k context injection into LLM prompt
- Answers always include citations

### Real-Time Knowledge Updates
- Kafka streams continuously update embeddings
- No manual re-indexing

### AI Evaluation Harness
- Automated RAG scoring (RAGAS)
- Golden dataset regression tests
- Hallucination + faithfulness metrics

### Production-Grade Engineering
- Rate limiting + caching
- Observability + tracing
- Multi-tenant design ready
- Token cost controls

### Cloud-Native Deployment
- Docker Compose for local dev
- Kubernetes + Helm for production
- Terraform infrastructure templates

---

## Tech Stack

### AI / GenAI Layer
- LangChain / LlamaIndex
- OpenAI API / Anthropic / AWS Bedrock
- Prompt Guardrails + Tool Calling Agents

### Embeddings + Vector Search
- SentenceTransformers
- pgvector (PostgreSQL)
- Milvus (optional)

### Streaming + Data Platform
- Apache Kafka
- Schema Registry + Avro
- Spark/Flink extensions (optional)

### Backend + APIs
- Go (Fiber / Gin)
- Java 21 + Spring Boot 3
- gRPC + REST

### Infra & Platform
- Kubernetes (EKS-ready)
- Terraform + Helm + ArgoCD
- GitHub Actions CI/CD

### Observability
- OpenTelemetry
- Prometheus + Grafana
- Jaeger + Datadog-ready

---

## Repository Structure

ai-rag-streaming-platform/
│
├── services/
│   ├── ingestion-go/          # Document + event ingestion
│   ├── embedding-python/      # Embedding + vector indexing
│   ├── rag-api-java/          # Main AI Copilot API gateway
│   ├── agent-service/         # Tool-using AI agent layer
│
├── infra/
│   ├── docker-compose/        # Local environment
│   ├── terraform/             # Cloud infrastructure
│   ├── helm/                  # Kubernetes deployment charts
│
├── eval/
│   ├── golden-dataset/        # Benchmark QA pairs
│   ├── ragas-benchmarks/      # Evaluation scripts
│
├── docs/
│   ├── architecture.md
│   ├── latency-results.md
│   ├── roadmap.md
│
└── README.md


---

## Quickstart (Local)

### 1. Clone Repository
```bash
git clone https://github.com/ADeOSantos/ai-rag-kafka-streaming-platform.git
cd ai-rag-kafka-streaming-platform
```

### 2. Start Infrastructure

Run Kafka + Postgres + Vector DB + Redis:

```bash
docker-compose up -d
```

### 3. Run Embedding Service

```bash
cd services/embedding-python
pip install -r requirements.txt
uvicorn main:app --reload
```

### 4. Run RAG Gateway API

```bash
cd services/rag-api-java
./mvnw spring-boot:run
```

### 5. Ask Questions

Example query:

```bash
curl -X POST http://localhost:8080/query \
  -d '{"question":"What systems process 10M events/day?"}'
```

```json
{
  "answer": "The global IoT platform processes over 10M events/day...",
  "sources": [
    "buckman_architecture.pdf",
    "event_pipeline.md"
  ]
}
```

---

## Kafka Topics

| Topic Name | Purpose |
|-----------|---------|
| documents.raw | Raw docs ingestion |
| embeddings.ready | Embedding pipeline output |
| events.live | Real-time enterprise events |
| rag.query.logs | Copilot usage analytics |

---

## Evaluation & Benchmarking

Run RAG evaluation suite:

```bash
cd eval/ragas-benchmarks
python run_eval.py
```

Metrics tracked:
- Faithfulness
- Context precision
- Answer relevance
- Hallucination rate

Example output:

```
RAG Score: 0.87
Hallucination Rate: 2.1%
p95 Latency: 220ms
```

---

## Performance Targets

| Metric | Goal |
|--------|------|
| p95 latency | < 300ms |
| p99 latency | < 500ms |
| Kafka throughput | 50k+ msg/sec |
| Hallucination rate | < 3% |

---

## Safety & Guardrails

Implemented protections against:
- Prompt injection
- Data leakage
- Unsafe completions
- Over-budget token usage

Includes:
- Input sanitization
- Output validation
- Policy filters

---

## Deployment (Kubernetes)

### Deploy with Helm

```bash
helm upgrade --install ai-copilot infra/helm
```

### Deploy with Terraform

```bash
cd infra/terraform
terraform init
terraform apply
```

Supports:
- AWS EKS + Bedrock
- GCP Vertex AI
- Azure AI Studio

---

## Roadmap

Planned upgrades:
- Multi-modal RAG (images + docs)
- LoRA fine-tuning pipeline
- Triton inference serving
- Online feedback learning loop
- Full AI observability dashboards

---













