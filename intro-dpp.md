# Introduction

Jusqu'à présent nous avons considéré des modèles de tests adaptatifs qui présentent des questions une à une. Une variante appelée test à multi-étapes consiste à poser les questions par paquets de $k$, ce qui présente plusieurs avantages :

- les apprenants peuvent vérifier leurs questions avant soumission ;
- à la fin de la première soumission, l'estimation des connaissances sera moins biaisée qu'après avoir posé une seule question (où le risque d'avoir mal interprété la réponse vraie ou fausse du candidat est grand) ;
- poser en une session des questions variées est moins déconcertant que de varier les composantes de connaissances requises à chaque question.

Ainsi que plusieurs inconvénients :

- le processus est alors moins adaptatif (dans le cas extrême où $k$ est le nombre total de questions, on pose toutes les questions en une fois, auquel cas le test redevient un test classique) ;
- la probabilité de guessing devient plus grande car on peut s'aider du contenu des autres questions pour répondre à une question.

Le problème des tests à multi-étapes devient alors de façon combinatoire plus difficile à résoudre : si maximiser une fonction objectif pour un seul élément reste faisable, en revanche itérer sur tous les sous-ensembles de questions à $k$ éléments pour calculer une fonction objectif devient impraticable. On recourt alors généralement à des heuristiques, des algorithmes d'approximation, qui ont une borne de complexité prouvée.

Dans ce chapitre, nous proposons une nouvelle heuristique afin de poser les $k$ toutes premières questions.
