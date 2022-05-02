#!/bin/bash

# Lire le nombre d'arguments passés en ligne de commande
# et vérifier qu'il est égal à 1
if [ $# -ne 1 ]; then
    echo "Usage: $0 <source file>"
    exit 1
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
done

for i in ${lignes[@]}; do
    # decouper la ligne avec le séparateur ":"
    # et stocker le résultat dans un tableau
    champs=(${i//:/ })
    # donner le login du nouvel utilisateur
    echo "Création de l'utilisateur ${champs[0]}"
    # creer le nouvel utilisateur
    useradd -m -p ${champs[1]} ${champs[0]}
    # rajouter un commentaire dans le fichier /etc/passwd
    echo "# ${champs[0]}:${champs[1]}:${champs[2]}:${champs[3]}" >> /etc/passwd
done

