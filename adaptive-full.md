# Introduction

'De plus en plus d'évaluations de connaissances sont faites par ordinateur, que ce soient pour les célèbres tests standardisés (SAT, TOEFL, GMAT) ou celles qu'on trouve dans les *cours massifs en ligne* (MOOC, *massive online open courses*). L'automatisation de l'évaluation a simplifié le stockage et l'analyse des données des apprenants, ce qui permet de proposer des évaluations plus précises et plus courtes pour des apprenants futurs. L'analytique de l'apprentissage[^1] consiste à collecter des données d'apprenants, déterminer des motifs permettant d'améliorer l'apprentissage au sens large, et de continuellement mettre à jour les modèles en fonction des nouvelles données récoltées [@Chatti2012]. On s'est intéressé à l'adaptation de l'enseignement à plusieurs niveaux : celui de la conception du cours en fonction des occurrences précédentes, celui de la tâche présentée à l'apprenant, et celui de l'étape de résolution suggérée à l'apprenant [@Aleven2016]. En évaluation, un test est dit *adaptatif*, s'il choisit la question suivante à poser en fonction des réponses que donne l'apprenant au cours du test. Réduire la durée de l'évaluation est d'autant plus utile qu'aujourd'hui les apprenants sont surévalués : par exemple, les écoliers américains entre l'équivalent CM1 au primaire et l'équivalent première au lycée passent 20 à 25 heures par an à passer 8 évaluations obligatoires [@Zernike2015], ce qui représente 2,34 % du temps d'instruction d'un enfant d'équivalent 4\ieme au collège, et laisse moins de temps pour les cours, c'est pourquoi le gouvernement a demandé moins de tests ou des tests plus utiles et réfléchis.

 [^1]: En anglais, *learning analytics*.

Les premiers modèles utilisés pour les tests adaptatifs [@Hambleton1985] sont *sommatifs* : ils affectent un score, une valeur de niveau aux examinés, ce qui permet de les classer, et par exemple de déterminer ceux qui obtiendront un certificat. Plus récemment, on s'est demandé comment construire des tests adaptatifs *formatifs*, qui font un retour plus utile à l'apprenant pour qu'il puisse s'améliorer, par exemple sous la forme de points maîtrisés et de points à retravailler. Ainsi, en combinant des modèles cognitifs, qui déterminent un profil discret correspondant à ce que maîtrise l'apprenant et ce qu'il ne maîtrise pas, avec des modèles de tests adaptatifs, on a pu proposer des diagnostics cognitifs adaptatifs [@Ferguson2012; @Huebner2010], qui indiquent à l'apprenant à la fin du test les points à retravailler et sont d'autant plus utiles pour les apprenants pour s'orienter, et pour les professeurs pour juger le niveau de leur classe.

Dans cette thèse, nous nous sommes concentrés sur l'utilisation de données de tests existants d'apprenants ayant répondu de façon correcte ou incorrecte à des questions, pour proposer des versions adaptatives de ces tests comportant moins de questions. De plus, nous souhaitons que ces tests soient formatifs, et qu'ils fassent un retour à l'apprenant. Ce retour peut être agrégé à différents niveaux (celui de l'étudiant, d'une classe, d'une école, d'un district, d'un état ou d'un pays), sur des panneaux de visualisation (*dashboards*), de façon à prendre des décisions informées [@Shute2016].

Ce chapitre est organisé de la façon suivante. Nous commençons par décrire plus précisément le domaine de l'analytique de l'apprentissage et ses méthodes, puis nous présentons les différents modèles de tests adaptatifs issus de domaines divers ainsi que leurs limitations.

# Analytique de l'apprentissage

Il existe deux domaines très proches qui sont celui de la fouille de données éducatives[^2] et l'analytique de l'apprentissage. La première part d'un modèle mathématique et se demande comment extraire de l'information à partir de données éducatives. La deuxième se veut plus holistique et s'intéresse aux effets que les systèmes éducatifs ont sur l'apprentissage, et comment représenter les informations récoltées sur les apprenants de façon à ce qu'elles puissent être utilisées par des apprenants, des professeurs ou des administrateurs et législateurs.

 [^2]: En anglais, *educational data mining*.

Sur le plan de l'évaluation qui nous concerne, @Chatti2012 décrit différents objectifs de l'analytique de l'apprentissage : le besoin d'un retour intelligent dans les évaluations, le problème de déterminer l'activité suivante à présenter à l'apprenant. Les méthodes utilisées sont regroupées en plusieurs classes : statistiques, visualisation d'information, fouille de données (dont apprentissage statistique), et analyse de réseaux sociaux.\nomenclature{LA}{learning analytics}

Comme le disent @Desmarais2012, « Le ratio entre la quantité de faits observés et la largeur de l'évaluation est particulièrement critique pour des systèmes qui couvrent un large nombre de compétences, dans la mesure où il serait inacceptable de poser des heures de questions avant de faire une évaluation utilisable. »

Dans les systèmes éducatifs, il y a une différence entre l'*adaptativité*, la capacité à modifier les contenus des cours en fonction de différents paramètres et d'un ensemble de règles préétablies, et l'*adaptabilité*, qui consiste à permettre aux apprenants de personnaliser les contenus de cours par eux-mêmes. @Chatti2012 précise que « des travaux récents en apprentissage adaptatif personnalisé ont critiqué que les approches traditionnelles soient dans une hiérarchie descendante et ignorent le rôle crucial des apprenants dans le processus d'apprentissage. » Il devrait y avoir un meilleur équilibre entre donner à l'apprenant ce qu'il a besoin d'apprendre (adaptativité) et lui donner ce qu'il souhaite apprendre (adaptabilité), de la façon qu'il souhaite l'apprendre (s'il préfère plus d'exemples, ou plus d'exercices). Dans tous les cas, construire un profil de l'apprenant est une tâche cruciale.

Comme cas d'utilisation, considérons un nouvel arrivant sur un MOOC (cours en ligne ouvert massif). Celui-ci ayant acquis des connaissances de différents domaines, certains prérequis du cours peuvent ne pas être maîtrisés tandis que d'autres leçons pourraient être sautées. Ainsi, il serait utile de pouvoir évaluer ses besoins et préférences de façon adaptative, pour filtrer le contenu du cours en conséquence et minimiser la surcharge d'information. @Lynch2014 décrit un tel algorithme qui identifie l'état des connaissances d'un apprenant en posant quelques questions au début d'un cours.\nomenclature{MOOC}{massive online open course}

En analytique de l'apprentissage, parmi les méthodes employées pour construire des modèles prédictifs, on trouve l'apprentissage automatique[^3]. Une application populaire est la prédiction de l'obtention du certificat d'un apprenant à partir de différentes variables liées aux traces de l'apprenant : le nombre d'heures passées à consulter les cours, à regarder les vidéos, le nombre de messages postés sur le forum, entre autres. La majorité de ces modèles prédictifs s'attaquent à prédire une certaine variable objectif à partir d'un nombre fixé de variables, mais à notre connaissance, peu de modèles interrogent l'apprenant sur ses besoins et préférences. Nous estimons qu'il reste encore beaucoup de recherche à faire vers des modèles d'analytique de l'apprentissage plus interactifs.

<!-- TODO nombre fixé -->

 [^3]: En anglais, *machine learning*.

Deux éléments issus des systèmes de recommandation peuvent être transposés au cadre éducatif de l'analytique de l'apprentissage. Le premier est la technique du filtrage collaboratif (cf. section \vref{collaborative-filtering}), qui permet de concevoir un système de recommandation de ressources éducatives [@Chatti2012; @Manouselis2011; @Verbert2011]. Le second est le problème du démarrage à froid de l'utilisateur, dans la mesure où lorsqu'un nouvel utilisateur utilise un système de recommandation, le système n'a que peu d'information sur lui et doit donc lui poser des questions de façon à éliciter ses préférences.

Le temps de réponse lors d'une évaluation a été étudié en psychologie cognitive, car le temps qu'un apprenant met pour répondre à une question peut indiquer quelques aspects sur le processus cognitif [@Chang2014] et joue un rôle dans la performance [@Papamitsiou2014]. Cela requiert des modèles statistiques sophistiqués que nous ne considérons pas ici.

# Modèles de tests adaptatifs

<!-- TODO lien filtrer -->

Dans notre cas, nous cherchons à filtrer et ordonner les questions à poser à un apprenant. Plutôt que de poser les mêmes questions à tout le monde, les tests adaptatifs [@VDL2010] choisissent la question suivante à poser à un certain apprenant étant donné les réponses qu'il a données depuis le début du test. Cela permet une adaptation à chaque étape de la séquence de questions. Leur conception repose sur deux critères : un critère de *terminaison* et un critère de *choix de la question suivante*. Tant que le critère de terminaison n'est pas satisfait (par exemple, poser un certain nombre de questions), les questions sont posées selon le critère de choix de la question suivante (par exemple, poser la question la plus informative pour déterminer les connaissances de l'apprenant). @Lan2014 ont prouvé que de tels tests adaptatifs permettaient d'obtenir une mesure aussi précise que des tests non adaptatifs, tout en requérant moins de questions.

Raccourcir la taille des tests est utile à la fois pour le système, qui doit équilibrer la charge du serveur, et pour les apprenants, qui risqueraient de se lasser de devoir fournir trop de réponses [@Lynch2014; @Chen2015]. Ainsi, les tests adaptatifs deviennent de plus en plus utiles dans l'ère actuelle des MOOC, où la motivation des apprenants joue un rôle important sur leur apprentissage [@Lynch2014]. Lorsqu'on implémente ces tests pour une utilisation réelle, des contraintes supplémentaires s'appliquent : pour qu'un apprenant n'ait pas à patienter longuement entre deux questions du test, le calcul du critère du choix de la question suivante doit se faire dans un temps raisonnable, ainsi la complexité en temps de ce calcul est importante. De même, lorsqu'on évalue des connaissances, un certain degré d'incertitude est à prendre en compte : un apprenant risque de faire des fautes d'inattention ou de deviner une bonne réponse alors qu'il n'a pas compris la question. C'est pourquoi une simple dichotomie sur le niveau de l'apprenant, c'est-à-dire poser des questions plus difficiles lorsqu'un apprenant réussit une question ou poser des questions plus faciles lorsqu'il échoue, n'est pas suffisant. Il faut considérer des méthodes plus robustes, tels que des modèles probabilistes pour l'évaluation des compétences.

Les tests adaptatifs ont été étudiés au cours des dernières années et ont été développées en pratique. Par exemple, 238 536 tests de ce type ont été administrés via le Graduate Admission Management Test (GMAT), développé par le Graduate Management Admission Council (GMAC) entre 2012 et 2013. Étant donné un modèle de l'apprenant [@Pena2014], l'objectif est de fournir une mesure précise des caractéristiques d'un nouvel apprenant tout en minimisant le nombre de questions posées. Ce problème s'appelle la *réduction de longueur d'un test* [@Lan2014] et est également lié à la prédiction de performance future [@Bergner2012; @ThaiNghe2011]. En apprentissage automatique, ce problème est connu sous le nom d'apprentissage actif : choisir les éléments à étiqueter de façon adaptative afin de maximiser l'information récoltée à chaque pas.\nomenclature{GMAT}{Graduate Admission Management Test}

Dans ce qui suit, nous ne permettons pas à l'apprenant de revenir en arrière pour corriger ses réponses, mais certains modèles de tests adaptatifs plus compliqués le permettent [@Han2013; @Wang2015].

En fonction du but de l'évaluation, plusieurs modèles peuvent être utilisés, selon si l'on souhaite estimer un niveau général de connaissance, faire un diagnostic détaillé, ou identifier les connaissances maîtrisées par l'apprenant [@Mislevy2012]. Dans ce qui suit, nous proposons une répartition de ces modèles dans les trois catégories suivantes : théorie de la réponse à l'item pour des tests sommatifs, modèles de diagnostic cognitif pour des tests formatifs basés sur des composantes de connaissances, et enfin apprentissage automatique.

## Théorie de la réponse à l'item

La *théorie de la réponse à l'item* consiste à supposer que les réponses d'un apprenant que l'on observe lors d'un test peuvent être expliquées par un certain nombre de valeurs cachées, qu'il convient d'identifier.

### Modèle de Rasch

Le modèle le plus simple de tests adaptatifs est le *modèle de Rasch*, aussi connu sous le nom de modèle logistique à un paramètre. Il modélise un apprenant par une valeur unique de niveau, et les questions ou tâches à résoudre par une valeur de difficulté. La propension d'un apprenant à résoudre une tâche ne dépend que de la différence entre sa difficulté et son niveau. Ainsi, si un apprenant $i$ a un niveau $\theta_i$ et souhaite résoudre une question $j$ de difficulté $d_j$ :

$$ Pr(\textnormal{``l'apprenant $i$ répond correctement à la question $j$''}) = \Phi(\theta_i - d_j) $$

\noindent
où $\Phi : x \mapsto 1 / (1 + e^{-x})$ est la fonction logistique.\nomenclature{$\Phi$}{fonction logistique}

<!-- \begin{figure}
\includegraphics[width=\linewidth]{figures/irt}
\caption{Courbes pour différentes valeurs du paramètre de difficulté $d$ du modèle de Rasch.}
\end{figure} -->

<!-- TODO nouvelle courbe -->

<!-- (Exemple de produit de matrices.) -->

Spécifier toutes les valeurs de difficulté à la main serait coûteux pour un expert, et fournirait des valeurs subjectives qui risquent de ne pas correspondre aux données observées. Ce modèle est suffisamment simple pour qu'il soit possible de calibrer automatiquement et de façon efficace les paramètres de niveau et difficulté, à partir d'un historique de réponses. En particulier, aucune connaissance du domaine n'est requise.

Ainsi, lorsqu'un apprenant passe un test, les variables observées sont ses résultats (vrai ou faux) sur les questions qui lui sont posées, et la variable que l'on souhaite estimer est son niveau, étant donné les valeurs de difficulté des questions qui lui ont été posées, ainsi que ses résultats. L'estimation est habituellement faite en calculant le maximum de vraisemblance, facile à déterminer en utilisant la méthode de Newton pour déterminer les zéros de la dérivée de la fonction de vraisemblance. Ainsi, le processus adaptatif devient : étant donné une estimation du niveau de l'apprenant, quelle question poser afin d'obtenir un résultat informatif pour affiner cette estimation ? Il est en effet possible de quantifier l'information que chaque question $j$ donne sur le paramètre de niveau. Il s'agit de l'information de Fisher, définie par la variance du gradient de la log-vraisemblance en fonction du paramètre de niveau :

$$ I_j(\theta_i) = E\left[{\left(\frac\partial{\partial\theta} \log f(X_j, \theta_i)\right)}^2 \bigg| \theta_i \right] $$

où $X_j$ est la variable correspondant au succès/échec de l'apprenant $i$ sur la question $j$ et $f(X_j, \theta_i)$ est la fonction de probabilité pour $X_j$ qui dépend de $\theta_i$ comme indiqué plus haut : $f(X_j, \theta_i) = \Phi(\theta_i - d_j)$.

Ainsi, un test adaptatif peut être conçu de la façon suivante : étant donné l'estimation actuelle du niveau de l'apprenant, choisir la question qui va apporter le plus d'information sur son niveau, mettre à jour l'estimation en fonction du résultat (succès ou échec), et ainsi de suite. À la fin du test, on peut visualiser le processus comme dans les figures \ref{irt} et \ref{irt-output} : l'intervalle de confiance sur le niveau de l'apprenant est réduit après chaque résultat, et les questions sont choisies de façon adaptative.

\begin{figure}
\includegraphics[width=\linewidth]{figures/irt.pdf}
\caption{Évolution de l'estimation du niveau via un test adaptatif basé sur le modèle de Rasch.}
\label{irt}
\end{figure}

\begin{figure}
\begin{verbatim}
On pose la question 42 à l'apprenant.
Correct !
On pose la question 48 à l'apprenant.
Correct !
On pose la question 82 à l'apprenant.
Incorrect.
On pose la question 53 à l'apprenant.
Correct !
On pose la question 78 à l'apprenant.
Incorrect.
On pose la question 56 à l'apprenant.
Correct !
On pose la question 76 à l'apprenant.
Incorrect.
On pose la question 58 à l'apprenant.
Incorrect.
\end{verbatim}
\caption{Exemple de test adaptatif.}
\label{irt-output}
\end{figure}

Le modèle de Rasch est unidimensionnel, donc il ne permet pas d'effectuer un diagnostic cognitif. Il reste pourtant populaire pour sa simplicité, sa généricité [@Desmarais2012; @Bergner2012] et sa robustesse [@Bartholomew2008]. @Verhelst2012 a montré qu'avec la simple donnée supplémentaire d'une répartition des questions en catégories, il est possible de renvoyer à l'examiné un profil utile à la fin du test, spécifiant quels sous-scores de catégorie sont plus bas ou plus haut que la moyenne. Plus précisément, si l'on considère que dans chaque catégorie, une réponse donne 1 point si elle est correcte, 0 point sinon, on peut calculer le nombre de points obtenus par l'apprenant dans chaque catégorie. À partir du modèle de Rasch, il est alors possible de calculer l'espérance du sous-score dans chaque catégorie, étant donné le score total. Enfin, le profil de déviation, défini comme la différence entre le sous-score obtenu et le sous-score moyen, fournit une bonne visualisation des catégories qui requièrent un approfondissement, voir la figure \ref{deviation}. De tels profils de déviation peuvent être agrégés de façon à mettre en évidence les points forts et faibles des apprenants au niveau d'un pays, pour identifier d'éventuelles carences dans le programme scolaire de ce pays. En effet, des évaluations internationales telles que PISA ou TIMSS permettent des comparaisons à l'échelle des pays. À partir des données de l'édition 2011 du test Trends in International Mathematics and Science Study (TIMSS), @Verhelst2012 a pu construire le diagramme à la figure \ref{deviation-country}, où l'on peut observer que la Roumanie est plus forte en algèbre qu'attendu, tandis que la Norvège est plus faible en algèbre qu'attendu. Ceci est un remarquable exemple de visualisation d'information basé sur le plus simple modèle psychométrique, le modèle de Rasch, et avec une répartition des questions en 4 catégories : numération, géométrie, probabilité, algèbre.\nomenclature{TIMSS}{Trends in International Mathematics and Science Study}

\begin{figure}
\centering
\includegraphics[width=0.5\linewidth]{figures/profil.png}
\caption{Profil de déviation d'un unique apprenant, à partir du modèle de Rasch.}
\label{deviation}
\end{figure}

\begin{figure}
\includegraphics[width=\linewidth]{figures/profilpays.png}
\caption{Profil de déviation de différents pays sur le jeu de données de TIMSS 2011, tiré de la présentation de of N.D. Verhelst au workshop Psychoco 2016.}
\label{deviation-country}
\end{figure}

### Théorie de la réponse à l'item multidimensionnelle

\label{mirt}

Il est naturel d'étendre le modèle de Rasch à des compétences multidimensionnelles. En théorie de la réponse à l'item multidimensionnelle (TRIM) [@Reckase2009], les apprenants et les questions ne sont plus modélisés par de simples scalaires mais par des vecteurs de dimension $d$, tels que la propension pour un apprenant à répondre correctement à une question dépend seulement du produit scalaire de ces vecteurs. Ainsi, un apprenant a plus de chances de répondre à des questions qui sont corrélées à son vecteur de compétences, et poser une question apporte de l'information dans la direction de son vecteur.\nomenclature{TRIM}{théorie de la réponse à l'item multidimensionnelle}

\def\R{\textbf{R}}

Ainsi, si l'apprenant $i \in \{1, \ldots, n\}$ est modélisé par le vecteur $\mathbf{\theta_i} \in \R^d$ et la question $j \in \{1, \ldots, m\}$ par le vecteur $\mathbf{d_j} \in \R^d$:

$$ Pr(\textnormal{``l'apprenant $i$ répond correctement à la question $j$''}) = \Phi(\mathbf{\theta_i} \cdot \mathbf{d_j}). $$

Notez qu'on ne retrouve pas le modèle de Rasch lorsque $d = 1$ mais lorsque $d = 2$ avec des paramètres $\mathbf{\theta_i} = (\theta, 1)$ et $\mathbf{d_j} = (1, d_j)$, car :

$$ \mathbf{\theta_i} \cdot \mathbf{d_j} = (\theta, 1) \cdot (1, -d_j) = \theta - d_j $$

\noindent
qui correspond bien au modèle de Rasch.

Lorsqu'on considère un modèle de type TRIM, l'apprenant et les questions ont des caractéristiques selon plusieurs dimensions. l'information de Fisher qu'apporte une question n'est plus un scalaire mais une matrice, dont on cherche habituellement à maximiser soit le déterminant (règle D), soit la trace (règle T). Choisir la question avec la règle D apporte la plus grande réduction de volume dans la variance de l'estimation du niveau, tandis que choisir la question avec la règle T augmente l'information moyenne de chaque dimension du niveau, en ignorant la covariance entre composantes.

Réécrit comme un problème de factorisation de matrice, TRIM devient :

$$ M \simeq \Phi(\Theta D^T) $$

\noindent
où $M$ est la matrice $n \times m$ des réponses des $n$ étudiants sur les $m$ questions d'un test, $\Theta$ est la matrice $n \times d$ des vecteurs des apprenants et enfin $D$ est la matrice $m \times d$ des vecteurs des questions.

Ce modèle plus riche a beaucoup plus de paramètres : $d$ paramètres doivent être estimés pour chacun des $n$ apprenants et chacune des $m$ questions, soit $d(n + m)$ paramètres au total. Ayant de nombreux paramètres, ce modèle est plus difficile à calibrer [@Desmarais2012; @Lan2014].

## Modèles de diagnostic cognitif basés sur les composantes de connaissances

Les *modèles de diagnostic cognitif* font l'hypothèse que la résolution des questions ou tâches d'apprentissage peut être expliquée par la maîtrise ou non-maîtrise de certaines composantes de connaissance (CC), ce qui permet de transférer de l'information d'une question à l'autre. Par exemple, pour calculer $1/7 + 8/9$ correctement, un apprenant est censé maîtriser l'addition, et la mise au même dénominateur. En revanche, pour calculer $1/7 + 8/7$, il suffit de savoir additionner deux fractions de même dénominateur. Ces modèles cognitifs requièrent la spécification des CC impliqués dans la résolution de chacune des questions du test, sous la forme d'une matrice binaire appelée q-matrice, qui fait le lien entre les questions et les CC : c'est ce qu'on appelle un modèle de transfert. Voir Table \ref{fraction-qmatrix} pour un exemple de q-matrice.\nomenclature{CC}{Composante de connaissance}

\begin{table}
\centering
\begin{minipage}{0.42\textwidth}
\small
\begin{tabular}{c@{\hspace{5mm}}cccccccc} \toprule
& \multicolumn{8}{c}{Comp. de connaissance}\\
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
\begin{minipage}{0.57\textwidth}
\small
Description des composantes de connaissance :
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
\caption{La q-matrice correspondant aux réponses de 536 collégiens sur 20 questions de soustraction de fonction comportant 8 composantes de connaissance. Le jeu de données est étudié dans \cite{DeCarlo2010}.}
\label{fraction-qmatrix}
\end{table}

### Modèle DINA

\label{dina}
\nomenclature{DINA}{Deterministic Input, Noisy And}
Le modèle DINA (*Deterministic Input, Noisy And*, c'est-à-dire entrée déterministe, avec un « et » avec bruit) suppose que l'apprenant résoudra une certaine question $i$ avec probabilité $1 - s_i$ s'il maîtrise toutes les CC impliquées dans sa résolution, sinon avec probabilité $g_i$. Le paramètre $g_i$ est le paramètre de chance de la question $i$, c'est-à-dire la probabilité de deviner la bonne réponse alors que l'on ne maîtrise pas les CC nécessaires, tandis que $s_i$ est le paramètre d'inattention, c'est-à-dire la probabilité de se tromper alors qu'on maîtrise les CC associées. Il existe d'autres variantes de modèles cognitifs tels que le modèle DINO (*Deterministic Input, Noisy Or*, c'est-à-dire entrée déterministe, avec un « ou » avec bruit) où ne maîtriser qu'une seule des CC impliquées dans une question $i$ suffit à la résoudre avec probabilité $1 - s_i$, et si en revanche aucune CC impliquée n'est maîtrisée, la probabilité d'y répondre correctement est $g_i$.

L'état latent d'un apprenant est représenté par un vecteur de bits $(c_1, \ldots, c_K)$, un par CC à maîtriser ($K$ est donc le nombre de CC impliquées dans le test), indiquant les CC qui sont maîtrisées : $c_k$ vaut 1 si l'apprenant maîtrise la $k$-ième CC, 0 sinon. Chaque réponse que l'apprenant donne sur une question nous donne de l'information sur les états possibles qui pourraient correspondre à l'apprenant. @Xu2003 ont utilisé des stratégies de tests adaptatifs pour inférer l'état latent de l'apprenant en utilisant peu de questions, c'est ainsi qu'ont été développés les tests adaptatifs de diagnostic cognitif (en anglais CD-CAT, pour *cognitive diagnosis computerized adaptive testing*), que nous appellerons diagnostics cognitifs adaptatifs. Ayant une estimation a priori de l'état mental de l'apprenant, on peut inférer son comportement sur les questions restantes du test, et choisir des questions informatives en fonction. À chaque étape, le système maintient une distribution de probabilité sur les $2^K$ états mentaux possibles et l'affine après chaque réponse de l'apprenant de façon bayésienne.\nomenclature{CD-CAT}{cognitive diagnosis computerized adaptative testing, tests adaptatifs de diagnostic cognitif}

Pour converger rapidement vers l'état latent le plus vraisemblable, la meilleure question à poser est celle qui réduit le plus l'incertitude [@Doignon2012; @Huebner2010], c'est-à-dire l'entropie de la distribution sur les états latents possibles :

$$ H(\mu) = - \sum_{c \in \{0, 1\}^K} \mu(c) \log \mu(c). $$

D'autres critères ont été étudiés et comparés tels que la question qui maximise la divergence de Kullback-Leibler, qui est une mesure de la différence entre deux distributions de probabilité [@Cheng2009]:

$$ D_{KL}(P||Q) = \sum_i P(i) \log \frac{P(i)}{Q(i)}. $$

<!-- TODO rappel meilleur -->

Un exemple de test adaptatif basé sur le modèle DINA est donné dans la figure \ref{example-dina}.

\begin{figure}
\begin{verbatim}
Tour 1 -> On pose la question 1 à l'apprenant.
Elle requiert les CC suivantes : [1, 1, 0, 0]
Correct !
L'examiné a beaucoup de chance de maîtriser ces 2 premières CC
Estimation: 0000
Vérité: 0001

Tour 2 -> On pose la question 3 à l'apprenant.
Elle requiert les CC suivantes : [0, 0, 1, 0]
Correct !
L'examiné a peu de chances
Estimation: 0000
Vérité: 0001
\end{verbatim}
\caption{Exemple de test adaptatif basé sur le modèle DINA.}
\label{example-dina}
\end{figure}

<!-- \begin{figure}
\includegraphics{figures/compnum}
\caption{Exemple de q-matrice.}
\label{example-dina}
\end{figure}

\begin{figure}
\includegraphics{figures/hierarchy}
\caption{Exemple de relations de prérequis.}
\label{example-dina}
\end{figure} -->

Comme le dit @Chang2014, "Une étude conduite à Zhengzhou indique que CD-CAT encourage la pensée critique, en rendant les étudiants plus autonomes en résolution de problèmes, et offre de la remédiation personnalisée facile à suivre, ce qui rend l'apprentissage plus intéressant." En effet, une fois que l'état mental de l'apprenant a été identifié, on peut l'orienter vers des ressources utiles pour combler ses lacunes.

Comme l'espace des états latents possibles est discret, on peut maintenir la distribution de probabilité $(\pi_i)_{i \in \mathbf{N}}$ sur les vecteurs de compétences possibles tout au long du test. Connaissant la réponse de l'apprenant à la $i$-ième question, la mise à jour de $\pi_{i - 1}$ est faite par la règle de Bayes. Soit $x$ un état latent, $s_i$ et $g_i$ les paramètres d'inattention et de chance associés à la $i$-ième question et soit $a_i$ une variable qui vaut 1 si la réponse de l'apprenant est correcte, 0 sinon. Si les CC associées à $x$ sont suffisantes pour répondre à la question correctement,

\label{dina-update}

$$ \pi_i(x) = \pi_{i - 1}(x) \cdot [a_i \cdot(1-s_i) + (1-a_i)\cdot s_i] $$

sinon

$$ \pi_i(x) = \pi_{i - 1}(x) \cdot [a_i \cdot g_i + (1-a_i)\cdot(1-g_i)]. $$

En effet : si $x$ a bien les compétences requises, il peut soit donner la bonne réponse en ne faisant pas d'erreur d'inattention (résultat $a_i = 1$ avec probabilité $1 - s_i$), soit faire une erreur d'inattention (résultat $a_i = 0$ avec probabilité $s_i$).

La complexité du choix de la question suivante est $O(2^K K |Q|)$, ce qui est impraticable pour de larges valeurs de $K$. C'est pourquoi en pratique $K \leq 10$ [@Su2013]. Il est toutefois possible de réduire la complexité en supposant des relations de prérequis entre CC : si la maîtrise d'une CC implique celle d'une autre CC, le nombre d'états possibles décroît et donc la complexité en temps fait de même. Cette approche est appelée modèle de hiérarchie sur les attributs [@Leighton2004] et permet d'obtenir des représentations de connaissances qui correspondent mieux aux données [@Rupp2012].\label{ahm}

La q-matrice peut être coûteuse à construire. Ainsi, calculer une q-matrice automatiquement est un sujet de recherche à part entière. @Barnes2005 utilise une technique d'escalade de colline[^4] (qui consiste à modifier un bit de la q-matrice, regarder si l'erreur est diminuée, et itérer le processus) tandis que @Winters2005 et @Desmarais2011 ont essayé des méthodes de factorisation de matrice pour recouvrer des q-matrices à partir de données d'apprenants. Ils ont découvert que pour des domaines bien distincts comme le français et les mathématiques, ces techniques permettent de séparer les questions qui portent sur ces domaines. Une critique est que même si l'on obtient via ces méthodes automatiques des matrices qui correspondent bien aux données, les colonnes risquent de ne plus être interprétables. @Lan2014 a tenté de contourner ce problème en tentant d'interpréter a posteriori les colonnes de la q-matrice, en utilisant des tags spécifiés par des experts sur les questions. @Koedinger2012 ont réussi à combiner des q-matrices de différents experts par externalisation ouverte (*crowdsourcing*) de façon à obtenir des q-matrices plus riches, toujours interprétables, et qui correspondent davantage aux données.

 [^4]: En anglais, *hill-climbing technique*.

Un avantage du modèle DINA est qu'il n'a pas besoin de données de test pour être déjà adaptatif. La q-matrice suffit à administrer des tests, où l'on suppose alors que les apprenants ont autant de chance de maîtriser une composante que de ne pas la maîtriser. À l'aide d'un historique des apprenants, on peut avoir un a priori sur les composantes qu'un nouvel apprenant maîtrisera ou non, et améliorer l'adaptation.

<!-- TODO peut être plus clair -->

### Théorie des espaces de connaissances basés sur les compétences
\label{knowledge-space}

@Doignon2012 ont développé la théorie des espaces de connaissances, qui repose sur une représentation atomique des connaissances, similaire aux CC du modèle DINA. Ainsi, l'état de connaissance d'un apprenant peut être modélisé par l'ensemble des CC possibles qu'il maîtrise. Supposons qu'il existe un certain nombre de CC à apprendre, pour lesquelles on connaît les relations de prérequis, c'est-à-dire quelles CC doivent être maîtrisées avant d'apprendre une certaine CC, voir figure \ref{dependency}. À partir de ce graphe, on peut calculer les états de connaissances possibles qu'un apprenant peut avoir. Par exemple, dans la figure \ref{dependency}, $\{a, c\}$ est un état de connaissance possible tandis que $\{c\}$ ne l'est pas, car $a$ doit être maîtrisé avant $c$. Donc pour cet exemple, il y a 10 états de connaissance possibles pour l'apprenant : $\emptyset$, $\{a\}$, $\{b\}$, $\{a, b\}$, $\{a, c\}$, $\{a, b, c\}$, $\{a, b, c, d\}$, $\{a, b, c, e\}$, $\{a, b, c, d, e\}$ et $\{a, b, c, d, e, f\}$. Un test adaptatif peut donc déterminer l'état de connaissance de l'apprenant d'une façon similaire au modèle de hiérarchie sur les attributs décrit à la Section \ref{ahm}. Une fois que l'état de connaissance de l'apprenant a été identifié, le modèle peut lui suggérer les prochaines CC à apprendre pour progresser, à travers ce que l'on appelle un parcours d'apprentissage, voir figure \ref{dependency}. Par exemple, si l'apprenant a pour état de connaissance $\{a\}$, il peut choisir d'apprendre $b$ ou $c$.

@Falmagne2006 proposent un test adaptatif pour deviner de façon efficace l'état de connaissance de l'apprenant en minimisant l'entropie, mais leur méthode n'est pas robuste aux erreurs d'inattention. Ce modèle a été implémenté dans le système ALEKS, qui appartient désormais à McGraw-Hill Education et est utilisé par des millions de personnes aujourd'hui [@Kickmeier2015; @Desmarais2012].

\begin{figure}
\centering
\includegraphics{figures/knowledge-space.pdf}
\qquad
\includegraphics[width=0.4\textwidth]{figures/learning-path.pdf}
\caption{À gauche, un graphe de dépendance. À droite les parcours d'apprentissage possibles pour apprendre toutes les CC.}
\label{dependency}
\end{figure}

@Lynch2014 a implémenté un test adaptatif similaire au début d'un MOOC de façon à deviner ce que l'apprenant maîtrise déjà et l'orienter automatiquement vers des ressources utiles du cours. Pour résister aux erreurs d'inattention et aux apprenants qui devinent les bonnes réponses sans avoir les CC nécessaires, ils combinent des modèles de la théorie des espaces de connaissance et de la théorie de la réponse à l'item.

Il y a une tendance pour des modèles plus fins pour le diagnostic qui considèrent des représentations de connaissance plus riches, telles que des réseaux bayésiens [@Shute2011] ou des ontologies du domaine couvert par le test [@Mandin2014; @Kickmeier2015]. Toutefois, de telles représentations sont coûteuses à construire.

## Lien entre tests adaptatifs et filtrage collaboratif

Les systèmes de recommandation peuvent recommander des nouvelles ressources à un utilisateur en fonction de ses préférences sur d'autres ressources et des préférences d'autres utilisateurs sur ces mêmes ressources. Le but est de prédire le comportement d'un utilisateur face à une ressource inédite, à partir de ses préférences sur une fraction des ressources qu'il a consultées. Deux techniques sont utilisées.

\begin{enumerate}
\item Des recommandations basées sur le contenu, qui analysent le contenu des ressources de façon à calculer une mesure de similarité entre ressources, pour recommander des ressources similaires à celles appréciées par l'utilisateur. Ici, la communauté d'utilisateurs n'a pas d'impact sur les recommandations.
\item Le filtrage collaboratif, où la mesure de similarité entre ressources dépend seulement des préférences des utilisateurs : des œuvres étant préférées par les mêmes personnes sont supposées proches.
\end{enumerate}

Dans notre cas, nous devons prédire la performance d'un apprenant sur une question inédite, en fonction de son comportement sur d'autres questions et du comportement d'autres apprenants ont eu dans le passé sur le même test. Les techniques de filtrage collaboratif ont été appliqués à deux problèmes issus de la fouille de données éducatives : la recommandation de ressources éducatives à des apprenants [@Manouselis2011; @Verbert2011] et la prédiction de performance d'un apprenant sur un test [@Toscher2010; @ThaiNghe2011; @Bergner2012].

Un autre élément qui apparaît dans les systèmes de recommandation peut être utile à notre analyse, celui du *démarrage à froid* : étant donné un nouvel utilisateur, comment lui recommander des ressources pertinentes ? La seule référence que nous ayons trouvée au problème du démarrage à froid dans un contexte éducatif vient de @ThaiNghe2011 : « Dans des environnements éducatifs, le problème du démarrage à froid n'est pas aussi nuisible que dans des environnements commerciaux, où de nouveaux utilisateurs ou produits apparaissent chaque jour ou même chaque heure. Donc, les modèles n'ont pas besoin d'être réentraînés continuellement. » Toutefois, cet article est antérieur à l'arrivée des MOOC, donc cette affirmation n'est plus vraie aujourd'hui.

Parmi les techniques les plus populaires pour s'attaquer au problème du démarrage à froid, une méthode qui nous intéresse particulièrement est un test adaptatif qui présente certaines ressources à l'apprenant et lui demande de les noter. @Golbandi2011 construit un arbre de décision qui pose des questions à un nouvel utilisateur et, en fonction de ses réponses, choisit les meilleures questions à lui poser de façon à identifier rapidement un groupe d'utilisateurs qui lui sont proches. Les meilleures questions sont celles qui séparent la population en trois parties de taille similaire, selon si l'utilisateur a apprécié la ressource, n'a pas apprécié la ressource, ou ne connaît pas la ressource. La différence principale avec notre cadre éducatif est que les apprenants risquent de moins coopérer avec un système d'évaluation qu'avec un système de recommandations commercial, car leur objectif n'est pas d'obtenir des bonnes recommandations mais un bon score. Ainsi, leurs réponses risquent de ne pas refléter les compétences qu'ils maîtrisent vraiment.

## Stratégies adaptatives pour le compromis exploration-exploitation
\label{bandits}

Dans certaines applications de tests adaptatifs, on souhaite maximiser une certaine fonction objectif pendant qu'on pose les questions. Par exemple, supposons qu'un site commercial cherche à maximiser le nombre de clics sur ses publicités. Il y a un compromis entre explorer l'espace des publicités en présentant à l'utilisateur des publicités plus risquées, et exploiter la connaissance sur l'utilisateur en lui présentant des publicités sur des domaines susceptibles de lui plaire. Dans un contexte éducatif, on peut se demander quelle serait la tâche qui permettrait de faire progresser l'apprenant le plus, tout en cherchant à identifier ce qu'il maîtrise ou non. C'est la technique qu'adoptent @Clement2015 aux systèmes de tuteurs intelligents : ils personnalisent les séquences d'activités d'apprentissage de façon à identifier les CC de l'apprenant tout en maximisant son progrès, défini comme la performance sur les dernières activités. Ils utilisent deux modèles de bandit, l'un se basant sur la zone proximale de développement de Vygotski [@Vygotsky1980] sous la forme d'un graphe de prérequis, l'autre sur une q-matrice. Ils ont comparé ces deux approches sur 400 apprenants de 7 et 8 ans, et ont découvert de façon surprenante que le graphe de dépendance se comportait mieux que le modèle qui utilise une q-matrice spécifiée par un expert. Leur technique est adaptée à des populations d'apprenants de niveaux variés, notamment ceux ayant des difficultés.

## Tests à étapes multiples

Jusqu'à présent, nous n'avons considéré que des questions posées une par une. Mais les premières étapes d'un test adaptatif conduisent à des estimations du niveau de l'apprenant biaisées, car il y a peu de faits sur lesquels s'appuyer pour effectuer un diagnostic. C'est pourquoi d'autres recherches en psychométrie portent sur des tests à étapes multiples [@Yan2014], qui posent des groupes de questions avant de choisir le groupe de questions suivant. Après une première planche de $k_1$ questions, l'apprenant est orienté vers une autre planche de $k_2$ questions sélectionnées en fonction de sa performance sur la première planche, et ainsi de suite, voir la figure \ref{mst}. Cela permet également à l'apprenant de vérifier ses réponses avant de déclencher le processus suivant de questions.

Il y a ainsi un compromis entre adapter le processus après chaque question ou ne le faire que lorsque suffisamment d'information a été récoltée sur l'apprenant. @Wang2016 suggère de poser un groupe de questions au début du test, lorsque peu d'information sur l'apprenant est disponible, puis progressivement réduire le nombre de questions de chaque planche afin d'augmenter les opportunités d'adapter le processus. Aussi, poser des groupes de questions permet d'équilibrer les planches de questions en termes de CC évaluées, tandis que poser les questions une par une crée forcément un passage d'une CC à une autre, question après question.

\begin{figure}
\centering
\includegraphics{figures/mst.pdf}
\caption{Un exemple de test à étapes multiples. Les questions sont posées par groupe.}
\label{mst}
\end{figure}

# Limitations

Dans tous les modèles de tests adaptatifs présentés dans ce chapitre, nous nous cherchons à évaluer les connaissances des apprenants, et non d'autres dimensions telles que leur persévérance, leur organisation ou leur prudence lorsqu'ils répondent à des questions. En réduisant le nombre de questions, nous réduisons le temps que les apprenants passent à être évalués, ce qui les empêche de s'ennuyer et laisse plus de temps pour d'autres activités d'apprentissage.

Tous les modèles que nous considérons ne posent jamais deux fois la même question au sein d'un test. Pourtant dans certains scénarios, présenter le même item plusieurs fois est utile, par exemple lors de l'apprentissage d'un vocabulaire. Certains outils appelés systèmes à répétition espacée tels qu'Anki ont été utilisés pour l'apprentissage du vocabulaire de façon probante [@Altiner2011]. Dans notre cas, nous préférons poser des questions différentes qui requièrent les mêmes CC, ce qui permet de réduire les risques que l'apprenant devine la bonne réponse.

Notre approche est principalement statique, ce qui veut dire que nous ne supposons pas que le niveau de connaissance de l'apprenant augmente alors qu'il passe un test. Nos modèles fournissent donc une photographie de la connaissance d'un apprenant à un certain instant.

Nous ne considérons pas de profil de l'apprenant autre que ses réponses au test. Cela nous permet de proposer des tests anonymes. L'apprenant n'a donc pas à craindre que ses données puissent être enregistrées indéfiniment [@Obama2014].

Il existe d'autres interfaces pour l'évaluation plus riche telles que des jeux sérieux ou l'évaluation furtive [@Shute2011], qui permet de concevoir des environnements plus stimulants pour les apprenants. Par exemple, l'application *Packet Tracer* développée par Cisco pour apprendre le routage des paquets sur un réseau, ou *Newton's Playground* pour apprendre des notions de physique. Nous pensons que notre approche générique de considérer des succès et échecs d'apprenants sur des questions peut être appliqué à ces interfaces plus spécifiques.

# Conclusion

Historiquement, les tests adaptatifs ont été développés pour réduire le coût des tests standardisés et augmenter leur sécurité, car tous les examinés n'obtenaient pas les mêmes questions. Combinés avec des modèles cognitifs, ils permettent de faire un retour à l'apprenant à la fin du test sur les points à améliorer, ce qui est plus bénéfique pour l'apprenant, et peut également être utile pour un professeur afin d'identifier les apprenants qui ont besoin d'intervention. De plus, @Dunlosky2013 ont prouvé que s'entraîner à passer des tests avait un impact notable sur l'apprentissage.

Les tests adaptatifs permettent une meilleure personalisation en organisant les ressources d'apprentissage. Par exemple, le séquençage du programme (*curriculum sequencing*) consiste à définir des parcours d'apprentissage dans un espace d'objectifs d'apprentissage [@Desmarais2012]. Cela consiste à faire passer des évaluations de compétences pour adapter le contenu d'apprentissage à partir d'un minimum de faits observés. En effet, à partir du retour d'un test adaptatif formatif, comme on a une idée plus précise des CC que maîtrise l'apprenant, il est possible de filtrer le contenu du cours qui lui sera utile pour s'améliorer.
