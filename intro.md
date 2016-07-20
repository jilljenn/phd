# Tests adaptatifs

De nos jours, de nombreuses personnes se rendent sur des sites Internet pour apprendre de nouvelles choses. C'est devenu plus facile que jamais avec l'arrivée des cours en ligne massifs sur des plateformes fermées comme Coursera (Stanford) ou open source comme edX (Harvard, MIT), qui permettent de faire cours à plusieurs dizaines de milliers de personnes à la fois. Mais la pluralité des profils, notamment leurs âges, fait qu'il est crucial d'identifier les connaissances que les apprenants ont accumulées dans le passé, afin de personnaliser leur expérience d'apprentissage. Or, répondre à de nombreuses questions d'un test de positionnement au début d'un cours risque de paraître fastidieux pour les apprenants. Il est alors encouragé de ne poser des questions que lorsque c'est nécessaire, par exemple ne pas poser des questions trop difficiles tant que l'apprenant n'a pas répondu à des questions faciles, et ne pas poser des questions requérant des compétences que l'apprenant semble déjà maîtriser, au vu de ses réponses précédentes.

S'efforcer à poser des questions informatives n'est pas un sujet nouveau de recherche. De tels tests, dits *adaptatifs*, choisissent la question suivante à poser étant donné la performance passée de l'apprenant. Alors que la théorie de la réponse à l'item remonte aux années 50, ces tests sont aujourd'hui utilisés en pratique par le GMAT. Toutefois, les enjeux de ces tests sont le plus souvent de mesurer les apprenants afin de leur remettre ou non un certificat, plutôt que de leur renvoyer un feedback indiquant les points à retravailler, ce qui leur serait plus utile.

On distingue alors deux types de tests adaptatifs :

- Tests adaptatifs sommatifs, qui mesurent l'apprenant
- Tests adaptatifs formatifs, qui font un retour utile à l'apprenant afin qu'il puisse s'améliorer

Les tests adaptatifs qui se contentent de mesurer l'apprenant opèrent de façon purement statistique, agnostique du domaine. En revanche, les tests formatifs ont besoin d'une représentation du domaine, par exemple une structure de données faisant le lien entre les questions et les composantes de connaissances impliquées dans leur résolution.

# Filtrage collaboratif

Également de nos jours, de nombreuses personnes se rendent sur des sites Internet pour découvrir de nouvelles choses. Toutefois ils se retrouvent parfois submergés par un océan de ressources, à partir desquelles il est difficile de faire son choix. Heureusement, à partir des données communiquées par les autres internautes, il est possible de faire le tri de façon automatique pour un nouvel utilisateur, par exemple en identifiant des internautes ayant un profil similaire à celui-ci et en lui suggérant des ressources qui les ont satisfaits.

Il y a dans ce domaine de recherche des objectifs similaires au nôtre : en effet, nous cherchons justement à positionner un nouvel apprenant en fonction des autres en peu de questions, ce qui consiste à faire le tri parmi les questions à poser. Certains services recourent à des tests adaptatifs de façon similaire aujourd'hui, par exemple Facebook suggère à ses utilisateurs des amis à ajouter au moyen de questions de type : « Vous connaissez peut-être… »

# Problèmes

- Dans une situation donnée, quel modèle de test adaptatif un enseignant peut-il choisir ? De quelles données un test adaptatif a-t-il besoin pour fonctionner de façon satisfaisante ? Comment valider un modèle de test adaptatif ?

- Quelles sont les limitations de ces tests et comment les contourner ?

# Contributions

Framework de comparaison de tests adaptatifs

:	Nous avons conçu un framework permettant de comparer la capacité prédictive de plusieurs modèles de tests adaptatifs sur un même jeu de données et l'avons mis en œuvre sur différents jeux de données. Cela a permis de mettre en évidence que selon le type de jeu de données, le meilleur modèle n'est pas le même.

GenMA, un modèle explicatif plus prédictif

:	(General Multidimensional Adaptive) La comparaison que nous avons effectuée a permis de mettre en exergue les limitations des différents modèles : par exemple, un modèle plus explicatif réalise des prédictions moins bonnes. Cela nous a permis de proposer un nouveau modèle hybride pour administrer des tests adaptatifs, plus précis car prenant en compte à la fois la difficulté des questions et une représentation des connaissances qu'évalue le test.

InitialD, une manière de poser les $k$ premières questions

:	(Initial Determinant) Une variante des tests adaptatifs nommée tests à étapes multiples consiste à poser les questions par groupes de $k$, de façon à minimiser le biais de la première estimation. Nous proposons une nouvelle approche reposant sur une mesure de diversité que l'on retrouve dans les systèmes de recommandation.

Méthodologie de mise un œuvre d'un test adaptatif dans un MOOC

:	Afin de montrer ce qu'il est possible de faire à partir des données d'un véritable MOOC de Coursera, nous avons mis en pratique les approches proposées.
