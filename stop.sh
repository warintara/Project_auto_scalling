#!/bin/bash
# ===============================================
# 🧹 Arrêt et nettoyage complet du projet
# ===============================================

echo "🛑 Suppression des ressources Kubernetes..."
kubectl delete all --all --ignore-not-found=true

echo "🧽 Suppression des images locales inutiles..."
docker rmi -f node-app:latest react-app:latest 2>/dev/null || true

echo "🧊 Arrêt de Minikube..."
minikube stop

echo "✅ Tout est proprement arrêté."
