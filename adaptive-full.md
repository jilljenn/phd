# Introduction

De nos jours, les évaluations sont automatisées, rendant possible le stockage et l'analyse de données d'apprenants qui permettent de proposer des évaluations plus courtes et plus précises pour des apprenants futurs. L'analytique de l'apprentissage consiste à collecter des données d'apprenants, déterminer des motifs permettant d'améliorer l'apprentissage au sens large, et de continuellement mettre à jour les modèles en fonction des nouvelles données récoltées [@Chatti2012]. Dans le cadre des tests adaptatifs, il s'agit de déterminer la prochaine activité à faire faire à l'apprenant. Réduire la durée de l'évaluation est d'autant plus utile qu'aujourd'hui les apprenants sont surévalués [@Zernike2015], ce qui leur laisse moins de temps pour apprendre.

Les premiers modèles utilisés pour les tests adaptatifs [@Hambleton1985] sont *sommatifs* : ils affectent une valeur de niveau aux examinés, ce qui permet de les classer. Plus récemment, on s'est demandé comment construire des tests *formatifs*, qui font un retour plus utile à l'apprenant pour qu'il puisse s'améliorer. Ainsi, en combinant des modèles cognitifs, on a pu proposer des diagnostics cognitifs adaptatifs [@Ferguson2012; @Huebner2010], qui indiquent à l'apprenant à la fin du test les points à retravailler et sont d'autant plus utiles pour les professeurs afin de juger le niveau de leur classe.

Dans cette thèse, nous nous sommes concentrés sur l'utilisation de données d'apprenants à des questions ou items, sous la forme de motifs de réponse dichotomiques : les apprenants ont répondu de façon correcte ou incorrecte à des questions. Comment réduire le nombre de questions en fonction de l'historique de passage d'un test. Nous souhaitons entraîner des modèles pour qu'ils puissent garantir une mesure précise des apprenants tout en réduisant le nombre de questions à poser. De plus, nous souhaitons que ces tests soient formatifs, et qu'ils fassent un retour à l'apprenant. Ce retour peut être agrégé à différents niveaux (celui de l'étudiant, d'une classe, d'une école, d'un district, d'un état ou d'un pays), sur des panneaux de visualisation (*dashboards*), de façon à prendre des décisions informées [@Shute2015].

Ce chapitre est organisé de la façon suivante. Nous commençons par décrire plus précisément le domaine de l'analytique de l'apprentissage et ses méthodes, puis nous présentons les différents modèles de tests adaptatifs issus de domaines divers ainsi que leurs limitations.

# Analytique de l'apprentissage

Il existe deux domaines très proches qui sont celui de la fouille de données éducatives et l'analytique de l'apprentissage. La première part d'un modèle et s'intéresse à voir comment il permet d'extraire de l'information à partir de données. La deuxième se veut plus holistique et s'intéresse à voir, avec un peu plus de recul, les effets que les systèmes ont sur l'apprentissage, et comment représenter l'information de façon à ce qu'elle puisse être utilisée par un apprenant, un professeur ou un décideur politique (*policy-maker*).

Sur le plan de l'évaluation qui nous concerne, @Chatti2012 décrit différents objectifs de l'analytique de l'apprentissage : le besoin en retour intelligent, le problème de déterminer l'activité suivante à présenter à l'apprenant. Les méthodes utilisées sont regroupées en plusieurs classes : statistiques, visualisation d'information, fouille de données (dont apprentissage statistique), et analyse de réseaux sociaux.\nomenclature{LA}{learning analytics}

Comme le dit @Desmarais2012, « Le ratio de la quantité de faits observés à la largeur de l'évaluation est particulièrement critique pour des systèmes qui couvrent un large nombre de compétences, dans la mesure où il serait inacceptable de poser des heures de questions avant de faire une évaluation utilisable. »

Dans les systèmes éducatifs, il y a une différence entre l'adaptativité, la capacité à modifier les contenus des cours en fonction de différents paramètres et d'un ensemble de règles préétablies, et l'adaptabilité, qui consiste à permettre aux apprenants de personnaliser les contenus de cours par eux-mêmes. @Chatti2012 précise que « des travaux récents en apprentissage adaptatif personnalisé ont critiqué que les approches traditionnelles soient top-down et ignorent le rôle crucial des apprenants dans le processus d'apprentissage. » Il doit y avoir un meilleur équilibre entre donner à l'apprenant ce qu'il a besoin d'apprendre (adaptativité) et lui donner ce qu'il souhaite apprendre (adaptabilité), de la façon qu'il souhaite l'apprendre (s'il préfère plus d'exemples, ou plus d'exercices). Dans tous les cas, le profilage de l'apprenant est une tâche cruciale.

Comme cas d'utilisation, considérons un nouvel arrivant sur un MOOC (cours en ligne ouvert massif). Il peut avoir acquis des connaissances de milieux divers, certains prérequis du cours pourraient ne pas être maîtrisés tandis que d'autres leçons pourraient être sautées. Ainsi, il serait utile de pouvoir évaluer leurs besoins et préférences de açon adaptatives, pour filtrer le contenu du cours en conséquence et minimiser la surcharge d'information. @Lynch2014 décrit un tel algorithme qui dévoile l'état des connaissances d'un apprenant en posant quelques questions au début d'un cours.\nomenclature{MOOC}{massive online open course}

En analytique de l'apprentissage, parmi les méthodes on trouve l'apprentissage automatique pour la prédiction. Par exemple, prédire à partir des traces d'un apprenant s'il va obtenir son certificat à la fin du cours, ou non. Nous avons été surpris de constater dans les méthodes en analytique de l'apprentissage tant de modèles intéressés dans la prédiction d'un certain objectif à partir d'un nombre fixé de variables et si peu de modèles interrogeant l'apprenant sur ses besoins et préférences. Nous estimons qu'il reste encore beaucoup de recherche à faire vers des modèles d'analytique de l'apprentissage plus interactifs. À ces fins, nous avons rédigé un chapitre de journal répertoriant les plus récents modèles en évaluation adaptative [@Vie2016b], qui reprend les éléments de ce chapitre de thèse.

Deux éléments issus des systèmes de recommandation peuvent être transposés au cadre éducatif de l'analytique de l'apprentissage. Le premier est la technique du filtrage collaboratif, décrite à la section \ref{collaborative-filtering}, qui permet de concevoir un système de recommandation de ressources éducatives [@Chatti2012; @Manouselis2011; @Verbert2011]. Le second est le problème du démarrage à froid de l'utilisateur, dans la mesure où lorsqu'un nouvel utilisateur utilise un système de recommandation, le système n'a que peu d'information sur lui et doit donc lui poser des questions de façon à éliciter ses préférences.

Le temps de réponse lors d'une évaluation a été étudié en psychologie cognitive, car le temps qu'un apprenant met pour répondre à une question peut indiquer quelques aspects sur le processus cognitif [@Chang2014] et joue un rôle dans la performance [@Papamitsiou2014]. Cela requiert des modèles statistiques sophistiqués que nous ne considérons pas ici.

# Modèles de tests adaptatifs

Dans notre cas, nous cherchons à filtrer les questions à poser à un apprenant. Plutôt que de poser les mêmes questions à tout le monde, les tests adaptatifs [@VDL2010] choisissent la question suivante à poser étant donné les réponses précédentes, ainsi permettant une adaptation à chaque élément de la séquence. Leur conception repose sur deux critères : un critère de *terminaison* et un critère de *choix de la question suivante*. Tant que le critère de terminaison n'est pas satisfait (par exemple, poser un certain nombre de question), les questions sont posées selon le critère de choix de la question suivante (par exemple, poser la question la plus informative pour déterminer les connaissances de l'apprenant). @Lan2014 a prouvé que de tels tests adaptatifs permettaient d'obtenir une mesure aussi précise que des tests non adaptatifs, tout en requérant moins de questions.

Raccourcir la taille des tests est utile à la fois pour le système, qui doit équilibrer la charge, et pour les apprenants, qui risqueraient d'être frustrés de fournir trop de réponses [@Lynch2014; @Chen2015]. Ainsi, les tests adaptatifs deviennent de plus en plus utiles dans l'ère actuelle des MOOC, où la motivation des apprenants joue un rôle important sur leur apprentissage [@Lynch2014]. Lorsqu'on implémente ces tests dans la vraie vie, des contraintes supplémentaires s'appliquent : le calcul des critères doit se faire dans un temps raisonnable, ainsi la complexité en temps est importante. De même, lorsqu'on évalue des CC, l'incertitude est à prendre en compte. Un apprenant risque de faire des fautes d'inattention ou de deviner une bonne réponse alors qu'il n'a pas compris la question. C'est pourquoi une simple dichotomie sur le niveau de l'apprenant (poser des questions plus difficiles lorsqu'un apprenant réussit une question ou poser des questions plus faciles lorsqu'il échoue) n'est pas viable, il faut considérer des méthodes plus robustes, tels que des modèles probabilistes pour l'évaluation des compétences.

Les tests adaptatifs ont été étudiés au cours des dernières années et ont été développées en pratique. Par exemple, 238 536 tels tests ont été administrés via le GMAT (Graduate Admission Management Test), développé par le Graduate Management Admission Council (GMAC) entre 2012 et 2013. Étant donné un modèle de l'apprenant [@Pena2014], l'objectif est de fournir une mesure précise des paramètres d'un nouvel apprenant tout en minimisant le nombre de questions posées. Ce problème s'appelle la *réduction de longueur d'un test* [@Lan2014] et est également liée à la prédiction de performance future [@Bergner2012; @ThaiNghe2011]. En apprentissage automatique, on parle également d'apprentissage actif : choisir les éléments à étiqueter de façon adaptative afin de maximiser l'information récoltée à chaque pas.

En fonction du but de l'évaluation, plusieurs modèles sont disponibles, selon si l'on souhaite estimer un niveau général de connaissance, faire un diagnostic détaillé, ou identifier les CC maîtrisées [@Mislevy2012]. Dans ce qui suit, nous décrivons ces modèles dans les catégories suivantes : théorie de la réponse à l'item pour des tests sommatifs, modèles cognitifs pour des tests formatifs, structures de connaissance plus complexes, compromis exploration et exploitation et tests à étapes multiples.

## Modèle de Rasch

La théorie de la réponse à l'item consiste à supposer que les réponses d'un apprenant que l'on observe lors d'un test peuvent être expliquées par un certain nombre de valeurs cachées, qu'il convient d'identifier.

Le modèle le plus simple de tests adaptatifs est le modèle de Rasch, aussi connu sous le nom de modèle logistique à un paramètre. Il modélise un apprenant par une valeur unique de niveau, et les questions ou tâches par une valeur de difficulté. La propension d'un apprenant à résoudre une tâche ne dépend que de la différence entre sa difficulté et son niveau. Ainsi, si un apprenant $i$ a un niveau $\theta_i$ et souhaite résoudre une question $j$ de difficulté $d_j$ :

$$ Pr(\textnormal{``l'apprenant $i$ répond correctement à la question $j$''}) = \Phi(\theta_i - d_j) $$

où $\Phi : x \mapsto 1 / (1 + e^{-x})$ est la fonction logistique.\nomenclature{$\Phi$}{fonction logistique}

\begin{figure}
\includegraphics[width=\linewidth]{figures/irt}
\caption{Courbes pour différentes valeurs du paramètre de difficulté $d$ du modèle de Rasch.}
\end{figure}

 <!-- TODO nouvelle courbe -->

(Exemple de produit de matrices.)

Spécifier toutes les valeurs de difficulté à la main serait coûteux pour un expert, et fournirait des valeurs subjectives qui risquent de ne pas correspondre aux données observées. Ce modèle est suffisamment simple pour qu'il soit possible de calibrer automatiquement et de façon efficace les paramètres de niveau et difficulté, à partir d'un historique de réponses. En particulier, aucune connaissance du domaine n'est requise.

Ainsi, lorsqu'un apprenant passe un test, les variables observées sont ses résultats (vrai ou faux) sur les questions qui lui sont posées, et la variable que l'on souhaite estimer est son niveau, étant donné les valeurs de difficulté des questions qui lui ont été posées, ainsi que ses résultats. L'estimation est habituellement faite en calculant le maximum de vraisemblance, facile à déterminer en utilisant la méthode de Newton pour déterminer les zéros de la dérivée de la fonction de vraisemblance. Ainsi, le processus adaptatif devient : étant donné une estimation du niveau de l'apprenant, quelle question poser afin d'obtenir un résultat informatif pour affiner cette estimation ? Il est en effet possible de quantifier l'information que chaque question $j$ donne sur le paramètre de niveau. Il s'agit de l'information de Fisher, définie par la variance du gradient de la log-vraisemblance en fonction du paramètre de niveau :

$$ I_j(\theta_i) = E\left[{\left(\frac\partial{\partial\theta} \log f(X_j, \theta_i)\right)}^2 \bigg| \theta_i \right] $$

où $X_j$ est la variable correspondant au succès/échec de l'apprenant $i$ sur la question $j$ et $f(X_j, \theta_i)$ est la fonction de probabilité pour $X_j$ qui dépend de $\theta_i$ comme indiqué plus haut : $f(X_j, \theta_i) = \Phi(\theta_i - d_j)$.

Ainsi, un test adaptatif peut être conçu de la façon suivante : étant donné l'estimation actuelle du niveau de l'apprenant, choisir la question qui va apporter le plus d'information sur son niveau, mettre à jour l'estimation en fonction du résultat (succès ou échec), et ainsi de suite. À la fin du test, on peut visualiser le processus comme dans les Figures \ref{irt} et \ref{irt-output} : l'intervalle de confiance sur le niveau de l'apprenant est réduit après chaque résultat, et les questions sont choisies de façon adaptative.

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

Le modèle de Rasch est unidimensionnel, donc il ne permet pas d'effectuer un diagnostic cognitif. Il reste pourtant populaire pour sa simplicité, sa généricité [@Desmarais2012; @Bergner2012] et sa robustesse [@Bartholomew2008]. @Verhelst2012 a montré qu'avec la simple donnée supplémentaire d'une répartition des questions en catégories, il est possible de renvoyer à l'examiné un profil utile à la fin du test, spécifiant quels sous-scores de catégorie sont plus bas ou plus haut que la moyenne. Plus précisément, si l'on considère que dans chaque catégorie, une réponse donne 1 point si elle est correcte, 0 point sinon, on peut calculer le nombre de points obtenu par l'apprenant dans chaque catégorie. À partir du modèle de Rasch, il est alors possible de calculer l'espérance du sous-score dans chaque catégorie, étant donné le score total. Enfin, le profil de déviation, défini comme la différence entre le sous-score obtenu et le sous-score moyen, fournit une bonne visualisation des catégories qui requièrent un approfondissement, voir la figure \ref{deviation}. De tels profils de déviation peuvent être agrégés de façon à mettre en évidence les points forts et faibles des apprenants au niveau d'un pays, pour identifier d'éventuelles carences dans le programme scolaire de ce pays. En effet, des évaluations internationales telles que PISA ou TIMSS permettent des comparaisons à l'échelle des pays. À partir des données de l'édition 2011 du test Trends in International Mathematics and Science Study (TIMSS), @Verhelst2012 a pu construire le diagramme à la figure \ref{deviation-country}, où l'on peut observer que la Roumanie est plus forte en algèbre qu'attendu, tandis que la Norvège est plus faible en algèbre qu'attendu. Ceci est un remarquable exemple de visualisation d'information basé sur le plus simple modèle psychométrique, le modèle de Rasch, et avec une répartition des questions en 4 catégories.\nomenclature{TIMSS}{Trends in International Mathematics and Science Study}

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

\label{mirt}

Il est naturel d'étendre le modèle de Rasch à des compétences multidimensionnelles. En théorie de la réponse à l'item multidimensionnelle (TRIM) [@Reckase2009], les apprenants et les questions ne sont plus modélisés par de simples scalaires mais par des vecteurs de dimension $d$, tels que la propension pour un apprenant à répondre correctement à une question dépend seulement du produit scalaire de ces vecteurs. Ainsi, un apprenant a plus de chances de répondre à des questions qui sont corrélées à son vecteur de compétences, et poser une question apporte de l'information dans la direction de son vecteur.\nomenclature{TRIM}{théorie de la réponse à l'item multidimensionnelle}

\def\R{\textbf{R}}

Ainsi, si l'apprenant $i \in \{1, \ldots, n\}$ est modélisé par le vecteur $\mathbf{\theta_i} \in \R^d$ et la question $j \in \{1, \ldots, m\}$ par le vecteur $\mathbf{d_j} \in \R^d$:

$$ Pr(\textnormal{``l'apprenant $i$ répond correctement à la question $j$''}) = \Phi(\mathbf{\theta_i} \cdot \mathbf{d_j}). $$

Notez qu'on ne retrouve pas le modèle de Rasch lorsque $d = 1$ mais lorsque $d = 2$ avec des paramètres $\mathbf{\theta_i} = (\theta, 1)$ et $\mathbf{d_j} = (1, d_j)$, car :

$$ \mathbf{\theta_i} \cdot \mathbf{d_j} = (\theta, 1) \cdot (1, -d_j) = \theta - d_j $$

qui correspond bien au modèle de Rasch.

Avec le modèle de la TRIM, l'information de Fisher n'est plus un scalaire mais une matrice, dont on cherche à maximiser soit le déterminant ou la trace. La question de déterminant maximal apporte le plus d'information donc la plus grande réduction de volume dans la variance de l'estimation du niveau, tandis que la question de trace maximale essaie d'augmenter l'information moyenne de chaque dimension du niveau, en ignorant la covariance entre composantes.

Réécrit comme un problème de factorisation de matrice, MIRT devient :

$$ M \simeq \Phi(\Theta D^T) $$

où $M$ est la matrice $n \times m$ des réponses des $n$ étudiants sur les $m$ questions d'un test, $\Theta$ est la matrice $n \times d$ des vecteurs des apprenants et enfin $D$ est la matrice $m \times d$ des vecteurs des questions.

Ce modèle plus riche a beaucoup plus de paramètres : $d$ paramètres doivent être estimés pour chacun des $n$ apprenants et chacune des $m$ questions, soit $d(n + m)$ paramètres au total. Ainsi, ce modèle est plus difficile à converger [@Desmarais2012; @Lan2014].

## Modèle DINA

Les modèles de diagnostic cognitif font l'hypothèse que la résolution des questions ou tâches d'apprentissage peut être expliquée par la maîtrise ou non-maîtrise de certaines composantes de connaissance (CC), ce qui permet de transférer de l'information d'une question à l'autre. Par exemple, pour calculer $1/7 + 8/9$ correctement, un apprenant est censé maîtriser l'addition, et la mise au même dénominateur. En revanche, pour calculer $1/7 + 8/7$, il suffit de savoir additionner deux fractions de même dénominateur. Ces modèles cognitifs requièrent la spécification des CC impliqués dans la résolution de chacune des questions du test, sous la forme d'une matrice binaire appelée q-matrice, qui fait le lien entre les questions et les CC : c'est un modèle de transfert. Voir Table \ref{fraction-qmatrix} pour un exemple de q-matrice.\nomenclature{CC}{Composante de connaissance}

\begin{table}
\centering
\begin{minipage}{0.46\textwidth}
$$ \begin{array}{cccccccc}
0 & 0 & 0 & 1 & 0 & 1 & 1 & 0\\
0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\
0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\
0 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
0 & 1 & 0 & 1 & 0 & 0 & 1 & 1\\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
1 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 0 & 0 & 0 & 0\\
0 & 1 & 0 & 0 & 1 & 0 & 1 & 1\\
0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 1\\
0 & 1 & 0 & 1 & 1 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
1 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 1 & 1 & 1 & 0\\
1 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
0 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
\end{array} $$
\end{minipage}
\begin{minipage}{0.46\textwidth}
Description des composantes de connaissance :
\begin{itemize}
\item convertir un nombre entier en fraction
\item séparer un nombre entier d'une fraction
\item simplifier avant de soustraire
\item mettre au même dénominateur
\item soustraire une fraction d'un entier
\item poser la retenue lors de la soustraction des numérateurs
\item soustraire les numérateurs
\item réduire les fractions sous forme irréductible
\end{itemize}
\end{minipage}
\caption{La q-matrice correspondant aux réponses de 536 collégiens sur 20 questions de soustraction de fonction comportant 8 composantes de connaissance. Le jeu de données est étudié dans @DeCarlo2010.}
\label{fraction-qmatrix}
\end{table}

\label{dina}
\nomenclature{DINA}{Deterministic Input, Noisy And}
Le modèle DINA ("deterministic input noisy and", c'est-à-dire entrée déterministe, avec un « et » avec bruit) suppose que l'apprenant résoudra une certaine question $i$ avec probabilité $1 - s_i$ s'il maîtrise toutes les CC impliquées dans sa résolution, sinon avec probabilité $g_i$. Le paramètre $g_i$ est le paramètre de chance de la question $i$, c'est-à-dire la probabilité de deviner la bonne réponse alors que l'on ne maîtrise pas les CC nécessaires, tandis que $s_i$ est le paramètre d'inattention, c'est-à-dire la probabilité de se tromper alors qu'on maîtrise les CC associées. Il existe d'autres variantes de modèles cognitifs tels que le modèle DINO ("deterministic input noisy or", c'est-à-dire entrée déterministe, avec un « ou » avec bruit) où ne maîtriser qu'une seule des CC impliquées dans une question $i$ suffit à la résoudre avec probabilité $1 - s_i$, et si en revanche aucune CC impliquée n'est maîtrisée, la probabilité d'y répondre correctement est $g_i$.

L'état latent d'un apprenant est représenté par un vecteur de bits $(c_1, \ldots, c_K)$, une par CC à maîtriser ($K$ est donc le nombre de CC impliquées dans le test), indiquant les CC qui sont maîtrisées : $c_k$ vaut 1 si l'apprenant maîtrise la $k$-ième CC, 0 sinon. Chaque réponse que l'apprenant donne sur une question nous donne de l'information sur les états possibles qui pourraient correspondre à l'apprenant. @Xu2003 ont utilisé des stratégies de tests adaptatifs pour inférer l'état latent de l'apprenant en utilisant peu de questions, c'est ainsi qu'ont été développés les tests adaptatifs de diagnostic cognitif (en anglais CD-CAT, pour *cognitive diagnosis computerized adaptive testing*), que nous appellerons diagnostics cognitifs adaptatifs. Ayant une estimation a priori de l'état mental de l'apprenant, on peut inférer son comportement sur les questions restantes du test, et choisir des questions informatives en fonction. À chaque étape, le système maintient une distribution de probabilité sur les $2^K$ états mentaux possibles et l'affine après chaque réponse de l'apprenant de façon bayésienne.\nomenclature{CD-CAT}{cognitive diagnosis computerized adaptative testing, tests adaptatifs de diagnostic cognitif}

Pour converger rapidement vers l'état latent le plus vraisemblable, la meilleure question à poser est celle qui réduit l'incertitude le plus [@Doignon2012; @Huebner2010], c'est-à-dire l'entropie de la distribution sur les états latents possibles :

$$ H(\mu) = - \sum_{c \in \{0, 1\}^K} \mu(c) \log \mu(c). $$

D'autres critères ont été étudiés et comparés tels que la question qui maximise la divergence de Kullback-Leibler, qui est une mesure de la différence entre deux distributions de probabilité [@Cheng2009]:

$$ D_{KL}(P||Q) = \sum_i P(i) \log \frac{P(i)}{Q(i)}. $$

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

\begin{figure}
\includegraphics{figures/compnum}
\caption{Exemple de q-matrice.}
\label{example-dina}
\end{figure}

\begin{figure}
\includegraphics{figures/hierarchy}
\caption{Exemple de relations de prérequis.}
\label{example-dina}
\end{figure}

Comme le dit @Chang2014, "Une étude conduite à Zhengzhou indique que CD-CAT encourage la pensée critique, en rendant les étudiants plus autonomes en résolution de problèmes, et offre de la remédiation personnalisée facile à suivre, ce qui rend l'apprentissage plus intéressant." En effet, une fois avoir identifié à l'issue d'un test l'état mental de l'apprenant, on peut l'orienter vers des ressources utiles pour combler ses lacunes.

Comme l'espace des états latents possibles est discret, on peut maintenir la distribution de probabilité $(\pi_i)_{i \in \mathbf{N}}$ sur les vecteurs de compétences possibles tout au long du test. Connaissant la réponse de l'apprenant à la $i$-ième question, la mise à jour de $\pi_{i - 1}$ est faite par la règle de Bayes. Soit $x$ un état latent, $s_i$ et $g_i$ les paramètres d'inattention et de chance associés à la $i$-ième question et soit $a_i$ une variable qui vaut 1 si la réponse de l'apprenant est correcte, 0 sinon. Si les CC associées à $x$ sont suffisantes pour répondre à la question correctement,

$$ \pi_i(x) = \pi_{i - 1}(x) \cdot [a_i \cdot(1-s_i) + (1-a_i)\cdot s_i] $$

sinon

$$ \pi_i(x) = \pi_{i - 1}(x) \cdot [a_i \cdot g_i + (1-a_i)\cdot(1-g_i)]. $$

En effet : si $x$ a bien les compétences requises, il peut soit donner la bonne réponse en ne faisant pas d'erreur d'inattention (résultat $a_i = 1$ avec probabilité $1 - s_i$), soit faire une erreur d'inattention (résultat $a_i = 0$ avec probabilité $s_i$).

Maintenir la distribution de probabilité sur les $2^K$ états latents possibles risque d'être impraticable pour de larges valeurs de $K$, c'est pourquoi en pratique $K \leq 10$ [@Su2013]. Il est toutefois possible de réduire la complexité en supposant des relations de prérequis entre CC : si la maîtrise d'une CC implique celle d'une autre CC, le nombre d'états possibles décroît et donc la complexité en temps fait de même. Cette approche est appelée modèle de hiérarchie sur les attributs [@Leighton2004] et permet d'obtenir des représentations de connaissances qui correspondent mieux aux données [@Rupp2012].\label{ahm}

La q-matrice peut être coûteuse à construire. Ainsi, calculer une q-matrice automatiquement a été un sujet de recherche. @Barnes2005 utilise une technique d'escalade de colline (qui consiste à flipper quelques bits et regarder si l'erreur est diminuée) tandis que @Winters2005 et @Desmarais2011 ont essayé des méthodes de factorisation de matrice pour recouvrer des q-matrices à partir de données d'apprenants. Ils ont découvert que pour des domaines bien distincts comme le français et les mathématiques, ces techniques permettent de séparer les questions qui portent sur ces domaines. Une critique est que même si l'on obtient via ces méthodes automatiques des matrices qui correspondent bien aux données, les colonnes risquent de ne plus être interprétables. @Lan2014 a tenté de contourner ce problème en tentant d'interpréter a posteriori les colonnes de la q-matrice, en utilisant des tags spécifiés par des experts sur les questions. @Koedinger2012 a réussi à combiner des q-matrices de différents experts par externalisation ouverte (*crowdsourcing*) de façon à obtenir des q-matrices plus riches, toujours interprétables, et qui correspondent davantage aux données.

De façon surprenante, le modèle DINA n'a pas besoin de données de test pour être déjà adaptatif. La q-matrice suffit à lancer des tests, où l'on suppose alors que les apprenants ont autant de chance de maîtriser une composante que de ne pas la maîtriser. À l'aide d'un historique, on peut avoir un a priori sur les composantes qu'un nouvel apprenant maîtrisera ou non.

## Théorie des espaces de connaissances basés sur les compétences
\label{knowledge-space}

@Doignon2012 ont développé la théorie des espaces de connaissances, qui repose sur un ordre partiel entre les sous-ensembles d'un espace de connaissances discret. Supposons qu'il existe 

have developed knowledge space theory, an abstract theory that relies on a partial order between subsets of a discrete knowledge space. Formally, let us assume that there is a certain number of KCs to learn, following a dependency graph specifying which KCs needs to be mastered before learning a certain KC, see Figure \ref{dependency}. From this dependency graph, one can compute the feasible knowledge states, i.e., the KCs that are actually mastered by the learner. For example, $\{a, b\}$ is a feasible knowledge state while the singleton $\{b\}$ is not, because $a$ needs to be mastered before $b$. Thus, for this example there are 10 feasible knowledge states: $\emptyset, \{a\}, \{b\}, \{a, b\}, \{a, c\}, \{a, b, c\}, \{a, b, c, d\}, \{a, b, c, e\}, \{a, b, c, d, e\}$. An adaptive testing can then uncover the knowledge state of the examinee, in a similar fashion to the Attribute Hierarchy Model described above. Once the knowledge subset of a learner has been identified, this model can suggest to him the next knowledge components to learn in order to help him progress, through a so-called learning path, see Figure \ref{dependency}. From the knowledge state $\{a\}$, the learner can choose whether he wants to learn the KC $b$ or the KC $c$ first.

@Falmagne2006 provide an adaptive test in order to guess effectively the knowledge space using entropy minimization, which is however not robust to careless errors. This model has been implemented in practice in the ALEKS system, which is said to be used by millions of users today [@Kickmeier2015; @Desmarais2012].

\begin{figure}
\centering
\includegraphics{figures/knowledge-space.pdf}
\qquad
\includegraphics[width=0.4\textwidth]{figures/learning-path.pdf}
\caption{On the left, the precedence diagram for algebra problems. On the right, the corresponding learning paths.}
\label{dependency}
\end{figure}

@Lynch2014 have implemented a similar adaptive pretest at the beginning of a MOOC in order to guess what the learner already masters and help them jump directly to useful materials in the course. To address slip and guess parameters, they combine models from knowledge space theory and item response theory.

There has been a tendency for more fine-grained models for adaptive testing that consider an even richer domain representation such as an ontology [@Mandin2014; @Kickmeier2015] of the domain covered by the test. However, such knowledge representations are costly to make.

## Démarrage à froid en filtrage collaboratif

Recommender systems can recommend new items to a user based on his preferences on other items. Two approaches are used:

\begin{enumerate}
\item content-based recommendations, that analyze the content of the items in order to devise a measure of similarity between items;
\item collaborative filtering, where the similarity between items depend solely on the preferences of the users: items with common aficionados are assumed similar.
\end{enumerate}

Overall, the aim is to predict the preference of a user over an unseen item, based on his preferences over a fraction of the items he knows. In our case, we want to predict the performance of a user over an unasked question, based on his previous performance. Collaborative filtering techniques have been applied on student data in an user-to-resource fashion [@Manouselis2011; @Verbert2011] and in an user-to-task fashion [@Toscher2010; @ThaiNghe2011; @Bergner2012].

All recommender systems face the user cold-start problem: given a new user, how to quickly recommend new relevant items to him? In technology-enhanced learning, the problem becomes: given a new learner, how to quickly identify the resources that he will need? To the best of our knowledge, the only reference to the cold-start problem within educational environments has been coined by @ThaiNghe2011: "In the educational environment, the cold-start problem is not as harmful than in the e-commerce environment where [new] users and items appear every day or even hour, thus, the models need not to be re-trained continuously." However, this article predates the advent of MOOCs, therefore this statement is no longer true.

Among the most famous approaches to tackle the cold-start problem, one method of particular interest is an adaptive interview that presents some items to the learner and asks him to rate them. @Golbandi2011 builds a decision tree that starts an interview process with the new user in order to quickly identify users similar to him. The best items are the ones that bisect the population into roughly two halves, and are in a way similar to discriminative items in item response theory. If we transfer this problem to adaptive testing with test-size reduction, it becomes: what questions should we ask to a new learner in order to infer its whole vector of answers? The core difference with an e-commerce environment is that learners might try to game the system more than in a commercial environment, thus their answers might not fit their ability estimate.

Most collaborative filtering techniques assume the user-to-item matrix $M$ is of low rank $r$ and look for a low-rank approximation under the matrix factorization $M \simeq UV^T$ where $U$ and $V$ are assumed of width $r$. Please note that if $M$ is binary and the loss function for the approximation is the logistic loss, we get back to the MIRT model (as a generalized linear model), see Section \ref{mirt}.

\paragraph{Diversity} Recommender systems have been criticized to "put the user in a box" and harm serendipity. But since then, there has been more research into diversity (finding a set of diverse items to recommend) and explained recommendations. More recently, there has been a need of more interactive recommender systems, giving back power to the user by letting him steer the recommendations towards other directions. The application to learner systems is straightforward: we could help the learner navigate in the course.

\paragraph{Implicit feedback} In e-commerce use cases, recommender systems differentiate explicit feedback given willingly by the user, such as "this user liked this item", from implicit feedback resulting from unintentional behavior, such as "this user stayed a lot of time on this page". The fact that a user stays a lot of time on a page may indicate that he is interested in the content of this page. Therefore, such implicit feedback data is used by e-commerce websites in order to know their clients better. In technology-enhanced learning use cases, explicit feedback data is often sparse, thus implicit feedback techniques are attractive candidates to improve recommender performance, using for example the time spent on a page, search terms used by the user, information about downloaded resources and comments posted by the user [@Verbert2011]. Such data may be of interest when recorded while the test is administered, for example for a learner browsing the course content while attempting a low-stake adaptive testing.

\paragraph{Adding external information} Some recommender systems embed additional information in their learning models such as the description of the item, or even the musical content itself in the scope of music recommendation. In order to improve prediction over the test, one could consider extracting any features from the problem statements of the items and incorporate them within the feature vector.

## Stratégies adaptatives pour le compromis exploration-exploitation
\label{bandits}

In some applications, one wants to maximize a certain objective function while asking questions. There is a tradeoff between knowing the user more by exploring the space of items and exploiting what we know in order to maximize a certain reward. @Clement2015 applied these techniques to intelligent tutoring systems: they personalize sequences of learning activities in order to uncover the knowledge components of the learner while maximizing his learning progress, as a function of the performance over the latest tasks. They use two models based on multi-armed bandits, one that relies on Vigotsky’s zone of proximal development [@Vygotsky1980] under the form of a dependency graph, the second on a q-matrix. They tested both approaches on 400 real students between 7 and 8 years old. They discovered quite surprisingly that the dependency graph performed better than the model using the expert-specified q-matrix. Their technique provided a great gain in learning for populations of students with larger variety and stronger difficulties.

## Tests à étapes multiples

So far, we only considered questions asked one after another. But the first ability estimate, using only the first answer, has high bias. Thus ongoing psychometrics research tends to consider asking pools of questions at each step, allowing adaptation only once sufficient information has been gathered. This approach has been referred to as multistage testing (MST) [@Yan2014]. After the first stage of $k_1$ questions, according to his performance, the learner moves to another stage of $k_2$ questions that depend only on his performance, and so on, see Figure \ref{mst}. MST presents another advantage: the learner can revise his answers before moving to the next stage without the need of complicated models for response revision [@Han2013; @Wang2015]. In clinical trials, MST design can be viewed as a group sequential design while a CAT can be viewed as a fully sequential design. The item selection is performed automatically, but the test developers can review the assembled test forms before administration.

@Wang2016 suggests to ask a group of questions at the beginning of the test, when little information about learner ability is available, and progressively reduce the number of questions of each stage in order to increase opportunities to adapt. Also, asking pools of questions allow to do content balancing at each stage instead of jumping from one knowledge component to the other after every question.

\begin{figure}
\centering
\includegraphics{figures/mst.pdf}
\caption{In multistage testing, questions are asked in a group sequential design.}
\label{mst}
\end{figure}

# Limitations

Here we just considered knowledge recall, not other dimensions such as perseverance, clarity, carefulness. By reducing items, we reduce the time spent by students being assessed, which prevents boredom and leaves more time for other activities.

In our case, within a test our model never asks the same question twice. In many scenarios though, presenting the same item several times is better, for example in vocabulary learning. Such so-called spaced repetition systems such as Anki have been succesfully used for vocabulary learning [@RefNecessaire]. In our case, we prefer to ask different items that need similar KCs (knowledge components). Such approach has been referred to as interleaved practice [@Dunlosky2013] and reduces the risks of guessing the correct answer.

Our approach is mainly static, which means we don't assume that the knowledge of the student increases after he gets many opportunities of being assessed on the same KCs. This assumption is made in intelligent tutoring systems, where the knowledge of the learner is dynamic. Thus, our diagnostic test provides a snapshot of the knowledge for the student at a certain time.
(Là faudrait pas que je me contredise trop avec The Future of Assessment où l'on écrit que l'explicit testing pourrait être remplacé par de l'embedded assessment : d'être continument monitoré par la plateforme.)

We don't consider metadata over the learner, such as demographic information. This allows us to provide an anonymous test, of which the results are stored anonymously. This prevents stress from the examinee, scared that his mistakes may be recorded forever [@Obama2014].

We do not track the student from one occurrence of the test to the next one. Thus, a student may get the same items from an occurrence to the other one. This could be prevented by recording minimal information such as the previous items administered (not the outcomes).

There exist different interfaces for assessment such as serious games or stealth assessment [@Shute2015], which lead to more motivation and engagement from the students (such as Packet Tracer for learning network routing, or Newton's Playground for learning physics). We believe our approach is more generic: it only needs student data under the form of 1 and 0's and may be applied to these serious-game scenarios. We leave this for further research.

# Discussion

Practice testing is a key factor to success [@Dunlosky2013]. However, asking questions can be boring. In order to prevent boredom, asking less questions is better.

Adaptive testing allows better personalization by organizing learning resources. For example, curriculum sequencing consists in defining learning paths in a space of learning objectives [@Desmarais2012]. It aims to use skills assessment to tailor the learning content with the least possible amount of evidence. 

Dans les tests adaptatifs, nous n'observons pas toutes les réponses  all student responses but only the answers to the subset of questions we asked, which may differ from a student to another. It is still possible to compute the deviation profile within this subset, but it can't be aggregated to a higher level, because of the bias induced by the adaptive process.
