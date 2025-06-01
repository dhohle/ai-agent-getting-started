#!/bin/bash
echo "Waiting for Ollama to start..."
until curl -s http://ollama:11434 | grep -q '"models"'; do
  sleep 1
done

# Start Gunicorn with Uvicorn workers
exec gunicorn app.main:app -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000 --workers 4
