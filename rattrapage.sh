#!/bin/bash

# Vérification des droits d'administration
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté en tant qu'administrateur" 
   exit 1
fi

#Liste des arguments
username=$1
comment=$2
shell=$3
duree=$4
quota=$5

echo "$username $comment $shell $duree $quota"

password="INF3611"

# Création de l'utilisateur avec répertoire personnel et bash comme shell
useradd -m -d "/home/$username" -s /bin/$shell -c "$comment" -e $(date -d "+$duree days" +%y-%m-%d) $username

# Définir les permissions pour que seul l'utilisateur puisse écrire dans son répertoire
chmod 700 "/home/$username"

# Définition du mot de passe
echo "$username:$password" | chpasswd

# Forcer le changement de mot de passe à la première connexion
chage -d 0 "$username"

echo "Compte créé pour $username"

#Configuration des quotas de disques
qouta_kb=$((quota*1024*1024)) # pour convertir en Kilobit
sudo setquota -u "$username" "$quota_kb" "$quota_kb" 0 0  "$fs"

#Restreindre les connexions entre 08h et 18h 
sudo bash -c "echo 'login ; tty* ; $username ; Al0800-1800' >> /etc/security/time.conf"
sudo bash -c "echo 'account required pam_time.so' >> /etc/pam.d/common-auth"



echo "Création du compte terminée."

