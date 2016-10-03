# Composants modulables d'un test adaptatif

## Modèle de la probabilité de répondre correctement à chaque question

Tous les modèles de tests adaptatifs reposent sur des caractéristiques des questions et des apprenants, spécifiés par un expert ou déterminés automatiquement au moyen d'algorithmes. Ils reposent sur une expression de la probabilité qu'un certain apprenant réponde à une certaine question, en fonction de leurs caractéristiques.

## Calibrage des caractéristiques

\label{training-step}

Les caractéristiques des questions et des apprenants peuvent être spécifiées à la main par un enseignant, ou bien calculées automatiquement à partir de ce qu'on appelle des *données d'entraînement*. Si le test est administré pour la première fois, il n'y a pas de données d'entraînement, sinon on dispose d'un historique de réponses d'une population $I$ d'apprenants face à des questions d'un ensemble $Q$, sous la forme d'une matrice $|I| \times |Q|$ dont l'élément $m_{ij}$ vaut 1 si l'apprenant $i$ a répondu correctement à la question $j$, 0 sinon.

En général, les valeurs calculées automatiquement conduisent à une erreur du modèle plus faible, car les algorithmes de calibrage sont justement conçus pour minimiser le taux d'erreur autant que possible sur les données d'entraînement, contrairement à un humain dont les valeurs affectées peuvent être subjectives et ne pas correspondre à la réalité.

Il est également possible de spécifier une partie des caractéristiques et de calculer automatiquement les autres. Lorsqu'il y a plusieurs caractéristiques à optimiser, il est possible d'en optimiser une première en fixant toutes les autres, puis optimiser la deuxième en fixant toutes les autres, et ainsi de suite, jusqu'à obtenir une erreur convenable.

<!-- TODO et itérer plusieurs fois -->

## Choix de la question initiale

Au début d'un test adaptatif, le système n'a aucune information sur l'apprenant, car il n'a fourni aucune réponse et nous ne considérons aucune donnée sur l'apprenant nous permettant de l'identifier, telles que des données démographiques comme son âge ou son pays.

Le système peut choisir la première question à poser au hasard, ou bien initialiser les caractéristiques de l'apprenant à une certaine valeur qui peut dépendre des éventuellement données d'entraînement à disposition. Par exemple, le système peut supposer que l'apprenant est de niveau moyen au sein de la population.

<!-- Nous avons fait ce dernier choix afin d'avoir un processus déterministe qui utilise toute l'information à disposition. -->

## Choix de la question suivante

À un certain moment du test, le système doit, à partir des questions déjà posées et de leurs résultats, choisir la question suivante. Ainsi, la fonction qui choisit la question suivante prend en paramètre une liste de couples $\{(i_k, r_k)\}_k$ où $r_k$ vaut 1 si l'apprenant a répondu correctement à la question $i_k$, 0 sinon.

## Retour fait à la fin du test

L'apprenant obtient à la fin du test ses caractéristiques qui ont été calculées pendant le processus. Cela peut comprendre la liste des questions qu'il a résolues correctement ou non, munies éventuellement de leurs caractéristiques. Par exemple, le modèle de Rasch renvoie une valeur réelle de niveau tandis que le modèle DINA indique la probabilité que le candidat maîtrise chacune des CC.

Pour visualiser cette information, diverses méthodes peuvent être employées. Pour le modèle de Rasch, on peut indiquer à l'apprenant où il se trouve au sein de la population (par exemple, dans les 10 % meilleurs). Pour le modèle DINA, on peut tracer des jauges de maîtrise des différentes compétences, à partir de sa probabilité de les maîtriser.

<!-- # Bornes théoriques de problèmes similaires

## Recherche binaire généralisée

Le problème d'identification d'une cible en posant la question qui minimise l'entropie à chaque tour s'appelle la recherche dichotomique généralisée. On peut considérer des erreurs iid mais pour des erreurs persistantes, ce problème est peu connu théoriquement.

## Sous-modularité

Toutefois, on a une borne théorique dans le cas où les apprenants répondent sans erreur. -->

# Évaluation qualitative

\label{quali-comp}

Plusieurs aspects font qu'on peut préférer un modèle de test adaptatif plutôt qu'un autre. Par exemple, la mise en œuvre d'un modèle de test peut requérir la construction d'une q-matrice, ce qui peut être coûteux si l'on a plusieurs milliers de questions à apparier avec une dizaine de composantes de connaissance.

Multidimensionalité

:   Est-ce que le modèle mesure une ou plusieurs dimensions ?

<!-- dimension -->

Interprétabilité

:   Dans les évaluations formatives, il est important de pouvoir nommer les composantes de connaissances dont l'apprenant a dû faire preuve, de façon satisfaisante ou insatisfaisante. Disposer d'une q-matrice spécifiée par un humain permet d'accroître l'interprétabilité du système, car il est alors possible d'identifier les lacunes de l'apprenant soulignées par le test.

Explicabilité

:   Un modèle explicable est capable de justifier par quel processus le diagnostic a été obtenu. On reproche parfois aux modèles d'apprentissage statistique de faire des prédictions correctes sans pouvoir les expliquer (on parle de modèles \og boîte noire \fg). Si le modèle prédictif est linéaire ou log-linéaire, il est possible de justifier ses prédictions. S'il est non linéaire, on ne peut pas expliquer les prédictions.

<!-- Ça va pas -->

Besoin d'un historique

:   Est-ce que le modèle a besoin d'un historique d'apprenants pour fonctionner ou est-ce que le test peut être adaptatif dès sa première administration ?

Complexité

:   Quelle est la complexité de chacun des composants modulables ?

# Méthodologie de comparaison quantitative de modèles

Nous allons employer un formalisme qui vient de l'apprentissage automatique pour définir notre problème.

## Apprentissage automatique à partir d'exemples

Lorsqu'on cherche à modéliser un phénomène naturel, on peut utiliser un modèle statistique, dont on estime les paramètres en fonction des occurrences observées. Par exemple, si on suppose qu'une pièce suit une loi de Bernoulli et tombe sur Face avec probabilité $p$ et Pile avec probabilité $1 - p$, on peut estimer $p$ à partir de l'historique des occurrences des lancers de la pièce. Plus l'historique est grand, meilleure sera l'estimation de $p$. À partir de ce modèle, il est possible de faire des prédictions sur les futurs lancers de la pièce.

L'apprentissage automatique consiste à construire des modèles à partir d'ex\-emples capables de prédire des caractéristiques sur des données inédites, par exemple : reconnaître des chiffres sur des codes postaux, ou des chats sur des images. Plus il y a d'exemples pour entraîner le modèle, meilleures sont ses prédictions.

En ce qui nous concerne, nous souhaitons utiliser l'historique des réponses d'apprenants sur un test pour permettre de concevoir automatiquement un test adaptatif composé des mêmes questions. Dans le cadre d'un MOOC, par exemple, il sera possible de réutiliser les données des apprenants d'une session pour proposer des tests plus efficaces pour la session suivante.

On distingue deux types d'apprentissage automatique. L'*apprentissage supervisé* consiste à disposer d'échantillons étiquetés, c'est-à-dire appariés avec une variable d'intérêt, et à devoir prédire les étiquettes d'échantillons inédits. L'*apprentissage non supervisé* consiste à disposer d'échantillons non étiquetés, et donc à déterminer des motifs récurrents au sein des échantillons ou à en extraire des caractéristiques utiles pour expliquer les données.

En apprentissage supervisé, on appelle *classifieur* un modèle qui prédit une variable discrète, et *régresseur* un modèle qui prédit une variable continue. Ainsi, à partir des *caractéristiques* d'un échantillon $\mathbf{x} = (x_1, \ldots, x_d)$, par exemple les couleurs des pixels d'une image, un classifieur peut prédire une variable $y$ dite *étiquette*, par exemple le chiffre 1 si l'image est un chat, 0 sinon. Une fois ce modèle entraîné sur des échantillons de caractéristiques $\mathbf{x}^{(1)}, \ldots, \mathbf{x}^{(e)}$ étiquetées par les variables $y^{(1)}, \ldots, y^{(e)}$ (c'est la *phase d'entraînement*), on peut s'en servir pour prédire les étiquettes d'échantillons inédits $\mathbf{x'}^{(1)}, \ldots, \mathbf{x'}^{(t)}$ (c'est la *phase de test*).

Ainsi on distingue les données d'entraînement $X_{train} = (\mathbf{x}^{(1)}, \ldots, \mathbf{x}^{(e)})$, sous la forme d'une matrice de taille $e \times d$ où $e$ est le nombre d'échantillons et $d$ la dimension des caractéristiques, et leurs étiquettes $\mathbf{y}_{train} = (y^{(1)}, \ldots, y^{(e)})$ des données de test $X_{test} = (\mathbf{x'}^{(1)}, \ldots, \mathbf{x'}^{(t)})$.

En ce qui nous concerne, nous disposons des résultats de plusieurs apprenants sur les questions d'un test, et nous cherchons à prédire les résultats d'un nouvel apprenant alors qu'il passe ce même test, sous la forme de succès ou échecs à chacune des questions. Notre problème commence par une phase d'apprentissage non supervisé, car à partir du simple historique des résultats au test, il faut extraire des caractéristiques sur les apprenants et les questions qui expliquent ces résultats. Puis, on se ramène à une phase d'apprentissage supervisé pour un nouvel apprenant car il s'agit d'un problème de classification binaire : on cherche à prédire à partir des réponses que donne l'apprenant ses résultats sur le reste des questions du test. Une particularité est que l'apprentissage du modèle est ici interactif, dans la mesure où c'est le modèle qui choisit les questions à poser (c'est-à-dire, les éléments à faire étiqueter) à l'apprenant afin d'améliorer son apprentissage des caractéristiques de l'apprenant. Cette approche s'appelle apprentissage actif (*active learning*), et dans ce cadre elle comporte du bruit, car l'apprenant peut faire des fautes d'inattention ou deviner la bonne réponse.

## Extraction automatique de q-matrice

Il peut arriver que pour un test donné, on ne dispose pas de q-matrice. Certaines approches en fouille de données pour l'éducation consistent à la calculer automatiquement pour ensuite en interpréter les CC correspondant aux colonnes. @Barnes2005 fait ainsi une escalade de colline[^1], mais la complexité de cette opération est grande. @Desmarais2011 fait une factorisation de matrices positives.

 [^1]: En anglais, *hill-climbing technique*.

Nous avons testé des approches plus génériques. @Zou2006 présentent un algorithme pour l'analyse de composantes principales creuses, qui détermine deux matrices $W$ et $H$ tels que :

$$M \simeq WH \textnormal{ et } H \textnormal{ est creuse}. $$

@Lee2010 proposent une analyse de composantes principales creuses avec une fonction de lien logistique, ce qui est plus approprié pour notre problème pour lequel la matrice que nous cherchons à approximer est binaire.

$$M \simeq \Phi(WH) \textnormal{ et } H \textnormal{ est creuse}. $$

Dans ces deux cas, $H$ est composée majoritairement de 0. Pour en extraire une q-matrice, nous fixons à 1 les entrées non nulles.

## Validation bicroisée

Pour valider un modèle d'apprentissage supervisé, une méthode courante consiste à estimer ses paramètres à partir d'une fraction des données et leurs étiquettes, calculer les prédictions faites sur les données restantes et les comparer avec les vraies étiquettes. Cette méthode s'appelle *validation croisée*. Ainsi, le jeu de données $X$ est divisé en deux parties $X_{train}$ et $X_{test}$, le modèle est entraîné sur $X_{train}$ et ses étiquettes $\mathbf{y}_{train}$ et fait une prédiction sur les données $X_{test}$ appelée $\mathbf{y}_{pred}$, qui est ensuite comparée aux vraies valeurs $\mathbf{y}_{test}$ pour validation. S'il s'agit d'un problème de régression, on peut utiliser par exemple la fonction de coût RMSE (*root mean squared error*) :

$$ RMSE(\mathbf{y}_{test}, \mathbf{y}_{pred}) = \sqrt{\frac1n \sum_{k = 1}^n (y^*_i - y_i)^2} $$

où $\mathbf{y}_{pred} = (y_1, \ldots, y_n)$ et $\mathbf{y}_{test} = (y^*_1, \ldots, y^*_n)$.\bigskip

S'il s'agit d'un problème de classification binaire, on utilise habituellement la fonction de coût *log-loss* (aussi appelée coût logistique ou perte d'entropie mutuelle) :

$$ logloss(\mathbf{y}_{test}, \mathbf{y}_{pred}) = \frac1n \sum_{k = 1}^n \log (1 - |y^*_k - y_k|). $$

Toutes les valeurs prédites étant comprises entre 0 et 1, cette fonction pénalise beaucoup plus une grosse différence entre valeur prédite (comprise entre 0 ou 1) et valeur réelle (égale à 0 ou 1) que la RMSE. <!-- TODO, voir Figure \ref{rmse-ll}. -->

Afin d'obtenir une validation plus robuste, il faut s'assurer que la proportion de 0 et de 1 soit la même dans les étiquettes d'entraînement et dans les étiquettes d'évaluation. Pour une validation encore meilleure, on peut recourir à une validation croisée à $k$ paquets : le jeu de données $X$ est divisé en $k$ paquets, et $k$ validations croisées sont faites en utilisant $k - 1$ paquets parmi les $k$ pour entraîner le modèle et le paquet restant pour l'évaluer.

\begin{figure}
\centering
\includegraphics[width=0.6\linewidth]{figures/traintest}
\caption{Jeu de données séparé pour la validation bicroisée.}
\label{traintest}
\end{figure}

Dans notre cadre, nous avons deux types de populations : les apprenants de l'historique, pour lesquels nous avons observé les résultats à toutes les questions, et les apprenants pour lesquels on souhaite évaluer le modèle de test adaptatif. Nous faisons donc une validation bicroisée, car nous séparons les apprenants en deux groupes d'entraînement et de test, et également les questions en deux groupes de test et de validation. À la figure \ref{traintest}, un exemple de découpage est présenté. Chaque ligne correspond à un apprenant et pour chaque apprenant de test, seules les questions 1, 2, 4, 6, 7 sont posées, les questions 3, 5, 8 étant conservées pour validation. Pour chaque apprenant du groupe d'entraînement, nous connaissons toutes ses réponses et pouvons entraîner nos modèles à partir de ces données. Pour chaque apprenant du groupe de test, nous simulons un test adaptatif qui choisit les questions à poser, hors celles de validation. Nous vérifions alors, à chaque étape du test adaptatif pour l'apprenant, les prédictions du modèle de son comportement sur l'ensemble des questions de validation.

Notre comparaison de modèles a deux aspects : qualitatifs en termes d'interprétabilité ou d'explicabilité et quantitatifs en termes de vitesse de convergence de la phase d'entraînement et performance des prédictions.

## Évaluation quantitative
\label{comp-cat}

Rapidité de convergence vers un diagnostic

:   Combien faut-il de questions pour que le diagnostic converge ?

Pouvoir prédictif

:   Est-ce que le diagnostic fait après un nombre réduit de questions permet effectivement d'expliquer les résultats de l'apprenant sur le reste du test ?

Nous cherchons à comparer le pouvoir prédictif de différents modèles de tests adaptatifs qui modélisent la probabilité qu'un certain apprenant résolve une certaine question d'un test. Ces modèles sont comparés sur un jeu de données réel $D$ de taille $|I| \times |Q|$ où $D_{iq}$ vaut 1 si l'apprenant $i$ a répondu correctement à la question $q$, 0 sinon. Pour faire une validation bicroisée, nous séparons les apprenants de l'ensemble $I$ en $U$ paquets et les questions de l'ensemble $Q$ en $V$ paquets. Ainsi, si on numérote les paquets d'apprenants $I_i$ pour $i = 1, \ldots, U$  et les paquets de questions $Q_j$ pour $j = 1, \ldots, V$, l'expérience $(i, j)$ consiste à, pour chaque modèle $T$ :

1. entraîner le modèle $T$ sur tous les paquets d'apprenants sauf le $i$-ième (l'ensemble d'apprenants d'entraînement $I_{train} = I \setminus I_i$) ;
2. simuler des tests adaptatifs sur les apprenants du $i$-ème paquet (l'ensemble d'apprenants de test $I_{test} = I_i$) en utilisant les questions de tous les paquets sauf le $j$-ième, et après chaque réponse de l'apprenant, en évaluant l'erreur du modèle $T$ sur le $j$-ème paquet de questions (l'ensemble de questions de validation $Q_{val} = Q_j$). On fait donc un appel à \textsc{Simuler}($train, test$), voir l'algorithme \ref{algo}.

Par exemple, sur la figure \ref{predict}, après que la question de probabilité plus proche de 0,5 a été choisie puis posée, les paramètres de l'apprenant sont mis à jour, une prédiction est faite sur l'ensemble de questions de validation et cette prédiction est évaluée étant donnée la vraie performance de l'apprenant.

\begin{figure}
\centering
\includegraphics[width=0.8\linewidth]{figures/predict}
\caption{Exemple de phase de test. La question de probabilité la plus proche de 0,5 est posée à chaque étape.}
\label{predict}
\end{figure}

\begin{algorithm}
\begin{algorithmic}
\Procedure{Simuler}{modèle $M$, $I_{train}$, $I_{test}$}
\State $\alpha \gets \Call{TrainingStep}{M, D[I_{train}]}$
\For{tout étudiant $s$ de l'ensemble $I_{test}$}
    \State $\pi_0 \gets \Call{PriorInitialization}$
    \For{$t$ de 0 à $|Q \setminus Q_{val}| - 1$}
        \State $q_{t + 1} \gets \Call{NextItem}{\{(q_k, r_k)\}_{k = 1, \ldots, t}, \alpha, \pi_t}$
        \State Poser la question $q_{t + 1}$ à l'apprenant $s$
        \State Récupérer la valeur de succès ou échec $r_{t + 1}$ de sa réponse
        \State $\pi_{t + 1} \gets \Call{EstimateParameters}{\{(q_k, r_k)\}_{k = 1, \ldots, t + 1}, \alpha}$
        \State $p \gets$ \Call{PredictPerformance}{$\alpha, \pi_t, Q_{val}$}
        \State $\sigma_t \gets$ \Call{EvaluatePerformance}{$p, D[s][Q_{val}]$}
    \EndFor
\EndFor
\EndProcedure
\end{algorithmic}
\caption{Simulation d'un modèle de tests adaptatifs}
\label{algo}
\end{algorithm}

Pour chaque modèle testé, nous avons implémenté les routines suivantes :

- **TrainingStep**($I_{train}$) : calibrer le modèle sur l'historique des apprenants $I_{train}$ et renvoyer les paramètres $\alpha$ ;
- **PriorInitialization**($\alpha$) : initialiser les paramètres d'un nouvel apprenant au début de son test et renvoyer ses paramètres $\pi$ ;
- **NextItem**($\{(q_k, r_k)\}_k, \alpha, \pi$) : choisir la question à poser telle que la probabilité que l'apprenant y réponde correctement est la plus proche de 0,5 [@Chang2014], en fonction des réponses précédentes de l'apprenant et de l'estimation en cours de son niveau ;
- **UpdateParameters**($\{(q_k, r_k)\}_k, \pi$) : mettre à jour les paramètres de l'apprenant en fonction de ses réponses aux questions posées ;
- **PredictPerformance**($\alpha, \pi$) : calculer pour chacune des questions du test la probabilité que l'apprenant en cours de test y réponde correctement et renvoyer le vecteur de probabilités obtenu ;
- **EvaluatePerformance**($p$) : comparer la performance prédite à la vraie performance de l'apprenant sur l'ensemble de questions de validation, de façon à évaluer le modèle. La fonction d'erreur peut être la *log loss* ou le nombre de prédictions incorrectes.

De façon à visualiser les questions posées par un modèle de tests adaptatifs, on peut construire l'arbre binaire de décision correspondant. La racine est la première question posée, puis chaque réponse fausse renvoie vers le nœud gauche, chaque réponse vraie renvoie vers le nœud droit [@Ueno2010; @Yan2014]. En chaque nœud on peut calculer l'erreur en cours du modèle sur l'ensemble des questions de validation, et le meilleur modèle est celui dont l'erreur moyenne est minimale.

Pour calculer l'erreur, nous avons choisi la *log loss*, courante pour les problèmes de classification binaire :

$$ e(p, a) = \frac1{|Q_{val}|} \sum_{k \in Q_{val}} a_k \log p_k + (1 - a_k) \log (1 - p_k) $$

\noindent
où $p$ est la performance prédite sur les $|Q_{val}|$ questions et $a$ est le vrai motif de réponse de l'apprenant en cours. Ainsi, \textsc{EvaluatePerformance} calcule la *log loss* et le nombre de prédictions incorrectes entre la performance prédite $p$ et $a$ qui vaut $D[s][Q_{val}]$ pour l'apprenant $s$.

Lors de chaque expérience $(i, j)$, on enregistre pour chaque apprenant $t$ valeurs d'erreurs où $t$ est le nombre de questions posées, soit $|Q \setminus Q_{val}|$. Ainsi, on peut déterminer l'erreur moyenne que chaque modèle a obtenu après avoir posé un certain nombre de questions. Ces valeurs sont stockées dans une matrice de taille $U \times V$ dont chaque case correspond à l'expérience $(i, j)$ correspondant à un ensemble d'apprenants d'entraînement $I_{test} = I_i$ et un ensemble de questions de validation $Q_{val} = Q_j$ (voir figure \ref{crossval}). En calculant l'erreur moyenne selon chaque colonne, on peut visualiser comment les modèles se comportent pour chaque ensemble de question de validation. On calcule la moyenne de toutes les cases pour tracer les courbes correspondant à chaque modèle.

\begin{figure}
\centering
\includegraphics{figures/crossval.pdf}
\caption{Validation bicroisée selon 6 paquets d'apprenants et 4 paquets de questions.}
\label{crossval}
\end{figure}

## Jeux de données
\label{datasets}

Pour nos expériences, nous avons utilisé les quatre jeux de données réelles suivants.

### SAT

Le SAT est un test standardisé aux États-Unis. Il est multidisciplinaire, car les questions portent sur 4 catégories : mathématiques, biologie, histoire et français. Dans ce jeu de données, 296 apprenants ont répondu à 40 questions. Ce jeu a été étudié par @Winters2005 et @Desmarais2011 pour déterminer une q-matrice automatiquement via une factorisation de matrices positives.

### ECPE

Il s'agit d'une matrice $2922 \times 28$ représentant les résultats de 2922 apprenants sur 28 questions d'anglais de l'examen ECPE (*Examination for the Certificate of Proficiency in English*). Ce test standardisé cherche à mesurer trois attributs, c'est pourquoi la q-matrice correspondante a 3 CC : règles morphosyntaxiques, règles cohésives, règles lexicales.\nomenclature{ECPE}{\emph{Examination for the Certificate of Proficiency in English}}

À titre d'exemple, les paramètres d'inattention et de chance déterminés lors de l'entraînement ont été répertoriés dans la figure \ref{ecpe-guess}.

### Fraction

Ce jeu de données regroupe les résultats de 536 collégiens sur 20 questions de soustraction de fractions. Les items et la q-matrice correspondante sont décrits dans @DeCarlo2010.

### TIMSS

Le TIMSS (*Trends in International Mathematics and Science Study*) effectue un test standardisé de mathématiques. Les données sont librement disponibles sur leur site pour les chercheurs. En l'occurrence, ce jeu de données provient de l'édition 2003 du TIMSS. C'est une matrice binaire de taille $757 \times 23$ qui regroupe les résultats de 757 apprenants du grade 8 sur 23 questions de mathématiques. La q-matrice a été définie par des experts du TIMSS et comporte 13 des 15 composantes de connaissances décrites dans @Su2013.

### Castor

Le Castor est un concours d'informatique où les candidats, collégiens ou lycéens, doivent résoudre des problèmes d'algorithmique déguisés au moyen d'interfaces. Le jeu de données provient de l'édition 2013, où 58 939 élèves de 6\ieme{} et 5\ieme{} ont dû résoudre 17 problèmes. La matrice est encore dichotomique, c'est-à-dire que son entrée $(i, j)$ vaut 1 si l'apprenant $i$ a eu le score parfait sur la question $j$, 0 sinon.

<!--
\begin{figure}
\includegraphics[width=\textwidth]{plot-ecpe.png}\\
\includegraphics[width=\textwidth]{plot-fraction.png}
\caption{Mean error (negative log-likelihood) after a certain number of questions have been asked.}
\label{curves}
\end{figure}
-->

\begin{table}
$$ \begin{array}{C{5mm}C{5mm}C{5mm}|cc|c}
\multicolumn{3}{c|}{\textnormal{q-matrice}} & \textnormal{chance} & \textnormal{inattention} & \textnormal{taux de succès}\\
\hline
1 & 1 & 0 & 0.705 & 0.085 & 80 \%\\
0 & 1 & 0 & 0.724 & 0.101 & 83 \%\\
1 & 0 & 1 & 0.438 & 0.266 & 57 \%\\
0 & 0 & 1 & 0.480 & 0.162 & 70 \%\\
0 & 0 & 1 & 0.764 & 0.040 & 88 \%\\
0 & 0 & 1 & 0.717 & 0.066 & 85 \%\\
1 & 0 & 1 & 0.544 & 0.085 & 72 \%\\
0 & 1 & 0 & 0.802 & 0.040 & 89 \%\\
0 & 0 & 1 & 0.534 & 0.199 & 70 \%\\
1 & 0 & 0 & 0.483 & 0.163 & 65 \%\\
1 & 0 & 1 & 0.556 & 0.099 & 72 \%\\
1 & 0 & 1 & 0.195 & 0.305 & 43 \%\\
1 & 0 & 0 & 0.633 & 0.122 & 75 \%\\
1 & 0 & 0 & 0.517 & 0.212 & 65 \%\\
0 & 0 & 1 & 0.749 & 0.040 & 88 \%\\
1 & 0 & 1 & 0.549 & 0.126 & 70 \%\\
\textbf0 & \textbf1 & \textbf1 & \textbf{0.816} & \textbf{0.058} & \textbf{88 \%}\\
0 & 0 & 1 & 0.729 & 0.086 & 84 \%\\
0 & 0 & 1 & 0.473 & 0.150 & 71 \%\\
1 & 0 & 1 & 0.239 & 0.295 & 46 \%\\
1 & 0 & 1 & 0.621 & 0.097 & 75 \%\\
0 & 0 & 1 & 0.322 & 0.188 & 63 \%\\
0 & 1 & 0 & 0.637 & 0.075 & 81 \%\\
0 & 1 & 0 & 0.313 & 0.322 & 53 \%\\
1 & 0 & 0 & 0.512 & 0.272 & 61 \%\\
0 & 0 & 1 & 0.555 & 0.211 & 70 \%\\
1 & 0 & 0 & 0.265 & 0.369 & 44 \%\\
0 & 0 & 1 & 0.659 & 0.086 & 81 \%\\
\end{array} $$
\caption{La q-matrice utilisée pour le jeu de données ECPE, ainsi que les paramètres d'inattention et de chance, et le taux de succès de chaque question. En gras, la ligne ayant la plus grande valeur de chance.}
\label{ecpe-guess}
\end{table}

<!-- TODO expliquer -->

## Spécification des modèles

Le code est en Python, un langage lisible pour concevoir des scripts en peu de lignes de code, et fait appel à des fonctions en R au moyen du package ``RPy2``. Des détails concernant l'implémentation sont donnés dans l'annexe \ref{code}.

### Rasch

Chaque apprenant a une unique caractéristique correspondant à son niveau, tandis que chaque question a une unique caractéristique correspondant à sa difficulté.

TrainingStep

:   La phase d'apprentissage consiste à déterminer l'estimateur du maximum de vraisemblance pour les paramètres des apprenants et des questions. Comme le modèle est simple, l'expression de la dérivée de la vraisemblance est simple et on peut les paramètres qui l'annulent par la méthode de Newton. Cette partie est effectuée par le package ``ltm``.

PriorInitialization

:   Lorsqu'un nouvel apprenant passe le test, on initialise son niveau à 0.

NextItem

:   Comme pour chaque modèle, la question choisie est celle de probabilité la plus proche de 0,5.

<!-- TODO corriger -->

UpdateParameters

:   Après chaque réponse de l'apprenant, l'estimation ses caractéristiques est faite par le maximum de vraisemblance. Si trop peu de réponses ont été fournies, l'estimation est bayésienne. Cette estimation est faite par le package ``catR``.

<!-- TODO corriger -->

PredictPerformance

:   Pour rappel, la formule est donnée par l'expression :

$$ Pr(success_{ij}) = \Phi(\theta_i - d_j). $$

### DINA

Chaque apprenant a une caractéristique qui est son état latent, défini à la section \vref{dina}, et chaque question a pour caractéristiques la liste des CC qu'elle requiert dans la q-matrice, ainsi qu'un paramètre d'inattention et un paramètre de chance.

Pendant la phase de calibrage, nous calculons, à partir d'une q-matrice et d'une population, les paramètres d'inattention et de chance expliquant le mieux les données.

Afin d'accélérer la procédure d'entraînement parfois coûteuse, nous utilisons ``pypy`` : il s'agit d'un interpréteur Python qui compile le code à la volée en code machine, afin de fournir une exécution plus rapide de code Python. Pour l'utiliser, il suffit de taper ``pypy fichier.py`` au lieu de ``python fichier.py``.

TrainingStep

:   Si l'on dispose d'une q-matrice, la phase d'apprentissage consiste à déterminer les états latents des apprenants d'entraînement, ainsi que les paramètres d'inattention et de chance des questions les plus vraisemblables.

<!-- TODO wtf -->

La calibration des paramètres des questions est effectuée par le package R ``CDM`` (pour *cognitive diagnosis modelling*), à partir des motifs de réponse des apprenants d'entraînement et de la q-matrice. Pour déterminer les états latents des apprenants, on simule le fait de leur poser toutes les questions en utilisant le modèle DINA. Si on ne dispose pas de q-matrice, nous la calculons automatiquement en itérant plusieurs phases d'optimisation de la q-matrice via escalade de colline, des paramètres d'inattention et de chance via optimisation convexe, et des états latents des apprenants.\nomenclature{CDM}{\emph{Cognitive Diagnosis Modelling}, modèles de diagnostic cognitif.}

PriorInitialization

:   Lorsqu'un nouvel apprenant passe le test, on suppose qu'il a une probabilité d'être dans chaque état latent, déterminée par la moyenne de la population d'entraînement. On va maintenir cette distribution de probabilité sur les $2^K$ états latents possibles, initialisée à cette distribution a priori.

NextItem

:   Comme pour chaque modèle, la question choisie est celle de probabilité la plus proche de 0,5.

UpdateParameters

:   Après chaque réponse de l'apprenant, une mise à jour de la distribution de probabilité est faite, de façon bayésienne. Voir la section \ref{dina-update} pour les formules utilisées.

PredictPerformance

:   Pour rappel, la formule est donnée par l'expression :

$$ Pr(success_{ij}) = \left\{\begin{array}{ll}
1 - s_j & \textnormal{ si l'apprenant $i$ maîtrise toutes les CC requises par $j$}\\
g_j & \textnormal{ sinon.}
\end{array}\right. $$

# Résultats

## Évaluation qualitative

Rasch

:   Le modèle de Rasch est unidimensionnel, il n'a pas besoin de q-matrice pour fonctionner et il fait un retour à l'apprenant sous la forme d'une valeur de niveau. Cela permet à l'apprenant de se situer au sein des autres apprenants mais pas de comprendre les points du cours qu'il doit approfondir. Les paramètres estimés peuvent être interprétés comme des valeurs de niveau pour les apprenants et de difficulté pour les questions, mais peuvent correspondre à des erreurs d'énoncé. Enfin, afin de calibrer les paramètres de difficulté des questions et de niveau des apprenants, le modèle de Rasch a besoin de données d'entraînement.

DINA

:   Le modèle DINA est multidimensionnel, requiert une q-matrice, fait un retour à l'apprenant sous la forme d'une probabilité de maîtriser chacune des composantes de connaissance. Ainsi, l'apprenant peut se situer vis-à-vis des objectifs du cours. Les paramètres estimés sont les probabilités de répondre correctement aux questions alors qu'on ne maîtrise pas les composantes de connaissances, et inversement. Grâce à la q-matrice, on peut interpréter les différentes dimensions, et les déductions sont faites de façon bayésienne. Si la q-matrice est mal définie, des valeurs aberrantes apparaîtront pour les paramètres d'inattention et de chance. Le modèle DINA peut fonctionner sans historique, en supposant une distribution uniforme a priori sur les états latents possibles.

La complexité est calculée selon plusieurs paramètres :

- le nombre d'apprenants $N_A$ ;
- le nombre de questions $N_Q$ ;
- le nombre de CC $K$ ;
- le nombre de valeurs non nulles de la q-matrice $|Q|$.

Par exemple, pour le modèle DINA, le choix de la question suivante coûte $O(K 2^K N_Q)$ opérations. La phase d'entraînement de DINA a une complexité $O(|I_{train}| N_Q^2 K 2^K)$ tandis que la phase de test $O(|I_{test}| \cdot |Q \setminus Q_{val}|^2 K 2^K)$.

## Évaluation quantitative

Les résultats sont donnés dans les figures \ref{comp-sat} à \ref{comp-timss}.

\newpage

### SAT

<!-- results/sat2 -->
\begin{figure}[h]
\small
\centering
\includegraphics[width=\linewidth]{figures/comp/sat-mean}
\begin{tabular}{cccc}
& Après 5 questions & Après 10 questions & Après 15 questions\\
DINA K = 4 & $0.411 \pm 0.029$ (81 \%) & $0.398 \pm 0.031$ (82 \%) & $0.387 \pm 0.028$ (82 \%)\\
Rasch & $0.381 \pm 0.027$ (82 \%) & $0.363 \pm 0.026$ (83 \%) & $0.362 \pm 0.027$ (84 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne sur le jeu de données SAT après qu'un certain nombre de questions ont été posées.}
\label{comp-sat}
\end{figure}

Dans la figure \ref{comp-sat}, le modèle de Rasch réalise un diagnostic un peu meilleur que le modèle DINA avec une q-matrice calculée automatiquement. Comme dans @Desmarais2011, notre extraction de q-matrice a réussi à identifier que les questions 1 à 10 partageaient une CC (mathématiques) ainsi que les questions 31 à 40 (français) mais a eu plus de mal à identifier les questions de biologie et d'histoire.

Le modèle de Rasch converge en 10 questions mais plafonne à 82 % de précision tandis que le modèle DINA continue à augmenter légèrement sa précision.

Nous faisons l'hypothèse que comme ce jeu de données est multidisciplinaire et que les questions portent principalement sur une CC, poser une question de mathématiques ne va pas apporter beaucoup d'information sur les CC en français ; c'est pourquoi le modèle de Rasch peut en quelques questions avoir une bonne information sur l'ensemble du test, tandis que le modèle DINA en récolte que de l'information sur la maîtrise ou non maîtrise de la CC sur laquelle porte la question qu'elle pose.

### ECPE

<!-- % results/ecpe -->
\begin{figure}[h]
\small
\centering
\includegraphics[width=\linewidth]{figures/comp/ecpe-mean}
\begin{tabular}{ccc}
& Après 5 questions & Après 10 questions\\
Rasch & $0.534 \pm 0.005$ (73 \%) & $0.524 \pm 0.005$ (74 \%)\\
DINA K = 3 & $0.532 \pm 0.003$ (73 \%) & $0.524 \pm 0.003$ (74 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne sur le jeu de données ECPE après qu'un certain nombre de questions ont été posées.}
\label{comp-ecpe}
\end{figure}

Dans la figure \ref{comp-ecpe}, les modèles se valent. DINA est en moyenne très légèrement meilleur.

Nous faisons l'hypothèse que comme le jeu de données a beaucoup de motifs de réponse différents, les prédictions sont erronées.

### Fraction

<!-- % results/fraction-auto-5 -->
\begin{figure}[h]
\small
\centering
\includegraphics[width=\linewidth]{figures/comp/fraction-mean}
\begin{tabular}{ccc}
& Après 4 questions & Après 7 questions\\
DINA K = 8 & $0.368 \pm 0.039$ (86 \%) & $0.346 \pm 0.039$ (86 \%)\\
Rasch & $0.402 \pm 0.037$ (84 \%) & $0.381 \pm 0.033$ (85 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne sur le jeu de données Fraction après qu'un certain nombre de questions ont été posées.}
\label{comp-fraction}
\end{figure}

Dans la figure \ref{comp-fraction}, le meilleur modèle en moyenne est le modèle DINA dont la q-matrice a été spécifiée par un expert. Après avoir posé 4 questions de façon adaptative, le modèle DINA est capable de prédire en moyenne 86 % de l'ensemble de question de validation correctement, soit en moyenne plus de 8 questions sur 10.

Nous faisons l'hypothèse que comme il s'agit d'un jeu de données de soustraction de fraction, l'information que l'apprenant maîtrise ou non le fait de mettre au même dénominateur est suffisant pour prédire son comportement sur des questions qui ne lui ont pas été posées.

### TIMSS

<!-- results/timss2003 -->
\begin{figure}[h]
\small
\centering
\includegraphics[width=\linewidth]{figures/comp/timss-mean}
\begin{tabular}{ccc}
& After 4 questions & After 8 questions\\
Rasch & $0.576 \pm 0.008$ (70 \%) & $0.559 \pm 0.008$ (71 \%)\\
DINA K = 13 & $0.588 \pm 0.005$ (68 \%) & $0.57 \pm 0.006$ (70 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne sur le jeu de données TIMSS après qu'un certain nombre de questions ont été posées.}
\label{comp-timss}
\end{figure}

Dans la figure \ref{comp-timss}, les deux modèles se valent. 

Les intervalles de confiance de la *log loss* des modèles sont, comme dans le jeu de données ECPE, très serrés. Et les modèles ne parviennent pas à augmenter leur précision. Nous faisons l'hypothèse que ces jeux de données se ressemblent : il y a beaucoup de motifs de réponse possibles.

### Castor

<!-- results/castor -->
\begin{figure}[h]
\centering
\includegraphics[width=\linewidth]{figures/comp/castor-mean}
\begin{tabular}{ccc}
& Après 4 questions & Après 8 questions\\
DINA K = 3 & $0.504 \pm 0.004$ (78 \%) & $0.512 \pm 0.004$ (77 \%)\\
Rasch & $0.493 \pm 0.004$ (78 \%) & $0.485 \pm 0.004$ (79 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne sur le jeu de données Castor après qu'un certain nombre de questions ont été posées.}
\label{comp-castor}
\end{figure}

Dans la figure \ref{comp-castor}, les deux modèles se valent. 

## Vitesse

\begin{table}[H]
\centering\begin{tabular}{@{}c|cc@{}}
& Train phase & Test phase\\
\hline
IRT & 1 min 49 s & 4 min 20 s\\%0.499 $\pm$ 0.024 & 0.469 $\pm$ 0.020 & 0.446 $\pm$ 0.015\\
Q $K = 1$ & 2 min 32 s & 7 s\\
Q $K = 2$ & 5 min 24 s & 14 s\\
Q $K = 3$ & 10 min 57 s & 25 s\\ %0.517 $\pm$ 0.016 & 0.470 $\pm$ 0.012 & 0.444 $\pm$ 0.012\\
Q $K = 4$ & 23 min 29 s & 49 s\\ %0.494 $\pm$ 0.015 & 0.459 $\pm$ 0.011 & 0.417 $\pm$ 0.011\\
Q $K = 5$ & 48 min 42 s & 1 min 35 s\\ %\textbf{0.474 $\pm$ 0.014} & 0.433 $\pm$ 0.011 & 0.415 $\pm$ 0.011\\
Q $K = 6$ & 1 h 45 min 3 s & 3 min 14 s %0.482 $\pm$ 0.015 & \textbf{0.425 $\pm$ 0.012} & \textbf{0.403 $\pm$ 0.011}\\
\end{tabular}
\caption{Temps de calcul des phases d'entraînement et de test pour chaque modèle, sur le jeu de données Fraction.}
\label{tab:time}
\end{table}

## Discussion

\label{discu-comp}

Selon le jeu de données, le meilleur modèle n'est pas le même. Par exemple, pour des tâches procédurales telles que le test Fraction, le modèle DINA a une haute précision en prédiction de performance. Le modèle de Rasch a de bonnes performances tout en étant très simple.

Il est utile de remarquer que pour le modèle DINA avec $K = 1$, l'apprenant peut être modélisé par une probabilité d'avoir l'unique CC ou non. Si la question ne requiert aucune CC, il a une probabilité constante $1 - s_i$ d'y répondre. Sinon, sa probabilité est $(1 - p) g_i + p (1 - s_i) = g_i + p (1 - s_i - g_i)$ soit une valeur qui croît entre $g_i$ et $1 - s_i$ de façon linéaire avec $p$. On retrouve les paramètres de chance et d'inattention du modèle logistique à 4 paramètres. Cela donne une interprétation géométrique du modèle de Rasch comparé au modèle DINA.

Le calcul automatique d'une q-matrice est un problème difficile : s'il y a $|Q|$ questions et $K$ composantes de connaissance, il y a $|Q|K$ bits donc $2^{|Q|K}$ q-matrices possibles. Pour chacune, le calcul des paramètres d'inattention et de chance est un problème d'optimisation convexe.

Notre calcul a conduit à des résultats peu satisfaisants, sachant que la méthode de calibration du modèle de Rasch est efficace tandis que si l'on souhaite calculer une distribution a priori sur les apprenants du modèle DINA, la complexité est grande dans la mesure où il faut simuler l'administration de chaque question à chaque apprenant de l'ensemble d'entraînement, or chaque fois qu'un apprenant répond à une question, il faut mettre à jour la distribution de probabilité sur les états possibles ce qui a une complexité $O(2^K K)$, ce qui donne une complexité totale de $N M 2^K K$ où $N$ est le nombre d'apprenants de l'ensemble d'entraînement et $M$ le nombre de questions.

Le modèle DINA en lui-même mélange des paramètres discrets (les bits de la q-matrice) et des paramètres continus (les paramètres d'inattention et de chance), ce qui fait qu'il s'agit ni d'un problème d'optimisation linéaire en nombres entiers, ni d'un problème d'optimisation convexe. La méthode naïve d'escalade de colline fait tomber dans des minima locaux qui ne donnent pas un modèle qui correspond aux données de façon satisfaisante. Ainsi on préférera le modèle de Rasch ou ses analogues multidimensionnels de la théorie de la réponse à l'item.

# Applications aux MOOC

Forts de la description des modèles de tests adaptatifs au chapitre précédent, et de leur comparaison qualitative dans ce chapitre, nous proposons à présent une méthodologie de choix de modèles en fonction du type de test que l'on souhaite administrer dans un MOOC. Dans une seconde section, nous illustrons la réduction du nombre de questions obtenue par un test adaptatif simulé sur un MOOC de Coursera.

## Méthodologie de choix de modèles

\label{use-cases}

### Test adaptatif au début d'un MOOC

Au début d'un cours, il faut identifier les connaissances de l'apprenant avec le moins de questions possible. C'est un problème de démarrage à froid de l'apprenant, où il faut identifier si celui-ci a bien les prérequis du cours. Si un graphe de prérequis entre composantes de connaissances (CC) est disponible, nous suggérons d'utiliser le modèle de @Falmagne2006, décrit à la section \ref{knowledge-space}, ou son analogue composé de paramètres d'inattention et de chance, le modèle de hiérarchie sur les attributs. Si une q-matrice est disponible, nous suggérons d'utiliser le modèle DINA, décrit à la section \ref{dina}. Sinon, le modèle de Rasch permet au moins de classer les apprenants. Si aucun historique sur le test n'est disponible, par exemple parce qu'il s'agit de la première édition du cours, les seuls modèles envisageables parmi ceux présentés sont celui de @Falmagne2006 qui nécessite un graphe de prérequis, ou le modèle DINA qui nécessite une q-matrice.

Une autre application consiste à faire un test adaptatif à partir du graphe de prérequis sur les CC développées dans le cours. Ainsi, il sera possible d'indiquer à l'apprenant s'il peut se passer de suivre certaines parties du cours.

### Test adaptatif au milieu d'un MOOC

Les apprenants aiment pouvoir savoir sur quoi ils vont être testés, sous la forme d'une autoévaluation qui \og ne compte pas \fg. Cet entraînement de passage de tests a un effet bénéfique sur leur apprentissage [@Dunlosky2013]. Il y a toutefois plusieurs scénarios à considérer. Si les apprenants ont accès au cours alors qu'ils passent ce test à faible enjeu, le modèle de test adaptatif doit prendre en compte le fait que le niveau de l'apprenant puisse changer alors qu'il passe le test, par exemple parce qu'il consulte son cours avant de répondre à chaque question. Dans ce cas, les modèles qui tentent de faire progresser le plus les élèves, tel que celui proposé par @Clement2015 décrit à la section \ref{bandits}, sont appropriés. Ils requièrent soit un graphe de prérequis, soit une q-matrice. Si les apprenants n'ont pas accès au cours pendant le test, le modèle DINA convient, à condition qu'une q-matrice soit spécifiée.

### Test adaptatif à la fin d'un MOOC

Un test d'évaluation à la fin d'un cours peut se baser sur les modèles de tests adaptatifs usuels, de façon à mesurer les apprenants efficacement et leur attribuer une note. Pour ce dernier examen, nous supposons que le retour peut se limiter à un score, ainsi le modèle de Rasch est le plus simple à mettre en place.

## Simulation d'un test adaptatif à partir d'un graphe de prérequis

\label{mooc}
\input{mooc}

# Conclusion

Dans ce chapitre, nous avons détaillé les différents composants modulables dans la conception d'un système de test adaptatif, nous permettant de comparer différents modèles de tests adaptatifs sur un même jeu de données. La méthode de validation que nous proposons, la validation bicroisée, est souvent utilisée en apprentissage automatique, notamment pour valider des techniques de filtrage collaboratif.

Nous avons implémenté ce système et l'avons appliqué à la comparaison du modèle de Rasch et du modèle DINA sur des données réelles. Nous avons mis en évidence que selon le type de test, le meilleur modèle n'est pas le même. Comme @Rupp2012, nous ne cherchons pas à déterminer un meilleur modèle pour tous les usages, nous cherchons à identifier quel modèle convient le mieux à quel usage et nous avons proposé une méthodologie pour comparer leur capacité à efficacement réduire la taille des tests.

Dans la littérature, nous avons observé que la plupart des modèles qui se basent sur des q-matrices sont évalués sur des données simulées [@Desmarais2011]. Ici, nous ne considérons que des données réelles d'apprenants, et notre système de comparaison peut être testé sur n'importe quel jeu de données de test dichotomique. Il peut également être généralisé à des tests à étapes multiples comme nous le verrons à la section \vref{initiald}. Le fait de considérer seulement les réussites ou les échecs d'apprenants face à des questions ou tâches permet d'appliquer un modèle de test adaptatif à des données issues d'interfaces plus complexes telles que des jeux sérieux.

Nous avons terminé ce chapitre en proposant une méthodologie de choix d'un modèle de test adaptatif en fonction du type de test qui peut apparaître dans un MOOC. Nous l'avons illustré par une simulation d'un test adaptatif basé sur le modèle de hiérarchie sur les attributs, appliqué à des données réelles d'un MOOC de Coursera. Pour cette simulation, nous avons construit une représentation du domaine couvert par un test d'analyse fonctionnelle, et avons mis en évidence que le nombre de questions du test pouvait être réduit grâce à ce modèle de tests adaptatifs.

Le système de comparaison développé dans ce chapitre va nous être utile pour valider un nouveau modèle de test adaptatif décrit dans le chapitre suivant.
