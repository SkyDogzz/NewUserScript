#!/bin/bash

# Lire le nombre d'arguments passés en ligne de commande
# et vérifier qu'il est égal à 1
if [ $# -ne 1 ]; then
    echo "Usage: $0 <source file>"
    exit 1
fi

# Lire le fichier passé en argument et stockée le nombre
# de lignes dans la variable nbLignes
nbLignes=$(wc -l < $1)

# Stocker chaque ligne du fichier dans le tableau lignes
lignes=($(cat $1))

echo "Nombre de lignes: $nbLignes" 

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
done

for i in ${lignes[@]}; do
    # decouper la ligne avec le séparateur ":"
    # et stocker le résultat dans un tableau
    champs=(${i//:/ })
    # donner le login du nouvel utilisateur
    echo "Création de l'utilisateur ${champs[0]}"
    # creer le nouvel utilisateur
    useradd -m -p ${champs[1]} ${champs[0]}
done
