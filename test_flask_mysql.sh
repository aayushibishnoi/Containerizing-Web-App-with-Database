#!/bin/bash

# Test script for Containerized Flask + MySQL App

# Check if Docker is installed
echo "Checking for Docker..."
if ! command -v docker >/dev/null 2>&1; then
    echo "FAIL: Docker not found. Install it with 'sudo apt install docker.io'."
    exit 1
fi
echo "PASS: Docker found"

# Check if Docker Compose is installed
echo "Checking for Docker Compose..."
if ! command -v docker-compose >/dev/null 2>&1; then
    echo "FAIL: Docker Compose not found. Install it with 'sudo apt install docker-compose'."
    exit 1
fi
echo "PASS: Docker Compose found"

# Start containers
echo "Starting containers..."
docker-compose up -d

# Wait for Flask app to be ready
echo "Waiting for Flask app..."
sleep 10

# Test 1: Add a user
echo "Testing add user endpoint..."
curl -s -X POST -H "Content-Type: application/json" \
    -d '{"name":"Alice","email":"alice@example.com"}' \
    http://localhost:5000/add_user > add_user_response.txt
if grep -q "User added successfully" add_user_response.txt; then
    echo "PASS: User added successfully"
else
    echo "FAIL: Failed to add user"
fi

# Test 2: Get users
echo "Testing get users endpoint..."
curl -s http://localhost:5000/users > get_users_response.txt
if grep -q "Alice" get_users_response.txt; then
    echo "PASS: Retrieved users successfully"
else
    echo "FAIL: Failed to retrieve users"
fi

# Clean up
echo "Cleaning up..."
docker-compose down
rm -f add_user_response.txt get_users_response.txt

echo "All tests completed!"
