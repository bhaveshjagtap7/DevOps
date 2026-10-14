# DevOps Engineering Deployment Runbook

This comprehensive guide details the prerequisite setup, step-by-step deployment instructions, health check verification, and teardown procedures for each module in this repository.

---

## 1. Jenkins CI/CD Pipeline (`java-mvn-cicd-pipeline`)

### Prerequisites
- JDK 17 (Eclipse Temurin or OpenJDK)
- Apache Maven 3.8+
- Running Jenkins instance with Git and Pipeline plugins installed

### Local Build & Test Execution
```bash
cd java-mvn-cicd-pipeline
mvn clean compile
mvn test
mvn package
```
Distributable JAR will be located at `target/java-mvn-cicd-pipeline-1.0-SNAPSHOT.jar`.

### Containerized Execution
```bash
docker build -t java-mvn-app:latest .
docker run -d -p 8080:8080 --name java-app java-mvn-app:latest
```

---

## 2. Docker Containerization (`python-docker-exercise`)

### Prerequisites
- Docker Engine 24.0+
- Docker Compose v2+

### Running with Docker Compose
```bash
cd python-docker-exercise
docker compose up -d --build
```

### Health & Endpoint Verification
```bash
# Check status
curl http://localhost:5000/
curl http://localhost:5000/health
curl http://localhost:5000/api/info
```

### Automated Unit Testing
```bash
pytest tests/ -v
```

### Teardown
```bash
docker compose down
```

---

## 3. Kubernetes Minikube Lab (`k8s-minikube-lab`)

### Prerequisites
- Minikube installed and running (`minikube start`)
- `kubectl` configured

### Deployment Procedure
```bash
cd k8s-minikube-lab

# 1. Apply ConfigMap
kubectl apply -f nginx-configmap.yaml

# 2. Deploy Nginx Pods
kubectl apply -f nginx-deployment.yaml

# 3. Expose NodePort Service
kubectl apply -f nginx-service.yaml

# 4. Enable Horizontal Pod Autoscaling
kubectl apply -f nginx-hpa.yaml
```

### Verification
```bash
kubectl get deployments
kubectl get pods -l app=web-app
kubectl get svc web-service
kubectl get hpa web-app-hpa
minikube service web-service --url
```

---

## 4. Terraform EC2 Controller (`terraform-ec2-controller`)

### Prerequisites
- Terraform >= 1.5.0
- Configured AWS CLI credentials (`aws configure`) with IAM permissions for EC2, IAM, and VPC

### Deployment Steps
```bash
cd terraform-ec2-controller
cp terraform.tfvars.example terraform.tfvars
# Customize terraform.tfvars as needed

terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

### Connecting to Controller and Running Inner Infrastructure
```bash
# Obtain public IP from outputs
IP=$(terraform output -raw controller_public_ip)
ssh -i tf-runner-key.pem ubuntu@$IP

# Inside the EC2 Controller:
cd ~/secondary-infra
terraform init
terraform apply -auto-approve
```

### Clean Teardown
```bash
# Inside EC2 Controller:
terraform destroy -auto-approve

# On local workstation:
terraform destroy -auto-approve
```