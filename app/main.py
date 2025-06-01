# https://ollama.com/library
from langchain_ollama.llms import OllamaLLM
from langchain.agents import initialize_agent, Tool
# from langgraph.prebuilt import create_react_agent

import uvicorn
from fastapi import FastAPI

# https://haystack.deepset.ai/integrations/duckduckgo-api-websearch
from duckduckgo_api_haystack import DuckduckgoApiWebSearch

search = DuckduckgoApiWebSearch(top_k=1)

# llm = OllamaLLM(model="mistral")
def get_ollama_client():
    import os
    ollama_host = os.environ.get("OLLAMA_HOST", "http://localhost:11434")
    return OllamaLLM(base_url=ollama_host, model="mistral")

llm = get_ollama_client()

tools = [
    Tool(
        name="Search",
        func=search.run,
        description="Useful for when you need to answer questions about current events or general knowledge.",
    )
]
agent = initialize_agent(
    tools=tools,
    llm=llm,
    agent="zero-shot-react-description",
    verbose=True,
)

app = FastAPI()
@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/search")
def search_endpoint(query: str):
    response = agent.run(query)
    return {"query": query, "response": response}

@app.get("/health")
def health_check():
    return {"status": "ok"}

if __name__ == "__main__":
    uvicorn.run("main:app", port=8000, log_level="info")
    