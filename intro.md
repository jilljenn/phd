# Tests adaptatifs

De nos jours, les gens se rendent sur des plateformes pour apprendre de nouvelles choses. Ainsi, les cours en ligne massifs permettent de faire cours à plusieurs dizaines de milliers de personnes à la fois. Mais la pluralité des profils, notamment leurs âges, fait qu'il est crucial d'identifier les connaissances que les apprenants ont accumulées dans le passé, afin de personnaliser leur expérience d'apprentissage. Or, répondre à de nombreuses questions d'un test au début d'un cours risque de paraître fastidieux pour les apprenants. Il est alors encouragé de ne poser des questions que lorsque c'est nécessaire.

S'efforcer à poser des questions informatives n'est pas un sujet nouveau de recherche. De tels tests, dits *adaptatifs*, choisissent la question suivante à poser étant donné la performance passée de l'apprenant. Alors que la théorie de la réponse à l'item remonte aux années 50, ces tests sont aujourd'hui utilisés en pratique par le GMAT. Toutefois, les enjeux de ces tests sont le plus souvent de mesurer les apprenants afin de leur remettre ou non un certificat, plutôt que de leur renvoyer un feedback indiquant les points à retravailler, ce qui leur serait plus utile.

On distingue alors deux types de tests adaptatifs :

- Tests adaptatifs sommatifs, qui mesurent l'apprenant
- Tests adaptatifs formatifs, qui font un retour utile à l'apprenant afin qu'il puisse s'améliorer

# Problèmes

- Dans une situation donnée, quel test adaptatif un enseignant peut-il choisir ? De quelles données un test adaptatif a-t-il besoin pour fonctionner de façon satisfaisante ? Comment valider un modèle de test adaptatif ?

- Quelles sont les limitations de ces tests et comment les contourner ?

# Contributions

Framework de comparaison de tests adaptatifs

:	Nous avons conçu un framework permettant de comparer la capacité prédictive de plusieurs modèles de tests adaptatifs sur un même jeu de données et l'avons mis en œuvre sur différents jeux de données. Cela a permis de mettre en évidence que selon le jeu de données, le meilleur modèle n'est pas le même.

GenMA, un modèle explicatif plus prédictif

:	La comparaison que nous avons effectuée a permis de mettre en exergue les limitations des différents modèles : par exemple, un modèle plus explicatif réalise des prédictions moins bonnes. Cela nous a permis de proposer un nouveau modèle hybride pour administrer des tests adaptatifs, plus précis car prenant en compte à la fois la difficulté des questions et une représentation des connaissances qu'évalue le test.

InitialD, une manière de poser les $k$ premières questions

:	Une variante des tests adaptatifs nommée tests à étapes multiples consiste à poser les questions par groupes de $k$, de façon à minimiser le biais de la première estimation. Nous proposons une nouvelle approche reposant sur une mesure de diversité que l'on retrouve dans les systèmes de recommandation.

Méthodologie de mise un œuvre d'un test adaptatif dans un MOOC

:	Afin de montrer ce qu'il est possible de faire à partir des données d'un véritable MOOC de Coursera, nous avons mis en pratique les approches proposées.
