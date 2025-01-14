# Script de création d'utilisateur avec gestion de quota, expiration et restriction d'accès

Ce script permet de créer un utilisateur sur un système Linux avec des paramètres personnalisables, tels que le shell, le commentaire, le quota disque, et la date d'expiration. Il configure également des restrictions sur les heures de connexion de l'utilisateur et force le changement de mot de passe à la première connexion.

## Prérequis

- Le script doit être exécuté en tant qu'utilisateur **root**.
- Le paquet `quota` doit être installé et configuré sur le système.

## Fonctionnalités

1. **Vérification des droits d'administration**  
   Le script vérifie que l'utilisateur exécutant le script dispose des privilèges administratifs (root).

2. **Création d'un utilisateur**  
   - Crée un utilisateur avec un répertoire personnel et un shell spécifié.
   - Ajoute un commentaire associé à l'utilisateur.
   - Définit une date d'expiration basée sur le nombre de jours spécifié (`duree`).
   
3. **Sécurisation du répertoire utilisateur**  
   Le répertoire personnel de l'utilisateur est configuré pour que seul l'utilisateur puisse y accéder et y écrire (`chmod 700`).

4. **Définition du mot de passe**  
   Le mot de passe par défaut est `INF3611`, mais l'utilisateur est invité à le changer lors de sa première connexion (via la commande `chage`).

5. **Gestion du quota disque**  
   Un quota disque de 2 Go (ou tout autre montant spécifié via l'argument `quota`) est appliqué à l'utilisateur. Le quota est configuré en kilooctets pour la commande `setquota`.

6. **Restriction des heures de connexion**  
   Le script limite les connexions de l'utilisateur entre **08h00 et 18h00** uniquement, en modifiant les fichiers de configuration suivants :
   - `/etc/security/time.conf`
   - `/etc/pam.d/common-auth`

## Utilisation

### Syntaxe

```bash
sudo ./create_user.sh <username> <commentaire> <shell> <duree_en_jours> <quota_en_Go>
