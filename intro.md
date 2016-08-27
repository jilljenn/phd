# Tests adaptatifs

La personnalisation de l'enseignement et l'évaluation est un fort enjeu. Donner la même feuille d'exercices à tous les élèves d'une classe conduit à des situations où certains élèves finissent très vite et demandent d'autres exercices, tandis que d'autres peinent à résoudre un exercice. Il serait plus profitable pour les élèves d'avoir des feuilles d'exercices personnalisées. Mais le travail de piocher des exercices dans une banque de façon à maintenir un certain équilibre pour une unique fiche universelle est déjà difficile pour un professeur, alors concevoir des fiches d'exercices différentes pour chaque étudiant peut sembler insurmontable. Heureusement, les progrès en traitement de l'information rendent cela possible, on voit ainsi aujourd'hui des professeurs d'université distribuer des copies différentes à tous leurs étudiants lors d'un examen [@Zeileis2012], ce qui pose toutefois des questions d'impartialité de l'évaluation. Personnaliser l'évaluation permet également de poser moins de questions à chaque apprenant [@Chang2014], ce qui est d'autant plus utile que les apprenants passent aujourd'hui trop de temps à être testés [@Zernike2015].

Avec l'arrivée des cours en ligne ouverts massifs (MOOC), ce besoin en évaluation adaptative s'est accentué. Des cours de plusieurs universités à travers le monde peuvent être suivis par des centaines de milliers d'étudiants. Mais la pluralité des profils de ces apprenants, notamment leurs âges et parcours, fait qu'il devient crucial d'identifier les connaissances que les apprenants ont accumulées dans le passé, afin de personnaliser leur expérience d'apprentissage et d'aider le professeur à mieux connaître sa classe pour améliorer son cours. Or, répondre à de nombreuses questions d'un test de positionnement au début d'un cours risque de paraître fastidieux pour les apprenants [@Desmarais2012]. Il est alors encouragé de ne poser des questions que lorsque c'est nécessaire, par exemple ne pas poser des questions trop difficiles tant que l'apprenant n'a pas répondu à des questions faciles, et ne pas poser des questions requérant des compétences que l'apprenant semble déjà maîtriser, au vu de ses réponses précédentes [@Chang2014].

Cette réduction du nombre de questions d'un test a été étudiée depuis longtemps en psychométrie. La théorie de la réponse à l'item suppose qu'un faible nombre de variables peut expliquer les réponses d'un étudiant à plusieurs questions, et cherche à déterminer les questions les plus informatives pour dévoiler les facteurs latents de l'étudiant. Cette théorie a ainsi développé des tests *adaptatifs*, qui choisissent la question suivante à poser étant donné la performance passée de l'apprenant. Alors que la théorie de la réponse à l'item remonte aux années 50, ces tests sont aujourd'hui utilisés en pratique par le GMAT, une certification administrée à des centaines de milliers d'étudiants chaque année. Toutefois, les enjeux de ces tests sont davantage liés à l'évaluation qu'à la formation : leur objectif est de mesurer les apprenants afin de leur remettre ou non un certificat, plutôt que de leur renvoyer un feedback indiquant les points à retravailler, ce qui leur serait plus utile pour s'améliorer, et également renforcerait leur engagement. Ainsi, les organismes de certification se placent davantage du côté des institutions, qui décident d'une barre d'admissibilité et d'un quota d'entrants, tandis qu'une plateforme de MOOC se place davantage du côté de ses utilisateurs.

On distingue deux types de tests adaptatifs :

- Tests adaptatifs sommatifs, qui mesurent l'apprenant ;
- Tests adaptatifs formatifs, qui font un retour utile à l'apprenant afin qu'il puisse s'améliorer.

Les tests adaptatifs qui se contentent de mesurer l'apprenant opèrent de façon purement statistique, agnostique du domaine. En revanche, les tests formatifs ont besoin d'une représentation du domaine, par exemple une structure de données faisant le lien entre les questions et les composantes de connaissances impliquées dans leur résolution.

# Filtrage collaboratif

Comment faire pour avoir une idée du comportement d'un apprenant face à des questions qu'on ne lui a pas posées, en s'aidant des données d'autres apprenants (ayant, eux, répondu à ces questions) ? C'est le problème auquel s'attaquent les techniques de filtrage collaboratif\footnote{Notez que si les questions deviennent \og Est-ce que l'utilisateur $i$ a apprécié le film $j$ ? \fg, on retombe sur les systèmes de recommandation de films.}. Une méthode consiste à déterminer les apprenants ayant un profil similaire afin de s'appuyer sur leur comportement pour faire des déductions.

Également de nos jours, de nombreuses personnes se rendent sur des sites Internet pour découvrir de nouvelles choses. Toutefois ils se retrouvent parfois submergés par un océan de ressources, à partir desquelles il est difficile de faire son choix. Heureusement, à partir seulement des données communiquées par les autres internautes, il est possible de faire le tri de façon automatique pour un nouvel utilisateur, par exemple en identifiant des internautes ayant un profil similaire à celui-ci et en lui suggérant des ressources qui les ont satisfaits.

Il y a dans ce domaine de recherche des objectifs similaires au nôtre : en effet, nous cherchons justement à positionner un nouvel apprenant en fonction des autres en peu de questions, ce qui consiste à faire le tri parmi les questions à poser. Certains services recourent à des tests adaptatifs de façon similaire aujourd'hui, par exemple Facebook suggère à ses utilisateurs des amis à ajouter au moyen de questions de type : « Vous connaissez peut-être… » car la connaissance de certaines personnes implique une forte probabilité d'en connaître d'autres.

En filtrage collaboratif, on imagine que l'on dispose d'utilisateurs ayant noté certains objets : $m_{ui}$ désigne la note que l'utilisateur $u$ affecte à l'objet $i$. La matrice observée $M = (m_{ui})$ est creuse, c'est-à-dire qu'une faible partie de ses entrées est renseignée. Le problème consiste à déterminer les entrées manquantes, par exemple en supposant que la matrice $M$ a un faible rang.

L'historique d'un test peut être représenté par une matrice $M = (m_{ui})$ où l'élément $m_{ui}$ représente 1 si l'apprenant $u$ a réussi la question $i$, 0 sinon. Administrer un test adaptatif à un nouvel apprenant revient à ajouter une ligne dans la matrice et choisir les composantes à révéler (les questions à poser) de façon à inférer les composantes restantes.

# Problèmes

- Dans une situation donnée, quel modèle de test adaptatif un enseignant peut-il choisir ? De quelles données un test adaptatif a-t-il besoin pour fonctionner de façon satisfaisante ? Comment valider un modèle de test adaptatif ?

- Quelles sont les limitations de ces tests et comment y remédier ?

- Comment conserver la confidentialité des apprenants ?

# Contributions

## Framework de comparaison de tests adaptatifs

Nous avons conçu un framework permettant de comparer la capacité prédictive de plusieurs modèles de tests adaptatifs sur un même jeu de données et l'avons mis en œuvre sur différents jeux de données. Cela a permis de mettre en évidence que selon le type de jeu de données, le meilleur modèle n'est pas le même.

## GenMA, un modèle explicatif plus prédictif

(General Multidimensional Adaptive) La comparaison que nous avons effectuée a permis de mettre en exergue les limitations des différents modèles : par exemple, un modèle plus explicatif réalise des prédictions moins bonnes. Cela nous a permis de proposer un nouveau modèle hybride pour administrer des tests adaptatifs, plus précis car prenant en compte à la fois la difficulté des questions et une représentation des connaissances qu'évalue le test.

## InitialD, tirer les $k$ premières questions pour démarrer

(Initial Determinant) Certaines critiques ont été apportées concernant le fait d'adapter le processus d'évaluation dès la première question. Une variante des tests adaptatifs nommée tests à étapes multiples consiste à poser plusieurs questions avant d'estimer le niveau de l'apprenant pour minimiser l'erreur du premier diagnostic. Nous proposons une nouvelle approche pour choisir les $k$ premières questions  reposant sur une mesure de diversité que l'on retrouve dans les systèmes de recommandation.

## Méthodologie de mise un œuvre d'un test adaptatif dans un MOOC

Afin de montrer ce qu'il est possible de faire à partir des données d'un véritable MOOC de Coursera, nous avons mis en pratique les approches proposées.

# Publications

- Conférence à LATINCRYPT 2012 @Abdalla2012
- Poster à EDM 2015 @Vie2015
- Workshop à EAEI 2015 @Vie2015b
- Conférence à EC-TEL 2016 @Vie2016
- Chapitre de journal Springer 2016 @Vie2016b
- Revue STICEF 2016 @Vie2016c
- Livre @Durr2016
