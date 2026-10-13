#!/bin/bash
set -e

echo "=== STEP 1: Updating System & Installing Prerequisites ==="
sudo apt-get update -y
sudo apt-get install -y curl wget apt-transport-https ca-certificates gnupg lsb-release conntrack

echo "=== STEP 2: Installing Docker Engine ==="
# Install docker.io which is natively available and fully supported
sudo apt-get install -y docker.io containerd
sudo systemctl enable --now docker
sudo usermod -aG docker ubuntu

echo "=== STEP 3: Verifying Docker ==="
sudo docker --version
sudo docker ps
sudo systemctl status docker --no-pager | head -n 10

echo "=== STEP 4: Installing Kubectl ==="
K8S_VER=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${K8S_VER}/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl
kubectl version --client

echo "=== STEP 5: Installing Minikube ==="
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm -f minikube-linux-amd64
minikube version

echo "=== ALL PREREQUISITES INSTALLED SUCCESSFULLY ==="
