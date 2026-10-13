# DevOps Engineering Projects & Assignments

Welcome to the central repository for **DevOps Engineering Projects and Assignments** by **[Bhavesh Jagtap](https://github.com/bhaveshjagtap7)**. This repository showcases end-to-end hands-on implementations of modern DevOps methodologies, CI/CD automation, containerization, container orchestration, and Infrastructure as Code (IaC).

---

## Repository Structure

| Project / Module | Description | Technologies & Tools |
| :--- | :--- | :--- |
| **[1. Jenkins CI/CD Pipeline](./java-mvn-cicd-pipeline)** | Automated build, test, package, and deployment pipeline for a Java Maven application. | Jenkins, Maven, Java, Git, Declarative Pipeline |
| **[2. Docker Containerization](./python-docker-exercise)** | Containerizing a Python Flask web application with Dockerfile, container lifecycle management, and verification. | Docker, Dockerfile, Python, Flask |
| **[3. Kubernetes Minikube Lab](./k8s-minikube-lab)** | Cluster provisioning, Deployments, Pod replication, NodePort Services, and traffic management on Minikube. | Kubernetes, Minikube, kubectl, Nginx |
| **[4. Terraform EC2 Automation](./terraform-ec2-controller)** | Automated cloud infrastructure provisioning on AWS (EC2, Security Groups, IAM) using modular IaC configurations. | Terraform, AWS EC2, HCL, Cloud Architecture |

---

## Tech Stack & Skills

- **CI / CD**: Jenkins (Pipeline-as-Code, Jenkinsfile), GitHub
- **Containers & Orchestration**: Docker, Docker Compose, Kubernetes, Minikube, kubectl
- **Infrastructure as Code (IaC)**: Terraform, AWS (EC2, VPC, Security Groups, IAM)
- **Build Tools & Languages**: Java, Apache Maven, Python, Bash / Shell Scripting
- **Testing & Verification**: JUnit, Maven Surefire, cURL, Browser validation

---

## Module Summaries

### 1. [Jenkins CI/CD Pipeline](./java-mvn-cicd-pipeline)
- **Goal**: Implement a multi-stage Jenkins Declarative Pipeline for a Java Maven application.
- **Stages**:
  - `Checkout`: Pull source code from version control.
  - `Build`: Compile Java source files (`mvn compile`).
  - `Unit Test`: Execute automated test suites (`mvn test`).
  - `Package`: Create distributable JAR package (`mvn package`).
  - `Post-Actions`: Archive artifacts and generate execution logs.
- Includes complete documentation, Jenkinsfile, source code, and configuration.

### 2. [Docker Containerization](./python-docker-exercise)
- **Goal**: Package and run a lightweight Python web application using Docker.
- **Key Highlights**:
  - Optimized `Dockerfile` and `.dockerignore`.
  - Image build and tag management.
  - Port forwarding and interactive/detached container execution.
  - Complete container lifecycle: `build`, `run`, `logs`, `stop`, `rm`.

### 3. [Kubernetes Minikube Lab](./k8s-minikube-lab)
- **Goal**: Deploy scalable workloads on a local Kubernetes cluster using Minikube.
- **Key Highlights**:
  - Declarative manifests: `nginx-deployment.yaml` and `nginx-service.yaml`.
  - Replica management and self-healing verification.
  - Exposing pods using `NodePort` service.
  - Port forwarding, curl verification, and cluster testing.

### 4. [Terraform EC2 Automation](./terraform-ec2-controller)
- **Goal**: Provision repeatable AWS infrastructure declaratively.
- **Key Highlights**:
  - Infrastructure definition using `main.tf`, `variables.tf`, and `outputs.tf`.
  - Automated provisioning workflow: `init`, `validate`, `plan`, `apply`, `destroy`.
  - EC2 instance configuration with automated bootstrap scripts.

---

## Author

**Bhavesh Jagtap**  
- **GitHub**: [@bhaveshjagtap7](https://github.com/bhaveshjagtap7)  
- **Email**: bhaveshjagtap0723@gmail.com
