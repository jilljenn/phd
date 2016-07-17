% Un nouveau modèle

# Motivations

@Cheng2009 essaie une version multidimensionnelle de test adaptatif avec un modèle cognitif basé sur une q-matrice. Elle compare divers critères de sélection de l'item suivant.

Ayant déjà montré dans un chapitre ultérieur que selon le type de test, le meilleur modèle n'est pas le même, il serait naturel de chercher un modèle hybride. Un tel modèle incorporerait des notions de difficulté et de composantes de connaissance. Ainsi à la fin du test, le retour serait une valeur de maîtrise selon chaque composante de connaissance.

C'est ainsi que nous avons suggéré et testé GenMA (General Multidimensional Adaptive). Il se trouve que ce modèle cognitif existe déjà sous le nom de General Diagnostic Model, mais à notre connaissance il n'a pas été utilisé pour administrer des tests adaptatifs.

# GenMA

La q-matrice considère un vecteur de bits par item, considérant si la composante de connaissance intervient ou pas. Ici nous nous proposons de remplacer cela par des poids.

# Comparaison avec MIRT

MIRT à 2 dimensions se débrouille mieux que GenMA, ce qui laisse entendre qu'un modèle prédictif n'est pas nécessairement explicatif. Toutefois afin de faire un retour à l'utilisateur, notre modèle fait un feedback correspondant davantage à la réalité qu'un modèle DINA basé sur les q-matrices.