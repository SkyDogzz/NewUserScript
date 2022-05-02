# Projet d'Administration Linux
## Scripts et personnalisation

[x] - Créer un script permettant de créer automatiquement des utilisateurs utilisables depuis un fichier source dont chaque ligne aura la la structure suivante: Login:prénom:nom:motdepasse.

[x] - Dans le champ commentaire de /etc/passwd, chaque nouveau utilisateur devra avoir son prénom suivi de son nom.

[x] - L'utilisateur doit être obliger de changer sont mot de passe lors de la première connexion.

[ ] - A la création de leurs comptes leurs répertoires devra être peuplés de 5 à 10 fichier d'un taille aléatoires entre 5Mo et 50Mo.

[x] - Les utilisateurs ne doivent pas pouvoir être créer plusieurs fois.

[ ] - Créer un script qui calcule la taille des répertoires personnels de tout les utilisateurs humains du système.

[ ] - A la connexion, chaque utilisateur verra aparaître la liste des 5 plus gros consomateurs d'espace dans l'ordre décroissant.

[ ] - Modifier le fichier .bashrc de chaque utilisateur pour qu'il voit s'afficher la taille de son répertoire personnel ainsi qu'un avertissement s'il occupe plus de 100Mo. Les tailles devront s'afficher sous la forme "XGo, YMo, Zko, Toctetcs".

[ ] - Créer un script permettant de contrôler les éxecutables pour lesquelles le SUID et/ou le SGID est activé. Ce script doit générer une liste de ces fichiers et de la comparer, si elle existe, avec la liste créée lors du précédent appel du script. Si deux listes sont différentes, un avertissement doit affichier la liste des différences et la date de modifications des fichiers litigeux.