% Factorisation
% JJV
% 13 juillet

# Régression logistique

Ce modèle simple se base sur la fonction logistique :

$$ \Phi(x) = \frac1{1 + e^{-x}}.$$

Lien avec le score Elo.

\def\R{\mathbf{R}}

Le modèle de la régression logistique est utilisé pour la prédiction de variables dichotomiques (vrai ou faux). Il estime un paramètre $\theta \in \R^d$ tel que $\Phi(X\theta) = y$.

Ainsi, à partir d'un plongement des questions dans $\R^d$, le problème revient à estimer le vecteur $\theta$ du candidat en fonction des réponses binaires aux questions qu'on lui a posées. C'est le modèle MIRT, qui justement cherche à trouver une représentation non supervisée $\Phi(\Theta V) = M$ où $M$ est la matrice binaire des résultats des apprenants à un test.

# Factorisation de matrices

Lorsqu'on dispose d'une matrice, on peut se demander si un faible nombre de variables peut expliquer sa structure. Cela revient à écrire $M = UV$ où si $M$ est de taille $m \times n$, $U$ est de taille $m \times r$ ($r$ étant le rang) et $V$ de taille $r \times n$. Les lignes de $U$ sont appelés poids tandis que les lignes de $V$ sont appelées composantes. Ainsi si $M_i$ est la $i$-ième ligne de $M$ et $(V_1, \ldots, V_r)$ sont les lignes de $V$, alors $M_i = u_{i1} V_1 + \ldots + u_{ir} V_r$, ce qui exprime bien la ligne $M_i$ comme une combinaison linéaire des composantes. On peut donc résumer chaque ligne $M$ par $r$ coefficients selon la famille $(V_1, \ldots, V_r)$, qui n'est pas nécessairement une base ; donc l'écriture n'est pas nécessairement unique. Cette approche est parfois appelée réduction de dimension.

## Analyse de composantes principales

L'analyse de composantes principales est une méthode descriptive qui consiste à déterminer les composantes qui expliquent le plus la variance. Pour procéder à cette analyse, on fait habituellement une décomposition en valeurs singulières $M = U \Sigma V$ où $\Sigma$ est diagonale de valeurs décroissantes et $U$ et $V$ sont unitaires. $V_1$ est alors la composante expliquant le plus la variance et les lignes de $V$ sont orthogonales deux à deux. La décomposition en valeurs singulières est donc un processus déterministe, qui conduit à une représentation « éclatée » du jeu de données.

## Analyse de facteurs

Une approche plus robuste au bruit est de faire une analyse de facteurs. Les composantes ne sont alors plus orthogonales mais plus interprétables.

# Factorisation de matrices positives

Ici on s'intéresse à écrire $M = WH$ où $W$ et $H$ n'ont que des coefficients positifs ou nuls et la norme de Frobenius $||M - WH||$ est minimisée. Ainsi il n'y a pas de compensation entre les composantes et les poids peuvent être facilement interprétés.