# Extraction de caractéristiques cachées

La théorie de la réponse à l'item suppose que les réponses des apprenants peuvent être expliquées par un faible nombre de facteurs. Ainsi, si l'on parvient à partir de peu de réponses de l'apprenant à identifier ces facteurs, on peut généraliser le comportement de l'apprenant à toutes les questions du test. Par exemple, il est inutile de poser davantage de questions portant sur le même sujet si l'apprenant au cours du test a prouvé à plusieurs reprises qu'il ne maîtrisait pas ce sujet. Pour réduire la taille d'un test, on cherche donc, entre autres, à éliminer la redondance dans les questions qu'on pose.

Il existe de nombreuses façons de réduire le nombre de dimensions d'un jeu de données afin d'interpréter plus facilement les motifs qui y apparaissent. C'est pourquoi nous avons jugé important de les mentionner afin de comprendre ce qui différencie ces méthodes, lesquelles modélisent la variance des données d'une façon particulière, et lesquelles sont approchées.

Toutes les méthodes que nous décrivons dans cette section consistent à tenter d'extraire automatiquement des caractéristiques des questions à partir de données d'apprenants y ayant répondu de façon correcte ou incorrecte. Ainsi, nous nous concentrons ici sur la phase d'apprentissage des modèles de tests adaptatifs décrite à la section \vref{training-step}. Les caractéristiques des questions extraites seront sous la forme de vecteurs à $d$ dimensions[^1], où $d$ est inférieur au nombre de questions du test, tels que pour un apprenant fixé, des questions de caractéristiques proches induisent des motifs de réponse de l'apprenant proches. De façon similaire, pour une question fixée, des utilisateurs de caractéristiques proches auront des motifs de réponse proches. Celles-ci nous permettront d'exécuter des tests adaptatifs pour de nouveaux apprenants.

 [^1]: Cette écriture est appelée *représentation distribuée* en apprentissage automatique.

Il est intéressant de tenter d'interpréter les dimensions des caractéristiques des questions a posteriori : ainsi, on pourra par exemple identifier que telle composante évalue la capacité de la question à mesurer la capacité de l'apprenant à savoir additionner, tandis que telle autre évalue la capacité de l'apprenant à savoir multiplier.

Dans cette section, on note $D$ la matrice des réponses succès / échecs des apprenants aux questions d'un test. Cette matrice est de taille $m \times n$, où $m$ est le nombre d'apprenants et $n$ le nombre de questions du test. Nous commençons par présenter le problème général de la factorisation de matrice, puis l'analyse en composantes principales, l'analyse de facteurs et enfin la théorie de la réponse à l'item multidimensionnelle.

## Factorisation de matrice pour la réduction de dimension

Formellement, le problème de la factorisation de matrice consiste à résoudre l'équation :

\begin{equation}
D \simeq UV^T
\end{equation}

- $d$ est un entier compris entre 1 et $n$ ;
- $U$ est une matrice de taille $m \times d$, qui ici correspondrait aux caractéristiques de l'apprenant ;
- $V$ est une matrice de taille $n \times d$, qui ici correspondrait aux caractéristiques des questions ;
- $V^T$ indique la matrice transposée de $V$.

Résoudre cette équation permet d'exprimer les lignes de $D$, c'est-à-dire les réponses des apprenants aux $n$ questions, comme une combinaison linéaire des $d$ lignes de $V^T$, qui sont en nombre plus faible. On réduit ainsi la dimension du problème : au lieu de devoir déterminer les réponses de l'apprenant aux $n$ questions, on se ramène à un problème intermédiaire : il faut déterminer les caractéristiques de l'apprenant sur seulement $d$ dimensions. Ainsi, moins de réponses de l'apprenant seront nécessaires pour obtenir une estimation suffisante.

Dans le problème générique de la factorisation de matrice, les lignes de $U$ sont appelés *poids* ou *facteurs* tandis que les lignes de $V^T$ sont appelées composantes. Dans notre problème, on peut interpréter la $i$-ème ligne de $U$ comme la maîtrise de l'apprenant selon plusieurs dimensions $d$, et la $j$-ème ligne de $V$ comme l'importance de chaque dimension dans la résolution de la question $j$.

Les caractéristiques des questions ainsi extraites sont les lignes de $V$.

## Analyse en composantes principales

L'analyse en composantes principales est une méthode descriptive qui consiste à déterminer par une factorisation de matrice les composantes qui expliquent le plus la variance des données. Pour procéder à cette analyse, on fait habituellement une décomposition en valeurs singulières, qui décompose la matrice $D$ de la façon suivante :

\begin{equation}
D = U \Sigma W^T
\end{equation}

- $r$ est un entier compris entre 1 et $n$ correspondant au rang de la matrice $D$ des motifs de réponse des apprenants ;
- $U$ est une matrice unitaire de taille $m \times r$, c'est-à-dire que $U^T U = I$ et donc que les lignes de $U$ sont deux à deux orthogonales ;
- $\Sigma$ est une matrice diagonale de taille $r \times r$ dont les éléments diagonaux $\sigma_1, \ldots, \sigma_r$ sont classés par ordre décroissant : $\sigma_1 \geq \cdots \geq \sigma_r$ ;
- $W$ est une matrice unitaire de taille $n \times r$ ;
- $W^T$ indique la matrice transposée de $W$.

Cette décomposition est habituellement obtenue en diagonalisant la matrice $D^T D$ puis en se ramenant à $D$.

La première ligne de $W^T$ est alors la composante expliquant le plus la variance des données, donc la direction séparant le mieux les données et les lignes de $W$ sont orthogonales deux à deux. La décomposition en valeurs singulières est donc un processus qui consiste à réordonner les composantes de façon à obtenir une représentation « éclatée » du jeu de données.

Une méthode de réduction de dimension consiste ensuite à calculer l'approximation de rang $d$ de la matrice $D$ pour une valeur de $d$ choisie entre 1 et $n$, donnée par :

\begin{equation}
D_d = U_d \Sigma_d W_d^T \simeq D
\end{equation}

- $U_d$ est la matrice $U$ tronquée aux $d$ premières colonnes ;
- $\Sigma_d$ est la matrice diagonale $\Sigma$ dont on n'a conservé que les $d$ éléments les plus grands, c'est-à-dire les $d$ premiers : $\sigma_1 \geq \cdots \geq \sigma_d$ ;
- $W_d$ est la matrice $W$ tronquée aux $d$ premières colonnes.

L'approximation $D_d$ obtenue est bien une matrice de rang $d$, proche de la matrice $D$ initiale des données des apprenants.

Ainsi, l'analyse en composantes principales est un processus déterministe qui conduira toujours au même résultat, et les caractéristiques des questions sont les colonnes de $\Sigma_d W_d^T$.

Une limitation de cette méthode est que si les données que l'on souhaite décomposer comportent des erreurs de mesure, aussi appelées *bruit*, la décomposition en valeurs singulières va prendre le bruit pour de la variance qui explique les données. Or, comme nous l'avons vu, les apprenants peuvent répondre faux à des questions par inattention, ou deviner la bonne réponse alors qu'ils ne maîtrisent pas les composantes nécessaires. C'est pourquoi on considère généralement des modèles probabilistes, qui modélisent le bruit comme une gaussienne.

## Analyse de facteurs

Faire une analyse de facteurs consiste à supposer que les données sont issues d'un modèle vérifiant :

\begin{equation}
D = UV^T + E
\end{equation}

- $d$ est un entier compris entre 1 et $n - 1$ ;
- $U$ est une matrice de taille $m \times d$, qui ici correspondrait aux caractéristiques de l'apprenant ;
- $V$ est une matrice de taille $n \times d$, qui ici correspondrait aux caractéristiques des questions ;
- $V^T$ indique la matrice transposée de $V$ ;
- $E$ est l'erreur de mesure dont la covariance est une matrice diagonale.

Cela consiste à supposer que les réponses de l'apprenant suivent une loi de probabilité telle que l'erreur de mesure a une variance différente selon chaque dimension. Avec cette hypothèse, l'estimation des composantes est séparée de celle du bruit, donc le modèle est robuste aux erreurs des apprenants.

Les composantes ne sont alors plus orthogonales comme dans une analyse en composantes principales et sont ainsi plus facilement interprétables. Les caractéristiques des questions extraites par cette méthode sont les lignes de $V$.

## Théorie de la réponse à l'item multidimensionnelle

Dans notre cas, la matrice $D$ des données des apprenants ne comporte que des 1 et des 0, correspondant respectivement aux succès et échecs des apprenants sur des questions du test.

Ainsi, si l'on modélise l'apprenant d'après la théorie de la réponse à l'item multidimensionnelle (MIRT) de dimension $d$, si l'apprenant a un grand facteur selon une dimension impliquée dans la résolution d'une question, il aura simplement plus de chances de répondre correctement à la question. Pour rappel, la probabilité que l'apprenant $i$ réponde correctement à la question $j$ est donnée par l'expression :

\begin{equation}
Pr(D_{ij} = 1) = \Phi(\boldsymbol{\theta_i} \cdot \boldsymbol{d_j} + \delta_j)
\end{equation}

- $\Phi$ est la fonction logistique définie sur les réels : $\Phi(x) = 1/(1 + e^{-x})$, qui tend vers 0 en $-\infty$ et vers 1 en $+\infty$ ;
- $\boldsymbol{\theta_i}$ est le vecteur des caractéristiques de l'apprenant $i$ ;
- $\boldsymbol{d_j}$ est le vecteur des caractéristiques de la question $j$ ;
- $\delta_j$ est un paramètre de facilité de la question $j$.

Écrit sous forme matricielle, le modèle MIRT devient, à la fonction logistique près, une analyse de facteurs :

\begin{equation}
D \simeq \Phi(\Theta V^T)
\end{equation}

- $d$ est un entier compris entre 1 et $n - 1$ ;
- $\Theta$ est de taille $m \times (d + 1)$, sa ligne $i$ est $(\theta_{i1}, \ldots, \theta_{id}, 1)$ ;
- $V$ est de taille $n \times (d + 1)$, sa ligne $j$ est $(d_{j1}, \ldots, d_{jd}, \delta_j)$ ;
- $V^T$ indique la matrice transposée de $V$.

L'estimation ne peut jamais être exacte, car $\Phi$ tend vers 0 et 1 en $\pm \infty$. Toutefois, $\Phi$ tend vite vers ses limites, par exemple $\Phi(4)$ vaut déjà environ 0,982.

Cette estimation revient à faire une phase d'apprentissage non supervisé, car les caractéristiques des questions sont directement extraites des données des apprenants $D$, elles ne sont pas spécifiées par un expert. Il y a $d(m + n)$ paramètres à estimer, donc la calibration des paramètres peine à converger lorsqu'on doit traiter des données de beaucoup d'apprenants.
