Cette thèse porte sur les tests adaptatifs. Vous avez sûrement déjà joué au jeu \og Qui est-ce ? \fg{} où il faut localiser la personne à laquelle la personne en face pense. De toute évidence, poser la question : \og Est-ce que le personnage auquel tu penses s'appelle Bob ? \fg{} ne va pas permettre de gagner rapidement. Il vaut mieux poser des questions discriminantes, qui divisent au mieux l'espace de recherche en deux (tiens, la moitié des personnes restantes ont des lunettes, je vais poser cette question-là). On retrouve de tels systèmes dans plusieurs domaines :

- l'élicitation des préférences sur un système de recommandation ;
- les jeux de devinette (recherche binaire généralisée) ;
- la théorie de la réponse à l'item en psychométrie, qui a conduit aux tests comme le GMAT ou le GRE ;
- de façon plus théorique, en active learning ;
- sous-modularité adaptative, où le but est de faire des algorithmes adaptatifs qui déterminent un meilleur ensemble.

De façon surprenante, ces systèmes ne sont pas très répandus en apprentissage. On aimerait pourtant ne poser des questions utiles dans un test, à la manière d'un arbre de décision, afin d'établir un diagnostic. C'est d'autant plus important que les apprenants sont aujourd'hui trop testés, et que les apprenants sur un cours sont largués car ils ne savent pas par quoi commencer. Le souci principal, c'est que les modèles de tests adaptatifs qu'on rencontre ne résistent pas à l'erreur : l'apprenant peut avoir fait une faute d'inattention, et là le diagnostic s'emballe. Les chercheurs en sciences sociales sont habitués à prendre avec des pincettes les réponses de leurs examinés.

Le problème est donc : quel nombre minimal de questions poser à un apprenant de manière à explorer au mieux ses connaissances ? Y a-t-il un moyen de ne poser que des questions informatives afin d'éviter de la redondance ? Qu'est-ce qu'une question nous apporte comme information sur le comportement de l'apprenant sur les autres questions ? Dans cette thèse, j'adopte un point de vue venant de l'apprentissage statistique, plus précisément du filtrage collaboratif, pour attaquer le problème du choix des questions à poser pour réaliser un diagnostic. En filtrage collaboratif, on se demande comment s'aider d'une communauté pour avoir une idée des préférences d'un utilisateur en fonction des préférences des autres utilisateurs.

Loin de moi le fait de vouloir faire un analogue direct entre l'apprentissage et la consommation de culture. Mais il est indéniable que les plateformes de consommation de culture sont plus préparées à recevoir des milliers d'utilisateurs que les salles de classe ou même les MOOCs, en termes d'adaptation. Ainsi, les algorithmes qu'on y retrouve ne comportent pas seulement de belles propriétés statistiques mais également d'un souci de mise en application efficace. On n'entendra pas un développeur de Netflix dire : \og Ça marche jusqu'à la dimension 10, ensuite ce n'est pas possible. \fg [@Su2013].

<!-- ![Les psychométriciens se situent entre les psychologues, les statisticiens et ceux qui savent programmer.](figures/psychometrie)

Et de fait, il y a de multiples stratégies qui permettent d'attaquer des problèmes de haute dimension. D'abord, la parallélisation des calculs lorsqu'on fait de la réduction de dimension.

Une réflexion plus personnelle est que le deep learning est une manière de concevoir un calcul de façon hiérarchique. On a des briques qui sont chacun des modèles, et on les emboîte. Pour un problème donné (traitement d'image) il faut certaines boîtes. Pour d'autres, d'autres. Ça permet d'avoir du recul, de concevoir son modèle de façon hiérarchique, et ça relève davantage de la culture. C'est pour ça qu'on parle de feature engineering.

Mais le deep learning porte sur des problèmes relativement objectifs : de façon indéniable, ceci est un chat. Mais peut-on vraiment dire que de façon indéniable, cet élève maîtrise l'addition ? On fera toujours des fautes de calcul. Le a-ha facteur semble requérir une discrétisation de la pensée. -->

# Comparaison des modèles {-}

Je les ai comparés selon plusieurs angles qualitatifs :

- capacité à mesurer plusieurs dimensions ;
- capacité à faire un retour à l'apprenant utile pour qu'il puisse s'améliorer ;
- besoin de données d'entraînement ou non pour faire fonctionner le test.

Et quantitatifs sur des données réelles :

- complexité en temps et mémoire pour l'entraînement des modèles ;
- capacité à requérir peu de questions de l'utilisateur pour converger vers un diagnostic ;
- capacité à avoir un diagnostic vraisemblable.

Cette analyse m'a permis de faire un état de l'art interdisciplinaire des modèles de tests adaptatifs récemment développés, et de proposer deux contributions.

# GenMA, un modèle de test adaptatif formatif {-}

Un modèle qui permet d'avoir un test adaptatif multidimensionnel qui fait un retour à l'apprenant sur ses lacunes. Meilleur que le modèle existant sur tous les jeux de données étudiés.

# InitialD {-}

Avant de commencer le diagnostic, on peut faire un prétest où l'on pose un groupe de questions diversifiées. J'applique un algorithme de récapitulation afin de ne conserver qu'un sous-ensemble de questions du test qui soit informatif, qui \og résume \fg{} l'ensemble.

Je montre ainsi que l'adaptation a elle-même ses limites, puisque parfois poser un petit groupe de questions est plus informatif que les poser une par une, de façon adaptative.
