Cette thèse porte sur les tests adaptatifs dans les environnements d'apprentissage. Elle s'inscrit dans les contextes de fouille de données éducatives et d'analytique de l'apprentissage, où l'on s'intéresse à utiliser les données laissées par les apprenants sur des environnements éducatifs pour optimiser l'apprentissage au sens large.

L'évaluation par ordinateur permet de stocker les réponses des apprenants facilement, afin de les analyser et d'améliorer les évaluations futures. Dans cette thèse, nous nous intéressons à un certain type de test par ordinateur, les *tests adaptatifs*. Ceux-ci permettent de poser une question à un apprenant, traiter sa réponse à la volée, et choisir la question suivante à lui poser en fonction de ses réponses précédentes. Ce processus réduit le nombre de questions à poser à un apprenant tout en conservant une mesure précise de son niveau. Les tests adaptatifs sont aujourd'hui implémentés pour des tests standardisés tels que le GMAT ou le GRE, administrés à des centaines de milliers d'étudiants aujourd'hui. Toutefois, les modèles de tests adaptatifs traditionnels se contentent de noter les apprenants, ce qui est utile pour l'institution qui évalue, mais pas pour leur apprentissage. C'est pourquoi des modèles plus formatifs ont été proposés, permettant de faire un retour plus riche à l'apprenant à l'issue du test pour qu'il puisse comprendre ses lacunes et y remédier. On parle alors de *diagnostic adaptatif*.

Dans cette thèse, nous avons répertorié des modèles de tests adaptatifs issus de différents pans de la littérature. Nous les avons comparés de façon qualitative et quantitative. Nous avons donc proposé un protocole expérimental, que nous avons implémenté pour comparer les principaux modèles de tests adaptatifs sur plusieurs jeux de données réelles. Cela nous a amenés à proposer un modèle hybride de diagnostic de connaissances adaptatif. Enfin, nous avons élaboré une stratégie pour poser plusieurs questions au tout début du test afin de réaliser une meilleure première estimation des connaissances de l'apprenant.

Nous avons souhaité adopter un point de vue venant de l'apprentissage automatique, plus précisément du filtrage collaboratif, pour attaquer le problème du choix des questions à poser pour réaliser un diagnostic. En filtrage collaboratif, on se demande comment s'aider d'une communauté active pour avoir une idée des préférences d'un utilisateur en fonction des préférences des autres utilisateurs. En évaluation adaptative, on se demande comment s'aider d'un historique de passage d'un test pour avoir une idée de la performance d'un utilisateur en fonction de la performance des autres utilisateurs. Il n'est pas question ici de faire un analogue direct entre l'apprentissage et la consommation de culture, mais plutôt de s'inspirer des techniques étudiées dans cet autre domaine : il est indéniable que les plateformes de consommation de biens culturels sont davantage préparées que les MOOC à recevoir des milliers d'utilisateurs, traiter les grandes quantités de données qu'ils récoltent et adapter leur contenu en conséquence. Ainsi, les algorithmes qu'on y retrouve ne reposent pas seulement sur une solide théorie statistique mais également sur un souci de mise en pratique efficace en grande dimension.

\section*{Comparaison des modèles}

Dans le cadre de cette thèse, nous avons considéré des réponses correctes ou incorrectes de la part des apprenants, c'est-à-dire des *motifs de réponse dichotomiques*. Ce cadre nous a permis d'analyser des données issues de différents environnements éducatifs : des tests standardisés, des plateformes de jeux sérieux ou des MOOC.

Afin de pouvoir mener nos expériences sur des données de test existantes, nous avons fait la supposition que le niveau de l'apprenant n'évolue pas pendant qu'il passe le test. Aussi nous supposons que l'apprenant répondra de la même façon indépendamment de l'ordre dans lequel nous posons les questions. Celles-ci doivent donc être localement indépendantes. Nous ne supposons aucun profil de l'apprenant autre que ses réponses aux questions posées, ce qui nous permet de proposer des tests anonymes.

Nous avons identifié plusieurs modèles de tests adaptatifs et les avons comparés selon plusieurs angles qualitatifs :

- capacité à mesurer plusieurs dimensions ;
- capacité à faire un retour à l'apprenant utile pour qu'il puisse s'améliorer ;
- capacité à expliquer ses propres déductions ; 
- besoin de données d'entraînement ou non pour faire fonctionner le test.

Nous les avons également comparés quantitativement sur des données réelles de tests :

- complexité en temps et mémoire pour l'entraînement des modèles ;
- capacité à requérir peu de questions de l'utilisateur pour converger vers un diagnostic ;
- capacité à avoir un diagnostic vraisemblable.

Le protocole expérimental que nous avons conçu est générique : il s'appuie sur les composants que l'on retrouve dans tous les modèles de tests adaptatifs, et peut ainsi être mis en œuvre pour de nouveaux modèles, et de nouveaux jeux de données.

Cette analyse nous a permis de faire un état de l'art interdisciplinaire des modèles de tests adaptatifs récents[^1] et de concevoir une méthodologie pour étudier les modèles de tests adaptatifs. Nous avons ainsi pu mettre en évidence que selon le type de test, le meilleur modèle n'est pas le même, et de proposer les deux contributions suivantes.

 [^1]: \fullcite{Vie2016b}.

\section*{GenMA, un modèle de test adaptatif reposant sur le modèle général de diagnostic}

Certains modèles plus explicatifs sont moins prédictifs. Dans ce chapitre, nous proposons un modèle hybride qui mesure à la fois le niveau de l'apprenant et son degré de maîtrise selon plusieurs composantes de connaissances, afin de lui renvoyer un retour utile pour s'améliorer. Ce modèle est un cas particulier de modèle de théorie de réponse à l'item multidimensionnelle, mais il est plus rapide à calibrer car le nombre de paramètres à déterminer est réduit.

GenMA est meilleur que le modèle existant de diagnostic cognitif sur tous les jeux de données étudiés. Il a été présenté à la conférence EC-TEL 2016[^2].

 [^2]: \fullcite{Vie2016}.

\section*{InitialD, une stratégie non adaptative de choix des premières questions}

Avant de démarrer le processus adaptatif, on peut faire un test préalable où l'on choisit un groupe de questions diversifiées pour récolter beaucoup d'information en une seule étape. Nous proposons dans ce chapitre un algorithme de récapitulation basé sur un processus à point déterminantal afin de ne conserver qu'un sous-ensemble de questions du test qui soit informatif, c'est-à-dire qui \og résume \fg{} bien l'ensemble des questions.

Nous montrons ainsi que l'adaptation a elle-même ses limites, puisque parfois poser un petit groupe de $k$ questions est plus informatif pour le modèle de test adaptatif que poser $k$ questions une par une, de façon adaptative.

\section*{Application pratique à des données de MOOC}

En annexe, nous présentons une méthodologie pour appliquer notre approche à des données de tests issues de MOOC, ainsi que de nouvelles méthodes d'apprentissage automatique pour traiter des données éducatives.
