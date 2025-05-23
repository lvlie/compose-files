#!/bin/bash
# scripts/validate-docker-compose.sh

# Exit immediately if a command exits with a non-zero status.
set -e

COMPOSE_FILE="$1"

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null
then
    echo "docker-compose could not be found, please install it to use this hook."
    exit 1
fi

# Validate the Docker Compose file
# The -q flag suppresses output on success, and errors go to stderr
if docker-compose -f "$COMPOSE_FILE" config -q; then
  # echo "Validation successful for $COMPOSE_FILE" # Optional: for verbose success
  exit 0
else
  echo "Validation failed for $COMPOSE_FILE" >&2
  exit 1
fi
