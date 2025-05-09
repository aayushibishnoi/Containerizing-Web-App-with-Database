# Containerizing-Web-App-with-Database : 
A project to deploy a Flask web app with a MySQL database using Docker containers.

# Project Structure :

    flask-mysql-docker/
    ├── app/
    │   ├── app.py
    │   ├── requirements.txt
    │   └── Dockerfile
    ├── db/
    │   ├── init.sql
    │   └── Dockerfile
    ├── docker-compose.yml
    └── test_flask_mysql.sh

## Features
- Containerizes a Flask app and MySQL database.
- Uses Docker Compose for container communication.
- Implements secure MySQL settings and API endpoints.
- Tests app-database connectivity.

## Directory Structure
- `app/`: Flask app code and Dockerfile.
- `db/`: MySQL initialization script and Dockerfile.
- `docker-compose.yml`: Orchestrates containers.
- `test_flask_mysql.sh`: Tests the application.

## Setup
1. Install Docker and Docker Compose: `sudo apt install docker.io docker-compose`.
2. Navigate to the project directory.
3. Run: `docker-compose up -d`.
4. Access the app at `http://localhost:5000`.
5. Run tests: `bash test_flask_mysql.sh`.
