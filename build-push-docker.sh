#!/bin/bash

# Script to build and push the SwarmUI Docker image to Docker Hub
# Usage: ./build-push-docker.sh [username]

# Default to environment variable if set, otherwise use argument
DOCKER_USERNAME=${DOCKERHUB_USERNAME:-$1}

# Check if username is provided
if [ -z "$DOCKER_USERNAME" ]; then
    echo "Error: Docker Hub username not provided"
    echo "Usage: ./build-push-docker.sh [username]"
    echo "   or set DOCKERHUB_USERNAME environment variable"
    exit 1
fi

echo "Building Docker image for $DOCKER_USERNAME/swarmui:latest"

# Build the Docker image
docker build -t $DOCKER_USERNAME/swarmui:latest -f launchtools/StandardDockerfile.docker .

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "Error: Docker build failed"
    exit 1
fi

echo "Docker image built successfully"

# Ask for confirmation before pushing
read -p "Do you want to push the image to Docker Hub? (y/n): " PUSH_CONFIRM

if [ "$PUSH_CONFIRM" = "y" ] || [ "$PUSH_CONFIRM" = "Y" ]; then
    echo "Pushing image to Docker Hub..."
    
    # Check if user is logged in to Docker Hub
    docker info | grep "Username" > /dev/null
    if [ $? -ne 0 ]; then
        echo "You are not logged in to Docker Hub"
        echo "Please run 'docker login' first"
        exit 1
    fi
    
    # Push the image
    docker push $DOCKER_USERNAME/swarmui:latest
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to push image to Docker Hub"
        exit 1
    fi
    
    echo "Image pushed successfully to $DOCKER_USERNAME/swarmui:latest"
else
    echo "Push cancelled"
fi

echo "Done" 