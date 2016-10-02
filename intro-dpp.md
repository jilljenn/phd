# Introduction

\label{initiald}

Notre comparaison de modèles au chapitre précédent a montré que GenMA était le modèle de test adaptatif formatif réduisant le mieux les questions à poser. À présent, nous allons comparer différentes stratégies de choix des questions à poser à un nouvel apprenant.

Jusqu'à présent nous avons considéré des modèles de tests adaptatifs qui présentent des questions à l'apprenant une par une. Une variante consiste à ne commencer à adapter le processus de test que lorsque plusieurs réponses de l'apprenant ont été récoltées. Cela consiste à réduire l'adaptativité du processus pour obtenir en contrepartie plus de précision dans l'estimation des paramètres de l'apprenant. @Chalmers2016 évoque aussi la possibilité de poser un groupe de questions au début du test avant de démarrer le processus adaptatif, et c'est sur ce problème que nous nous concentrons : le choix des toutes premières $k$ questions.

Ce problème est de façon combinatoire plus difficile à résoudre que celui du choix de la question suivante : si maximiser une fonction objectif pour un seul élément reste faisable, en revanche itérer sur tous les sous-ensembles de questions à $k$ éléments pour calculer une fonction objectif devient impraticable. On recourt alors généralement à des heuristiques, des algorithmes d'approximation, qui ont une borne de complexité prouvée.

Dans ce chapitre, nous nous intéressons au choix des $k$ premières questions qui vont nous aider à estimer le niveau de l'apprenant. En guise d'application, on peut imaginer une génération de fiche d'exercices automatique sur un MOOC, à partir d'exercices piochés dans les banques des QCM qui se trouvent déjà dans le MOOC. À noter que l'algorithme que nous présentons n'est pas déterministe : relancer la génération plusieurs fois donnera des planches d'exercices différentes, ce qui est intéressant pour diversifier les questions présentées aux apprenants.

<!-- présenter dans le même paragraphe => intro -->

Nous avons vu au chapitre précédent que les modèles issus de la théorie de réponse à l'item à plusieurs dimensions consistaient à affecter à chaque question un vecteur de caractéristiques indiquant la direction dans laquelle le vecteur mesure le niveau de l'apprenant. Ainsi, des questions ayant des vecteurs proches ont des motifs de réponse proches : comme elles mesurent les mêmes composantes, il y a de fortes chances qu'un apprenant qui parvient à en résoudre une parvienne à résoudre l'autre.

Comme on cherche à résoudre le plus possible le nombre de questions, on a intérêt à choisir des questions ayant des vecteurs peu corrélés deux à deux. Par exemple, si l'on suppose que l'on a trois questions dont les caractéristiques en dimension 2 sont représentées à la figure \ref{vectors}, et qu'on souhaite n'en choisir que deux, il vaut mieux choisir la 1\iere{} et la 3\ieme, afin d'avoir une mesure de l'apprenant la moins redondante possible. Nous présentons dans ce chapitre une méthode pour tirer des questions éloignées les unes des autres, basée sur une loi de probabilité appelée processus à point déterminantal.

\begin{figure}
\centering
\includegraphics{figures/vectors}
\caption{Caractéristiques de trois questions sur deux composantes de connaissances.}
\label{vectors}
\end{figure}

Nous avons ainsi une mesure de ce qui constitue un \og bon \fg{} ensemble de $k$ questions à poser : si le volume de l'espace clos engendré par les vecteurs caractéristiques des questions est grand, l'information apportée par ces questions sur le niveau de l'apprenant sera discriminante sur plusieurs dimensions. Calculer le volume de l'espace engendré par chacun des choix de $k$ vecteurs parmi $n$ a une complexité $O({n \choose k} k^2d + k^3)$, donc c'est impraticable. Mais la formulation du problème que nous proposons dans ce chapitre permet de tirer un bon ensemble, pas nécessairement le meilleur, avec une complexité $O(nk^3)$, permettant l'application de notre approche à de grandes banques de questions.

Dans ce chapitre, nous rappelons le problème du démarrage à froid dans le filtrage collaboratif. Puis nous donnons la définition d'un processus à point déterminantal et expliquons comment notre problème peut s'y ramener. Enfin, nous décrivons notre stratégie de choix des $k$ toutes premières questions appelée InitialD (Initial Determinant) et la validons via un protocole expérimental qui généralise notre méthode décrite à la section \vref{comp-cat}. Sur tous les jeux de données étudiés, InitialD est meilleur que les autres approches connues.
