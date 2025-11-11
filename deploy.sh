#!/bin/bash
# ===============================================
# 🚀 Déploiement complet du projet AutoScaling
# ===============================================



echo "🛠️ (Re)construction des images Docker locales..."
docker build -t node-app:latest ./redis-node-master
docker build -t react-app:latest ./redis-react-master

echo "📦 Démarrage ou redémarrage de Minikube..."
minikube start

echo "🔧 Nettoyage ancien déploiement..."
kubectl delete all --all --ignore-not-found=true

echo "📤 Chargement des images dans Minikube..."
minikube image load node-app:latest
minikube image load react-app:latest

# creer un namespace de monitoring pour isoler tout ce qui est relatif au monitoring, c'est un bon pratique 
kubectl create namespace monitoring
# utiliser kubectl get all -n monitoring pour voir Prometheus et Grafana dans ce namespace


echo "📄 Application des manifests Kubernetes..."
kubectl apply -f redis/
kubectl apply -f nodejs/
kubectl apply -f react/

echo "⏳ Attente du démarrage des Pods..."
kubectl wait --for=condition=Ready pods --all --timeout=120s

echo "✅ Déploiement terminé !"
kubectl get all

IPKUBE=$(minikube ip)
echo
echo "🌍 Accès aux services :"
echo "-------------------------------------------"
echo "Minikube IP     : $IPKUBE"
echo "Frontend React  : http://$IPKUBE:30080"
echo "Backend Node.js : http://$IPKUBE:30000"
echo "-------------------------------------------"
