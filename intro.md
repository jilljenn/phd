# Évaluation adaptative à grande échelle

La personnalisation de l'enseignement et de l'évaluation est un fort enjeu de notre siècle. Donner la même feuille d'exercices à tous les élèves d'une classe conduit à des situations où certains élèves finissent très vite et demandent d'autres exercices, tandis que d'autres peinent à résoudre un exercice. Il serait plus profitable pour les élèves d'avoir des feuilles d'exercices personnalisées. Mais le travail consistant à piocher des exercices dans une banque de façon à maintenir un certain équilibre pour une unique feuille universelle est déjà difficile pour un professeur, alors concevoir des feuilles d'exercices différentes pour chaque étudiant peut sembler complexe à gérer. Heureusement, les progrès en traitement de l'information rendent cela possible. On voit ainsi aujourd'hui des professeurs d'université distribuer des énoncés différents à tous leurs étudiants lors d'un examen [@Zeileis2012], ce qui pose toutefois des questions d'impartialité de l'évaluation. Personnaliser l'évaluation permet également de poser moins de questions à chaque apprenant [@Chang2014], ce qui est d'autant plus utile que les apprenants passent aujourd'hui trop de temps à être testés [@Zernike2015].

Avec l'arrivée des cours en ligne ouverts massifs (MOOC), ce besoin en évaluation adaptative s'est accentué. Des cours de nombreuses universités à travers le monde peuvent être suivis par des centaines de milliers d'étudiants. Mais la pluralité des profils de ces apprenants, notamment leurs âges et leurs parcours, fait qu'il devient crucial d'identifier les connaissances que les apprenants ont accumulées dans le passé, afin de personnaliser leur expérience d'apprentissage et d'aider le professeur à mieux connaître sa classe pour améliorer son cours. Or, répondre à de nombreuses questions d'un test de positionnement au début d'un cours risque de paraître fastidieux pour les apprenants [@Desmarais2012]. Il est alors encouragé de ne poser des questions que lorsque c'est nécessaire, par exemple ne pas poser des questions trop difficiles tant que l'apprenant n'a pas répondu à des questions faciles, et ne pas poser des questions requérant des compétences que l'apprenant semble déjà maîtriser, au vu de ses réponses précédentes [@Chang2014].

Cette réduction du nombre de questions d'un test a été étudiée depuis longtemps en psychométrie. La théorie de la réponse à l'item suppose qu'un faible nombre de variables peut expliquer les réponses d'un étudiant à plusieurs questions, et cherche à déterminer les questions les plus informatives pour dévoiler les facteurs latents de l'étudiant [@Hambleton1985]. Cette théorie a ainsi permis de développer des modèles de tests *adaptatifs*, qui posent une question à un apprenant, évaluent sa réponse et choisissent en fonction de celle-ci la question suivante à lui poser. Alors que la théorie de la réponse à l'item remonte aux années 50, ces tests sont aujourd'hui utilisés en pratique par le GMAT, une certification administrée à des centaines de milliers d'étudiants chaque année. Toutefois, les enjeux de ces tests sont davantage liés à l'évaluation qu'à la formation : leur objectif est de mesurer les apprenants afin de leur remettre ou non un certificat, plutôt que de leur faire un retour sur leur lacunes. Un tel retour leur serait plus utile pour s'améliorer, et également renforcerait leur engagement. Ainsi, les organismes de certification se placent davantage du côté des institutions, qui décident d'une barre d'admissibilité et d'un quota d'entrants, tandis qu'une plateforme de MOOC se place davantage du côté de ses utilisateurs, les apprenants.

# Diagnostic de connaissances

On distingue deux types de tests adaptatifs. Des tests adaptatifs *sommatifs* mesurent l'apprenant et lui renvoient un simple score, tandis que des tests adaptatifs *formatifs* font un diagnostic des connaissances de l'apprenant afin qu'il puisse s'améliorer, par exemple sous la forme de points à retravailler.

Les tests adaptatifs qui se contentent de mesurer l'apprenant opèrent de façon purement statistique, agnostique du domaine. En revanche, les tests formatifs ont besoin d'une représentation du domaine qui fait le lien entre les questions et les composantes de connaissances impliquées dans leur résolution.

Dans cette thèse, nous avons répertorié des modèles de tests adaptatifs issus de différents pans de la littérature. Nous les avons comparés de façon qualitative et quantitative. Nous avons donc proposé un protocole expérimental, que nous avons implémenté pour comparer les principaux modèles de tests adaptatifs sur plusieurs jeux de données réelles. Cela nous a amenés à proposer un modèle hybride de diagnostic de connaissances adaptatif. Enfin, nous avons élaboré une stratégie pour poser plusieurs questions au tout début du test afin de réaliser une meilleure première estimation des connaissances de l'apprenant.

Nous avons souhaité adopter un point de vue venant de l'apprentissage automatique, plus précisément du filtrage collaboratif, pour attaquer le problème du choix des questions à poser pour réaliser un diagnostic. En filtrage collaboratif, on se demande comment s'aider d'une communauté active pour avoir une idée des préférences d'un utilisateur en fonction des préférences des autres utilisateurs. En évaluation adaptative, on se demande comment s'aider d'un historique de passage d'un test pour avoir une idée de la performance d'un utilisateur en fonction de la performance des autres utilisateurs. Il n'est pas question ici de faire un analogue direct entre l'apprentissage et la consommation de culture, mais plutôt de s'inspirer des techniques étudiées dans cet autre domaine : il est indéniable que les plateformes de consommation de biens culturels sont davantage préparées que les MOOC à recevoir des milliers d'utilisateurs, traiter les grandes quantités de données qu'ils récoltent et adapter leur contenu en conséquence. Ainsi, les algorithmes qu'on y retrouve ne reposent pas seulement sur une solide théorie statistique mais également sur un souci de mise en pratique efficace en grande dimension.

<!-- ## Comparaison de méthodes par validation croisée

Une question récurrente est de savoir comment comparer deux algorithmes de filtrage collaboratif. La méthode de *validation croisée* consiste à séparer les notes dont on dispose en deux parties : notes d'entraînement et de test, et de tenter de prédire les notes de test à partir des notes d'entraînement. Ainsi, les notes de test ne sont considérées que pour l'évaluation des algorithmes. Dans cette thèse, nous appliquons cette méthode à l'évaluation de modèles de tests adaptatifs.

## Démarrage à froid

Lorsqu'un nouvel utilisateur se rend sur un site de recommandation, le système n'a aucune information sur ses goûts et doit donc solliciter l'utilisateur afin d'obtenir ces informations : c'est le problème du *démarrage à froid* de l'utilisateur. Afin que le processus soit efficace, il est préférable de poser un minimum de questions, donc tout l'enjeu est de déterminer des œuvres discriminantes permettant au système d'avoir une idée précise des goûts de l'utilisateur. @Golbandi2011 construit ainsi un arbre de décision qui vise à répartir les utilisateurs dans des groupes au sein desquels le taux d'erreur des prédictions est faible. Il est également possible d'incorporer des informations supplémentaires sur les produits (descriptions, auteurs, thèmes, etc.) afin de calculer des valeurs de similarité entre œuvres et pouvoir déterminer par inférence des œuvres susceptibles de plaire à l'utilisateur.

Ce problème du démarrage à froid pour l'utilisateur est analogue à notre problème de choisir les meilleures questions à poser à un apprenant.

## Obtenir des recommandations diversifiées

Enfin, dans les systèmes de recommandation on cherche parfois à déterminer un ensemble diversifié de recommandations : plutôt que de trier les résultats par pertinence, un moteur de recherche, qui n'est autre qu'un système de recommandation de pages Web, a plutôt intérêt à présenter des éléments diversifiés. Si l'on trie par pertinence les résultats associés à la recherche \og jaguar \fg, on risque de se retrouver avec seulement des liens associés à l'animal, ou seulement des liens à la marque de voiture, alors qu'on aimerait pouvoir récapituler les résultats de recherche à ces deux catégories, afin de maximiser les chances que l'internaute trouve ce qu'il recherche.

Ce problème de récapitulation des items pour l'utilisateur est analogue à notre recherche de la réduction du nombre des questions à présenter à un apprenant. -->

# Problèmes

Dans cette thèse, nous nous sommes intéressés aux problèmes suivants liés aux modèles de tests adaptatifs.

### Réduction du nombre de questions d'un test

Si un intervenant ne peut poser que $k$ questions d'une banque de $n$ questions (où $k < n$) à un apprenant, lesquelles choisir ? Pour ce problème, nous avons considéré différents modèles de tests adaptatifs ainsi que différentes stratégies du choix des premières questions. Laquelle de ces approches fournit les meilleurs résultats en fonction de $k$ ?

### Méthodologie de comparaison de modèles

Comment comparer des modèles de tests adaptatifs différents sur un même jeu de données ? Quels critères considérer pour la comparaison ? Quels sont les avantages et limitations des modèles de tests adaptatifs ?

Également, comment comparer différentes stratégies de choix d'un ensemble de questions ?

### Méthodologie de choix de modèles

Dans une situation donnée, en fonction des données dont un intervenant dispose et de ses objectifs, quel modèle de test adaptatif a-t-il intérêt à choisir ?

### Élaboration d'un test adaptatif dans un MOOC

Dans le cas pratique d'une utilisation d'un test adaptatif dans un MOOC, comment pourrait-on procéder ?

# Contributions

## Hypothèses

Dans le cadre de cette thèse, nous avons considéré que les réponses de l'apprenant pouvaient être correctes ou incorrectes, c'est-à-dire qu'ils produisent des *motifs de réponse dichotomiques*. Ce cadre nous a permis d'analyser des données issues de différents environnements éducatifs : des tests standardisés, des plateformes de jeux sérieux ou des MOOC.

Afin de pouvoir mener nos expériences sur des données de test existantes, nous avons fait la supposition que le niveau de l'apprenant n'évolue pas pendant qu'il passe le test. Aussi nous supposons que l'apprenant répondra de la même façon indépendamment de l'ordre dans lequel nous posons les questions. Celles-ci doivent donc être localement indépendantes. Nous ne supposons aucun profil de l'apprenant autre que ses réponses aux questions posées, ce qui nous permet de proposer des tests anonymes.

## Système de comparaison de tests adaptatifs

Nous avons identifié plusieurs modèles de tests adaptatifs et les avons comparés selon plusieurs angles qualitatifs :

- capacité à mesurer plusieurs dimensions ;
- capacité à faire un retour à l'apprenant utile pour qu'il puisse s'améliorer ;
- capacité à expliquer ses propres déductions ; 
- besoin de données d'entraînement ou non pour faire fonctionner le test.
- complexité en temps et mémoire pour l'entraînement des modèles ;

Nous les avons également comparés selon plusieurs angles quantitatifs :

- capacité à requérir peu de questions de l'utilisateur pour converger vers un diagnostic ;
- capacité à avoir un diagnostic vraisemblable.

Ce cadre nous a permis d'évaluer des modèles de tests adaptatifs sur plusieurs jeux de données réelles :

- un test multidisciplinaire SAT
- un examen d'anglais ECPE
- un test de soustraction de fractions
- un test standardisé de mathématiques
- un concours d'initiation à l'informatique Castor
- les données d'un MOOC de Coursera

Le protocole expérimental que nous avons conçu est générique : il s'appuie sur les composants que l'on retrouve dans tous les modèles de tests adaptatifs, et peut ainsi être mis en œuvre pour de nouveaux modèles, et de nouveaux jeux de données.

Cette analyse nous a permis de faire un état de l'art interdisciplinaire des modèles de tests adaptatifs récents et de concevoir une méthodologie pour étudier les modèles de tests adaptatifs. Nous avons ainsi pu mettre en évidence que selon le type de test, le meilleur modèle n'est pas le même, et de proposer les deux contributions suivantes.

## GenMA, un modèle explicatif plus prédictif

(General Multidimensional Adaptive) La comparaison que nous avons effectuée a permis de mettre en exergue les limitations des différents modèles : par exemple, un modèle plus explicatif réalise des prédictions moins bonnes. Cela nous a permis de proposer un nouveau modèle hybride pour administrer des tests adaptatifs, plus précis car prenant en compte à la fois la difficulté des questions et une représentation des connaissances qu'évalue le test.\nomenclature{GenMA}{\emph{General Multidimensional Adaptive}}

Certains modèles plus explicatifs sont moins prédictifs. Dans ce chapitre, nous proposons un modèle hybride qui mesure à la fois le niveau de l'apprenant et son degré de maîtrise selon plusieurs composantes de connaissances, afin de lui renvoyer un retour utile pour s'améliorer. Ce modèle est un cas particulier de modèle de théorie de réponse à l'item multidimensionnelle, mais il est plus rapide à calibrer car le nombre de paramètres à déterminer est réduit.

GenMA est meilleur que le modèle existant de diagnostic cognitif sur tous les jeux de données étudiés. Il a été présenté à la conférence EC-TEL 2016.

## InitialD, tirer les $k$ premières questions pour démarrer

(Initial Determinant) Adapter le processus d'évaluation dès la première question peut conduire à des estimations biaisées du niveau de l'apprenant, car celui-ci peut faire des fautes d'inattention ou deviner la bonne réponse. Une variante des tests adaptatifs nommée tests à étapes multiples consiste à poser plusieurs questions avant d'estimer le niveau de l'apprenant pour minimiser l'erreur du premier diagnostic. Nous proposons une nouvelle approche pour choisir les $k$ premières questions reposant sur une mesure de diversité que l'on retrouve dans les systèmes de recommandation.\nomenclature{InitialD}{\emph{Initial Determinant}}

Avant de démarrer le processus adaptatif, on peut faire un test préalable où l'on choisit un groupe de questions diversifiées pour récolter beaucoup d'information en une seule étape. Nous proposons dans ce chapitre un algorithme de récapitulation basé sur un processus à point déterminantal afin de ne conserver qu'un sous-ensemble de questions du test qui soit informatif, c'est-à-dire qui \og résume \fg{} bien l'ensemble des questions.

Nous montrons ainsi que l'adaptation a elle-même ses limites, puisque parfois poser un petit groupe de $k$ questions est plus informatif pour le modèle de test adaptatif que poser $k$ questions une par une, de façon adaptative.

<!-- ## Méthodologie de mise un œuvre d'un test adaptatif dans un MOOC

Afin de montrer ce qu'il est possible de faire à partir des données d'un véritable MOOC, nous avons mis en pratique les approches proposées, et l'avons illustré par une simulation d'un test adaptatif sur les données d'un MOOC de Coursera. -->

# Publications

### Poster à EDM 2015

Jill-Jênn Vie, Fabrice Popineau, Éric Bruillard et Yolaine Bourda (2015a). "Predicting Performance over Dichotomous Questions : Comparing Models for Large-Scale Adaptive Testing". In : *8th International Conference on Educational Data Mining (EDM 2015)*.

### Workshop EAEI 2015 à EIAH 2015

Jill-Jênn Vie, Fabrice Popineau, Jean-Bastien Grill, Éric Bruillard et Yolaine Bourda (2015b). "Prédiction de performance sur des questions dichotomiques : comparaison de modèles pour des tests adaptatifs à grande échelle". In : *Atelier Évaluation des Apprentissages et Environnements Informatiques, EIAH 2015*.

### Conférence à EC-TEL 2016

Jill-Jênn Vie, Fabrice Popineau, Yolaine Bourda et Éric Bruillard (2016b). "Adaptive Testing Using a General Diagnostic Model". In : *European Conference on Technology Enhanced Learning*. Springer, p. 331--339.

### Chapitre de journal Springer 2016

Jill-Jênn Vie, Fabrice Popineau, Éric Bruillard et Yolaine Bourda (2016a). "A review of recent advances in adaptive assessment". In : *Learning analytics: Fundaments, applications, and trends: A view of the current state of the art*. Springer, in press.

### Revue STICEF 2016

Jill-Jênn Vie, Fabrice Popineau, Éric Bruillard et Yolaine Bourda (2016). "Utilisation de tests adaptatifs dans les MOOC dans un cadre de crowdsourcing". In : STICEF, in review.

# Plan

Cette thèse est construite comme suit. Dans le chapitre 1, nous introduisons les tests adaptatifs et les techniques d'apprentissage automatique dont nous nous sommes inspirés, ainsi que les problèmes auxquels nous nous sommes attaqués et les contributions que nous avons proposées.

Dans le chapitre 2, nous décrivons les différents modèles de tests adaptatifs que nous avons rencontrés dans des communautés scientifiques différentes (théorie de la réponse à l'item, modèles basés sur des composantes de connaissances, apprentissage automatique), ainsi que leurs limitations.

Dans le chapitre 3, nous proposons une méthode pour comparer des modèles de tests adaptatifs différents de façon qualitative et quantitative sur un même jeu de données. Nous l'appliquons à la comparaison de deux modèles, un issu de la théorie de la réponse à l'item, un autre basé sur des composantes de connaissances.

Dans le chapitre 4, nous présentons un nouveau modèle de test adaptatif, qui peut être vu à la fois comme issu de la théorie de la réponse à l'item multidimensionnelle et comme un modèle basé sur des composantes de connaissance. En utilisant le système de comparaison décrit au chapitre 3, nous montrons qu'il a une capacité plus prédictive que les autres modèles, sur tous les jeux de données testés.

Dans le chapitre 5, nous présentons une nouvelle stratégie de choix des $k$ premières questions pour le modèle GenMA, basée sur une métrique qui quantifie à quel point un ensemble de questions peut être informatif. Nous montrons qu'elle permet de converger plus vite vers un diagnostic de l'apprenant.

Enfin, dans le chapitre 6, nous décrivons les perspectives de notre travail, et nos futures pistes de recherche.
