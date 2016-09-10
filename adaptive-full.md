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

La théorie de la réponse à l'item consiste à supposer que les réponses d'un apprenant observées lors d'un test peuvent être expliquées par un certain nombre de valeurs cachées, qu'il convient d'identifier.

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

Ainsi, un test adaptatif peut être conçu de la façon suivante : étant donné l'estimation actuelle du niveau de l'apprenant, choisir la question qui va apporter le plus d'information sur son niveau, mettre à jour l'estimation en fonction du résultat (succès ou échec), et ainsi de suite. À la fin du test, on peut visualiser le processus comme dans les Figures \ref{irt} et \ref{irt-output} : l'intervalle de confiance sur le niveau de l'apprenant réduit après chaque résultat, et les questions sont choisies de façon adaptative.

\begin{figure}
\includegraphics[width=\linewidth]{figures/irt.pdf}
\caption{Evolution of the ability estimate throughout an adaptive test based on the Rasch model.}
\label{irt}
\end{figure}

\begin{figure}
\begin{verbatim}
We ask question 42 to the examinee.
Correct!
We ask question 48 to the examinee.
Correct!
We ask question 82 to the examinee.
Incorrect.
We ask question 53 to the examinee.
Correct!
We ask question 78 to the examinee.
Incorrect.
We ask question 56 to the examinee.
Correct!
We ask question 76 to the examinee.
Incorrect.
We ask question 58 to the examinee.
Incorrect.
\end{verbatim}
\caption{Exemple de test adaptatif.}
\label{irt-output}
\end{figure}

Being a unidimensional model, the Rasch model is not suitable for cognitive diagnosis. Still, it is really popular because of its simplicity, its stability and its sound mathematical framework [@Desmarais2012; @Bergner2012]. Also, @Verhelst2012 has showed that if the items are splitted into categories, it is possible to provide to the examinee a useful deviation profile, specifying which category subscores were lower or higher than expected. More precisely, if we consider that in each category, an answer gives one point if correct, no point otherwise, we can compute the number of points obtained by the learner in each category (the subscores), which sum up to his total score. Given the Rasch model only, it is possible to compute the expected subscore of each category, given the total score. Finally, the deviation profile, defined as the difference between the observed and expected subscores, provides a nice visualization of the categories that need further work, see Figure \ref{deviation}. Such deviation profiles can be aggregated in order to highlight the strong and weak points of the students at the level of a country, witnessing a possible deficiency in the national curriculum. Studies of international assessments, such as the Trends in International Mathematics and Science Study (TIMSS), allow for worldwide comparisons. An example is given over the TIMSS 2011 dataset of proficiency in mathematics, see Figure \ref{deviation}, highlighting the fact that Romania is stronger in Algebra than expected, while Norway is weaker in Algebra than expected. This belongs to the information visualization class of learning analytics methods, and shows what can be done using the most simple psychometric model and the student data only.

In adaptive testing though, we do not observe all student responses but only the answers to the subset of questions we asked, which may differ from a student to another. It is still possible to compute the deviation profile within this subset, but it can't be aggregated to a higher level, because of the bias induced by the adaptive process.

\begin{figure}
\centering
\includegraphics[width=0.5\linewidth]{figures/profil.png}\\
\includegraphics[width=\linewidth]{figures/profilpays.png}
\caption{Above, the deviation profile of a single learner. Below, the deviation profile of different countries on the TIMSS 2011 math dataset, from the presentation of N.D. Verhelst. at the Psychoco 2016 conference.}
\label{deviation}
\end{figure}

\label{mirt}

It is natural to extend the Rasch model to multidimensional abilities. In Multidimensional Item Response Theory (MIRT) [@Reckase2009], both learners and items are modelled by vectors of a certain dimension $d$, and the tendency for a learner to solve an item depends only on the dot product of those vectors. Thus, a learner has greater chance to solve items correlated with its ability vector, and asking a question brings information in the direction of its item vector.\nomenclature{TRIM}{théorie de la réponse à l'item multidimensionnelle}

\def\R{\textbf{R}}

Thus, if learner $i \in \{1, \ldots, n\}$ is modelled by vector $\vec{\theta_i} \in \R^d$ and item $j \in \{1, \ldots, m\}$ is modelled by vector $\vec{d_j} \in \R^d$:

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi(\vec{\theta_i} \cdot \vec{d_j}). $$

Using this model, the Fisher information becomes a matrix, of which one wants to maximize either the determinant ("D-rule") or the trace ("T-rule"). The item with maximum determinant provides the maximum volume of information thus the largest reduction of volume in the variance of the ability estimate, while the item with maximum trace attempts to increase the average information about each component of the ability, by ignoring the covariation between components.

Restated as a matrix factorization problem, MIRT becomes:

$$ M \simeq \Phi(\Theta D^T) $$

where $M$ is the $n \times m$ student data, $\Theta$ is the $n \times r$ learner matrix of all learners vectors and $D$ is the $m \times r$ item matrix of all item vectors.

Nevertheless, those richer models involve many more parameters : if $d$ parameters are estimated for each of the $n$ learners, and $d$ parameters are estimated for each of the $m$ items. Thus, this model has proven to be much harder to calibrate [@Desmarais2012; @Lan2014].

## Modèle DINA

Les modèles de diagnostic cognitif reposent sur une q-matrice, qui fait le lien entre les questions et les composantes de connaissance (CC).\nomenclature{CC}{Composante de connaissance}

    Round 1 -> We ask question 9 to the examinee.
    It requires KC: [0, 1, 0, 0, 0, 0, 0, 0]
    Correct!
    Examinee: [0.5, 0.74, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
    Estimate: 00000101100000000000
       Truth: 00011111111101001111

    Round 2 -> We ask question 6 to the examinee.
    It requires KC: [0, 0, 0, 0, 0, 0, 1, 0]
    Correct!
    Examinee: [0.5, 0.74, 0.5, 0.5, 0.5, 0.5, 0.91, 0.5]
    Estimate: 00000101100101010000
       Truth: 00011111111101001111

Les modèles de diagnostic cognitif font l'hypothèse que la résolution de tâches d'apprentissage peut être expliquée par la maîtrise ou non-maîtrise de certaines CC, ce qui permet de transférer de l'information d'une question à l'autre. Par exemple, pour calculer $1/7 + 8/9$ correctement, un apprenant est censé maîtriser l'addition, et la mise au même dénominateur. En revanche, pour calculer $1/7 +8/7$, seul le fait d'additionner est nécessaire. Ces modèles cognitifs requièrent la spécification des CC impliqués dans la résolution de chacune des questions du test, sous la forme d'une matrice binaire appelée q-matrice, qui fait le lien entre les questions et les CC : c'est un modèle de transfert. Voir Table \ref{fraction-qmatrix} pour un exemple de q-matrice.

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
Description of the knowledge components:
\begin{itemize}
\item convert a whole number to a fraction
\item separate a whole number from a fraction
\item simplify before subtracting
\item find a common denominator
\item borrow from whole number part
\item column borrow to subtract the second numerator from the first
\item subtract numerators
\item reduce answers to simplest form
\end{itemize}
\end{minipage}
\caption{The q-matrix corresponding to Tatsuoka's (1984) fraction subtraction data set of 536 middle school students over 20 fraction subtraction test items spanned over 8 knowledge components.}
\label{fraction-qmatrix}
\end{table}

\label{dina}
\nomenclature{DINA}{Deterministic Input, Noisy And}
The DINA model ("deterministic input noisy and") assumes that the learner will solve a certain item $i$ with probability $1 - s_i$ if he masters every KC involved in its resolution and with probability $g_i$ otherwise. The parameter $g_i$ is called the guess parameter of item $i$, it represents the probability of guessing the right answer to item $i$ while not being able to solve it, while $s_i$ is called the slip parameter of items $i$ and represents the probability of slipping on item $i$ while mastering the correct KCs. The DINO model ("deterministic input noisy or") only requires the mastery of one KC involved in the resolution of an item in order to solve it with probability $1 - s_i$. If no KC involved is mastered, the probability of solving the item is $g_i$.

The latent state of a learner is represented by a vector of $K$ bits $(c_1, \ldots, c_K)$ where $K$ is the number of KCs involved, indicating the KCs that are mastered: for each $KC$ $k$, $c_k$ is 1 if the learner masters the $k$-th KC, 0 otherwise. Each answer that the learner gives on an item brings us information about his probable latent state. @Xu2003 have used adaptive testing strategies in order to infer the latent state of the learner using few questions, coined as cognitive diagnosis computerized adaptive testing (CD-CAT). Knowing the mental state of a learner, we can infer his behavior over the remaining questions in the test, and choose questions accordingly. At each moment, the system keeps a probability distribution over the $2^K$ possible latent states and refines it after each question using the Bayes' rule. A usual measure of uncertainty is entropy:

$$ H(\mu) = - \sum_{c \in \{0, 1\}^K} \mu(c) \log \mu(c). $$

Therefore, in order to converge quickly into the true latent state, the best item to ask is the one that reduces average entropy the most [@Doignon2012; @Huebner2010]. Other criteria have been tried such as the question that maximizes the Kullback-Leibler divergence, which is a measure of the difference between two probability distributions [@Cheng2009]:

$$ D_{KL}(P||Q) = \sum_i P(i) \log \frac{P(i)}{Q(i)}. $$

As @Chang2014 states, "A survey conducted in Zhengzhou found that CD-CAT encourages critical thinking, making students more independent in problem solving, and offers easy to follow individualized remedy, making learning more interesting."

As the distribution over skills is on a finite support, we can maintain at each step the whole probability distribution $\pi$ over the possible skill vectors, initialized at some prior distribution inferred during the train phase.
Knowing the student answer to a certain question $i$, the update of $\pi_i$ is done according to Bayes' rule. Let $x$ be a skill vector, $s_i$ and $g_i$ the slip and guess parameters of the question $i$ and $a_i$ be 1 if the answer was correct, 0 otherwise. If the skills associated to $x$ are sufficient to answer the question correctly,

$$ \pi_{i+1}(x) = \pi_i(x) \cdot [a_i \cdot(1-s_i) + (1-a_i)\cdot s_i] $$

otherwise

$$ \pi_{i+1}(x) = \pi_i(x) \cdot [a_i \cdot g_i + (1-a_i)\cdot(1-g_i)]. $$

En effet : si $x$ a bien les compétences requises, il peut soit donner la bonne réponse en ne faisant pas d'erreur d'inattention (résultat $a_i = 1$ avec probabilité $1 - s_i$), soit faire une erreur d'inattention (résultat $a_i = 0$ avec probabilité $s_i$).

Maintaining the probability distribution over the $2^K$ states may be intractable for large values of $K$, therefore $K \leq 10$ in practice [@Su2013]. It is possible to reduce the complexity by assuming prerequisites between KCs: if the mastery of some KC implies the mastery of another KC, the number of possible states decreases and so does the complexity. This approach is called the Attribute Hierarchy Model [@Leighton2004], and has allowed more accurate knowledge representations that fit the data better [@Rupp2012].\label{ahm}

The q-matrix may be costly to build. Thus, devising a q-matrix automatically has been an open field of research. @Barnes2005 used a hill-climbing technique while [@Winters2005; @Desmarais2011] tried non-negative matrix factorization techniques to recover q-matrices from real and simulated multidisciplinary assessment data. They discovered that for topics well separated such as French and Mathematics, these techniques can separate well items that belong to these categories. On the contrary, on another dataset of assessments from the general knowledge game Trivial Pursuit, the results are no better than chance. As a recall, non-negative matrix factorization tries to devise matrices with non-negative coefficients $W$ and $Q$ such that the original matrix $M$ verifies $M \simeq WQ^T$. But other matrix factorization techniques can be tried such as sparse PCA [@Zou2006], which tries to devise a factorization under the form $M \simeq WQ^T$ where $Q$ is sparse, the intuition being: only few knowledge components are involved in the resolution of one task. On the datasets we tried, the expert-specified q-matrix fit better than a q-matrix devised automatically using sparse PCA. Even if we had an automatically devised q-matrix that fits the data better, we would not be able to name the knowledge components anyway. @Lan2014 tried to circumvent this issue by trying to interpret a posteriori the lines of the q-matrix, using expert-specified tags. A more recent work from @Koedinger2012 managed to combine q-matrices from several experts using crowdsourcing in order to find better cognitive models that are still explainable.

One may desire a model that encompasses both the mastery of a knowledge component and a notion of difficulty. To address this need, unified models have been designed, such as the general diagnostic model for partial credit data [@Davier2005] that takes MIRT and some cognitive models as special cases:

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi\left(\beta_i + \sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk}\right) $$

where $K$ is the number of KCs involved in the test, $\beta_i$ is the main ability of learner $i$, $\theta_{ik}$ its ability for KC $k$, $q_{jk}$ is the $(j,k)$ entry of the q-matrix which is 1 if KC $k$ is involved in the resolution of item $j$, 0 otherwise, $d_{jk}$ the difficulty of item $j$ over KC $k$. Please note that this model is similar to the MIRT model specified above, but the dot product is computed only on part of the components. The intuition is to consider a MIRT model where the number of dimensions is the number of KCs of the q-matrix ($d = K$). When we calibrate the feature vector of dimension $d$ of an item, only the components that correspond to KCs involved in the resolution of this item are taken into account, see Figure \ref{fig-genma}. Hence, the fact that few components are required to solve each item allows the MIRT parameter estimation to converge. @Vie2016 used it in adaptive testing under the name GenMA. Another advantage is that the ability estimate at some point in the test represents degrees of proficiency for each knowledge component. The GenMA model is therefore a hybrid model that combines the Rasch model and a cognitive model.
\label{genma}

\begin{figure}
\centering
\includegraphics[width=\linewidth]{figures/genma.pdf}
\caption{The GenMA hybrid model, combining item response theory and a q-matrix.}
\label{fig-genma}
\end{figure}

De façon surprenante, le modèle DINA n'a pas besoin de données de test pour être déjà adaptatif. La q-matrice suffit à lancer des tests, où l'on suppose alors que les apprenants ont autant de chance de maîtriser une composante que de ne pas la maîtriser. À l'aide d'un historique, on peut avoir un a priori sur les composantes qu'un nouvel apprenant maîtrisera ou non.

## Théorie des espaces de connaissances basés sur les compétences
\label{knowledge-space}

@Doignon2012 have developed knowledge space theory, an abstract theory that relies on a partial order between subsets of a discrete knowledge space. Formally, let us assume that there is a certain number of KCs to learn, following a dependency graph specifying which KCs needs to be mastered before learning a certain KC, see Figure \ref{dependency}. From this dependency graph, one can compute the feasible knowledge states, i.e., the KCs that are actually mastered by the learner. For example, $\{a, b\}$ is a feasible knowledge state while the singleton $\{b\}$ is not, because $a$ needs to be mastered before $b$. Thus, for this example there are 10 feasible knowledge states: $\emptyset, \{a\}, \{b\}, \{a, b\}, \{a, c\}, \{a, b, c\}, \{a, b, c, d\}, \{a, b, c, e\}, \{a, b, c, d, e\}$. An adaptive testing can then uncover the knowledge state of the examinee, in a similar fashion to the Attribute Hierarchy Model described above. Once the knowledge subset of a learner has been identified, this model can suggest to him the next knowledge components to learn in order to help him progress, through a so-called learning path, see Figure \ref{dependency}. From the knowledge state $\{a\}$, the learner can choose whether he wants to learn the KC $b$ or the KC $c$ first.

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