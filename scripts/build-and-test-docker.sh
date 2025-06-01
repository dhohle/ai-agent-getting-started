#!/bin/bash
set -e

app_name=mytemplate
port=8000

cleanup() {
  echo "Cleaning up..."
  docker stop $app_name-container
  docker rm $app_name-container
}
trap cleanup EXIT

echo "Building Docker image..."
docker build -t $app_name:latest .

echo "Running Docker container..."
docker run -d --name $app_name-container -p $port:$port $app_name:latest

# Wait for the server to start
timeout=30
elapsed=0

until curl -s http://localhost:$port/healthz > /dev/null; do
  if [ $elapsed -ge $timeout ]; then
    echo "Server failed to start after $timeout seconds"
    exit 1
  fi

  echo "Waiting for the server to start..."
  sleep 1
  elapsed=$((elapsed+1))
done

# Validate the server is running
response=$(curl -s http://localhost:$port/api/v1/hello_world)
expected='{"message":"Hello, World!"}'

if [[ "$response" == "$expected" ]]; then
  echo "Test passed! Expected: $expected, got: $response"
else
  echo "Test failed! Expected: $expected, got: $response"
  exit 1
fi

echo "Done!"
