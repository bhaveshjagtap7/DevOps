# Dockerizing a Python App - Practical Assignment

## Overview
This repository contains a containerized Python Flask web application built as part of the Docker Practical Assignment.

## Project Structure
```
python-docker-exercise/
├── app.py
├── requirements.txt
├── Dockerfile
├── .dockerignore
└── README.md
```

## Prerequisites
- Docker Engine / Docker Desktop (Version 20+ or newer)
- Python 3.9+ (for local development/testing)
- Web Browser or curl/Invoke-RestMethod

## Step-by-Step Instructions

### 1. Build the Docker Image
To build the Docker image with tag `my-python-app`:
```bash
docker build -t my-python-app .
```

Verify that the image is created:
```bash
docker image ls my-python-app
```

### 2. Run the Docker Container
Run the container in detached mode mapping host port `5050` to container port `5000`:
```bash
docker run -d -p 5050:5000 --name my-running-app my-python-app
```

Verify that the container is running:
```bash
docker ps
```

Check the container logs:
```bash
docker logs my-running-app
```

### 3. Verify Application in Browser
Open your browser and navigate to:
```
http://localhost:5050
```
Expected output:
```
Hello from Dockerized Python! The app is running successfully.
```

Or via terminal:
```bash
curl http://localhost:5050
# Or PowerShell:
(Invoke-WebRequest -Uri http://localhost:5050).Content
```

### 4. Stop and Remove the Container
Stop the running container:
```bash
docker stop my-running-app
```

Remove the stopped container:
```bash
docker rm my-running-app
```

Verify the image remains available:
```bash
docker image ls my-python-app
```
