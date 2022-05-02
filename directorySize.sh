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
        tailleRaw=$(du -s /root | cut -f1)
    else
        taille=$(du -sh /home/${champs[0]} | cut -f1)
        tailleRaw=$(du -s /home/${champs[0]} | cut -f1)
    fi
    #remplir la case 1 du tableau
    users[$j]="${tailleRaw}:${champs[0]}:${taille}o"
    j=$(($j+1))
done

#classer le tableau par taille avec un tri cocktail
echange=1
while [ $echange -eq 1 ]; do
    echange=0
    for ((i=0; i<$((${#users[@]}-2)); i++)); do
        user1=(${users[$i]//:/ })
        user2=(${users[$(($i+1))]//:/ })
        if [ "${user1}" -lt "${user2}" ]; then
            echange=1
            tmp=${users[$i]}
            users[$i]=${users[$(($i+1))]}
            users[$(($i+1))]=$tmp
        fi
    done
    for ((i=$((${#users[@]}-2)); i>0; i--)); do
        user1=(${users[$i]//:/ })
        user2=(${users[$(($i+1))]//:/ })
        if [ "${user1}" -lt "${user2}" ]; then
            echange=1
            tmp=${users[$i]}
            users[$i]=${users[$(($i+1))]}
            users[$(($i+1))]=$tmp
        fi
    done
done

#afficher le tableau
for i in ${users[@]}; do
    echo $i
done
