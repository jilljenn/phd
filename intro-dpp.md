# Introduction

\label{initiald}

Jusqu'à présent nous avons considéré des modèles de tests adaptatifs qui présentent des questions à l'apprenant une par une. Une variante appelée test à étapes multiples consiste à poser les questions par paquets de $k$, ce qui consiste à réduire l'adaptativité pour obtenir plus de précision en contrepartie. @Chalmers2016 évoque aussi la possibilité de poser un groupe de questions avant de démarrer le processus adaptatif.

Le problème des tests à étapes multiples est de façon combinatoire plus difficile à résoudre : si maximiser une fonction objectif pour un seul élément reste faisable, en revanche itérer sur tous les sous-ensembles de questions à $k$ éléments pour calculer une fonction objectif devient impraticable. On recourt alors généralement à des heuristiques, des algorithmes d'approximation, qui ont une borne de complexité prouvée.

Dans ce chapitre, nous nous intéressons au choix des $k$ premières questions qui vont aider à estimer le niveau de l'apprenant. En guise d'application, on peut imaginer une génération de planche d'exercices automatique sur un MOOC. À noter qu'ici, notre algorithme n'est pas déterministe : relancer la génération plusieurs fois donnera des planches d'exercices différentes, ce qui est intéressant pour diversifier la banque des premières questions présentées aux apprenants.

Nous présentons d'abord une intuition sur la manière dont nous allons nous y prendre. Nous avons vu au chapitre précédent que les modèles de théorie de réponse à l'item à plusieurs dimensions consistaient à affecter à chaque question un vecteur de caractéristiques tel que des questions proches aient des motifs de réponse proches. Ainsi, si l'on suppose que l'on a en dimension 2 les trois questions suivantes représentées à la figure \ref{vectors}, il vaut mieux choisir des questions éloignées donc la première et la troisième. Nous présentons dans ce chapitre une façon de pouvoir tirer des questions éloignées les unes des autres, appelée processus à point déterminantal.

\begin{figure}
\includegraphics{figures/vectors}
\caption{Trois questions en dimension 2 ; s'il ne faut en choisir que 2, on a intérêt à prendre la 1\iere{} et la 3\ieme{} afin d'avoir un ensemble le moins redondant possible.}
\label{vectors}
\end{figure}
