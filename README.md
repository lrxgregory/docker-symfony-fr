# Docker Symfony

Ce projet utilise Docker pour créer un environnement de développement local pour une application Symfony. Il inclut des services Docker tels que Nginx, PHP-FPM, MySQL, et phpMyAdmin.

## Prérequis

Assurez-vous que vous avez les logiciels suivants installés sur votre machine :

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Contenu du Projet

Ce projet utilise Docker Compose pour gérer plusieurs services nécessaires à l'exécution de votre application Symfony. Voici les services inclus :

- **Nginx** : Serveur web pour servir l'application Symfony.
- **PHP-FPM** : Interpréteur PHP configuré pour fonctionner avec Symfony.
- **MySQL** : Serveur de base de données pour stocker les données de l'application.
- **phpMyAdmin** : Interface web pour gérer facilement la base de données MySQL.

## Installation

Suivez ces étapes pour configurer votre environnement de développement local :

### Étape 1 : Cloner le Répertoire du Projet

Clonez ce dépôt Git sur votre machine locale :

```bash
git clone git@github.com:lrxgregory/docker-symfony.git
cd docker-symfony
```

### Étape 2 : Créer un fichier `.env`

Créez un fichier `.env` à la racine du projet avec les informations suivantes (remplacez si nécessaire) :

```
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=appdb
MYSQL_USER=user
MYSQL_PASSWORD=password
```

### Étape 3 : Construire les Images Docker

Construisez les images Docker nécessaires à l'exécution des services :

```bash
docker compose build
```

### Étape 4 : Démarrer les Services

Démarrez les services Docker en mode détaché (en arrière-plan) :

```bash
docker compose up -d
```

### Étape 5 : Installer Symfony

Accédez au shell du conteneur PHP pour installer Symfony :

```bash
docker exec -it <nom_du_container_php> bash
composer create-project symfony/skeleton:"7.1.*" my_project
cd my_project
composer require webapp
```

Si vous créez une API ou un microservice, utilisez cette commande :

```bash
composer create-project symfony/skeleton:"7.1.*" my_project
```

> **Remarque** : Si vous changez le nom du dossier `my_project`, pensez à mettre à jour le fichier `nginx.conf` à la ligne suivante :
> 
> ```
> root /var/www/html/my_project/public;
> ```

### Étape 6 : Accéder à l'Application Symfony

Pensez à mettre à jour le fichier `.env` dans votre dossier symfony pour pouvoir utiliser doctrine :

```
#Ajouter les varaibles au début dans le fichier .env :
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=appdb
MYSQL_USER=user
MYSQL_PASSWORD=password

#Changer le DATABASE_URL comme ici:
# DATABASE_URL="mysql://app:!ChangeMe!@127.0.0.1:3306/app?serverVersion=8.0.32&charset=utf8mb4"
=> DATABASE_URL="mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mysql:3306/${MYSQL_DATABASE}?serverVersion=8.4.2&charset=utf8mb4"
```

### Étape 7 : Accéder à l'Application Symfony

Votre application Symfony sera disponible à l'adresse suivante : [http://localhost:8080](http://localhost:8080).

### Étape 8 : Arrêter les Services

Pour arrêter et supprimer les conteneurs Docker, utilisez la commande suivante :

```bash
docker compose down
```

## Accès aux Services

- **Application Symfony (via Nginx)** : [http://localhost:8080](http://localhost:8080)
- **phpMyAdmin** : [http://localhost:8081](http://localhost:8081)
  * Serveur MySQL : `mysql`
  * Nom d'utilisateur : `${MYSQL_USER}`
  * Mot de passe : `${MYSQL_ROOT_PASSWORD}`

## Gestion des Bases de Données

### Connexion MySQL via un Client SQL

Vous pouvez utiliser un client de base de données tel que TablePlus, MySQL Workbench ou DBeaver pour vous connecter à la base de données MySQL en utilisant les informations suivantes :

- Host : `localhost`
- Port : `3306`
- Nom d'utilisateur : `${MYSQL_USER}`
- Mot de passe : `${MYSQL_PASSWORD}`
- Nom de la base de données : `${MYSQL_DATABASE}`

## Reconstruction des Images Docker

Si vous modifiez le `Dockerfile` ou `docker-compose.yml`, vous devrez reconstruire les images Docker pour appliquer les modifications :

```bash
docker compose build --no-cache
```

## Visualiser les Logs

Pour surveiller les logs des conteneurs et déboguer des erreurs potentielles :

```bash
docker compose logs -f
```

## Volumes Persistants

Pour s'assurer que les données MySQL sont persistantes entre les arrêts de conteneurs, un volume Docker est utilisé pour la base de données. Si vous avez besoin de supprimer les données, vous pouvez le faire en supprimant ce volume :

```bash
docker volume rm docker-symfony_data
```

