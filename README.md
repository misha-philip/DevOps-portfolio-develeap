# DevOps Portfolio SaaS Application

> A fully containerized SaaS demo project showcasing CI/CD pipelines, Infrastructure as Code, and Kubernetes microservices deployment on AWS.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [CI/CD Pipeline](#cicd-pipeline)
- [Contributing](#contributing)
- [Release History](#release-history)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

## Overview

This project demonstrates a complete DevOps workflow to build, test, package, and deploy a simple Python Flask application backed by MongoDB to an EKS Kubernetes cluster.

Key features:

- Terraform-managed AWS infrastructure
- GitHub Actions CI/CD pipeline with automated E2E tests
- Docker containerization and ECR registry integration

## Architecture

This solution consists of a Flask REST API, MongoDB database, and supporting infrastructure deployed via IaC.

![Architecture Diagram](images/architecture_diagram.png)

## Technology Stack

| Category             | Technologies                                             |
| -------------------- | -------------------------------------------------------- |
| **Infrastructure**   | AWS, Terraform                                           |
| **Containerization** | Docker, docker-compose                                   |
| **CI/CD**            | GitHub Actions                                           |
| **Version Control**  | GitHub                                                   |
| **Security**         | AWS IAM, GitHub Secrets                                  |
| **Application**      | Python Flask, pymongo                                    |
| **Database**         | MongoDB                                                  |

## Repository Structure

project-root/
├── app/ # Flask application source code
│ ├── init.py # Application factory and MongoDB setup
│ ├── models.py # Account model logic
│ └── routes.py # REST API endpoints
├── tests/ # Pytest test cases
│ └── test_api.py # E2E API tests
├── Dockerfile # Multi-stage Docker build
├── docker-compose.yaml # Local development stack
├── Cluster Resources/cluster setup # Infrastructure as Code (EKS cluster)
│ └── main.tf # Terraform modules and configuration
├── k8s-manifests/ # Kubernetes deployment and service YAMLs
│ ├── deployment.yaml # Flask and MongoDB deployments
│ └── service.yaml # LoadBalancer services
└── .github/workflows/ # GitHub Actions CI/CD pipeline
└── ci-cd.yml # Workflow definition
└── deploy-to-eks.yml # Workflow definition and deployment to eks

markdown
Copy
Edit

## Prerequisites

Requirements for building and running the project:

- AWS CLI installed and configured
- Terraform v1.0+
- Docker installed
- kubectl installed
- Python 3.9+
- An AWS account with IAM permissions

## Getting Started

Follow these instructions to set up the project locally and deploy it.

### Infrastructure Setup

1. **Initialize Terraform and Deploy EKS**

```bash
cd Cluster Resources\cluster setup
terraform init
terraform apply
Expected output:

yaml
Copy
Edit
Apply complete! Resources: X added, 0 changed, 0 destroyed.
Configure kubectl

bash
Copy
Edit
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
kubectl get nodes
Application Deployment
Build and Push Docker Image

bash
Copy
Edit
docker build -t my-ecr-repo:latest .
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com
docker tag my-ecr-repo:latest <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/my-ecr-repo:latest
docker push <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/my-ecr-repo:latest
Deploy Kubernetes Manifests

bash
Copy
Edit
kubectl apply -f k8s-manifests/deployment.yaml
kubectl apply -f k8s-manifests/service.yaml
Verify Deployment

bash
Copy
Edit
kubectl get pods
kubectl get svc
Expected result: External LoadBalancer IP for the API.

CI/CD Pipeline
This workflow automates build, test, packaging, and deployment.

mermaid
Copy
Edit
graph LR
    A[Checkout Code] --> B[Install Dependencies]
    B --> C[Unit Tests]
    C --> D[Build Docker Image]
    D --> E[End-to-End Tests]
    E --> F[Push to ECR]
    F --> G[Update K8s Deployment]
Contributing
This project is not intended for contributions, but if you wish to fork it:

Fork the repository

Create your feature branch (git checkout -b feature/[FEATURE_NAME])

Commit your changes (git commit -m 'Add [FEATURE_NAME]')

Push to the branch (git push origin feature/[FEATURE_NAME])

Open a Pull Request

Release History
0.1.0

Initial release with infrastructure, application, and CI/CD

Contact
Misha Philip - LinkedIn - [michaelpgilippyev@gmail.com]

Project Link: https://github.com/misha-philip/DevOps-portfolio-develeap

Acknowledgments
AWS Documentation

HashiCorp Terraform Modules

Docker and Kubernetes communities
