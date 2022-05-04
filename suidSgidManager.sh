#!/bin/bash

# recupere la liste des commandes possedant les droits SUID ou SGID
# et les stocke dans un tableau
commands=($(sudo find / -perm -u+s -o -perm -g+s 2>/dev/null))

# recuperer le dernier champs saparer par "/"
# et stocker le résultat dans un tableau
for i in ${commands[@]}; do
    champs=(${i//\// })
    commands[$j]=${champs[$((${#champs[@]}-1))]}
    j=$(($j+1))
done

for i in ${commands[@]}; do
    echo $i
done

# tester si le fichier "suidSgid" existe
if [ -f suidSgid ]; then
    # si le fichier existe alors on stocker les commandes dans un le fichier "suidSgidNew"
    echo ${commands[@]} > suidSgidNew
    # si les fichiers sont identiques
    # on supprime le fichier "suidSgidNew"
    if [ -f suidSgid ] && cmp -s suidSgid suidSgidNew; then
        rm suidSgidNew
    else
        # sinon on affiche les différences
        diff suidSgid suidSgidNew
else
    # si le fichier n'existe pas alors on le cree
    echo ${commands[@]} > suidSgid
fi