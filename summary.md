Cette thèse porte sur les tests adaptatifs dans les environnements d'apprentissage. Vous avez sûrement déjà joué au jeu \og Qui est-ce ? \fg{} où il faut localiser l'individu auquel l'adversaire pense. De toute évidence, poser la question : \og Est-ce que le personnage auquel tu penses s'appelle Bob ? \fg{} ne va pas permettre de gagner rapidement. Il vaut mieux poser des questions discriminantes, qui divisent au mieux l'espace de recherche en deux (si la moitié des candidats restants ont des lunettes, demander si la cible porte des lunettes sera utile). On retrouve de tels systèmes dans plusieurs domaines :

- en psychométrie, dans certains tests standardisés tels que le GMAT ou le GRE ;
- l'élicitation des préférences sur un système de recommandation ;
- les jeux de devinette (recherche binaire généralisée) ;
- de façon plus théorique, en apprentissage actif pour l'apprentissage statistique.

De façon surprenante, ces systèmes ne sont pas très répandus en apprentissage. Lorsqu'on évalue un apprenant, on aimerait pourtant ne poser que des questions utiles, afin d'établir un diagnostic en peu de questions. C'est d'autant plus important que les élèves sont aujourd'hui trop testés, et que pour que les apprenants sur un cours en ligne restent stimulés, il faille leur poser des questions ni trop faciles, ni trop difficiles.

La difficulté principale, c'est qu'il y a beaucoup de scénarios possibles lorsqu'un apprenant passe un test, et certains modèles de tests adaptatifs ne sont pas robustes : il suffit que l'apprenant fasse une erreur d'inattention pour que le diagnostic s'emballe. Les chercheurs en sciences sociales sont toutefois habitués à prendre avec des pincettes les réponses de leurs examinés.

Cette thèse s'inscrit dans le domaine en vogue des analytiques d'apprentissage : comment s'aider des données laissées par les apprenants sur des environnements éducatifs pour optimiser l'apprentissage sous toutes ses formes ? Les problèmes que je me suis posés sont les suivants : Quel nombre minimal de questions poser à un apprenant de manière à explorer au mieux ses connaissances ? Y a-t-il un moyen de ne poser que des questions informatives afin d'éviter de la redondance ? Qu'est-ce la réponse à une question nous dit sur le comportement de l'apprenant sur les autres questions ? Dans cette thèse, j'adopte un point de vue venant de l'apprentissage statistique, plus précisément du filtrage collaboratif, pour attaquer le problème du choix des questions à poser pour réaliser un diagnostic.

En filtrage collaboratif, on se demande comment s'aider d'une communauté pour avoir une idée des préférences d'un utilisateur en fonction des préférences des autres utilisateurs. Il n'est pas question ici de faire un analogue direct entre l'apprentissage et la consommation de culture, mais plutôt de s'inspirer des techniques étudiées dans cet autre domaine : il est indéniable que les plateformes de consommation de culture sont plus préparées à recevoir des milliers d'utilisateurs que les salles de classe ou même les MOOCs, en termes d'adaptation. Ainsi, les algorithmes qu'on y retrouve ne comportent pas seulement de belles propriétés statistiques mais également d'un souci de mise en pratique efficace[^1].

 [^1]: On n'entendra pas un développeur de Netflix dire : \og Ça marche jusqu'à la dimension 10, ensuite ce n'est pas possible. \fg{} [@Su2013].

<!-- ![Les psychométriciens se situent entre les psychologues, les statisticiens et ceux qui savent programmer.](figures/psychometrie)

Et de fait, il y a de multiples stratégies qui permettent d'attaquer des problèmes de haute dimension. D'abord, la parallélisation des calculs lorsqu'on fait de la réduction de dimension.

Une réflexion plus personnelle est que le deep learning est une manière de concevoir un calcul de façon hiérarchique. On a des briques qui sont chacun des modèles, et on les emboîte. Pour un problème donné (traitement d'image) il faut certaines boîtes. Pour d'autres, d'autres. Ça permet d'avoir du recul, de concevoir son modèle de façon hiérarchique, et ça relève davantage de la culture. C'est pour ça qu'on parle de feature engineering.

Mais le deep learning porte sur des problèmes relativement objectifs : de façon indéniable, ceci est un chat. Mais peut-on vraiment dire que de façon indéniable, cet élève maîtrise l'addition ? On fera toujours des fautes de calcul. Le a-ha facteur semble requérir une discrétisation de la pensée. -->

\section*{Comparaison des modèles}

J'ai identifié plusieurs modèles de tests adaptatifs et je les ai comparés selon plusieurs angles qualitatifs :

- capacité à mesurer plusieurs dimensions ;
- capacité à faire un retour à l'apprenant utile pour qu'il puisse s'améliorer ;
- capacité à expliquer ses propres déductions ; 
- besoin de données d'entraînement ou non pour faire fonctionner le test.

Mais aussi comparés quantitativement sur des données réelles de tests :

- complexité en temps et mémoire pour l'entraînement des modèles ;
- capacité à requérir peu de questions de l'utilisateur pour converger vers un diagnostic ;
- capacité à avoir un diagnostic vraisemblable.

Cette analyse m'a permis de faire un état de l'art interdisciplinaire des modèles de tests adaptatifs récents, de concevoir une méthodologie pour étudier les modèles de tests adaptatifs et de proposer deux contributions.

# GenMA, un modèle de test adaptatif faisant un retour à l'apprenant {-}

Un modèle qui permet d'avoir un test adaptatif qui fait un retour à l'apprenant selon plusieurs dimensions. GenMA est meilleur que le modèle existant de diagnostic cognitif sur tous les jeux de données étudiés.

# InitialD, un premier choix de questions non adaptatif {-}

Avant de commencer le diagnostic, on peut faire un test préalable où l'on pose un groupe de questions diversifiées. J'applique un algorithme de récapitulation afin de ne conserver qu'un sous-ensemble de questions du test qui soit informatif, c'est-à-dire qui \og résume \fg{} l'ensemble des questions.

Je montre ainsi que l'adaptation a elle-même ses limites, puisque parfois poser un petit groupe de $k$ questions est plus informatif que poser $k$ questions une par une, de façon adaptative.
