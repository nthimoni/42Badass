#!/bin/bash

# Set names for images and containers
ROUTER_IMAGE="router_image"
HOST_IMAGE="host_image"
ROUTER_CONTAINER="router_container"
HOST_CONTAINER="host_container"

# Stop and remove any existing containers
docker rm -f $ROUTER_CONTAINER $HOST_CONTAINER 2>/dev/null

echo "Building router image..."
docker build -t $ROUTER_IMAGE ./router || { echo "Router build failed"; exit 1; }

echo "Building host image..."
docker build -t $HOST_IMAGE ./host || { echo "Host build failed"; exit 1; }

echo "Running router container..."
docker run --privileged -d --name $ROUTER_CONTAINER $ROUTER_IMAGE || { echo "Failed to start router container"; exit 1; }

echo "Running host container..."
docker run --privileged -d --name $HOST_CONTAINER $HOST_IMAGE || { echo "Failed to start host container"; exit 1; }

echo "Both containers are up and running."
