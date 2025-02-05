# Project Title

## Overview

This project is a web application built using Django for the backend, Angular for the frontend, and Nginx as the web server. It is containerized using Docker, allowing for easy deployment and management of services.

## Project Structure

```text
project-root
├── docker
│   ├── nginx
│   │   └── nginx.conf
│   ├── python
│   │   ├── Dockerfile
│   │   └── requirements.txt
│   └── angular
│       └── Dockerfile
├── backend
│   ├── manage.py
│   ├── requirements.txt
│   └── api
│       ├── __init__.py
│       ├── urls.py
│       ├── views.py
│       └── models.py
├── frontend
│   ├── src
│   │   ├── app
│   │   │   ├── app.component.ts
│   │   │   └── app.module.ts
│   │   └── main.ts
│   ├── package.json
│   └── angular.json
├── docker-compose.yml
└── README.md
```

## Setup Instructions

### Prerequisites

- Docker
- Docker Compose

### Running the Application

1. Clone the repository:

   ```sh
   git clone <repository-url>
   cd project-root
   ```

2. Build and run the containers:

   ```sh
   docker compose up --build
   ```

3. Access the application:
   - Frontend: `http://localhost:4200`
   - Backend: `http://localhost:8000`

## Usage

- Use `manage.py` for Django management commands.
- Angular application can be modified in the `frontend/src` directory.

## Contributing

Feel free to submit issues or pull requests for improvements or bug fixes.

## License

This project is licensed under the MIT License.
