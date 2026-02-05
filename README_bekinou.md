# Image to Cluster – Automatisation avec Packer, K3d et Ansible

## 📌 Présentation du projet

Ce projet met en place une chaîne complète d’automatisation DevOps permettant de créer une image applicative et de la déployer automatiquement dans un cluster Kubernetes.

L’ensemble du projet est réalisé dans GitHub Codespaces afin de garantir un environnement reproductible et sans configuration locale.

---

## 🎯 Objectifs

- Créer une image Docker personnalisée avec Packer
- Déployer un cluster Kubernetes local avec K3d
- Automatiser le déploiement Kubernetes avec Ansible
- Exposer une application web et vérifier son fonctionnement
- Documenter clairement le processus de travail

---

## 🧱 Architecture cible

Le workflow du projet est le suivant :

1. Création d’une image Docker basée sur Nginx avec Packer
2. Déploiement d’un cluster Kubernetes K3d (1 master, 2 workers)
3. Import de l’image Docker dans le cluster
4. Déploiement Kubernetes automatisé avec Ansible
5. Exposition de l’application via un Service NodePort
6. Accès à l’application via un port-forward

---

## 📂 Structure du projet

.
├── index.html
├── packer.pkr.hcl
├── deploy.yml
├── README.md
└── Architecture_cible.png


---

## 🚀 Guide d’utilisation pas à pas

### 1️⃣ Fork et ouverture du projet

- Forker le repository GitHub
- Ouvrir un GitHub Codespace depuis l’onglet Code

---

### 2️⃣ Création du cluster Kubernetes

```bash
k3d cluster create lab --servers 1 --agents 2
kubectl get nodes

3️⃣ Création de l’image Docker avec Packer
packer init .
packer build .


Cette étape permet de construire une image Docker Nginx intégrant le fichier index.html.

4️⃣ Import de l’image dans le cluster K3d
k3d image import nginx:latest -c lab

5️⃣ Déploiement Kubernetes automatisé avec Ansible
ansible-galaxy collection install kubernetes.core
pip3 install kubernetes
ansible-playbook deploy.yml


Ce playbook crée :

un namespace Kubernetes

un Deployment Nginx

un Service de type NodePort

6️⃣ Accès à l’application
kubectl get svc -n demo
kubectl port-forward svc/nginx-custom -n demo 8090:80


L’application est accessible via l’URL fournie par le Codespace.

🤖 Automatisation

Création d’image automatisée avec Packer

Déploiement Kubernetes automatisé avec Ansible

Aucun déploiement manuel via kubectl apply

Environnement reproductible via GitHub Codespaces

🧠 Conclusion

Ce projet démontre une chaîne DevOps complète et automatisée, de la construction d’une image applicative jusqu’à son déploiement Kubernetes.


## 📊 Correspondance avec le barème d’évaluation

| Critère | Validation |
|--------|------------|
| Repository exécutable sans erreur | Oui (GitHub Codespaces) |
| Fonctionnement conforme au scénario | Oui (image → cluster → application accessible) |
| Degré d’automatisation | Packer + Ansible |
| Qualité de la documentation | README clair et structuré |
| Processus de travail | Étapes progressives et cohérentes |

---

## 👤 Auteur
Bereket TSIGIE