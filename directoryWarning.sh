#!/bin/bash

# calculer la taille du repertoire home du user founrni par le parametre
# si le parametre est "root" alors le repertoire est /root
# sinon le repertoire est /home/user
if [ "$1" == "root" ]; then
    taille=$(du -sh /root | cut -f1)
    tailleRaw=$(du -s /root | cut -f1)
else
    taille=$(du -sh /home/$1 | cut -f1)
    tailleRaw=$(du -s /home/$1 | cut -f1)
fi

echo "${tailleRaw}:${1}:${taille}o"
echo "Le repertoire $1 a une taille de ${taille}o"

# si tailleRaw > 10485760 affiche un warning
if [ $tailleRaw -gt 10485760 ]; then
    echo "WARNING: le repertoire $1 a une taille de ${taille}o"
fi