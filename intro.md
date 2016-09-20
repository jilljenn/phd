# Tests adaptatifs

La personnalisation de l'enseignement et de l'évaluation est un fort enjeu de notre siècle. Donner la même feuille d'exercices à tous les élèves d'une classe conduit à des situations où certains élèves finissent très vite et demandent d'autres exercices, tandis que d'autres peinent à résoudre un exercice. Il serait plus profitable pour les élèves d'avoir des feuilles d'exercices personnalisées. Mais le travail de piocher des exercices dans une banque de façon à maintenir un certain équilibre pour une unique fiche universelle est déjà difficile pour un professeur, alors concevoir des fiches d'exercices différentes pour chaque étudiant peut sembler insurmontable. Heureusement, les progrès en traitement de l'information rendent cela possible, on voit ainsi aujourd'hui des professeurs d'université distribuer des copies différentes à tous leurs étudiants lors d'un examen [@Zeileis2012], ce qui pose toutefois des questions d'impartialité de l'évaluation. Personnaliser l'évaluation permet également de poser moins de questions à chaque apprenant [@Chang2014], ce qui est d'autant plus utile que les apprenants passent aujourd'hui trop de temps à être testés [@Zernike2015].

Avec l'arrivée des cours en ligne ouverts massifs (MOOC), ce besoin en évaluation adaptative s'est accentué. Des cours de plusieurs universités à travers le monde peuvent être suivis par des centaines de milliers d'étudiants. Mais la pluralité des profils de ces apprenants, notamment leurs âges et parcours, fait qu'il devient crucial d'identifier les connaissances que les apprenants ont accumulées dans le passé, afin de personnaliser leur expérience d'apprentissage et d'aider le professeur à mieux connaître sa classe pour améliorer son cours. Or, répondre à de nombreuses questions d'un test de positionnement au début d'un cours risque de paraître fastidieux pour les apprenants [@Desmarais2012]. Il est alors encouragé de ne poser des questions que lorsque c'est nécessaire, par exemple ne pas poser des questions trop difficiles tant que l'apprenant n'a pas répondu à des questions faciles, et ne pas poser des questions requérant des compétences que l'apprenant semble déjà maîtriser, au vu de ses réponses précédentes [@Chang2014].

Cette réduction du nombre de questions d'un test a été étudiée depuis longtemps en psychométrie. La théorie de la réponse à l'item suppose qu'un faible nombre de variables peut expliquer les réponses d'un étudiant à plusieurs questions, et cherche à déterminer les questions les plus informatives pour dévoiler les facteurs latents de l'étudiant. Cette théorie a ainsi développé des tests *adaptatifs*, qui choisissent la question suivante à poser étant donné la performance passée de l'apprenant. Alors que la théorie de la réponse à l'item remonte aux années 50, ces tests sont aujourd'hui utilisés en pratique par le GMAT, une certification administrée à des centaines de milliers d'étudiants chaque année. Toutefois, les enjeux de ces tests sont davantage liés à l'évaluation qu'à la formation : leur objectif est de mesurer les apprenants afin de leur remettre ou non un certificat, plutôt que de leur faire un retour indiquant les points à retravailler, ce qui leur serait plus utile pour s'améliorer, et également renforcerait leur engagement. Ainsi, les organismes de certification se placent davantage du côté des institutions, qui décident d'une barre d'admissibilité et d'un quota d'entrants, tandis qu'une plateforme de MOOC se place davantage du côté de ses utilisateurs, les apprenants.

On distingue deux types de tests adaptatifs :

- Tests adaptatifs sommatifs, qui mesurent l'apprenant et lui renvoient un simple score ;
- Tests adaptatifs formatifs, qui font un retour utile à l'apprenant afin qu'il puisse s'améliorer, par exemple sous la forme de points à retravailler.

Les tests adaptatifs qui se contentent de mesurer l'apprenant opèrent de façon purement statistique, agnostique du domaine. En revanche, les tests formatifs ont besoin d'une représentation du domaine, par exemple une structure de données faisant le lien entre les questions et les composantes de connaissances impliquées dans leur résolution.

# Filtrage collaboratif

\label{collaborative-filtering}
Comment faire pour avoir une idée du comportement d'un apprenant face à des questions qu'on ne lui a pas posées, en s'aidant des données d'autres apprenants (ayant, eux, répondu à ces questions) ? C'est le problème auquel s'attaquent les techniques de filtrage collaboratif\footnote{Notez que si les questions deviennent \og Est-ce que l'utilisateur $i$ a apprécié le film $j$ ? \fg, on retombe sur les systèmes de recommandation de films.}. Une méthode consiste à déterminer les apprenants ayant un profil similaire afin de s'appuyer sur leur comportement pour faire des déductions.

Également de nos jours, de nombreuses personnes recherchent des ressources d'apprentissage sur Internet. Toutefois ils se retrouvent parfois submergés par un océan de ressources, à partir desquelles il est difficile de faire son choix. Heureusement, à partir seulement des données communiquées par les autres internautes, il est possible de faire le tri de façon automatique pour un nouvel utilisateur, par exemple en identifiant des internautes ayant un profil similaire à celui-ci et en lui suggérant des ressources qui les ont satisfaits.

Il y a dans ce domaine de recherche des objectifs similaires au nôtre : en effet, nous cherchons justement à positionner un nouvel apprenant en fonction des autres en peu de questions, ce qui consiste à faire le tri parmi les questions à poser. Certains services recourent à des tests adaptatifs de façon similaire aujourd'hui, par exemple Facebook suggère à ses utilisateurs des amis à ajouter au moyen de questions de type : « Vous connaissez peut-être… » car la connaissance de certaines personnes implique une forte probabilité d'en connaître d'autres.

En filtrage collaboratif, on imagine que l'on dispose d'utilisateurs ayant noté certains objets : $m_{ui}$ désigne la note que l'utilisateur $u$ affecte à l'objet $i$. La matrice observée $M = (m_{ui})$ est creuse, c'est-à-dire qu'une faible partie de ses entrées est renseignée. Le problème consiste à déterminer les entrées manquantes, par exemple en supposant que la matrice $M$ a un faible rang.

L'historique d'un test peut être représenté par une matrice $M = (m_{ui})$ où l'élément $m_{ui}$ représente 1 si l'apprenant $u$ a réussi la question $i$, 0 sinon. Administrer un test adaptatif à un nouvel apprenant revient à ajouter une ligne dans la matrice et choisir les composantes à révéler (les questions à poser) de façon à inférer les composantes restantes (les questions qui n'ont pas été posées).

\begin{figure}
\includegraphics[width=\linewidth]{figures/cf.jpg}
\caption{Un exemple de problème de filtrage collaboratif appliqué à la complétion de matrice.}
\end{figure}

On peut citer de nombreuses différences : les connaissances évoluent plus vite que les goûts ; il y aura toujours des discordes entre les goûts des utilisateurs, tandis qu'en éducation, on aimerait que tout le monde puisse passer d'un état où il ne répond pas correctement partout à un état où il répond correctement partout.

La plupart des sites marchands peuvent recommander des œuvres étant donné les œuvres précédentes notées par un utilisateur. Ils s'attaquent au problème : étant donné un immense catalogue, comment faire le tri entre ce qui est susceptible de m'intéresser et ce qui risque de ne pas l'être ? On distingue deux types de systèmes de recommandation.

Basés sur le contenu

:   Cela consiste à utiliser de l'information sur les œuvres (descriptions, auteurs, etc.) afin de calculer des valeurs de similarité entre œuvres. À partir de cela, il est possible de recommander à un utilisateur des œuvres similaires à celles qu'il a aimées.

Filtrage collaboratif

:   Cela consiste à utiliser uniquement des informations de notation des œuvres, sous la forme « l'user $i$ a attribué à l'œuvre $j$ la note $r_{ij}$ ». Ces notes peuvent être catégoriques (aimé, pas aimé) ou continues (une note entre 1 et 5 par exemple). On obtient alors une matrice creuse (1 % des valeurs sont renseignées) dont on cherche à deviner les entrées manquantes : ainsi, un motif de réponse d'un utilisateur partiellement rempli pourra être complété afin de déterminer des œuvres susceptibles de lui plaire à partir des autres notes de la communauté. On distingue ici des approches de filtrage collaboratif basées sur les utilisateurs (qui reposent sur des calculs de similarité entre utilisateurs) ou basées sur les œuvres (qui reposent sur des calculs de similarité entre œuvres à partir des notations de la communauté et non de leur contenu).

Calcul de pertinence des recommandations

:   Lorsque les notes sont catégoriques (aimé, pas aimé), habituellement la prédiction revêt la forme d'une probabilité que l'utilisateur aime l'œuvre, et le score est la log-perte. D'autres approches [@Rashid2008] utilisent une fonction d'erreur qui pénalise davantage les faux positifs que les faux négatifs. Lorsque les notes sont continues, on utilise habituellement la RMSE (*root mean square error*).

Lorsqu'un nouvel utilisateur se rend sur un site de recommandation, celui-ci n'a aucune information et doit donc solliciter l'utilisateur afin d'obtenir ces informations : c'est le problème du *démarrage à froid*. Afin que le processus soit efficace, il est préférable de poser un minimum de questions, donc tout l'enjeu est de déterminer des œuvres discriminantes permettant au système d'avoir une idée précise des goûts de l'utilisateur. @Golbandi2011 fait ainsi un arbre de décision qui vise à répartir les utilisateurs dans des groupes au sein desquels la RMSE est faible.

Ce problème du démarrage à froid pour l'utilisateur est analogue à notre problème de choisir les meilleures questions à poser à un apprenant.

Enfin, dans les systèmes de recommandation on cherche à déterminer un ensemble diversifié de recommandations : plutôt que de trier les résultats par pertinence, un moteur de recherche, qui n'est autre qu'un système de recommandation d'URL, a plutôt intérêt à présenter des éléments diversifiés. Si l'on trie par pertinence les résultats associés à la recherche \og jaguar \fg, on risque de se retrouver avec seulement des liens associés à l'animal, ou seulement des liens à la marque de voiture, alors qu'on aimerait pouvoir récapituler les résultats de recherche à ces deux catégories, afin de maximiser les chances que l'internaute trouve ce qu'il recherche.

Ce problème de récapitulation des items pour l'utilisateur est analogue à notre recherche de la réduction des questions à présenter à un apprenant.

# Problèmes

Nous nous sommes intéressés aux problèmes suivants.

- Dans une situation donnée, quel modèle de test adaptatif un enseignant a-t-il intérêt à choisir ? De quelles données un test adaptatif a-t-il besoin pour fonctionner de façon satisfaisante ? Comment valider un modèle de test adaptatif ?

- Peut-on combiner les modèles de tests adaptatifs pour pallier leurs limitations ?

- Si l'intervenant ne peut choisir que $k$ questions du test de façon adaptative ou non adaptative, lesquelles choisir ? Laquelle de ces approches fournit les meilleurs résultats en fonction de $k$ ?

- Comment concevoir des tests adaptatifs sur des MOOC à partir des données d'utilisation ?

# Contributions

## Système de comparaison de tests adaptatifs

Nous avons conçu un framework permettant de comparer la capacité prédictive de plusieurs modèles de tests adaptatifs sur un même jeu de données et l'avons mis en œuvre sur différents jeux de données. Cela a permis de mettre en évidence que selon le type de jeu de données, le meilleur modèle n'est pas le même.

## GenMA, un modèle explicatif plus prédictif

(General Multidimensional Adaptive) La comparaison que nous avons effectuée a permis de mettre en exergue les limitations des différents modèles : par exemple, un modèle plus explicatif réalise des prédictions moins bonnes. Cela nous a permis de proposer un nouveau modèle hybride pour administrer des tests adaptatifs, plus précis car prenant en compte à la fois la difficulté des questions et une représentation des connaissances qu'évalue le test.\nomenclature{GenMA}{\emph{General Multidimensional Adaptive}}

## InitialD, tirer les $k$ premières questions pour démarrer

(Initial Determinant) Certaines critiques ont été apportées concernant le fait d'adapter le processus d'évaluation dès la première question. Une variante des tests adaptatifs nommée tests à étapes multiples consiste à poser plusieurs questions avant d'estimer le niveau de l'apprenant pour minimiser l'erreur du premier diagnostic. Nous proposons une nouvelle approche pour choisir les $k$ premières questions reposant sur une mesure de diversité que l'on retrouve dans les systèmes de recommandation.\nomenclature{InitialD}{\emph{Initial Determinant}}

## Méthodologie de mise un œuvre d'un test adaptatif dans un MOOC

Afin de montrer ce qu'il est possible de faire à partir des données d'un véritable MOOC de Coursera, nous avons mis en pratique les approches proposées.

# Publications

### Poster à EDM 2015

\fullcite{Vie2015}.

### Workshop à EAEI 2015

\fullcite{Vie2015b}.

### Conférence à EC-TEL 2016

\fullcite{Vie2016}.

### Chapitre de journal Springer 2016

\fullcite{Vie2016b}.

### Revue STICEF 2016

\fullcite{Vie2016c}.

### Livre

\fullcite{Durr2016}.
