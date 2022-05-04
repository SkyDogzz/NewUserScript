#!/bin/bash

# Lire le nombre d'arguments passés en ligne de commande
# et vérifier qu'il est égal à 1
if [ $# -ne 1 ]; then
    echo "Usage: $0 <source file>"
    exit 1
fi

# --help
if [ "$1" == "--help" ]; then
    echo "Usage: $0 <source file>"
    exit 0
fi

# Stocker chaque ligne du fichier dans le tableau lignes
lignes=($(cat $1))

# recuperer la liste des utilisateurs deja existants
# et stocker le résultat dans un tableau
users=($(cut -d: -f1 /etc/passwd))

# tester si les lignes du fichier contiennent 4 champs
for i in ${lignes[@]}; do
    # decouper la ligne avec le séparateur ":"
    # et stocker le résultat dans un tableau
    champs=(${i//:/ })
    # si le tableau ne contient pas 4 éléments
    # alors on affiche une erreur
    if [ ${#champs[@]} -ne 4 ]; then
        echo "Erreur: la ligne $i ne contient pas 4 champs"
        exit 1
    fi
    # tester si le nom d'utilisateur existe déjà
    # si oui, afficher un message d'erreur
    if [[ " ${users[@]} " =~ " ${champs[0]} " ]]; then
        echo "Erreur: l'utilisateur ${champs[0]} existe déjà"
        exit 1
    fi
    # verifier si le champs 4 contient un mot de passe valable
    # si non, afficher un message d'erreur
    if ! echo ${champs[3]} | grep -q "^[a-zA-Z0-9]\{8,\}$"; then
        echo "Erreur: le mot de passe \"${champs[3]}\" n'est pas valide"
        echo "Le mot de passe doit contenir au moins 8 caractères"
        echo "et doit contenir des lettres et des chiffres"
        exit 1
    fi
done

for i in ${lignes[@]}; do
    # decouper la ligne avec le séparateur ":"
    # et stocker le résultat dans un tableau
    champs=(${i//:/ })
    # donner le login du nouvel utilisateur
    echo "Création de l'utilisateur ${champs[0]}"
    # creer le nouvel utilisateur
    useradd -m ${champs[0]}
    echo "${champs[0]}:${champs[3]}" | sudo chpasswd
    # passer le mot de passe en état expiré
    passwd -e ${champs[0]} > /dev/null
    # rajouter un commentaire dans le fichier /etc/passwd
    echo "# ${champs[0]}:${champs[1]}:${champs[2]}:${champs[3]}" >> /etc/passwd
done

for i in ${lignes[@]}; do
    #generer un chiffre entre 5 et 10
    chiffre=$(($RANDOM % 6 + 5))
    # decouper la ligne avec le séparateur ":"
    # et stocker le résultat dans un tableau
    champs=(${i//:/ })
    # ajouter directorySize.sh a la fin du .bashrc
    echo "directorySize.sh" >> /home/${champs[0]}/.bashrc
    # ajouter directoryWarning.sh a la fin du .bashrc
    echo "directoryWarning.sh ${champs[0]}" >> /home/${champs[0]}/.bashrc
    chsh -s /bin/bash ${champs[0]}
    #boucle for
    for ((j=0; j<$chiffre; j++)); do
        #creer un fichier avec un nom aléatoire
        name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
        touch /home/${champs[0]}/$name
        #generer un chiffre entre 5 et 50
        size=$(($RANDOM % 45 + 5))
        #multiplier le chiffre generer par 2^20
        size=$(($size*1024*1024))
        #creer un fichier de taille aléatoire
        dd if=/dev/urandom of=/home/${champs[0]}/$name bs=1 count=$size status=none
        # fichier creer
        echo "Fichier ${name} créé"
    done
done