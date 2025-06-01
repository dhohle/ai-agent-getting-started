#!/bin/bash
set -e
#
# docker build -t $app_name:latest .

echo "Building Docker image for Ollama..."
docker buildx build --platform linux/amd64,linux/arm64 -t harriedekorte/ollama:latest -f Dockerfile-ollama .


#
app_name=harriedekorte/ai-agent-getting-started
port=8000

echo "Building Docker image..."
# docker build -t $app_name:latest .
docker buildx build --platform linux/amd64,linux/arm64 -t $app_name:latest -f Dockerfile .
# docker buildx build --platform linux/amd64 -t $app_name:latest .

# docker push $app_name:latest
# docker buildx build --platform linux/amd64,linux/arm64 -t $app_name:latest --push .
