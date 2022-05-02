#!/bin/bash

# Recupere la liste des utilisateurs contenant le mot "/bin/bash" ou "/bin/sh"
# et les stocke dans un tableau
users=($(grep -E "/bin/bash|/bin/sh" /etc/passwd))
j=0
# calcul la taille de chaque repertoire
for i in ${users[@]}; do
    # decouper la ligne avec le séparateur ":"
    # et stocker le résultat dans un tableau
    champs=(${i//:/ })
    # stocker la taille du repertoire
    # si champs 0 == root
    if [ ${champs[0]} == "root" ]; then
        taille=$(du -sh /root | cut -f1)
    else
        taille=$(du -sh /home/${champs[0]} | cut -f1)
    fi
    #remplir la case 1 du tableau
    users[$j]="${champs[0]}:${taille}o"
    j=$(($j+1))
done

#afficher le tableau
for i in ${users[@]}; do
    echo $i
done