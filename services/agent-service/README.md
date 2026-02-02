# Agent Service

Autonomous AI agent with tool-calling capabilities, planning, and memory.

## Features
- Multi-step reasoning and planning
- Tool integration (web search, calculator, DB queries)
- Conversational memory
- ReAct-style agent loop
- Guardrails for safety

## Tech Stack
- Python 3.11+
- LangChain / LlamaIndex
- OpenAI Functions / Anthropic Tool Use
- Redis for memory

## Agent Capabilities

### Available Tools
- `search_knowledge_base` - RAG search over documents
- `web_search` - Internet search via API
- `calculator` - Mathematical operations
- `sql_query` - Execute safe SQL queries
- `send_email` - Notification tool

### Example Interaction
```python
agent.run("Find the latest sales numbers and send me a summary")

# Agent Plan:
# 1. search_knowledge_base("Q4 sales report")
# 2. Extract numbers from results
# 3. send_email(summary=...)
```

## API
```bash
POST /api/v1/agent/run
{
  "task": "Research competitors and summarize",
  "max_iterations": 10
}
```

## Configuration
- `AGENT_MODEL` - LLM for agent
- `MAX_ITERATIONS` - Max reasoning steps
- `TOOLS_ENABLED` - Comma-separated tool list

## Development
```bash
pip install -r requirements.txt
python app/agent.py
```
