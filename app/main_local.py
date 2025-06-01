from langchain_ollama.llms import OllamaLLM
from langchain.agents import initialize_agent, Tool

# https://haystack.deepset.ai/integrations/duckduckgo-api-websearch
from duckduckgo_api_haystack import DuckduckgoApiWebSearch

search = DuckduckgoApiWebSearch(top_k=10)

llm = OllamaLLM(model="mistral")

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

# Test
query = "What is the capital of the Netherlands?"
response = agent.run(query)
print(f"Query: {query}")
print(f"Response: {response}")

query = "What is the capital of Switzerland?"
response = agent.run(query)
print(f"Query: {query}")
print(f"Response: {response}")


