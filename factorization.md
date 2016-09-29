# Extraction de caractéristiques cachées

Pour réduire la taille d'un test, on cherche à éliminer la redondance dans les questions qu'on pose. La théorie de la réponse à l'item suppose que les réponses des apprenants peuvent être expliquées par un faible nombre de facteurs. Ainsi, si l'on parvient à partir de peu de réponses de l'apprenant à identifier ces facteurs, on peut généraliser le comportement de l'apprenant à toutes les questions du test. Par exemple, il est inutile de poser davantage de questions portant sur le même sujet si l'apprenant au cours du test a prouvé à plusieurs reprises qu'il ne maîtrisait pas ce sujet.

Toutes les méthodes que nous décrivons dans cette section consistent à tenter d'extraire automatiquement des caractéristiques des questions, sous la forme de vecteurs à $d$ dimensions. Il est intéressant de tenter d'intepréter les dimensions ces vecteurs a posteriori : ainsi, on pourra par exemple identifier que telle composante évalue la capacité de la question à mesurer la capacité de l'apprenant à savoir additionner, tandis que telle autre évalue la capacité de l'apprenant à savoir multiplier.

Dans cette section, on note $M$ la matrice des réponses succès / échecs des apprenants, de taille $m \times n$.

## Factorisation de matrices et réduction de dimension

Formellement, le problème de la factorisation de matrice consiste à trouver deux autres matrices $U$ et $V$ de tailles respectives $m \times d$ et $d \times n$ pour un certain entier $r$ compris entre 1 et $n$ telles que $M \simeq UV$. Faire cela permet d'exprimer les lignes de $M$, c'est-à-dire les réponses des apprenants, comme une combinaison linéaire des $d$ lignes de $V$, qui sont en plus faible nombre. On a donc réduit la dimension du problème. Les lignes de $U$ sont appelés poids ou facteurs tandis que les lignes de $V$ sont appelées composantes. Cette écriture n'est pas unique, et plus $r$ sera petit, moins de questions seront nécessaires pour identifier les facteurs latents de l'apprenant, mais moins la reconstruction sera bonne, c'est-à-dire que $UV$ sera distant de $M$.

Les caractéristiques des questions sont ainsi les colonnes de $V$.

## Analyse en composantes principales

L'analyse en composantes principales est une méthode descriptive qui consiste à déterminer les composantes qui expliquent le plus la variance. Pour procéder à cette analyse, on fait habituellement une décomposition en valeurs singulières $M = U \Sigma V$ où $\Sigma$ est diagonale et ses éléments diagonaux sont dans l'ordre décroissant et $U$ et $V$ sont unitaires. $V_1$ est alors la composante expliquant le plus la variance et les lignes de $V$ sont orthogonales deux à deux. La décomposition en valeurs singulières est donc un processus de réduction de dimension, qui conduit à une représentation « éclatée » du jeu de données.

Ainsi, l'analyse en composantes principales est un processus déterministe qui conduira toujours au même résultat, et les caractéristiques des questions seront les colonnes de $\Sigma V$.

## Analyse de facteurs

Lorsqu'on considère des réponses d'apprenant à un test, il est important de considérer que les données puissent comporter des erreurs. Ainsi, l'apprenant a un risque de répondre correctement à une question par chance, ou se tromper en faisant une erreur d'inattention.

Une approche plus robuste au bruit, dans le cas où la matrice $M$ peut comporter du bruit, est de faire une analyse de facteurs. Cela consiste à supposer que les réponses de l'apprenant suivent une loi de probabilité dont l'erreur a une variance différente selon chaque dimension.

Les composantes ne sont alors plus orthogonales, l'identification de $U \Sigma$ sachant $V$ n'est plus unique, mais cette approche résiste mieux au bruit et les composantes sont plus facilement interprétables, car le bruit a été séparé par le modèle.

## Régression logistique

Ce classifieur simple se base sur la fonction logistique :

$$\Phi(x) = \frac1{1 + e^{-x}}.$$

\def\R{\mathbf{R}}

Le modèle de régression logistique est utilisé pour la prédiction de variables dichotomiques (vrai ou faux), telles que les réponses des apprenants dans notre cas. Lorsqu'on a $n$ éléments de dimension $d$ $(\mathbf{x_1}, \ldots, \mathbf{x_n})$ pour lesquels on observe des résultats vrai/faux $\mathbf{y} = (y_1, \ldots, y_n) \in \{0, 1\}^n$, la régression logistique consiste à estimer un paramètre $\mathbf{\theta} \in \R^d$ tel que $\Phi(X\mathbf{\theta}) = \mathbf{y}$ où $X$ est la matrice ayant pour lignes les vecteurs $(\mathbf{x_1}, \ldots, \mathbf{x_n})$. Ce modèle est apprécié pour sa propriété de généralisation à partir de peu de données.

Ainsi, à partir d'une représentation des questions du test comme des vecteurs de $\R^d$, le problème revient à estimer le vecteur $\theta$ du candidat en fonction des réponses binaires aux questions qu'on lui a posées. 

C'est le modèle MIRT, qui justement cherche à trouver une représentation non supervisée $\Phi(\Theta V) = M$ où $M$ est la matrice binaire des résultats des apprenants à un test.

Le principe est de représenter apprenants et questions par des caractéristiques, des vecteurs de dimension $d$, de façon que pour un apprenant fixé, des questions de caractéristiques proches induisent des motifs de réponse de l'apprenant proches. De façon similaire, pour une question fixée, des utilisateurs de caractéristiques proches auront des motifs de réponse proches. Cette écriture est appelée *représentation distribuée* en apprentissage automatique.

On cherche ainsi à extraire $d$ variables cachées expliquant les motifs de réponse. On peut tenter d'interpréter les dimensions. Le modèle est log-linéaire, donc les poids des vecteurs des apprenants permettent de déterminer à quel point ils sont corrélés aux vecteurs de questions.

<!-- ## Extraction de q-matrice via factorisation de matrices positives

As a recall, non-negative matrix factorization tries to devise matrices with non-negative coefficients $W$ and $Q$ such that the original matrix $M$ verifies $M \simeq WQ^T$. But other matrix factorization techniques can be tried such as sparse PCA [@Zou2006], which tries to devise a factorization under the form $M \simeq WQ^T$ where $Q$ is sparse, the intuition being: only few knowledge components are involved in the resolution of one task. On the datasets we tried, the expert-specified q-matrix fit better than a q-matrix devised automatically using sparse PCA.

Ici on s'intéresse à écrire $M = WH$ où $W$ et $H$ n'ont que des coefficients positifs ou nuls et la norme de Frobenius $||M - WH||$ est minimisée. Ainsi il n'y a pas de compensation entre les composantes et les poids peuvent être facilement interprétés. -->
