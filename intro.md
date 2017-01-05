# Évaluation adaptative à grande échelle

L'individualisation de l'enseignement et de l'évaluation est un enjeu fort de notre siècle. Donner la même feuille d'exercices à tous les élèves d'une classe conduit à des situations où certains élèves finissent très vite et demandent d'autres exercices, tandis que d'autres peinent à résoudre un exercice. Il serait plus profitable pour les élèves d'avoir des feuilles d'exercices personnalisées. Mais le travail consistant à piocher des exercices dans une banque de façon à maintenir un certain équilibre pour une unique feuille universelle est déjà difficile pour un professeur, alors concevoir des feuilles d'exercices différentes pour chaque étudiant peut sembler complexe à gérer. Heureusement, les progrès en traitement de l'information rendent cela possible. On voit ainsi aujourd'hui des professeurs d'université distribuer des énoncés différents à tous leurs étudiants lors d'un examen [@Zeileis2012], ce qui pose toutefois des questions d'impartialité de l'évaluation. Personnaliser l'évaluation permet également de poser moins de questions à chaque apprenant [@Chang2014], ce qui est d'autant plus utile que les apprenants passent aujourd'hui trop de temps à être testés [@Zernike2015].

\newacronym{mooc}{MOOC}{\emph{Massive Open Online Courses}}

Avec l'arrivée des \gls{mooc}, ce besoin en évaluation adaptative s'est accentué. Des cours de nombreuses universités à travers le monde peuvent être suivis par des centaines de milliers d'étudiants. Mais la pluralité des profils de ces apprenants, notamment leurs âges et leurs parcours, fait qu'il devient crucial d'identifier les connaissances que les apprenants ont accumulées dans le passé, afin de personnaliser leurs expériences d'apprentissage et d'aider le professeur à mieux connaître sa classe pour améliorer son cours. Or, répondre à de nombreuses questions d'un test de positionnement au début d'un cours risque de paraître fastidieux pour les apprenants [@Desmarais2012]. Il est alors encouragé de ne poser des questions que lorsque c'est nécessaire, par exemple ne pas poser des questions trop difficiles tant que l'apprenant n'a pas répondu à des questions faciles, et ne pas poser des questions requérant des compétences que l'apprenant semble déjà maîtriser, au vu de ses réponses précédentes [@Chang2014].

Cette réduction du nombre de questions d'un test a été étudiée depuis longtemps en psychométrie. La théorie de la réponse à l'item suppose qu'un faible nombre de variables peut expliquer les réponses d'un étudiant à plusieurs questions, et cherche à déterminer les questions les plus informatives pour dévoiler les facteurs latents de l'étudiant [@Hambleton1985]. Cette théorie a ainsi permis de développer des modèles de tests *adaptatifs*, qui posent une question à un apprenant, évaluent sa réponse et choisissent en fonction de celle-ci la question suivante à lui poser. Alors que la théorie de la réponse à l'item remonte aux années 50, ces tests sont aujourd'hui utilisés en pratique par le GMAT, une certification administrée à des centaines de milliers d'étudiants chaque année. Toutefois, les enjeux de ces tests sont davantage liés à l'évaluation qu'à la formation : leur objectif est de mesurer les apprenants afin de leur remettre ou non un certificat, plutôt que de leur faire un retour sur leurs lacunes. Un tel retour leur serait plus utile pour s'améliorer, et également renforcerait leur engagement. Ainsi, les organismes de certification se placent davantage du côté des institutions, qui décident d'une barre d'admissibilité et d'un quota d'entrants, tandis qu'une plateforme de MOOC se place davantage du côté de ses utilisateurs, les apprenants.

# Diagnostic de connaissances

On distingue deux types de tests adaptatifs. Des tests adaptatifs *sommatifs* mesurent l'apprenant et lui renvoient un simple score, tandis que des tests adaptatifs *formatifs* font un diagnostic des connaissances de l'apprenant afin qu'il puisse s'améliorer, par exemple sous la forme de points à retravailler.

Les tests adaptatifs qui se contentent de mesurer l'apprenant opèrent de façon purement statistique, agnostique du domaine. En revanche, les tests formatifs ont besoin d'une représentation du domaine : en effet, pour expliquer à l'apprenant ce qu'il semble ne pas avoir compris, il faut avoir fait le lien entre les questions et les composantes de connaissances impliquées dans leur résolution.

Dans cette thèse, nous avons répertorié des modèles de tests adaptatifs issus de différents pans de la littérature. Nous les avons comparés de façon qualitative et quantitative. Nous avons ainsi proposé et implémenté un protocole expérimental pour comparer les principaux modèles de tests adaptatifs sur plusieurs jeux de données réelles. Cela nous a amenés à proposer un modèle hybride de diagnostic de connaissances adaptatif. Enfin, nous avons élaboré une stratégie pour poser plusieurs questions au tout début du test afin de réaliser une meilleure estimation initiale des connaissances de l'apprenant.

Nous avons souhaité adopter un point de vue venant de l'apprentissage automatique, plus précisément du filtrage collaboratif, pour attaquer le problème du choix des questions à poser pour réaliser un diagnostic. En filtrage collaboratif, on se demande comment s'aider d'une communauté active pour avoir une idée des préférences d'un utilisateur en fonction des préférences des autres utilisateurs. En évaluation adaptative, on se demande comment s'aider d'un historique de passage d'un test pour avoir une idée de la performance d'un apprenant en fonction de la performance des autres apprenants. Il n'est pas question ici de faire une analogie directe entre l'apprentissage et la consommation de culture, mais plutôt de s'inspirer des techniques étudiées dans cet autre domaine : il est indéniable que les plateformes de consommation de biens culturels sont davantage préparées que les MOOC à recevoir des milliers d'utilisateurs, traiter les grandes quantités de données qu'ils récoltent et adapter leur contenu en conséquence. Ainsi, les algorithmes qu'on y retrouve ne reposent pas seulement sur une solide théorie statistique mais également sur un souci de mise en pratique efficace en grande dimension.

# Problèmes

Dans cette thèse, nous nous sommes intéressés aux problèmes suivants liés aux modèles de tests adaptatifs.

### Réduction du nombre de questions d'un test

Si un intervenant ne peut poser que $k$ questions d'une banque de $n$ questions (où $k < n$) à un apprenant, lesquelles choisir ? Pour ce problème, nous avons considéré différents modèles de tests adaptatifs ainsi que différentes stratégies du choix des premières questions. Laquelle de ces approches fournit les meilleurs résultats en fonction de $k$ ?

### Méthodologie de comparaison de modèles

Comment comparer des modèles de tests adaptatifs différents sur un même jeu de données ? Quels critères considérer pour la comparaison ? Quels sont les avantages et limitations des modèles de tests adaptatifs ?

Également, comment comparer différentes stratégies de choix d'un ensemble de questions ?

### Méthodologie de choix de modèles

Dans une situation donnée, en fonction des données dont un enseignant dispose et de ses objectifs, quel modèle de test adaptatif a-t-il intérêt à choisir ?

### Élaboration d'un test adaptatif dans un MOOC

Dans le cas pratique d'une utilisation d'un test adaptatif dans un MOOC, comment pourrait-on procéder ? [@Vie2015b]

# Contributions

## Hypothèses

Dans le cadre de cette thèse, nous cherchons à évaluer les connaissances des apprenants, et non d'autres dimensions telles que leur persévérance, leur organisation ou leur capacité à faire preuve de précaution lorsqu'ils répondent à des questions. En réduisant le nombre de questions, nous réduisons le temps que les apprenants passent à être évalués, ce qui les empêche de se lasser de répondre à trop de questions et laisse plus de temps pour d'autres activités d'apprentissage.

Nous avons considéré que les réponses de l'apprenant pouvaient être correctes ou incorrectes, c'est-à-dire qu'ils produisent des *motifs de réponse dichotomiques*. Cela comprend les questions à choix multiples, les questions à réponse ouverte courte à condition d'avoir une fonction capable de traiter la réponse de l'apprenant afin de savoir si elle est correcte ou non, ou même des tâches plus complexes que l'apprenant peut résoudre ou ne pas résoudre. Ce cadre nous a permis d'analyser des données issues de différents environnements éducatifs : des tests standardisés, des plateformes de jeux sérieux ou des MOOC.

Afin de pouvoir mener nos expériences sur des données de test existantes, nous avons fait la supposition que le niveau de l'apprenant n'évolue pas pendant qu'il passe le test. Les modèles considérés fournissent donc une \og photographie \fg{} de la connaissance d'un apprenant à un instant donné. Aussi nous supposons que l'apprenant répondra de la même façon indépendamment de l'ordre dans lequel nous posons les questions. Celles-ci doivent donc être localement indépendantes. Nous ne supposons aucun profil de l'apprenant autre que ses réponses aux questions posées, ce qui nous permet de proposer des tests anonymes. L'apprenant n'a donc pas à craindre que ses erreurs puissent être enregistrées et associées à son identité indéfiniment [@Obama2014].

Enfin, les modèles que nous considérons ne posent jamais deux fois la même question au sein d'un test. Même si dans certains scénarios, présenter le même item plusieurs fois est utile, par exemple lors de l'apprentissage du vocabulaire d'une langue [@Altiner2011], nous préférons poser des questions différentes pour réduire les risques que l'apprenant devine la bonne réponse.

## Système de comparaison de tests adaptatifs

Nous avons identifié plusieurs modèles de tests adaptatifs et les avons comparés selon plusieurs angles qualitatifs :

- capacité à modéliser plusieurs dimensions de l'apprenant, c'est-à-dire à mesurer l'apprenant selon plusieurs composantes de connaissances ;
- capacité à faire un diagnostic de l'apprenant utile pour qu'il puisse s'améliorer ;
- nécessité de disposer de données d'entraînement ou non pour faire fonctionner le test ;
- complexité en temps pour l'entraînement des modèles.\bigskip

Nous les avons également comparés selon plusieurs angles quantitatifs :

- capacité à requérir peu de questions de l'utilisateur pour converger vers un diagnostic ;
- capacité à aboutir à un diagnostic vraisemblable.\bigskip

Ce cadre nous a permis d'évaluer des modèles de tests adaptatifs sur plusieurs jeux de données réelles :

- un test multidisciplinaire SAT ;
- un examen d'anglais ECPE ;
- un test de soustraction de fractions ;
- un test standardisé de mathématiques ;
- une édition du concours d'initiation à l'informatique Castor ;
- les données d'un MOOC de Coursera.\bigskip

Le protocole expérimental que nous avons conçu est générique : il s'appuie sur les composants que l'on retrouve dans tous les modèles de tests adaptatifs, et peut ainsi être réutilisé pour de nouveaux modèles, et de nouveaux jeux de données.

Cette première analyse [@Vie2015] nous a permis de faire un état de l'art intercommunautaire des modèles de tests adaptatifs récents que nous avons publié dans un livre sur l'analytique de l'apprentissage [@Vie2016b], et de concevoir une méthodologie pour étudier les modèles de tests adaptatifs. Nous avons ainsi pu mettre en évidence que selon le type de test, le meilleur modèle n'est pas le même, et proposer les deux autres contributions suivantes.

## GenMA, un modèle hybride adaptatif de diagnostic de connaissances

\newacronym{genma}{GenMA}{\emph{General Multidimensional Adaptive}}

La comparaison que nous avons effectuée a permis de mettre en exergue les limitations des différents modèles : par exemple, un modèle sommatif basé sur la théorie de la réponse à l'item est généralement plus prédictif qu'un modèle formatif basé sur un modèle de diagnostic cognitif.

Afin de pallier les limitations des deux types de modèles, nous avons proposé un nouveau modèle adaptatif de diagnostic de connaissances appelé \gls{genma} qui mesure à la fois le niveau de l'apprenant et son degré de maîtrise selon plusieurs composantes de connaissances pour lui faire un diagnostic utile pour s'améliorer. GenMA est donc un modèle hybride car il s'appuie sur une représentation des composantes de connaissances, et sur la théorie de la réponse à l'item.

GenMA est plus rapide à calibrer qu'un modèle de théorie de la réponse à l'item de même dimension. De plus, il est meilleur que le modèle existant de diagnostic cognitif sur tous les jeux de données étudiés. Nous l'avons présenté à la conférence EC-TEL 2016 [@Vie2016].

## InitialD, tirer les $k$ premières questions pour démarrer

\newacronym{initiald}{InitialD}{\emph{Initial Determinant}}

Pour l'utilisation du modèle GenMA, nous avons comparé différentes stratégies du choix des $k$ premières questions à poser à un nouvel apprenant. Adapter le processus d'évaluation dès la première question peut conduire à des estimations imprécises du niveau de l'apprenant, car celui-ci peut faire des fautes d'inattention ou deviner la bonne réponse. Une variante des tests adaptatifs nommée tests à étapes multiples consiste à poser plusieurs questions avant d'estimer le niveau de l'apprenant pour minimiser le taux d'erreur du premier diagnostic.

Nous avons proposé une nouvelle stratégie appelée \gls{initiald} pour choisir les $k$ premières questions, qui repose sur une mesure de diversité inspirée par les systèmes de recommandation. Ainsi, InitialD cherche à sélectionner $k$ questions diversifiées, afin de minimiser la redondance de ce qui est mesuré.

Nous montrons ainsi que l'adaptation a ses limites, puisque parfois poser un petit groupe de $k$ questions est plus informatif pour le modèle de test adaptatif que poser $k$ questions une par une, de façon adaptative. De façon théorique, la meilleure stratégie adaptative réalise un diagnostic plus fin que la meilleure stratégie non adaptative, mais nous avons mis en évidence que certaines stratégies adaptatives habituellement utilisées dans les tests adaptatifs se comportent moins bien que les stratégies non adaptatives que nous avons proposées.

# Publications

### Poster à EDM 2015

\englishpub{Jill-Jênn Vie, Fabrice Popineau, Éric Bruillard et Yolaine Bourda (2015a). ``Predicting Performance over Dichotomous Questions: Comparing Models for Large-Scale Adaptive Testing''. In: \emph{8th International Conference on Educational Data Mining (EDM 2015)}.}

### Workshop à EIAH 2015

Jill-Jênn Vie, Fabrice Popineau, Jean-Bastien Grill, Éric Bruillard et Yolaine Bourda (2015b). \og Prédiction de performance sur des questions dichotomiques : comparaison de modèles pour des tests adaptatifs à grande échelle \fg. In : *Atelier Évaluation des Apprentissages et Environnements Informatiques, EIAH 2015*.

### Conférence à EC-TEL 2016

\englishpub{Jill-Jênn Vie, Fabrice Popineau, Yolaine Bourda et Éric Bruillard (2016b). ``Adaptive Testing Using a General Diagnostic Model''. In: \emph{European Conference on Technology Enhanced Learning}. Springer, p. 331--339.}

### Chapitre de journal Springer 2016

\englishpub{Jill-Jênn Vie, Fabrice Popineau, Éric Bruillard et Yolaine Bourda (2016a). ``A review of recent advances in adaptive assessment''. In: \emph{Learning analytics: Fundaments, applications, and trends: A view of the current state of the art}. Springer, à paraître.}

### Revue STICEF 2016

Jill-Jênn Vie, Fabrice Popineau, Éric Bruillard et Yolaine Bourda (2016). \og Utilisation de tests adaptatifs dans les MOOC dans un cadre de crowdsourcing \fg. In : STICEF, soumis.

# Plan

Vous arrivez à la fin du chapitre 1, où nous avons introduit le concept de test adaptatif pour le diagnostic de connaissances, les problèmes auxquels nous nous sommes attaqués et les contributions que nous avons proposées, ainsi que le plan de la thèse.

Dans le chapitre 2, nous décrivons les différents modèles de tests adaptatifs que nous avons rencontrés dans des communautés scientifiques différentes (théorie de la réponse à l'item, modèles basés sur des composantes de connaissances, apprentissage automatique), ainsi que leurs limitations.

Dans le chapitre 3, nous proposons une méthode pour comparer de façon qualitative et quantitative des modèles de tests adaptatifs différents sur un même jeu de données. Nous l'appliquons à la comparaison de deux modèles, un issu de la théorie de la réponse à l'item, un autre basé sur des composantes de connaissances, sur cinq jeux de données.

Dans le chapitre 4, nous présentons un nouveau modèle de test adaptatif (GenMA), qui peut être vu à la fois comme issu de la théorie de la réponse à l'item multidimensionnelle et comme un modèle basé sur des composantes de connaissance. En utilisant le système de comparaison décrit au chapitre 3, nous montrons qu'il a une capacité plus prédictive que les autres modèles, sur tous les jeux de données testés.

Dans le chapitre 5, nous présentons une nouvelle stratégie de choix des $k$ premières questions (InitialD) pour le modèle GenMA, basée sur une métrique qui quantifie à quel point un ensemble de questions peut être informatif. Nous montrons qu'elle permet de converger plus vite vers un diagnostic vraisemblable de l'apprenant.

Enfin, dans le chapitre 6, nous décrivons les perspectives de notre travail, et nos futures pistes de recherche.
