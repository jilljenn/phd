% Tests adaptatifs dans un cadre de crowdsourcing
% Jill-Jênn Vie
% 28 avril 2016

# Introduction

De nos jours, les tests sont de plus en plus administrés par ordinateur, rendant possible la collecte des réponses de nombreux étudiants. Tirer parti de ces données permet d'identifier des motifs de réponses particuliers et d'en apprendre davantage sur les étudiants et les questions des tests. La communauté des *learning analytics* cherche ainsi à améliorer le processus d'apprentissage en s'appuyant sur toutes les données récoltées sur les étudiants [@Baker2014], ce qui peut poser des problèmes de confidentialité [@Obama2014].

En l'occurrence, on souhaite poser des questions avec parcimonie à un apprenant de manière à effectuer un diagnostic de ses connaissances, via une interface qui choisit automatiquement la question suivante en fonction de la performance de l'apprenant. Ce processus est semblable à une interrogation orale, en temps limité, où l'examinateur pose des questions qui lui permettent de raffiner son estimation du niveau de l'apprenant. C'est d'autant plus utile aujourd'hui que l'administration d'Obama a pointé du doigt que les jeunes passaient trop de temps à être testés, et a donc demandé des tests plus efficaces [@Zernike2015].

Ces « tests dont vous êtes le héros » peuvent être complètement spécifiés par le professeur à la manière d'un *visual novel*, mais le nombre de possibilités à considérer croît exponentiellement en le nombre de questions posées. Ainsi, on préfère recourir à des algorithmes de tests adaptatifs. Ainsi, si on peut quantifier l'information qu'apporte une question étant donné l'état de nos connaissance sur l'apprenant, on peut choisir la question qui va apporter le plus d'information sur l'apprenant. Les premiers tests adaptatifs reposent sur la théorie de la réponse à l'item, et de plus en plus de modèles émergent dans différentes communautés comme la psychométrie ou l'apprentissage statistique.

Afin d'établir des garanties sur l'efficacité du test, on ne peut partir de zéro. Il faut au moins accès à un historique de réponses, au mieux une représentation des connaissance sur le domaine évalué.


# Tests adaptatifs

Contrairement à un test classique, qui poserait les mêmes questions à tous les apprenants, un test adaptatif choisit la question suivante à poser en fonction des réponses précédentes de l'apprenant. Par exemple, si le candidat n'a pas réussi à répondre à une question de niveau moyen, il semble raisonnable de supposer qu'il ne réussira pas à répondre à une question difficile. Cette adaptation permet d'obtenir des tests plus courts tout en garantissant une mesure précise [@Redecker2013].

Les paramètres de difficulté des questions peuvent être spécifiées a priori, mais en général on utilise un historique de réponses du test pour calibrer automatiquement des difficultés plus vraisemblables. Ainsi, on utilise des réponses passées du test pour entraîner un modèle d'apprentissage statistique permettant d'inférer le comportement de l'apprenant sur des questions qu'on ne lui a pas posées.

Ainsi, pour concevoir un test adaptatif, il faut se poser plusieurs questions [@Wainer2000; @VDL2000] : quel est le modèle de l'apprenant ? quelle est la fonction que je cherche à optimiser à chaque pas (le *critère de sélection de la question suivante*) ? à quel moment le test doit-il s'arrêter (le *critère de terminaison*) ?

Pour évaluer un test adaptatif sur des données réelles, on peut effectuer la technique de validation croisée, aussi appelée *retrofitting* en psychométrie : simuler le test adaptatif sur un jeu de données réelles et voir si nos estimations concordent avec les motifs de réponse complets.

## Extensions

En général, lors d'un test adaptatif, l'apprenant ne peut pas modifier ses réponses précédentes. Des recherches récentes [@Wang2015] essaient de prendre ce facteur en compte.

Un autre modèle appelé *test à multi-étapes* [@Chang2014; @Yan2014] choisit un groupe de questions auxquelles l'apprenant peut répondre dans l'ordre qu'il souhaite avant d'obtenir le groupe de questions suivant (plutôt que question par question).

## Types de tests

### Concours, évaluation, score

Dans la plupart des concours, on cherche à classer les étudiants sur une échelle, de façon à, par exemple, n'en conserver que les $k$ premiers. Ainsi, l'enjeu consiste à pouvoir classer les apprenants en leur attribuant un score avec un intervalle de confiance, expliquant leur aptitude.

Les tests GMAT suivent ce critère, 238536 tels tests ont été administrés en 2012--2013 [@GMAT2013].

### Autoévaluation, positionnement, diagnostic

L'acte No Child Left Behind de 2001 a exigé davantage de tests formatifs [@Ferguson2012]. C'est ainsi que des tests adaptatifs de diagnostic ont été créés [@Xu2003], fournissant un retour (aussi appelé *feedback*) à l'issue du test.

Aujourd'hui, les apprenants souhaitent pouvoir s'entraîner sur des tests formatifs, qui leur font un retour sur les composantes de connaissance maîtrisées ou non.

De tels tests de positionnement sont utiles pour savoir à l'entrée d'un MOOC si l'on peut déjà sauter une partie du cours [@Lynch2014].

## Données étudiant

### Atemporelles

On suppose qu'on a accès à un historique du test, sous la forme d'entrées de type : « l'étudiant X a répondu juste ou faux à la question Y ». On appelle ces données *dichotomiques*, par opposition aux données *polytomiques* (un score sur 10 à chaque question, par exemple). Cela nous permet de calibrer les paramètres des différents modèles considérés.

Pour notre usage, tous les gens doivent avoir répondu à toutes les questions pour entraîner les modèles. Néanmoins, @Bergner2015 considère le cas de réponses manquantes, comme sur des données de MOOC par exemple.

### Temporelles

En apprentissage en ligne, comme dans les systèmes de tuteurs intelligents, la connaissance de l'utilisateur évolue continuellement, ainsi il est possible d'enregistrer la chronologie des échecs et succès de l'apprenant. Ces données plus riches permettent d'entraîner des modèles de réseaux bayésiens ou *bayesian knowledge tracing* [@Desmarais2012; @Almond2015; @Baker2014].

Pour symboliser l'erreur de l'apprenant qui diminue au cours de l'apprentissage, on parle de *courbes d'apprentissage* [@Koedinger2012; @Streeter2015].

## Représentation du domaine

On remarque différents types de représentations du domaine, développées plus loin.

- Aucune représentation du domaine
- Liens entre questions et composantes de connaissance (q-matrice)
- Hiérarchie sur les composantes de connaissance : graphe de prérequis sur les compétences
- Graphe plus riche, avec des liens de type « est requis » ou « renforce »
- Ontologie du domaine

## Modèles étudiants

Certains ne cherchent qu'à mesurer des paramètres de l'utilisateur et du jeu de questions, et sont donc agnostiques d'une représentation du domaine.

D'autres prennent en compte un lien entre questions et composantes de connaissance mises en œuvre dans le test : les q-matrices. Celles-ci permettent de faire un diagnostic cognitif de l'apprenant en fonction de ses réponses à un test. Certains modèles de tests adaptatifs prennent en compte une telle q-matrice, alors spécifiée par un expert.

## Critiques

Certains apprenants sont troublés par le fait d'être sollicités en permanence par le système qui s'adapte à leur niveau @RefNeeded. D'autres profitent du système, par exemple certains étudiants font exprès de répondre mal aux premières questions du GMAT afin de pouvoir garantir un bon score plus facilement @RefNeeded.

Un test adaptatif cherchant à maximiser son information peut sauter d'une catégorie de question à une autre, ralentissant l'apprenant, contraint de devoir faire de même [@Almond2015]. C'est pourquoi d'autres contraintes sont ajoutées de façon à obtenir un ordre plus naturel [@Adjei2016].


# Représentation du domaine

## Q-matrice

On peut représenter par une matrice les liens entre questions et un ensemble de $K$ composantes de connaissance. L'apprenant est alors modélisé par un vecteur à $K$ bits appelé *état* qui explique son comportement face aux questions.

Le nombre d'états possibles est de $2^K$, ce qui peut être contraignant lorsque $K$ est grand. Ainsi en pratique, $K$ excède rarement la valeur de 8 [@Su2013]. Si toutefois on suppose des relations de dépendance sur les composantes de connaissance, on peut réduire le nombre d'états possibles, comme indiqué dans la section suivante.

Dans la communauté d'*educational data mining*, certains cherchent à extraire automatiquement une q-matrice ou autre modèle de représentation de connaissance à partir des données [@Desmarais2011; @Lan2014]. Cela permet d'obtenir des modèles prédictifs mais non capables de faire un retour à l'apprenant.

## Graphe de prérequis sur les compétences

Pour enrichir le modèle de représentation de connaissances, on peut établir des liens entre les composantes de connaissances, de type prérequis (« la maîtrise de B implique celle de A ») ou de corrélation (« la maîtrise de A est liée à celle de B »). Pour en savoir plus, cf. la partie sur Attribute Hierarchy Model [@Leighton2004; @Rupp2012] plus bas.

## Knowledge Space Theory

La théorie des espaces de connaissance consiste à supposer qu'il existe un nombre fini d'éléments de connaissance à apprendre, avec éventuellement des prérequis. C'est très similaire à la description précédente.

## Ontologie

Une ontologie est une représentation. Ainsi, avec sa praxéologie, @Mandin2014 propose une estimation du taux de maîtrise basée sur trois valeurs propagées le long du test.

## Codage des réponses possibles

Si l'on souhaite faire un diagnostic plus précis, on peut lier chaque type d'erreur à une idée fausse. C'est sur ce principe que se base Force Concept Inventory [@Hestenes1992] ou les travaux en algèbre de @Grugeon2012. C'est toutefois une connaissance encore plus coûteuse à mettre en place.


# Modèles étudiants

De nombreux modèles sont proposés pour modéliser l'étudiant et ses réponses [@Desmarais2012], nous nous concentrons sur les suivants.

## Modèle de Rasch

Le modèle de Rasch [@Hambleton1985], unidimensionnel mais très populaire par sa simplicité, cherche à mesurer les questions par un paramètre de difficulté et les apprenants par un paramètre de niveau. C'est celui utilisé par des tests non adaptatifs comme PISA et des tests adaptatifs comme GMAT. Il est sommatif, donc ne fait aucun retour à l'apprenant autre que son niveau le plus vraisemblable étant donné ses réponses. @Verhelst2012 a toutefois montré qu'il était possible, en partitionnant les questions en catégories, à renvoyer à l'issue du test un profil statistique selon les différentes catégories. Il est donc possible d'obtenir un test formatif à partir du simple modèle de Rasch.

Plus le candidat est meilleur que la difficulté de la question ($\theta >> d$), plus il a de chances de répondre correctement :

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi(\theta_i - d_j) $$

où $\Phi : x \mapsto 1 / (1 + e^{-x})$ est la fonction logistique.

Ce modèle, s'appuyant sur une régression logistique, est similaire à Elo, un modèle utilisé pour évaluer les joueurs d'échecs.

Pour le critère de sélection de l'item suivant, on choisit en général la question qui maximise l'information de Fisher. (Également, *maximum expected posterior variance*), ce qui revient à poser la question de probabilité estimée la plus proche de 50 % [@RefNeeded].

![Un exemple de test adaptatif utilisant le modèle de Rasch.](irt.pdf)

## Théorie de la réponse à l'item multidimensionnelle (MIRT)

Il est naturel d'étendre le modèle de Rasch à plusieurs dimensions. Ainsi, une extension a été proposée [@Segall1996; @Reckase2009] qui modélise les apprenants et questions par des vecteurs à $d$ dimensions. Un apprenant a plus de chances de répondre correctement à une question corrélée à son vecteur de compétences :

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi(\vec{\theta_i} \cdot \vec{d_j}). $$

Ce modèle inclut plus de paramètres à calculer, et donc est plus difficile à converger [@Desmarais2012]. D'autres critiques ont été émises, par exemple par @Lan2014 qui a remarqué que le niveau d'un candidat pouvait baisser après avoir répondu correctement à une question et l'ont donc rectifié de façon à conserver des facteurs positifs.

## Modèle DINA

Un premier modèle qui utilise une q-matrice de largeur $K$ pour effectuer un test adaptatif. L'étudiant est modélisé par un vecteur de $K$ bits : s'il maîtrise toutes les compétences requises pour répondre à une certaine question, alors il y répond correctement, sinon il ne peut pas [@Tatsuoka1983]. Ce modèle comprend des paramètres d'ajustement : l'apprenant peut deviner la bonne réponse même s'il ne maîtrise pas toutes les composantes de connaissance, ou inversement se tromper alors qu'il les maîtrise.

Ainsi, un test adaptatif consiste à poser des questions pour identifier en peu de questions le vecteur de composantes de l'apprenant. Plus précisément, il s'agit de maintenir une distribution de probabilité sur les $O(2^K)$ états possibles et à la raffiner en fonction des réponses de l'apprenant.

La q-matrice est spécifiée par l'expert, mais certains chercheurs issus de la communauté d'EDM cherchent à les déterminer automatiquement à partir des données étudiant [@Desmarais2011]. Dans [@Koedinger2012], les auteurs combinent par crowdsourcing plusieurs q-matrices pour obtenir des q-matrices ayant une erreur plus faible. Parmi les critères de choix de l'élément suivant, on peut choisir la question qui maximise l'information de Fisher, ou la question qui réduit le plus l'entropie moyenne de la distribution sur les états [@Huebner2010; @Cheng2009].

Toutefois, ces modèles ont une complexité de $O(2^K)$. Afin d'obtenir une complexité plus satisfaisante, des chercheurs ont considéré des relations de précédence sur les composantes de connaissance, dits alors hiérarchiques (Attribute Hierarchy Model, [@Leighton2004; @Rupp2012]), ce qui réduit le nombre d'états possibles de l'apprenant.

## Identification de l'état via Knowledge Space Theory

On peut considérer l'ordre partiel d'inclusion sur les ensembles d'éléments de connaissance pour positionner un apprenant avec un test adaptatif [@Doignon2012; @Falmagne2006; @Lynch2014].

C'est ainsi qu'a été développé le système ALEKS [@Canfield2001; @Falmagne2006].

## Réseau bayésien

Dans les systèmes de tuteurs intelligents, on peut utiliser un réseau bayésien [@Almond2015].

Toutefois, plus le domaine à évaluer est grand, plus cela requiert de tâches. Ainsi pour un test ponctuel, on préférera un autre modèle qu'un réseau bayésien [@Almond2015].

## Modèle de diagnostic basé sur une ontologie

1. Besoin d'un référentiel de connaissance
2. Besoin d'identification des savoir-faire (via QCM)
3. Besoin de délimitation des critères évaluatifs (les tâches réussies sont… VS les tâches réussies nécessaires à maîtriser sont…)
4. Besoin de modèle de diagnostic du taux de maîtrise des savoir faire à partir des exercices réalisés.

Nous développons ces points.

1.

Pour leur ontologie, elles considèrent des relations « est sous-tâche de » sur les types de tâches.

Les types de tâches font partie de thèmes (ex. multiplication), reliés à des secteurs (ex. entiers, décimaux et fractions), assemblés en domaines (ex. nombres et calculs), rattachés à des disciplines (ex. maths).

Chaque tâche est associée à une ou plusieurs techniques (ManyToMany).
LIG (labo d'info de Grenoble) & Educlever ont réalisé l'ontologie, composée de 2000 praxéologies.

2.

Elles sont en faveur des QCM, qui permettent d'obtenir une évaluation à tout moment de l'apprentissage, en tant qu'outil d'auto-régulation et de remédiation ainsi que de certification.

« Labat (TICE 2002) a déjà proposé un système à base de QCM fondé sur une ontologie [ayant] pour objectif d'identifier les misconceptions des apprenants à partir de questions dont chaque réponse proposée est reliée à des compétences maîtrisées ou erronées. »

Elles insistent beaucoup sur le fait d'accompagner toute l'équipe pédagogique :

> Trois objectifs guident notre travail :  
— assister les enseignants dans l'adaptation de leurs cours aux savoir-faire évalués des apprenants ;  
— améliorer la visibilité des progrès des apprenants ;  
— diminuer le temps consacré à leur évaluation. »

Educlever a calibré 3000 QCM par rapport à l'ontologie.

3.

Elles font la même distinction que nous sur les évaluations : certificative vs. formative.
Elles mentionnent deux approches pour comparer les objets observés à des référents (normes ou profils attendus) :

— évaluation normée : comparaison des apprenants les uns aux autres (ce que je voulais appeler plus proches voisins) ;
— évaluation critériée : comparaison des apprenants à un niveau de référence attendu.

Elles se placent dans le cadre d'une évaluation formative avec une personnalisation de l'apprentissage et de la génération d'exercices en fonction d'interprétation des résultats collectés. Elles s'intéressent à :

— la couverture de l'évaluation (quels sont les savoir-faire réellement évalués ?) ;
— la qualité de l'évaluation (les exercices suffisent-ils à estimer la maîtrise d'un certain savoir-faire ?) ;
— la stabilité des résultats (les résultats se répètent-ils ?).

4.

Ils proposent un diagnostic basé sur le calcul de trois valeurs :

— la valeur de base VB, qui correspond à la note de l'élève sur les questions requérant directement une certaine tâche (total des points / total des points maximal) ;
— la valeur enrichie VE, qui correspond à une moyenne pondérée sur les questions requérant directement ou indirectement une certaine tâche ;
— la valeur agrégée VA, qui correspond à un taux de maîtrise d'une certaine tâche (sous la forme d'un pourcentage) : une moyenne pondérée sur les questions requérant directement ou indirectement une certaine tâche ou ses sous-tâches.

Ils ont comparé les valeurs obtenues sur 21 types de tâches aux évaluations de 5 juges (enseignants à l'école élémentaire).
« recouvrement partiel entre les types de tâches pris en compte pour le calcul de VE et ceux sélectionnés par les juges »
« pour la valeur finale du taux de maîtrise (VA), l'accord inter-juge n'est pas parfait »
« il semble que les juges sont plus prudents que le modèle quand il s'agit d'affirmer qu'un élève maîtrise un savoir-faire »

Critiques :

— les paramètres de pondération sont ici pour ajuster le modèle en fonction de différents facteurs (l'écart entre deux évaluations consécutives, le nombre de changements correct/incorrect au sein d'une même période évaluative) mais aucune information n'est communiquée quant à leur calibration ;
— le barème de la valeur de base est à fixer de sorte à rendre compte de l'effet du hasard ou la prise en compte de l'erreur, c'est encore très empirique.

Ça reprend des éléments traités dans la littérature EDM (le comportement de l'apprenant évoluant en fonction du nombre d'opportunités de solliciter un même type de tâche) mais le modèle repose sur beaucoup de valeurs empiriques et non d'une estimation de la probabilité de répondre correctement à une question.

## Importance du profil

Il existe sûrement un paramètre global qui peut tout changer.

**Ex.** Au GMAT on se rend compte qu'un Français ne peut pas faire le poids face à un *native speaker* à cause des tournures de phrases.
Personnalisation selon pays : regarder dans la littérature de PISA.

Est-ce que des facteurs démographiques sur l'apprenant peuvent bootstrapper les modèles et améliorer la personnalisation ? @MIRT permet d'intégrer au modèle de l'apprenant des informations démographiques tel que le genre afin de voir s'il influe sur les résultats.

## Implémentations pratiques des tests adaptatifs

On peut décider soit d'appliquer une politique pour choisir l'élément suivant, soit de précalculer un arbre de décision de profondeur $k$ à l'avance.

Plusieurs packages R permettent de faire des tests adaptatifs (catR @MagisRaiche2012, mirtCAT). Néanmoins, la plupart des plateformes d'apprentissage en ligne ne prévoient pas cette utilisation (WIMS, edX, TAO Testing). edX a une composante nommée XBlocks qui permet de faire passer des tests adaptatifs précalculés.


# Formulation théorique du problème

## Réduction du test

@Lan2014 propose de chercher une sélection.

## Sous-modularité adaptative

L'extraction de connaissance latentes n'est utile que si elle permet effectivement d'expliquer les résultats observés. Nous proposons donc le problème de réduction du test avec prédiction de performance.

Quelles fonctions à optimiser (maximiser l'information de Fisher, minimiser l'erreur) vérifient cette condition ?

Cette méthode consiste à éliminer les hypothèses une à une efficacement afin de réaliser un diagnostic efficace. Elle a été utilisée dans des approches de marketing viral.

> Generalized Linear Models in Adaptive Submodularity

Le problème du test adaptatif en éducation rentre dans le cadre d'adaptive submodularity [@Golovin2011], qui fournit des bornes d'approximation sur le comportement du glouton $k$ fois comparé au meilleur ensemble de $k$ questions que l'on puisse poser.

C'est un bon moyen de comparer *computerized adaptive testing* (approche séquentielle) et *multistage testing* (groupe de questions).

\textcolor{red}{Il s'agirait de voir quels sont les }


# Comparaison des modèles

Nous souhaitions savoir lequel de ces modèles correspondait le mieux aux données, à savoir :

- SAT : multidisciplinaire
- Fraction : procédural
- Castor : concours
- Coursera (matrice incomplète)
- Moodle

## Protocole expérimental

Des données de test sont représentées sous la forme d'un tableau de questions d'un ensemble $Q$ posées à un ensemble d'étudiants $I$. Un test adaptatif se déroule habituellement comme suit.\bigskip

\noindent
\textsc{Tester}(étudiant $i \in I$) :  
\indent \textbf{Tant que} toutes les questions n'ont pas été posées  
\indent \indent \textsc{Poser} à l'étudiant $i$ la question suivante\bigskip

On cherche à comparer la capacité prédictive de différents modèles de tests adaptatifs, calibrés pour estimer la probabilité de répondre à une question inédite. Donc pour tous les modèles considérés, nous devons définir :

- un ensemble d'étudiants d'entraînement $I_{train} \subset I$ ;
- un ensemble d'étudiants de test $I_{test} \subset I$ ;
- un ensemble de questions de validation $Q_{val} \subset Q$.

Nous conservons ces ensembles pour tous les modèles évalués.\bigskip

\noindent
\textsc{ÉvaluerModèle}(modèle $M$, $I_{train}$, $I_{test}$, $Q_{val}$) :  
\indent \textsc{Entraîner} modèle avec $I_{train}$  
\indent \textbf{Pour chaque} étudiant $i$ de $I_{test}$ \textbf{faire}  
\indent \indent \textbf{Tant que} toutes les questions $\in Q \setminus Q_{val}$ n'ont pas été posées  
\indent \indent \indent \textsc{Poser} la question suivante  
\indent \indent \indent Évaluer les prédictions du modèle $M$ sur les questions $Q_{val}$.\bigskip

Validation croisée

:   Faire une validation croisée sur $k$ paquets (en anglais, *$k$-fold cross-validation* d'un modèle $M$ signifie qu'on divise le jeu de données en $k$ parties et qu'on évalue la prédiction du modèle sur chaque partie après l'avoir entraîné sur les $k - 1$ autres parties.

Protocole expérimental

:   Nous effectuons une validation croisée de chaque modèle sur 10 paquets d'étudiants et 4 paquets de questions. Ainsi, si on numérote les paquets d'étudiants $I_i$ pour $i = 1, \ldots, 10$ et les paquets de questions $Q_j$ pour $j = 1, \ldots, 4$, l'expérience $(i, j)$ consiste à :

1. entraîner le modèle évalué sur tous les paquets d'étudiants sauf le $i$-ième ($I_{train} = I \setminus I_i$) ;
2. poser des questions au $i$-ième paquet d'étudiants ($I_{test} = I_i$) sur tous les paquets de questions sauf le $j$-ième ($Q_j$) ;
3. évaluer après chaque question le modèle sur le $j$-ième paquet de questions ($Q_{val} = Q_j$).

Visualisation

:   Les erreurs calculées lors des expériences $(i, j)$ sont répertoriées dans un tableau de taille $10 \times 4$ (voir \ref{crossval}). Ainsi, en calculant la moyenne des erreurs pour chaque colonne, on peut visualiser comment les modèles se sont comportés sur un certain ensemble de questions.

Resserrage des intervalles de confiance

:   Nous effectuons 5 tels tableaux d'expériences avant le calcul de la moyenne globale afin de resserrer les intervalles de confiance.

![Le tableau d'expériences de la validation croisée sur 10 paquets d'étudiants et 4 paquets de question. Chaque case désigne une expérience pour un certain ensemble d'étudiants de test ($I_{test} = I_i$) et un certain ensemble de questions de validation ($Q_{val} = Q_j$).\label{crossval}](fig)

## Résultat

Selon le type de test, le meilleur modèle n'est pas toujours le même.

\begin{figure}
\centering
\includegraphics[width=0.6\linewidth]{fraction.png}
\caption{Comparing adaptive testing models. Evolution of error (negative log-likelihood) over the validation question set, after a certain number of questions have been asked.}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=0.6\linewidth]{counter.png}
\caption{Comparing adaptive testing models. Evolution of the number of questions in the validation question set incorrectly predicted, after a certain number of questions have been asked.}
\end{figure}

L'un ou l'autre modèle est plus prédictif selon :

- si le test est multidisciplinaire ;
- si le test est procédural (fractions) ;
- si le test est un concours.

Il faudrait élaborer une taxonomie.

Pour trouver d'autres jeux de données, il faut demander :

- aux contacts d'Éric ;
- regarder sur Datashop (Carnegie Mellon University, EDM).

## Perspectives

Connaître un test à fond (ontologie, modèle de la distance entre deux types de tâches).

Demander l'accès à l'ontologie d'Educlever ?

Quelles sont les poids choisis ? Quelle est la formule de la distance ?


## Modèles tirés d'autres littératures

### Systèmes de recommandation

Dans les systèmes de recommandation, on cherche à faire du filtrage collaboratif : trouver quels éléments sont susceptibles à un utilisateur. Mais cela passe par le problème de complétion de matrice, qui pourrait nous être utile. En fait ça a déjà été envisagé par @Bergner2012 ainsi que @ThaiNghe2010 et @Toscher2010 lors de la KDD Cup 2010, sur des données étudiant.

<!-- # Peu de données

Le nombre d'échantillons de mon dataset est en général petit, c'est pourquoi tout modèle de type deep learning fera du surapprentissage.
30 000 échantillons : quel nombre de paramètres semble raisonnable ? -->

### Démarrage à froid utilisateur

Lorsqu'un nouvel utilisateur se présente à un système de recommandation, le système aimerait pouvoir déterminer ses profils en initiant un test adaptatif.

La différence essentielle avec notre problème est qu'ici, nous n'avons pas à prendre en compte des réponses bruitées (l'utilisateur ne cherche pas à deviner la bonne réponse, il la connaît).

### Démarrage à froid question

Lorsqu'une nouvelle question arrive sur le test, on se demande à qui la poser pour déterminer sa difficulté. À chaque tour on a le choix entre poser une question qui va calibrer efficacement l'apprenant, et poser une question qui va permettre d'apporter de l'information sur la question.

@Anava2015 a proposé une méthode non adaptative. TODO en proposer une méthode adaptative car cette approche se débrouille souvent mieux même si elle est plus difficile à prouver [@Golovin2011].

### Trouver les voisins/profils

Comment nos expériences se comportent-elles lorsqu'on n'a accès qu'à un historique partiel de réponses ?

SPARFA : *sparse factor analysis*.  
Limitation : si un apprenant répond correctement à toutes les questions du test adaptatif, l'estimateur pense qu'il a un niveau $+\infty$. L'approche consiste à projeter l'estimateur de maximum de vraisemblance sur un compact afin d'éviter ce désagrément.



<!-- # Représentation du domaine

## Liens entre questions et composantes de connaissance

- Lien entre questions et composantes de connaissance requises : on peut concevoir un test adaptatif qui maintient tout au long du processus une estimation de la maîtrise de chaque composante de connaissance pour l'apprenant, en affinant son diagnostic à chaque étape. Cela s'appelle un CD-CAT, basé sur les q-matrices.

- Composantes de cno

- Ontologie du domaine.

## Hiérarchie sur les composantes de connaissance : graphe de prérequis sur les compétences

## Graphe plus riche, avec des liens de type « est requis » ou « renforce »

## Ontologie du domaine -->

# Test adaptatif multidimensionnel avec feedback : General Diagnostic Model

On aimerait avoir à la fois la notion de difficulté sur les items et une notion de dimensionalité de façon à faire un retour à l'apprenant selon plusieurs composantes de connaissance.

L'astuce consiste donc à entraîner un modèle de type MIRT en utilisant la q-matrice comme masque : le vecteur de l'item $i$ n'aura comme coefficients non nuls que ceux correspondant à une composante de connaissance impliquée dans sa résolution.

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi\left(\beta_i + \sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk}\right) $$

\nocite{*}
