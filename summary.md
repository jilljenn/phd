Cette thèse porte sur les tests adaptatifs dans les environnements d'apprentissage. Elle s'inscrit dans les contextes de fouille de données éducatives et d'analytique de l'apprentissage, où l'on s'intéresse à utiliser les données laissées par les apprenants sur des environnements éducatifs pour optimiser l'apprentissage au sens large.

L'évaluation par ordinateur permet de stocker les réponses des apprenants facilement, afin de les analyser et d'améliorer les évaluations futures. Un certain type de test par ordinateur, les *tests adaptatifs*, permettent de poser une question à un apprenant, traiter sa réponse à la volée, et choisir la question suivante à lui poser en fonction de ses réponses précédentes. Ce processus réduit le nombre de questions à poser à un apprenant tout en conservant une mesure précise de son niveau. Les tests adaptatifs sont aujourd'hui implémentés pour des tests standardisés tels que le GMAT ou le GRE, largement étudiés en psychométrie. Toutefois, les modèles de tests adaptatifs traditionnels se contentent de noter les apprenants, ce qui est utile pour l'institution qui évalue, mais pas pour leur apprentissage. C'est pourquoi des modèles plus formatifs ont été proposés, s'appuyant sur des modèles cognitifs de l'apprenant, afin de pouvoir leur faire un retour utile à l'issue du test pour qu'ils puissent comprendre leurs lacunes et y remédier. On parle alors de *diagnostic adaptatif*.

Dans cette thèse, j'ai répertorié des modèles de tests adaptatifs issus de différents domaines. Je me suis demandé comment évaluer des modèles différents sur un même jeu de données. J'ai donc proposé un protocole expérimental, que j'ai mis en place sur plusieurs jeux de données réels. Cela m'a permis de proposer un modèle hybride de diagnostic de connaissances adaptatif. Enfin, je me suis intéressé à une méthode pour poser plusieurs questions au tout début du test avant de réaliser une première estimation des connaissances de l'apprenant.

J'ai souhaité adopter un point de vue venant de l'apprentissage automatique, plus précisément du filtrage collaboratif, pour attaquer le problème du choix des questions à poser pour réaliser un diagnostic. En filtrage collaboratif, on se demande comment s'aider d'une communauté active pour avoir une idée des préférences d'un utilisateur en fonction des préférences des autres utilisateurs. En évaluation adaptative, on se demande comment s'aider d'un historique de passage d'un test pour avoir une idée de la performance d'un utilisateur en fonction de la performance des autres utilisateurs. Il n'est pas question ici de faire un analogue direct entre l'apprentissage et la consommation de culture, mais plutôt de s'inspirer des techniques étudiées dans cet autre domaine : il est indéniable que les plateformes de consommation de culture sont plus préparées à recevoir des milliers d'utilisateurs que les salles de classe ou même les MOOCs, en termes d'adaptation. Ainsi, les algorithmes qu'on y retrouve ne reposent pas seulement sur une solide théorie statistique mais également sur un souci de mise en pratique efficace en grande dimension.

\section*{Comparaison des modèles}

Tout au long de mes recherches, je n'ai considéré que des réponses correctes ou incorrectes de la part des apprenants, c'est-à-dire des *motifs de réponse dichotomiques*. Ce cadre simple me permet d'analyser des données issues de différents environnements éducatifs : des tests standardisés, des plateformes de jeux sérieux ou des MOOCs.

Afin de pouvoir mener mes expériences sur des données de test existantes, j'ai fait la supposition que le niveau de l'apprenant n'évolue pas pendant qu'il passe le test. Aussi je suppose que quel que soit l'ordre dans lequel je pose mes questions, il y répondra de la même façon. Les questions doivent donc être localement indépendantes. Je ne suppose aucune information sur l'apprenant, ce qui me permet de proposer des tests anonymes.

J'ai identifié plusieurs modèles de tests adaptatifs et je les ai comparés selon plusieurs angles qualitatifs :

- capacité à mesurer plusieurs dimensions ;
- capacité à faire un retour à l'apprenant utile pour qu'il puisse s'améliorer ;
- capacité à expliquer ses propres déductions ; 
- besoin de données d'entraînement ou non pour faire fonctionner le test.

Mais aussi comparés quantitativement sur des données réelles de tests :

- complexité en temps et mémoire pour l'entraînement des modèles ;
- capacité à requérir peu de questions de l'utilisateur pour converger vers un diagnostic ;
- capacité à avoir un diagnostic vraisemblable.

Cette analyse m'a permis de faire un état de l'art interdisciplinaire des modèles de tests adaptatifs récents[^1] et de concevoir une méthodologie pour étudier les modèles de tests adaptatifs. J'ai ainsi pu mettre en évidence que selon le type de test, le meilleur modèle n'est pas le même, et de proposer deux contributions.

 [^1]: \fullcite{Vie2016b}.

\section*{GenMA, un modèle de test adaptatif reposant sur le modèle général de diagnostic}

Certains modèles plus explicatifs sont moins prédictifs. Dans ce chapitre, je propose un modèle hybride qui à la fois mesure le niveau de l'apprenant et son degré de maîtrise des composantes de connaissances, afin de lui faire un retour utile pour s'améliorer. Ce modèle est un cas particulier de modèle de théorie de réponse à l'item multidimensionnelle mais plus facile à converger.

GenMA est meilleur que le modèle existant de diagnostic cognitif sur tous les jeux de données étudiés. Il a été présenté à EC-TEL 2016[^2].

 [^2]: \fullcite{Vie2016}.

\section*{InitialD, un premier choix de questions non adaptatif}

Avant de commencer le diagnostic, on peut faire un test préalable où l'on pose un groupe de questions diversifiées. Je propose dans ce chapitre un algorithme de récapitulation basé sur un processus à point déterminantal afin de ne conserver qu'un sous-ensemble de questions du test qui soit informatif, c'est-à-dire qui \og résume \fg{} l'ensemble des questions.

Je montre ainsi que l'adaptation a elle-même ses limites, puisque parfois poser un petit groupe de $k$ questions est plus informatif que poser $k$ questions une par une, de façon adaptative.

\section*{Perspectives futures}

Enfin, en annexe je présente une méthodologie pour appliquer mon approche à des données de tests issues de MOOC, et présente un lien entre théorie de la réponse à l'item et apprentissage profond, qui offre de nouvelles opportunités en termes de méthodes d'apprentissage automatique pour traiter des données éducatives.
