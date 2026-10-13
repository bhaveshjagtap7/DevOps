# Kubernetes & Minikube on AWS EC2 Lab (Assignment 3)

**Student Name:** Bhavesh Jagtap  
**Lab:** Kubernetes & Minikube on AWS EC2 — Complete Practical, Screenshots and Word Documentation  
**Target Environment:** AWS EC2 (`t3.medium`, Ubuntu 24.04 LTS, 25 GB gp3)

---

## Architecture Overview
- **Host:** AWS EC2 `t3.medium` (2 vCPU, 4 GB RAM), Ubuntu 24.04 LTS
- **Storage:** 25 GB gp3 EBS Volume
- **Container Runtime:** Docker Engine
- **Kubernetes Engine:** Minikube (Docker driver)
- **Application Deployment:** Nginx (`nginx:1.25-alpine`, 2 Replicas)
- **Service:** NodePort Service `web-app-svc` on port `30080` (mapped to port 80)
- **Ingress / Host Exposure:** `kubectl port-forward --address 0.0.0.0 svc/web-app-svc 30080:80`

---

## Directory Structure
```
k8s-minikube-lab/
├── README.md
├── nginx-deployment.yaml
├── nginx-service.yaml
├── screenshots/
└── Kubernetes_Assignment_3_Report.docx
```
