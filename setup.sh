#!/bin/bash

echo "Setting up DokuWiki server..."

# Ensure docker-compose command exists
if ! command -v docker-compose &> /dev/null
then
    echo "docker-compose could not be found"
    exit 1
fi

# Pull the latest Docker image
docker-compose pull

# Start the DokuWiki container
docker-compose up -d

echo "DokuWiki is up and running on http://localhost:8081"

