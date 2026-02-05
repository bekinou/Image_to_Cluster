CLUSTER_NAME=lab
NAMESPACE=demo
SERVICE_NAME=nginx-custom
PORT=8100

.DEFAULT_GOAL := all

.PHONY: all cluster build import deploy access clean

all:
	@echo "🚀 Déploiement du projet en un clic..."
	@$(MAKE) cluster
	@$(MAKE) build
	@$(MAKE) import
	@$(MAKE) deploy
	@echo ""
	@echo "✅ Projet entièrement déployé"
	@echo "🌍 Accès à l'application :"
	@echo "➡️ Lancez : make access"
	@echo "➡️ Puis ouvrez le port $(PORT) dans l’onglet PORTS (Visibility: Public)"

cluster:
	@echo "🔧 Création du cluster Kubernetes..."
	k3d cluster create $(CLUSTER_NAME) --servers 1 --agents 2 || true

build:
	@echo "🏗️ Build de l'image avec Packer..."
	packer init .
	packer build .

import:
	@echo "📦 Import de l'image dans le cluster..."
	k3d image import nginx:latest -c $(CLUSTER_NAME)

deploy:
	@echo "📡 Déploiement Kubernetes via Ansible..."
	ansible-galaxy collection install kubernetes.core || true
	pip3 install kubernetes || true
	ansible-playbook deploy.yml

access:
	@echo "🌐 Port-forward vers l'application (port $(PORT))"
	kubectl port-forward svc/$(SERVICE_NAME) -n $(NAMESPACE) $(PORT):80

clean:
	@echo "🧹 Suppression du cluster"
	k3d cluster delete $(CLUSTER_NAME)

