# Use the official Python image for ARM architecture
FROM python:3.13-slim

# Install Poetry and system deps
RUN apt-get update && apt-get install -y curl git build-essential && apt-get clean
RUN pip install poetry gunicorn

# Copy and install dependencies
WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN poetry config virtualenvs.create false && poetry install --no-root
COPY app /app/app
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
