# Introduction

De plus en plus d'évaluations de connaissances sont faites par ordinateur, que ce soient pour les célèbres tests standardisés (SAT, TOEFL, GMAT) ou celles que l'on trouve dans les MOOC. L'automatisation de l'évaluation a simplifié le stockage et l'analyse des données des apprenants, ce qui permet de proposer des évaluations plus précises et plus courtes pour des apprenants futurs. L'analytique de l'apprentissage[^1] consiste à collecter des données d'apprenants, déterminer des motifs permettant d'améliorer l'apprentissage au sens large, et de continuellement mettre à jour les modèles en fonction des nouvelles données récoltées [@Chatti2012]. D'autres travaux ont porté sur l'adaptation de l'enseignement à plusieurs niveaux : celui de la conception d'un cours en fonction des occurrences précédentes, celui de la tâche présentée à l'apprenant, et celui de l'étape de résolution suggérée à l'apprenant [@Aleven2016]. En évaluation, un test est dit *adaptatif*, s'il choisit la question suivante à poser en fonction des réponses que donne l'apprenant au cours du test. Réduire la durée de l'évaluation est d'autant plus utile qu'aujourd'hui les apprenants sont surévalués : par exemple, les écoliers américains entre l'école primaire et le lycée[^2] passent 20 à 25 heures par an à subir 8 évaluations obligatoires [@Zernike2015], ce qui pour un élève de 4\ieme{} représente 2,34 % du temps d'instruction, est générateur de stress, et laisse moins de temps pour les cours. C'est pourquoi le gouvernement américain a demandé moins de tests ou des tests plus utiles et réfléchis.

 [^1]: En anglais, *learning analytics*.

 [^2]: Entre l'équivalent américain du CM1 français et l'équivalent américain de la classe de première française.

Les premiers modèles utilisés pour les tests adaptatifs [@Hambleton1985] sont *sommatifs* : ils affectent un score, une valeur de niveau aux examinés, ce qui permet de les classer, et par exemple de déterminer ceux qui obtiendront un certificat. Plus récemment, on s'est demandé comment construire des tests adaptatifs *formatifs*, qui font un retour plus utile à l'apprenant pour qu'il puisse s'améliorer, par exemple sous la forme de points maîtrisés et de points à retravailler. Ainsi, en combinant des modèles de diagnostic cognitif, qui déterminent un profil discret correspondant à ce que maîtrise l'apprenant et ce qu'il ne maîtrise pas, avec des modèles de tests adaptatifs, on a pu proposer des tests adaptatifs de diagnostic cognitif [@Ferguson2012; @Huebner2010], qui en peu de questions indiquent à l'apprenant à la fin du test les points à retravailler. De tels retours permettent aux professeurs de juger le niveau de leur classe selon plusieurs dimensions, et aux apprenants d'avoir une indication de leurs points faibles et de leurs points forts.

Dans cette thèse, nous nous sommes concentrés sur l'utilisation de données de tests existants d'apprenants ayant répondu de façon correcte ou incorrecte à des questions, pour proposer des versions adaptatives de ces tests comportant moins de questions. De plus, nous souhaitons que ces tests soient formatifs, et qu'ils puissent faire un retour à l'apprenant. Ce retour peut être agrégé à différents niveaux (celui de l'étudiant, d'une classe, d'une école, d'un district, d'un état ou d'un pays), sur des tableaux de bord (*dashboards*), de façon à prendre des décisions informées [@Shute2016].

Dans ce chapitre, nous commençons par décrire plus précisément le domaine de l'analytique de l'apprentissage et ses méthodes, puis nous présentons les différents modèles de tests adaptatifs issus de différentes communautés, ainsi que leurs limitations.

# Analytique de l'apprentissage pour l'évaluation

En technologies de l'éducation, il existe deux domaines très proches qui sont celui de la fouille de données éducatives[^3] et l'analytique de l'apprentissage. La première consiste à se demander comment extraire de l'information à partir de données éducatives, en utilisant les modèles mathématiques adéquats. La deuxième se veut plus holistique et s'intéresse aux effets que les systèmes éducatifs ont sur l'apprentissage, et comment représenter les informations récoltées sur les apprenants de façon à ce qu'elles puissent être utilisées par des apprenants, des professeurs ou des administrateurs et législateurs.

 [^3]: En anglais, *educational data mining*.

Plus généralement, l'analytique de l'apprentissage consiste à se demander comment utiliser les données récoltées sur les apprenants pour améliorer l'apprentissage, au sens large.

En ce qui concerne l'évaluation, @Chatti2012 décrivent différents objectifs de l'analytique de l'apprentissage : le besoin d'un retour intelligent dans les évaluations et le problème de déterminer l'activité suivante à présenter à l'apprenant. Les méthodes utilisées sont regroupées en plusieurs classes : statistiques, visualisation d'information, fouille de données (dont les méthodes d'apprentissage automatique), et analyse de réseaux sociaux.

Comme le disent @Desmarais2012, « Le ratio entre la quantité de faits observés et la largeur de l'évaluation est particulièrement critique pour des systèmes qui couvrent un large nombre de compétences, dans la mesure où il serait inacceptable de poser des questions pendant plusieurs heures avant de faire une évaluation utilisable. » Ils décrivent donc l'importance de réduire la longueur des tests lorsqu'on cherche à évaluer beaucoup de compétences.

Dans les systèmes éducatifs, il y a une différence entre l'*adaptativité*, la capacité à modifier les contenus des cours en fonction de différents paramètres et d'un ensemble de règles préétablies, et l'*adaptabilité*, qui consiste à permettre aux apprenants de personnaliser les contenus de cours par eux-mêmes. @Chatti2012 précisent que « des travaux récents en apprentissage adaptatif personnalisé ont critiqué le fait que les approches traditionnelles soient dans une hiérarchie descendante et ignorent le rôle crucial des apprenants dans le processus d'apprentissage. » Il devrait y avoir un meilleur équilibre entre donner à l'apprenant ce qu'il a besoin d'apprendre (adaptativité) et lui donner ce qu'il souhaite apprendre (adaptabilité), de la façon qu'il souhaite l'apprendre (s'il préfère plus d'exemples, ou plus d'exercices). Dans tous les cas, construire un profil des connaissances de l'apprenant est une tâche cruciale.

Comme cas d'utilisation, considérons un nouvel arrivant sur un MOOC. Celui-ci ayant acquis des connaissances de différents domaines, certains prérequis du cours peuvent ne pas être maîtrisés tandis que d'autres leçons pourraient être sautées. Ainsi, il serait utile de pouvoir évaluer ses besoins et préférences de façon adaptative, pour filtrer le contenu du cours en conséquence et minimiser la surcharge d'information. @Lynch2014 décrivent un tel algorithme qui identifie l'état des connaissances d'un apprenant en posant quelques questions au début d'un cours.

En analytique de l'apprentissage, parmi les méthodes employées pour construire des modèles prédictifs, on trouve l'apprentissage automatique[^4]. Une application populaire consiste à prédire si un apprenant sur un MOOC va obtenir son certificat à partir de différentes variables liées aux traces de l'apprenant : le nombre d'heures passées à consulter les cours, à regarder les vidéos, le nombre de messages postés sur le forum, entre autres. Cela permet de détecter les apprenants en difficulté à un instant donné du cours, pour les inviter à se rendre sur le forum, ou leur indiquer des ressources utiles pour les motiver à continuer. La majorité de ces modèles prédictifs s'attaquent à prédire une certaine variable objectif à partir d'un nombre fixé de variables, mais à notre connaissance, peu de modèles interrogent l'apprenant sur ses besoins et préférences. Nous estimons qu'il reste encore beaucoup de recherche à faire vers des modèles d'analytique de l'apprentissage plus interactifs, et les travaux de cette thèse vont dans ce sens.

 [^4]: En anglais, *machine learning*.

Deux éléments issus des systèmes de recommandation peuvent être transposés au cadre éducatif de l'analytique de l'apprentissage. Le premier est la technique du filtrage collaboratif (cf. section \vref{collaborative-filtering}), qui permet de concevoir un système de recommandation de ressources pédagogiques [@Chatti2012; @Manouselis2011; @Verbert2011]. Le second est le problème du démarrage à froid de l'utilisateur, dans la mesure où lorsqu'un nouvel utilisateur utilise un système de recommandation, le système n'a que peu d'information sur lui et doit donc lui poser des questions de façon à éliciter ses préférences.

Le temps de réponse lors d'une évaluation a été étudié en psychologie cognitive, car le temps qu'un apprenant met pour répondre à une question peut indiquer quelques aspects sur le processus cognitif [@Chang2014] et joue un rôle dans la performance [@Papamitsiou2014]. Cela requiert des modèles statistiques spécifiques que nous ne considérons pas ici.

# Modèles de tests adaptatifs

Dans notre cas, nous cherchons à filtrer et à ordonner les questions à poser à un apprenant. Plutôt que de poser les mêmes questions à tout le monde, les tests adaptatifs [@VDL2010] choisissent la question suivante à poser à un certain apprenant en fonction des réponses qu'il a données depuis le début du test. Cela permet une adaptation à chaque étape de la séquence de questions. Leur conception repose sur deux critères : un critère de *terminaison* et un critère de *choix de la question suivante*. Tant que le critère de terminaison n'est pas satisfait (par exemple, poser un nombre de questions fixé à l'avance), les questions sont posées selon le critère de choix de la question suivante (par exemple, poser la question la plus informative pour déterminer les connaissances de l'apprenant). @Lan2014 ont prouvé que de tels tests adaptatifs pouvaient permettre, sur certains jeux de données de tests en mathématiques, d'obtenir une mesure aussi précise que des tests non adaptatifs, tout en requérant moins de questions.

Raccourcir la taille des tests est utile à la fois pour le système, qui doit équilibrer la charge du serveur, et pour les apprenants, qui risqueraient de se lasser de devoir fournir trop de réponses [@Lynch2014; @Chen2015]. Ainsi, les tests adaptatifs deviennent de plus en plus utiles dans l'ère actuelle des MOOC, où la motivation des apprenants joue un rôle important sur leur apprentissage [@Lynch2014]. Lorsqu'on implémente ces tests pour une utilisation réelle, des contraintes supplémentaires s'appliquent : pour qu'un apprenant n'ait pas à patienter longuement entre deux questions du test, le calcul du critère du choix de la question suivante doit se faire dans un temps raisonnable, ainsi la complexité en temps de ce calcul est importante. De même, lorsqu'on évalue des connaissances, un certain degré d'incertitude est à prendre en compte : un apprenant risque de faire des fautes d'inattention ou de deviner une bonne réponse alors qu'il n'a pas compris la question. C'est pourquoi une simple dichotomie sur le niveau de l'apprenant, c'est-à-dire poser des questions plus difficiles lorsqu'un apprenant réussit une question ou poser des questions plus faciles lorsqu'il échoue, n'est pas suffisant. Il faut considérer des méthodes plus robustes, tels que des modèles probabilistes pour l'évaluation des compétences.

\newacronym{gmat}{GMAT}{\emph{Graduate Management Admission Test}}

Les tests adaptatifs ont été étudiés au cours des dernières années et ont été développés en pratique. Par exemple, 238 536 tests de ce type ont été administrés via le \gls{gmat}, développé par le Graduate Management Admission Council (GMAC) entre 2012 et 2013. Étant donné un modèle de l'apprenant [@Pena2014], l'objectif est de fournir une mesure précise des caractéristiques d'un nouvel apprenant tout en minimisant le nombre de questions posées. Ce problème s'appelle la *réduction de longueur d'un test* [@Lan2014] et est également lié à la prédiction de performance future [@Bergner2012; @ThaiNghe2011]. En apprentissage automatique, ce problème est connu sous le nom d'apprentissage actif : choisir les éléments à étiqueter de façon adaptative afin de maximiser l'information récoltée à chaque pas.

Dans ce qui suit, nous ne permettons pas à l'apprenant de revenir en arrière pour corriger ses réponses, mais certaines variantes de modèles de tests adaptatifs le permettent [@Han2013; @Wang2015].

En fonction du but de l'évaluation, plusieurs modèles peuvent être utilisés, selon si l'on souhaite estimer un niveau général de connaissances, faire un diagnostic détaillé, ou identifier les connaissances maîtrisées par l'apprenant [@Mislevy2012]. Dans ce qui suit, nous proposons une répartition de ces modèles dans les trois catégories suivantes : théorie de la réponse à l'item pour des tests sommatifs, modèles de diagnostic cognitif pour des tests formatifs basés sur des composantes de connaissances, et enfin apprentissage automatique.

Dans ce qui suit, on suppose que $D$ désigne la matrice binaire $m \times n$ des succès (1) ou échecs (0) des $m$ apprenants sur les $n$ questions d'un test. Ainsi \og $D_{ij} = 1$ \fg{} désigne l'événement \og L'apprenant $i$ a répondu correctement à la question $j$ \fg.\nomenclature{$D$}{données des apprenants}

## Théorie de la réponse à l'item

La *théorie de la réponse à l'item* consiste à supposer que les réponses d'un apprenant que l'on observe lors d'un test peuvent être expliquées par un certain nombre de valeurs cachées, qu'il convient d'identifier.

### Modèle de Rasch

Le modèle le plus simple de tests adaptatifs est le *modèle de Rasch*, aussi connu sous le nom de modèle logistique à un paramètre. Il modélise un apprenant par une valeur unique de niveau, et les questions ou tâches à résoudre par une valeur de difficulté. La propension d'un apprenant à résoudre une tâche ne dépend que de la différence entre la difficulté de la tâche et le niveau de l'apprenant. Ainsi, si un apprenant $i$ a un niveau $\theta_i$ et souhaite résoudre une question $j$ de difficulté $d_j$ :\nomenclature{$\theta_i$}{valeur de niveau de l'apprenant $i$ pour le modèle de Rasch}\nomenclature{$d_j$}{valeur de difficulté de la question $j$ pour le modèle de Rasch}

\begin{equation}
Pr(D_{ij} = 1) = \Phi(\theta_i - d_j)
\end{equation}

\noindent
où $\Phi : x \mapsto 1 / (1 + e^{-x})$ est la fonction logistique. Ainsi, plus l'apprenant a un haut niveau, plus grande est sa chance de répondre correctement à chacune des questions et plus une question a une difficulté basse, plus grande est la chance de n'importe quel apprenant d'y répondre correctement.\nomenclature{$\Phi$}{fonction logistique}

Spécifier toutes les valeurs de difficulté à la main serait coûteux pour un expert, et fournirait des valeurs subjectives qui risquent de ne pas correspondre aux données observées. Ce modèle est suffisamment simple pour qu'il soit possible de calibrer automatiquement et de façon efficace les paramètres de niveau et difficulté, à partir d'un historique de réponses. En particulier, aucune connaissance du domaine n'est prise en compte.

Ainsi, lorsqu'un apprenant passe un test, les variables observées sont ses résultats (vrai ou faux) sur les questions qui lui sont posées, et la variable que l'on souhaite estimer est son niveau, en fonction des valeurs de difficulté des questions qui lui ont été posées ainsi que de ses résultats. L'estimation est habituellement faite en déterminant le maximum de vraisemblance, facile à calculer en utilisant la méthode de Newton pour trouver les zéros de la dérivée de la fonction de vraisemblance. Ainsi, le processus adaptatif devient : étant donné une estimation du niveau de l'apprenant, quelle question poser afin d'obtenir un résultat informatif pour affiner cette estimation ? Il est en effet possible de quantifier l'information que chaque question $j$ donne sur le paramètre de niveau. Il s'agit de l'information de Fisher, définie par la variance du gradient de la log-vraisemblance en fonction du paramètre de niveau :

\begin{equation}
I_j(\theta) = E_{X_j}\left[{\left(\frac\partial{\partial\theta} \log f(X_j, \theta,  d_j)\right)}^2 \bigg| \theta \right]
\end{equation}

- $\theta$ est le niveau de l'apprenant qui passe le test en cours ;
- $d_j$ est la difficulté de la question $j$ ;
- $X_j$ est la variable correspondant au succès/échec de l'apprenant sur la question $j$ : elle vaut 1 si $i$ a répondu correctement à $j$ et 0 sinon ;
- et $f(X_j, \theta, d_j)$ est la fonction de probabilité que $X_j$ vaille 1, qui dépend de $\theta$ comme indiqué plus haut : $f(X_j, \theta, d_j) = \Phi(\theta - d_j)$.

Ainsi, un test adaptatif peut être conçu de la façon suivante : étant donné l'estimation actuelle du niveau de l'apprenant, choisir la question qui va apporter le plus d'information sur son niveau, mettre à jour l'estimation en fonction du résultat (succès ou échec), et ainsi de suite. À la fin du test, on peut visualiser le processus comme dans les figures \ref{irt} et \ref{irt-output} : l'intervalle de confiance sur le niveau de l'apprenant est réduit après chaque résultat, et les questions sont choisies de façon adaptative.

\begin{figure}
\includegraphics[width=\linewidth]{figures/irt.pdf}
\caption{Évolution de l'estimation du niveau via un test adaptatif basé sur le modèle de Rasch. Les croix désignent des mauvaises réponses, les points des bonnes réponses.}
\label{irt}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=0.7\textwidth]{figures/adaptive}
\begin{multicols}{2}
\raggedright
\textbf{Apprenant 1}\\
On pose la q. 5 à l'apprenant.\\
\hfill Correct !\\
On pose la q. 12 à l'apprenant.\\
\hfill Incorrect !\\
On pose la q. 7 à l'apprenant.\\
\hfill Incorrect.\\
Le niveau de l'apprenant est 6.\\
\vfill \columnbreak
\textbf{Apprenant 2}\\
On pose la q. 5 à l'apprenant.\\
\hfill Incorrect.\\
On pose la q. 3 à l'apprenant.\\
\hfill Correct !\\
On pose la q. 4 à l'apprenant.\\
\hfill Incorrect.\\
Le niveau de l'apprenant est 3.
\end{multicols}
\caption{Deux exemples de déroulement de test adaptatif pour des apprenants ayant des motifs de réponse différents. Ici on considère que les questions sont de difficulté croissante.}
\label{irt-output}
\end{figure}

Le modèle de Rasch est unidimensionnel, donc il ne permet pas d'effectuer un diagnostic cognitif. Il reste pourtant populaire pour sa simplicité, sa généricité [@Desmarais2012; @Bergner2012] et sa robustesse [@Bartholomew2008]. @Verhelst2012 a montré qu'avec la simple donnée supplémentaire d'une répartition des questions en catégories, il est possible de renvoyer à l'examiné un profil utile à la fin du test, spécifiant quels sous-scores de catégorie sont plus bas ou plus haut que la moyenne.

### Théorie de la réponse à l'item multidimensionnelle

\label{mirt}
\newacronym{mirt}{MIRT}{\emph{Multidimensional Item Response Theory}}

Il est naturel d'étendre le modèle de Rasch à des compétences multidimensionnelles. En théorie de la réponse à l'item multidimensionnelle, aussi appelée \gls{mirt} [@Reckase2009], les apprenants et les questions ne sont plus modélisés par de simples scalaires mais par des vecteurs de dimension $d$. La probabilité qu'un apprenant réponde correctement à une question dépend seulement du produit scalaire du vecteur de l'apprenant et du vecteur de la question, plus un paramètre de facilité. Ainsi, un apprenant a plus de chances de répondre à des questions qui sont corrélées à son vecteur de compétences, et poser une question apporte de l'information dans la direction de son vecteur.

\def\R{\textbf{R}}

Ainsi, si l'apprenant $i \in \{1, \ldots, m\}$ est modélisé par le vecteur $\boldsymbol{\theta_i} \in \R^d$ et la question $j \in \{1, \ldots, n\}$ par le vecteur $\boldsymbol{d_j} \in \R^d$ et le paramètre de facilité $\delta_j \in \R$ :\nomenclature{$\boldsymbol{\theta_i}$}{caractéristiques de l'apprenant $i$ dans MIRT, GenMA}\nomenclature{$\boldsymbol{d_j}$}{paramètres de discrimination de la question $j$ dans MIRT, GenMA}\nomenclature{$\delta_j$}{paramètre de facilité de la question $j$ dans MIRT, GenMA}

\begin{equation}
Pr(D_{ij} = 1) = \Phi(\boldsymbol{\theta_i} \cdot \boldsymbol{d_j} + \delta_j).
\end{equation}

\label{rasch-mirt}

Notez qu'on retrouve le modèle de Rasch lorsque $d = 1$ et $d_{j1} = 1$, avec un paramètre de facilité $\delta_j$ à la place d'un paramètre de difficulté $d_j$.

Lorsqu'on considère un modèle de type MIRT, l'apprenant et les questions ont des caractéristiques selon plusieurs dimensions. L'information de Fisher qu'apporte une question n'est plus un scalaire mais une matrice, dont on cherche habituellement à maximiser soit le déterminant (règle D), soit la trace (règle T). Choisir la question avec la règle D apporte la plus grande réduction de volume dans la variance de l'estimation du niveau, tandis que choisir la question avec la règle T augmente l'information moyenne de chaque dimension du niveau, en ignorant la covariance entre composantes.

Ce modèle plus riche a beaucoup plus de paramètres : $d$ paramètres doivent être estimés pour chacun des $m$ apprenants et $d + 1$ paramètres pour chacune des $n$ questions, soit $d(n + m) + n$ paramètres au total. Ayant de nombreux paramètres, ce modèle est plus difficile à calibrer que le modèle de Rasch [@Desmarais2012; @Lan2014].

### SPARFA

\newacronym{sparfa}{SPARFA}{\emph{Sparse Factor Analysis}}

@Lan2014 ont défini un nouveau modèle de tests adaptatifs appelé \gls{sparfa}. Leur probabilité que l'apprenant réponde correctement à une certaine question repose sur un produit scalaire, ce qui est semblable au modèle MIRT, avec des contraintes supplémentaires.

Si l'apprenant $i \in \{1, \ldots, m\}$ est modélisé par le vecteur $\boldsymbol{\theta_i} \in \R^d$ et la question $j \in \{1, \ldots, n\}$ par le vecteur $\boldsymbol{d_j} \in \R^d$ et le paramètre de facilité $\delta_j \in \R$ :

\begin{equation}
Pr(D_{ij} = 1) = \Phi(\boldsymbol{\theta_i} \cdot \boldsymbol{d_j} + \delta_j).
\end{equation}

Si l'on note $V$ la matrice ayant pour lignes les vecteurs $\boldsymbol{d_j}$, SPARFA ajoute comme contrainte que $V$ doit être une matrice uniquement constituée d'entrées positives. De plus, $V$ doit être creuse, c'est-à-dire que la majorité de ses entrées est nulle.

En ajoutant la contrainte que $V$ est creuse, @Lan2014 font la supposition que chaque question fait appel à peu de caractéristiques de l'apprenant : en effet, le calcul de la probabilité que l'apprenant $i$ réponde correctement à la question $j$ dépend seulement de $\boldsymbol{\theta_i} \cdot \boldsymbol{d_j} + \delta_j$. Ainsi, pour chaque $k$ tel que $d_{jk}$ vaut 0, ce qui arrive souvent puisque $V$ est creuse, le niveau de l'apprenant $\theta_{ik}$ ne sera pas pris en compte dans le calcul de ses chances de succès pour répondre à la question $j$.

En ajoutant la contrainte que les entrées de $V$ sont positives, @Lan2014 supposent que le fait que l'apprenant ait un grand niveau dans une dimension ne peut pas diminuer ses chances de répondre correctement à une question.

Nous aurions voulu intégrer le modèle SPARFA dans notre comparaison de modèles au chapitre suivant, mais leur code n'est pas en accès libre. De plus, le test ainsi considéré est sommatif selon plusieurs dimensions, mais pas formatif, car les caractéristiques extraites par SPARFA ne sont pas facilement interprétables. @Lan2014 essaient d'interpréter a posteriori les colonnes de la matrice $V$, en utilisant des tags spécifiés par des experts sur les questions, mais ce n'est pas toujours possible.

### Tests à étapes multiples

Jusqu'à présent, nous n'avons considéré que des questions posées une par une. Mais les premières étapes d'un test adaptatif conduisent à des estimations du niveau de l'apprenant peu représentatives de la réalité, car il y a peu de réponses observées sur lesquelles s'appuyer pour effectuer un diagnostic. C'est pourquoi d'autres recherches en psychométrie portent sur des tests à étapes multiples [@Yan2014], qui adaptent le processus d'évaluation seulement après qu'un groupe de questions a été posé. Ainsi, l'adaptation se fait au niveau des groupes et non des questions : après avoir posé un premier ensemble de $k_1$ questions à un apprenant, un autre ensemble de $k_2$ questions est sélectionné en fonction de sa performance sur le premier ensemble, et ainsi de suite, voir la figure \ref{mst}. Cela permet également à l'apprenant de vérifier ses réponses avant de valider, ce qui déclenche le processus suivant de questions.

Il y a ainsi un compromis entre adapter le processus de façon séquentielle, après chaque question, et ne le faire que lorsque suffisamment d'information a été récoltée sur l'apprenant. @Wang2016 suggèrent de poser un groupe de questions au début du test, lorsque peu d'information sur l'apprenant est disponible, puis progressivement réduire le nombre de questions de chaque groupe afin d'augmenter les opportunités d'adapter le processus. Aussi, poser des groupes de questions permet d'équilibrer les ensembles de questions en termes de connaissances évaluées, tandis que poser les questions une par une peut conduire à un test où les connaissances évaluées peuvent beaucoup changer d'une question à l'autre.

\begin{figure}
\centering
\includegraphics{figures/mst.pdf}
\caption{Un exemple de test à étapes multiples. Les questions sont posées par groupe.}
\label{mst}
\end{figure}

## Modèles de diagnostic cognitif basés sur les composantes de connaissances

\newacronym{cc}{CC}{composantes de connaissances}

Les *modèles de diagnostic cognitif* font l'hypothèse que la résolution des questions ou tâches d'apprentissage peut être expliquée par la maîtrise ou non-maîtrise de certaines \gls{cc}, ce qui permet de transférer de l'information d'une question à l'autre. Par exemple, pour calculer $1/7 + 8/9$ correctement, un apprenant est censé maîtriser l'addition, et la mise au même dénominateur. En revanche, pour calculer $1/7 + 8/7$, il suffit de savoir additionner deux fractions de même dénominateur. Ces modèles cognitifs requièrent la spécification des CC impliqués dans la résolution de chacune des questions du test, sous la forme d'une matrice binaire appelée *q-matrice*, qui fait le lien entre les questions et les CC : c'est ce qu'on appelle un modèle de transfert. Un exemple de q-matrice est donné à la table \ref{fraction-qmatrix} pour un test de 20 questions de soustraction de fractions comportant 8 composantes de connaissances. Le jeu de données de test correspondant est étudié dans [@DeCarlo2010] et à la section \vref{datasets} de cette thèse.

\begin{table}
\centering
\begin{minipage}{0.49\textwidth}
\small
\begin{tabular}{c@{\hspace{5mm}}cccccccc} \toprule
& \multicolumn{8}{c}{Comp. de connaissances}\\
& 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8\\ \midrule
Q1 & 0 & 0 & 0 & 1 & 0 & 1 & 1 & 0\\
Q2 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\
Q3 & 0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\
Q4 & 0 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
Q5 & 0 & 1 & 0 & 1 & 0 & 0 & 1 & 1\\
Q6 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
Q7 & 1 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
Q8 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
Q9 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0\\
Q10 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 1\\
Q11 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\
Q12 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1\\
Q13 & 0 & 1 & 0 & 1 & 1 & 0 & 1 & 0\\
Q14 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
Q15 & 1 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
Q16 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
Q17 & 0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\
Q18 & 0 & 1 & 0 & 0 & 1 & 1 & 1 & 0\\
Q19 & 1 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
Q20 & 0 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\ \bottomrule
\end{tabular}
\end{minipage}
\begin{minipage}{0.5\textwidth}
\small
Description des huit composantes de connaissances :
\begin{enumerate}
\item convertir un nombre entier en fraction
\item séparer un nombre entier d'une fraction
\item simplifier avant de soustraire
\item mettre au même dénominateur
\item soustraire une fraction d'un entier
\item poser la retenue lors de la soustraction des numérateurs
\item soustraire les numérateurs
\item réduire les fractions sous forme irréductible
\end{enumerate}
\end{minipage}
\caption{Exemple de q-matrice pour un test de 20 questions de soustraction de fractions.}
\label{fraction-qmatrix}
\end{table}

### Modèle DINA

\label{dina}
\newacronym{dina}{DINA}{\emph{Deterministic Input, Noisy And}}

Le modèle \gls{dina}, qui signifie \og entrée déterministe avec un *et* bruité \fg, suppose que l'apprenant résoudra une certaine question $i$ avec probabilité $1 - s_i$ s'il maîtrise toutes les CC impliquées dans sa résolution, sinon avec probabilité $g_i$. Le paramètre $g_i$ est le paramètre de chance de la question $i$, c'est-à-dire la probabilité de deviner la bonne réponse alors que l'on ne maîtrise pas les CC nécessaires, tandis que $s_i$ est le paramètre d'inattention, c'est-à-dire la probabilité de se tromper alors qu'on maîtrise les CC associées. Il existe d'autres variantes de modèles cognitifs tels que le modèle DINO (*Deterministic Input, Noisy Or*, c'est-à-dire entrée déterministe, avec un « ou » avec bruit) où ne maîtriser qu'une seule des CC impliquées dans une question $i$ suffit à la résoudre avec probabilité $1 - s_i$, et si en revanche aucune CC impliquée n'est maîtrisée, la probabilité d'y répondre correctement est $g_i$.\nomenclature{$g_i$}{paramètre de chance pour le modèle DINA}\nomenclature{$s_i$}{paramètre d'inattention pour le modèle DINA}\nomenclature{$K$}{nombre de composantes de connaissances}

\newacronym{cdcat}{CD-CAT}{\emph{Cognitive Diagnostic Computerized Adaptive Tests}}

S'il y a $K$ composantes de connaissances mises en œuvre dans le test, l'état latent d'un apprenant est représenté par un vecteur de $K$ bits $(c_1, \ldots, c_K)$, un par CC : $c_k$ vaut 1 si l'apprenant maîtrise la $k$-ième CC, 0 sinon. Chaque réponse que l'apprenant donne sur une question nous donne de l'information sur les états possibles qui pourraient correspondre à l'apprenant. @Xu2003 ont utilisé des stratégies de tests adaptatifs pour inférer l'état latent de l'apprenant en utilisant peu de questions, c'est ainsi qu'ont été développés les modèles de tests adaptatifs pour le diagnostic cognitif, en anglais \gls{cdcat} [@Cheng2009]. À partir d'une estimation a priori de l'état mental de l'apprenant, on peut inférer son comportement sur les questions restantes du test, et choisir des questions informatives en fonction. À chaque étape, le système maintient une distribution de probabilité sur les $2^K$ états mentaux possibles et l'affine après chaque réponse de l'apprenant en utilisant une approche bayésienne.

Pour converger rapidement vers l'état latent le plus vraisemblable, la meilleure question à poser est celle qui réduit le plus l'incertitude [@Doignon2012; @Huebner2010], c'est-à-dire l'entropie de la distribution sur les états latents possibles :

\begin{equation}
H(\pi) = - \sum_{c \in \{0, 1\}^K} \pi(c) \log \pi(c).
\end{equation}

Nous présentons un exemple de test adaptatif basé sur le modèle DINA, à partir de la q-matrice spécifiée dans la figure \ref{example-dina}. Si la tâche 1 est présentée à l'apprenant, et qu'il la résout correctement, cela signifie que les CC **form** et **mail** ont de bonnes chances d'être maîtrisées. Il est donc peu informatif de présenter la tâche 2. Si la tâche 4 est présentée, et que l'apprenant échoue, la CC **url** risque de ne pas être maîtrisée, ainsi il n'est pas nécessaire de poser la tâche 3. À la fin du test, le système peut dire à l'apprenant \og Vous semblez maîtriser les CC **form** et **mail** mais pas **url**.

\begin{figure}
\centering
\includegraphics{figures/compnum.pdf}
\caption{Exemple de q-matrice pour un test adaptatif basé sur le modèle DINA.}
\label{example-dina}
\end{figure}

Comme le dit @Chang2014, \og Une étude conduite à Zhengzhou indique que CD-CAT encourage la pensée critique, en rendant les étudiants plus autonomes en résolution de problèmes, et offre de la remédiation personnalisée facile à suivre, ce qui rend l'apprentissage plus intéressant. \fg{} En effet, une fois que l'état mental de l'apprenant a été identifié, on peut l'orienter vers des ressources utiles pour combler ses lacunes.

Comme l'espace des états latents possibles est discret, on peut maintenir une distribution de probabilité $(\pi_i)_{i \geq 0}$ sur les vecteurs de compétences possibles, mise à jour après chaque réponse de l'apprenant. Connaissant la réponse de l'apprenant à la $i$-ème question, la mise à jour de $\pi_{i - 1}$ est faite par la règle de Bayes. Soit $x$ un état latent, $s_i$ et $g_i$ les paramètres d'inattention et de chance associés à la $i$-ème question et soit $a_i$ une variable qui vaut 1 si la réponse de l'apprenant est correcte, 0 sinon. Si les CC associées à $x$ sont suffisantes pour répondre à la question correctement,

\label{dina-update}

\begin{equation}
\pi_i(x) \propto \pi_{i - 1}(x) \cdot [a_i \cdot(1-s_i) + (1-a_i)\cdot s_i]
\end{equation}

\noindent
sinon

\begin{equation}
\pi_i(x) \propto \pi_{i - 1}(x) \cdot [a_i \cdot g_i + (1-a_i)\cdot(1-g_i)].
\end{equation}

\nomenclature{$\propto$}{proportionnel à}

En effet : si $x$ a bien les compétences requises, il peut soit donner la bonne réponse en ne faisant pas d'erreur d'inattention (résultat $a_i = 1$ avec probabilité $1 - s_i$), soit faire une erreur d'inattention (résultat $a_i = 0$ avec probabilité $s_i$).

La complexité du choix de la question suivante est $O(2^K K |Q|)$, ce qui est impraticable pour de larges valeurs de $K$. C'est pourquoi en pratique $K \leq 10$ [@Su2013].

\label{auto-q-matrix}

La q-matrice peut être coûteuse à construire. Ainsi, calculer une q-matrice automatiquement est un sujet de recherche à part entière. @Barnes2005 utilise une technique d'escalade de colline[^5] (qui consiste à modifier un bit de la q-matrice, regarder si le taux d'erreur du modèle diminue, et itérer le processus) tandis que @Winters2005 et @Desmarais2011 ont essayé des méthodes de factorisation de matrice pour recouvrer des q-matrices à partir de données d'apprenants. Ils ont découvert que pour des domaines bien distincts comme le français et les mathématiques, ces techniques permettent de séparer les questions qui portent sur ces domaines. Une critique est que même si l'on obtient via ces méthodes automatiques des matrices qui correspondent bien aux données, les colonnes risquent de ne plus être interprétables. @Koedinger2012 ont réussi à combiner des q-matrices de différents experts par externalisation ouverte (*crowdsourcing*) de façon à obtenir des q-matrices plus riches, toujours interprétables, et qui correspondent davantage aux données.

 [^5]: En anglais, *hill-climbing technique*.

Un avantage du modèle DINA est qu'il n'a pas besoin de données de test pour être déjà adaptatif. La q-matrice suffit à administrer des tests, où l'on suppose alors que les apprenants ont autant de chance de maîtriser une composante que de ne pas la maîtriser. À l'aide d'un historique des réponses des apprenants, on peut avoir un a priori sur les composantes qu'un nouvel apprenant maîtrisera ou non, et améliorer l'adaptation.

### Modèle de hiérarchie sur les attributs

Il est toutefois possible de réduire la complexité en supposant des relations de prérequis entre composantes de connaissances (CC) : si la maîtrise d'une CC implique celle d'une autre CC, le nombre d'états possibles décroît et donc la complexité en temps fait de même. Cette approche est appelée modèle de hiérarchie sur les attributs (en anglais, *Attribute Hierarchy Model*) [@Leighton2004] et permet d'obtenir des représentations de connaissances qui correspondent mieux aux données [@Rupp2012].\label{ahm}

Nous allons à présent présenter la théorie des espaces de connaissances, découverte indépendamment des modèles de hiérarchie sur les attributs, mais qui y ressemble beaucoup.

### Théorie des espaces de connaissances basés sur les compétences
\label{knowledge-space}

@Doignon2012 ont développé la théorie des espaces de connaissances, qui repose sur une représentation abstraite des connaissances similaire aux composantes de connaissances (CC) qui apparaissent dans les q-matrices considérées par le modèle DINA. Ainsi, *l'état des connaissances* d'un apprenant peut être modélisé par l'ensemble des CC qu'il maîtrise. Supposons qu'il existe un certain nombre de CC à apprendre, pour lesquelles on connaît des relations de prérequis, c'est-à-dire quelles CC doivent être maîtrisées avant d'apprendre une certaine CC (voir figure \ref{dependency}). À partir de ce graphe, on peut calculer les états de connaissances dans lesquels l'apprenant peut se trouver. Par exemple, dans la figure \ref{dependency}, $\{a, c\}$ est un état des connaissances possible tandis que $\{c\}$ ne l'est pas, car $a$ doit être maîtrisé avant $c$. Donc pour cet exemple, il y a 10 états de connaissances possibles pour l'apprenant : $\emptyset$, $\{a\}$, $\{b\}$, $\{a, b\}$, $\{a, c\}$, $\{a, b, c\}$, $\{a, b, c, d\}$, $\{a, b, c, e\}$, $\{a, b, c, d, e\}$ et $\{a, b, c, d, e, f\}$. Un test adaptatif peut donc déterminer l'état des connaissances de l'apprenant d'une façon similaire au modèle de hiérarchie sur les attributs décrit plus haut dans cette section. Une fois que l'état des connaissances de l'apprenant a été identifié, le modèle peut lui suggérer les prochaines CC à apprendre pour progresser, à travers ce que l'on appelle un parcours d'apprentissage (voir figure \ref{dependency}). Par exemple, si l'apprenant a pour état de connaissances $\{a\}$, il peut choisir d'apprendre $b$ ou $c$.

@Falmagne2006 proposent un test adaptatif pour deviner de façon efficace l'état des connaissances de l'apprenant en minimisant l'entropie de la distribution sur les états des connaissances possibles de l'apprenant, mais leur méthode n'est pas robuste aux erreurs d'inattention. Ce modèle a été implémenté dans le système ALEKS, qui appartient désormais à McGraw-Hill Education et est utilisé par des millions de personnes aujourd'hui [@Kickmeier2015; @Desmarais2012].

\begin{figure}
\centering
\includegraphics{figures/knowledge-space.pdf}
\qquad
\includegraphics[width=0.4\textwidth]{figures/learning-path.pdf}
\caption{À gauche, un graphe de dépendance. À droite les parcours d'apprentissage possibles pour apprendre toutes les CC.}
\label{dependency}
\end{figure}

@Lynch2014 ont implémenté un test adaptatif analogue à la construction de @Falmagne2006 au début d'un MOOC de façon à deviner ce que l'apprenant maîtrise déjà et l'orienter automatiquement vers des ressources utiles du cours. Pour résister aux erreurs d'inattention et aux apprenants qui devinent les bonnes réponses sans avoir les CC nécessaires, ils combinent des modèles de la théorie des espaces de connaissances et de la théorie de la réponse à l'item, sans donner les détails de leurs constructions.

Certains modèles plus fins pour le diagnostic de connaissances considèrent des représentations de connaissances plus riches, telles que des réseaux bayésiens [@Shute2011; @Rupp2012] ou des ontologies du domaine couvert par le test [@Mandin2014; @Kickmeier2015]. Toutefois, de telles représentations sont coûteuses à construire, car il faut spécifier le poids d'une certaine relation entre la représentation de connaissances et chaque question du test.

## Lien avec l'apprentissage automatique

### Tests adaptatifs et filtrage collaboratif

\label{collaborative-filtering}

Une application de l'apprentissage automatique est l'élaboration de systèmes de recommandation, capables de recommander des ressources à des utilisateurs en fonction d'autres ressources qu'ils ont appréciées. En technologies de l'éducation, de tels systèmes sont appliqués à la recommandation de ressources pédagogiques [@Chatti2012; @Manouselis2011; @Verbert2011].

Le but est de prédire le comportement d'un utilisateur face à une ressource inédite, à partir de ses préférences sur une fraction des ressources qu'il a consultées. Deux techniques sont principalement utilisées.

1. Des recommandations *basées sur le contenu*, qui analysent le contenu des ressources de façon à calculer une mesure de similarité entre ressources, pour recommander des ressources similaires à celles appréciées par l'utilisateur. Ici, la communauté d'utilisateurs n'a pas d'impact sur les recommandations.
2. Le *filtrage collaboratif*, où la mesure de similarité entre ressources dépend seulement des préférences des utilisateurs : des produits étant préférés par les mêmes personnes sont supposés proches. À partir des données communiquées par les autres internautes (*collaboratif*), il est possible de faire le tri de façon automatique (*filtrage*) pour un nouvel utilisateur, par exemple en identifiant des internautes ayant aimé des produits similaires et en lui suggérant des ressources qui les ont satisfaits.

Dans notre cas, nous devons prédire la performance d'un apprenant sur une question inédite, en fonction de son comportement sur d'autres questions et du comportement que d'autres apprenants ont eu dans le passé sur le même test. Les techniques de filtrage collaboratif ont été appliquées à deux problèmes issus de la fouille de données éducatives : la recommandation de ressources éducatives à des apprenants [@Manouselis2011; @Verbert2011] et la prédiction de performance d'un apprenant sur un test [@Toscher2010; @ThaiNghe2011; @Bergner2012].

En filtrage collaboratif, on fait l'hypothèse que l'on dispose d'utilisateurs ayant noté certains objets : $m_{ui}$ désigne la note que l'utilisateur $u$ affecte à l'objet $i$. La matrice observée $M = (m_{ui})$ est creuse, c'est-à-dire qu'une faible partie de ses entrées est renseignée. Le problème consiste à déterminer les entrées manquantes de $M$ (voir table \ref{matrix-completion}). Afin d'accomplir cette tâche, on suppose en général que $M$ a un faible rang, c'est-à-dire que les notes des utilisateurs sont dans un espace de faible dimension, ou encore qu'on peut les exprimer par un faible nombre de composantes.

\begin{table}
\centering
\begin{tabular}{ccccc} \toprule
& Zootopie & 12 Monkeys & Oldboy & Paprika\\ \midrule
Sacha & $?$ & 5 & $2$ & $?$\\
Ondine & 4 & 1 & $?$ & 5\\
Pierre & 3 & 3 & 1 & 4\\
Joëlle & 5 & $?$ & 2 & $?$\\ \bottomrule
\end{tabular}
\caption{Un exemple de problème de complétion de matrice.}
\label{matrix-completion}
\end{table}

L'historique d'un test peut également être représenté par une matrice $M = (m_{ui})$ où l'élément $m_{ui}$ représente 1 si l'apprenant $u$ a répondu correctement à la question $i$, 0 sinon. Administrer un test adaptatif à un nouvel apprenant revient à ajouter une ligne dans la matrice et choisir les composantes à révéler (les questions à poser) de façon à inférer les composantes restantes (les questions qui n'ont pas été posées).

Un autre élément qui apparaît dans les systèmes de recommandation peut être utile à notre analyse, celui du *démarrage à froid de l'utilisateur* : étant donné un nouvel utilisateur, comment lui recommander des ressources pertinentes ? La seule référence que nous ayons trouvée au problème du démarrage à froid dans un contexte éducatif vient de @ThaiNghe2011 : \og Dans des environnements éducatifs, le problème du démarrage à froid n'est pas aussi dérangeant que dans des environnements commerciaux, où de nouveaux utilisateurs ou produits apparaissent chaque jour ou même chaque heure. Donc, les modèles n'ont pas besoin d'être réentraînés continuellement. \fg{} Toutefois, l'arrivée des MOOC en 2011 a accentué le besoin de mettre à jour fréquemment les modèles de recommandation de ressources.

Parmi les techniques les plus populaires pour s'attaquer au problème du démarrage à froid de l'utilisateur, une méthode qui nous intéresse particulièrement est un test adaptatif qui présente certaines ressources à l'apprenant et lui demande de les noter. @Golbandi2011 construisent un arbre de décision qui pose des questions à un nouvel utilisateur et choisit en fonction de ses réponses la meilleure question à lui poser de façon à identifier rapidement un groupe d'utilisateurs qui lui sont proches. Les meilleures questions sont celles qui séparent la population en trois parties de taille similaire, selon si l'utilisateur a apprécié la ressource, n'a pas apprécié la ressource, ou ne connaît pas la ressource. La différence principale avec notre cadre éducatif est que les apprenants risquent de moins coopérer avec un système d'évaluation qu'avec un système de recommandations commercial, car leur objectif n'est pas d'obtenir des bonnes recommandations mais un bon score. Ainsi, leurs réponses risquent de ne pas refléter les compétences qu'ils maîtrisent vraiment. C'est pourquoi les modèles que l'on considère pour les tests adaptatifs doivent prendre en compte le fait que l'apprenant puisse faire des fautes d'inattention, ou deviner la bonne réponse.

### Stratégies adaptatives pour le compromis exploration-exploitation
\label{bandits}

Dans certaines applications de tests adaptatifs, on souhaite maximiser une fonction objectif pendant qu'on pose les questions. Par exemple, supposons qu'un site commercial cherche à maximiser le nombre de clics sur ses publicités. Il y a un compromis entre explorer l'espace des publicités en présentant à l'utilisateur des publicités plus risquées, et exploiter la connaissance de l'utilisateur en lui présentant des publicités sur des domaines susceptibles de lui plaire.

Dans un contexte éducatif, on peut se demander quelle serait la tâche qui permettrait de maximiser la progression de l'apprenant, tout en cherchant à identifier ce qu'il maîtrise ou non. C'est la technique que @Clement2015 adoptent pour les systèmes de tuteurs intelligents : ils personnalisent les séquences d'activités d'apprentissage de façon à identifier les CC de l'apprenant tout en maximisant son progrès, défini comme la performance sur les dernières activités.

Pour cela, ils utilisent des modèles de bandits. Le problème du bandit manchot consiste à se demander, si l'on dispose de $k$ machines à sous d'espérances de gain inconnues, quelles machines essayer séquentiellement pour maximiser le gain. Il y a donc un compromis entre exploiter les machines dont on sait qu'elles ont une bonne espérance avec un intervalle de confiance serré, et explorer les machines plus risquées, parce qu'elles ont un intervalle de confiance plus large.

@Clement2015 utilisent deux modèles de bandits, l'un se basant sur la zone proximale de développement de Vygotski[^6] [@Vygotsky1980] sous la forme d'un graphe de prérequis, l'autre sur une q-matrice. Ils ont comparé ces deux approches sur 400 apprenants de 7 et 8 ans, et ont découvert que le graphe de dépendance se comportait mieux que le modèle qui utilise une q-matrice spécifiée par un expert. Leur technique est adaptée à des populations d'apprenants de niveaux variés, notamment ceux ayant des difficultés.

 [^6]: En français, Vygotski, en anglais, Vygotsky.

# Comparaison de modèles de tests adaptatifs

Comme le disent @Desmarais2012 : \og Les modèles de tests adaptatifs doivent être validés sur des données réelles afin de garantir que le modèle évalue bien ce qu'on croit qu'il évalue. Une validation usuelle réside dans la capacité de l'évaluation à prédire la performance future au sein du système d'apprentissage. \fg

Habituellement, on compare pour un même modèle plusieurs stratégies de choix de la question suivante. @Cheng2009 compare ainsi plusieurs critères de sélection de la question suivante pour le modèle DINA utilisé dans un cadre de tests adaptatifs. Pour ses expériences, elle considère des données simulées.

@Lalle2013 utilise une technique de validation croisée pour comparer des modèles de diagnostic de connaissances, mais pas dans le cadre de tests adaptatifs. Plus rarement, certaines recherches comparent des modèles de tests adaptatifs différents sur de mêmes données de test : @Lan2014 comparent SPARFA et le modèle de Rasch, @Bergner2012 comparent des algorithmes de filtrage collaboratif au modèle de Rasch. Toutefois, nous n'avons pas observé de comparaison de modèles sommatifs avec des modèles formatifs.

# Conclusion

Dans ce chapitre, nous avons présenté différents modèles de tests adaptatifs identifiés dans divers pans de la littérature, que nous avons classés selon trois catégories : théorie de la réponse à l'item, modèles de diagnostic basés sur les composantes de connaissances et apprentissage automatique. Nous avons mentionné différents travaux consistant à les comparer sur un même jeu de données.

L'avantage principal des modèles de théorie de la réponse à l'item est qu'ils peuvent être calibrés automatiquement à partir d'un historique des réponses d'un test, ce qui est utile dans des évaluations faites par ordinateur où l'on a facilement accès à un large historique d'utilisation, en particulier dans les MOOC. Ils conviennent donc tout à fait au cadre de l'analytique de l'apprentissage. En contrepartie, de tels tests sommatifs sont moins utiles à l'apprentissage que les modèles basés sur les composantes de connaissances qui permettent d'indiquer à l'apprenant et son professeur les points à améliorer. Ceux-ci ne dépendent plus d'un historique d'utilisation mais d'une représentation de connaissances minimale, faisant le lien entre chaque question et les CC qu'elle requiert pour être résolue correctement. Enfin, il nous a semblé important d'introduire les modèles d'apprentissage automatique pour leur cadre générique qui consiste à tenter d'optimiser une fonction objectif bien définie à partir de données existantes, et qui ont été utilisés dans de multiples domaines, associés à de larges bases de données.

Dans le chapitre suivant, nous allons faire une comparaison qualitative de ces modèles et proposer un système de comparaison quantitative de modèles de tests adaptatifs.
