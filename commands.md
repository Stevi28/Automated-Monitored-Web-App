# 🚀 Automated & Monitored Web App — Commands Reference

## Prerequisites

```bash
# Install Azure CLI
brew install azure-cli

# Install kubectl
brew install kubectl

# Install Helm
brew install helm

# Login to Azure
az login
```

---

## Step 1 — Connect to AKS

```bash
# Get credentials for kubectl
az aks get-credentials --resource-group rg-cloudnative --name aks-cloudnative-weu

# Verify node is ready
kubectl get nodes
```

---

## Step 2 — Install Argo CD

```bash
# Create namespace
kubectl create namespace argocd

# Install Argo CD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for pods to be ready
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=120s

# Check pods
kubectl get pods -n argocd

# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo

# Port-forward to access UI
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Open: https://localhost:8080
# Username: admin
# Password: (output from above)
```

---

## Step 3 — Install Prometheus & Grafana (Helm)

```bash
# Add Helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Update repos
helm repo update

# Install kube-prometheus-stack
helm install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace

# Check pods
kubectl get pods -n monitoring

# Get Grafana admin password
kubectl get secret -n monitoring monitoring-grafana \
  -o jsonpath="{.data.admin-password}" | base64 -d && echo

# Port-forward to access Grafana UI
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
# Open: http://localhost:3000
# Username: admin
# Password: (output from above)
```

---

## Grafana Dashboard

```
Import Dashboard ID: 15661
Datasource: Prometheus
```

---

## Useful kubectl commands

```bash
# Check all pods across all namespaces
kubectl get pods -A

# Check services
kubectl get svc

# Get external IP of app
kubectl get service cloud-native-app

# Check logs of a pod
kubectl logs <pod-name>

# Describe a pod (for debugging)
kubectl describe pod <pod-name>
```

---

## ⚠️ Cleanup — Delete everything when done

```bash
az group delete --name rg-cloudnative --yes --no-wait
```