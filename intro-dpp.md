# Introduction

\label{initiald}

Jusqu'à présent nous avons considéré des modèles de tests adaptatifs qui présentent des questions à l'apprenant une par une. Une variante appelée *test à étapes multiples* consiste à poser les questions par paquets de $k$, ce qui consiste à réduire l'adaptativité pour obtenir en contrepartie plus de précision dans l'estimation des paramètres de l'apprenant. @Chalmers2016 évoque aussi la possibilité de poser un groupe de questions au début du test avant de démarrer le processus adaptatif, et c'est sur ce problème que nous nous concentrons : le choix des toutes premières $k$ questions.

Ce problème est de façon combinatoire plus difficile à résoudre que celui du choix de la question suivante : si maximiser une fonction objectif pour un seul élément reste faisable, en revanche itérer sur tous les sous-ensembles de questions à $k$ éléments pour calculer une fonction objectif devient impraticable. On recourt alors généralement à des heuristiques, des algorithmes d'approximation, qui ont une borne de complexité prouvée.

Dans ce chapitre, nous nous intéressons au choix des $k$ premières questions qui vont aider à estimer le niveau de l'apprenant. En guise d'application, on peut imaginer une génération de planche d'exercices automatique sur un MOOC, à partir d'exercices piochés dans les banques des QCM qui se trouvent déjà dans le MOOC. À noter que l'algorithme que nous présentons n'est pas déterministe : relancer la génération plusieurs fois donnera des planches d'exercices différentes, ce qui est intéressant pour diversifier les questions présentées aux apprenants.

<!-- présenter dans le même paragraphe => intro -->

Nous présentons d'abord une intuition sur la manière dont nous allons nous y prendre. Nous avons vu au chapitre précédent que les modèles de théorie de réponse à l'item à plusieurs dimensions consistaient à affecter à chaque question un vecteur de caractéristiques de sorte que la question mesure le niveau multidimensionnel de l'apprenant dans la direction de ce vecteur. Ainsi, chaque question donne de l'information sur l'apprenant dans sa direction, et des questions proches ont des motifs de réponse proches. Par exemple, si l'on suppose que l'on a en dimension 2 les trois questions suivantes représentées à la figure \ref{vectors}, il vaut mieux choisir des questions éloignées donc la première et la troisième. Nous présentons dans ce chapitre une façon de pouvoir tirer des questions éloignées les unes des autres, appelée processus à point déterminantal.

\begin{figure}
\centering
\includegraphics{figures/vectors}
\caption{Trois questions en dimension 2 ; s'il ne faut en choisir que 2, on a intérêt à prendre la 1\iere{} et la 3\ieme{} afin d'avoir un ensemble le moins redondant possible.}
\label{vectors}
\end{figure}

Nous avons ainsi une mesure de ce qui constitue un \og bon \fg{} ensemble de $k$ questions : si le volume de l'espace clos engendré par les vecteurs est grand, l'information apportée sera selon plusieurs dimensions. Calculer le volume de l'espace engendré par $k$ vecteurs a une complexité $O(k^2d + k^3)$, donc il est proscrit de calculer cette valeur pour chacun des $n \choose k$ ensembles de $k$ questions parmi les $n$ possibles. Mais notre formulation du problème permet de tirer un bon ensemble, pas nécessairement le meilleur, avec une complexité $O(nk^3)$, permettant la généralisation de notre problème à de grandes banques de questions.

Dans ce chapitre, nous rappelons le problème du démarrage à froid dans le filtrage collaboratif. Puis nous donnons la définition d'un processus à point déterminantal et expliquons comment notre problème peut s'y ramener. Enfin, nous décrivons notre stratégie de choix des $k$ toutes premières questions appelée InitialD (Initial Determinant) et la validons via un protocole expérimental qui généralise notre méthode décrite à la section \vref{comp-cat}. Sur tous les jeux de données étudiés, InitialD est meilleur que les autres approches connues.
