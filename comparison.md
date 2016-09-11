# Spécification du test adaptatif

## Calibrage à partir d'un historique

Pour fonctionner, certains modèles de test adaptatif nécessitent un historique de réponses d'une population $U$ d'apprenants face à des questions d'un ensemble $I$, sous la forme d'une matrice $U \times I$ dont l'élément $m_{ui}$ vaut 1 si l'apprenant $u$ a répondu correctement à la question $i$, 0 sinon. Ils essaient ensuite de positionner un nouvel apprenant par rapport à la population donnée en historique.

## Choix de la question initiale

Au début d'un test adaptatif, le système n'a aucune information sur l'apprenant. Pour choisir la première question à poser, le système peut choisir au hasard, ou bien supposer que l'apprenant est de niveau moyen au sein de la population donnée en historique.

## Choix de la question suivante

À un certain moment du test, le système doit, à partir des questions déjà posées et de leurs résultats, choisir la question suivante. Ainsi, la fonction qui choisit la question suivante prend en paramètre une liste de couples $\{(i_k, r_k)\}_k$ où $r_k$ désigne 1 si l'apprenant a répondu correctement à la question $i_k$, 0 sinon.

## Modèle de la probabilité de répondre correctement à chaque question

Les choix que font le système et la calibration des paramètres dépendent du modèle de probabilité de réponse d'un apprenant sur une question.

## Nature du retour fait à la fin du test

Selon le modèle, l'apprenant obtient à la fin du test un retour qui sera utile ou non pour s'améliorer. Par exemple le modèle de Rasch renvoie une information de niveau tandis que le modèle DINA indique la probabilité que le candidat maîtrise chacune des CC.

<!-- # Bornes théoriques de problèmes similaires

## Recherche binaire généralisée

Le problème d'identification d'une cible en posant la question qui minimise l'entropie à chaque tour s'appelle la recherche dichotomique généralisée. On peut considérer des erreurs iid mais pour des erreurs persistantes, ce problème est peu connu théoriquement.

## Sous-modularité

Toutefois, on a une borne théorique dans le cas où les apprenants répondent sans erreur. -->

# Comparaison de modèles sur des jeux de données réels

## Apprentissage automatique à partir d'exemples

Lorsqu'on cherche à modéliser un phénomène naturel, on peut utiliser un modèle statistique, dont on estime les paramètres en fonction des occurrences observées. Par exemple, si on suppose qu'une pièce suit une loi de Bernoulli et tombe sur Face avec probabilité $p$ et Pile avec probabilité $1 - p$, on peut estimer $p$ à partir de l'historique des occurrences des lancers de la pièce. On appelle estimateur du maximum de vraisemblance la valeur des paramètres qui maximise la vraisemblance, c'est-à-dire qui maximise la probabilité d'obtenir les résultats observés.

On distingue l'apprentissage supervisé, où l'on a accès aux étiquettes que l'on cherche à prédire, de l'apprentissage supervisé, où il faut chercher une représentation des données dont on dispose afin de faire de l'apprentissage. Ainsi, reconnaître un chat sur une image est un problème supervisé si l'on dispose de plusieurs photos étiquetées « chat » ou « non chat ». En revanche, répartir en groupes un ensemble de photos d'animaux dépourvus d'étiquette est un problème non supervisé, car un système s'y attaquant doit identifier par lui-même des motifs récurrents au sein d'un groupe de photos, afin de comprendre ce qui fait qu'un chat est un chat. Formellement, pour un problème supervisé on note $X$ la matrice des données dont on dispose (en lignes les exemples, en colonnes les caractéristiques, par exemple la liste des pixels d'une image) et $y$ la colonne des valeurs à prédire (par exemple 1 si c'est un chat, 0 sinon). Pour un problème non supervisé, on a seulement accès à $X$.

Pour un problème de filtrage collaboratif, on dispose d'une matrice creuse $M$ comportant des informations sur certaines entrées. Le problème est de déterminer les entrées manquantes.

En ce qui nous concerne, notre problème commence par une phase d'apprentissage non supervisé, car à partir du simple historique des résultats au test, il faut déterminer des paramètres sur les apprenants et les questions qui expliquent ces résultats. Puis, le problème devient supervisé pour un nouvel apprenant car il s'agit d'un problème de classification binaire : on cherche à prédire à partir de ses réponses précédentes ses résultats (vrai ou faux) sur le reste des questions du test. Une particularité est que l'apprentissage est ici interactif, dans la mesure où c'est le système qui choisit les questions à poser (c'est-à-dire, les éléments à étiqueter) afin d'améliorer son apprentissage. Cette approche s'appelle apprentissage actif (*active learning*).

## Extraction automatique de q-matrice

Pour certains des jeux de données, nous en disposions pas de q-matrice. Certaines approches en fouille de données pour l'éducation consistent à la calculer automatiquement puis tenter de l'interpréter a posteriori.

- @Barnes2005 fait une escalade de colline, mais la complexité de cette opération est grande ;
- @Desmarais2011 a fait une factorisation de matrices positives.

Nous avons testé des approches plus génériques. @Zou2006 présente un algorithme pour l'analyse de composantes principales creuses, qui détermine deux matrices $W$ et $H$ tels que :

$$M \simeq WH \textnormal{ et } H \textnormal{ est creuse}. $$

@Lee2010 propose une analyse de composantes principales creuses avec une fonction de lien logistique, ce qui est plus approprié pour notre problème où nous cherchons à approximer une matrice binaire.

$$M \simeq \Phi(WH) \textnormal{ et } H \textnormal{ est creuse}. $$

Dans ces deux cas, $H$ est composée majoritairement de 0. Pour extraire une q-matrice, nous fixons à 1 les entrées non nulles.

## Double validation croisée

Pour valider un modèle d'apprentissage supervisé, une méthode courante consiste à estimer ses paramètres à partir de 80 % des données et évaluer les prédictions faites sur les données restantes. Cette méthode s'appelle validation croisée. Ainsi, le jeu de données $X$ est divisé en $X_{train}$ et $X_{test}$, le modèle est entraîné sur $X_{train}$ et $y_{train}$ et fait une prédiction sur les données $X_{test}$ appelée $y_{pred}$, qui est ensuite comparée à la vraie valeur $y_{test}$ pour validation. S'il s'agit d'un problème de régression, on utilise par exemple la fonction de coût RMSE (*root mean squared error*) :

$$ RMSE(y^*, y) = \sqrt{\frac1n \sum_{k = 1}^n (y^*_i - y_i)^2} $$

où $y = (y_1, \ldots, y_n)$ et $y^* = (y^*_1, \ldots, y^*_n)$.

S'il s'agit d'un problème de classification binaire, on utilise habituellement la fonction de coût *log-loss* (aussi appelée coût logistique ou perte d'entropie mutuelle) :

$$ logloss(y^*, y) = \frac1n \sum_{k = 1}^n \log (1 - |y^*_k - y_k|). $$

Toutes les valeurs prédites étant comprises entre 0 et 1, cette fonction pénalise beaucoup plus une grosse différence entre valeur prédite (comprise entre 0 ou 1) et valeur réelle (égale à 0 ou 1) que la RMSE, voir Figure \ref{rmse-ll}.

Afin d'obtenir une validation plus robuste, on peut recourir à une validation croisée à $k$ paquets : le jeu de données $X$ est divisé en $k$ paquets, et $k$ validations croisées sont faites en utilisant $k - 1$ paquets parmi les $k$ pour entraîner le modèle et le paquet restant pour l'évaluer.

Dans notre cadre, nous avons deux types de populations : les apprenants de l'historique, pour lesquels nous avons observé les résultats à toutes les questions, et les apprenants qui passent le test, pour lesquels nous observons les réponses aux questions une par une. Ainsi, comme nous cherchons à valider un modèle de tests adaptatifs, nous séparons les apprenants en deux groupes d'entraînement et de test, et également les questions en deux groupes de test et de validation. Pour chaque apprenant du groupe d'entraînement, nous connaissons toutes ses réponses et pouvons entraîner nos modèles à partir de ces données, et pour chaque apprenant du groupe de test, nous simulons un test adaptatif qui choisit les questions à poser parmi les questions de test. Nous vérifions alors, à chaque étape du test adaptatif, les prédictions sur l'ensemble des questions de validation.

Notre comparaison de modèles a deux aspects : qualitatifs en termes d'interprétabilité ou d'explicabilité et quantitatifs en termes de vitesse de convergence de la phase d'entraînement et performance des prédictions.

## Évaluation qualitative

Plusieurs aspects font qu'on peut préférer un modèle de test adaptatif plutôt qu'un autre. Par exemple, la mise en œuvre d'un modèle de test peut requérir la construction d'une q-matrice, ce qui peut être coûteux si l'on a plusieurs milliers de questions à apparier avec une dizaine de composantes de connaissance.

Multidimensionalité

:   Est-ce que le modèle mesure une ou plusieurs dimensions ?

Interprétabilité

:   Ce facteur distingue un modèle qui renvoie une simple valeur de niveau à l'apprenant d'un modèle qui fait un retour utile à l'apprenant (*feedback*) afin qu'il puisse s'améliorer. Disposer d'une q-matrice spécifiée par un humain permet d'accroître l'interprétabilité du système, car il est alors possible de nommer les lacunes de l'apprenant soulignées par le test.

Explicabilité

:   Un modèle explicable est capable de décrire le processus qui l'a fait aboutir à son diagnostic. On reproche parfois aux modèles d'apprentissage statistique de faire des prédictions correctes sans pouvoir les expliquer (on parle de modèles \og boîte noire \fg). Il est en effet possible d'avoir un modèle de test interprétable non explicable : par exemple, un modèle qui ne poserait que des questions de mathématiques à un apprenant et lui suggérerait à la fin de retravailler la conjugaison, pourrait être pertinent, mais ne serait pas capable de l'expliquer, les raisons étant plus profondes, par exemple parce que le modèle aurait capturé que les questions de mathématiques non résolues correctement comportaient du subjonctif imparfait.

Besoin d'un historique

:   Est-ce que le modèle a besoin d'un historique d'apprenants pour fonctionner ?

## Évaluation quantitative

Complexité

:   Quel est la complexité en temps et mémoire de ce modèle ?

Rapidité de convergence vers un diagnostic

:   C'est une façon de mesurer à quel point le test a été réduit grâce au modèle.

Pouvoir prédictif

:   Est-ce que le diagnostic permet effectivement d'expliquer les résultats qu'on aurait obtenu si on avait continué le test ?

## Implémentation

Les modèles testés implémentent les routines suivantes :

- **TrainingStep** : calibrer le modèle sur l'historique
- **PriorInitialization** : initialiser les paramètres de l'apprenant au début du test
- **NextItem** : choisir la meilleure question à poser selon un certain critère, en fonction des réponses précédentes de l'apprenant
- **UpdateParameters** : mettre à jour les paramètres de l'apprenant en fonction de sa réponse à la dernière question posée
- **TerminationRule** : critère de terminaison du test adaptatif
- **PredictPerformance** : calculer la probabilité de répondre correctement pour chacune des questions restantes du test
- **EvaluatePerformance** : comparer les vraies réponses à celles prédites, de façon à évaluer le modèle.

À chaque étape, nous posons la question de probabilité plus proche de 0,5 [@Chang2014].

In order to compare the models described above on real data, they can be embedded in a unified framework: all of them can be seen as decision trees [@Ueno2010; @Yan2014], where nodes are possible states of the test and edges are followed according to the answers provided by the learner, like a flowchart. Thus, within a node, we have access to an incomplete response pattern and want to infer the behavior of the learner over the remaining questions using our student model. The best model is the one that classifies remaining outcomes with minimal error.

Formally, let us consider students, from a set $I$, that answer questions from a set $Q$. Our student data is a binary matrix $D$ of size $|I| \times |Q|$ where $D_{iq}$ is 1 if student $i$ answered question $q$, 0 otherwise. An adaptive test can be formalized the following way.\bigskip

\noindent
\textsc{Test}(student $i \in I$) :  
\indent \textbf{While} some questions remain to be asked  
\indent \indent \textsc{Ask} to student $i$ the next question\bigskip

We want to compare the predictive power of different adaptive testing algorithms that model the probability of student $i$ solving question $j$. Thus, for our cross validation, we need to define:

- a student train set $I_{train} \subset I$;
- a student test set $I_{test} \subset I$;
- a validation question set $Q_{val} \subset Q$.

These sets will stay the same for all considered models.\bigskip

\noindent
\textsc{EvaluateModel}(model $M$, $I_{train}$, $I_{test}$, $Q_{val}$) :  
\indent \textsc{Train} model using lines $I_{train}$ of $D$  
\indent \textbf{For each} student $i$ of $I_{test}$ \textbf{do}  
\indent \indent \textbf{While} not all questions $\in Q \setminus Q_{val}$ have been asked  
\indent \indent \indent \textsc{ChooseNextItem} and ask it to student $i$  
\indent \indent \indent Evaluate predictions of model $M$ over questions $Q_{val}$.\bigskip

\begin{algorithm}
\begin{algorithmic}
\Procedure{Simulate}{$train, test$}
\State $\alpha \gets \Call{TrainingStep}{train}$
\State $t \gets 0$
\For{all students $s$ in $test$}
    \State $\pi \gets \Call{PriorInitialization}$
    \While{\textsc{TerminationRule} is not satisfied}
        \State $q_{t + 1} \gets \Call{NextItem}{q_1, r_1, \ldots, q_t, r_t, \alpha, \pi}$
        \State Ask question $q_{t + 1}$ to the student $s$
        \State Get reply $r_{t + 1}$
        \State $\pi \gets \Call{EstimateParameters}{q_1, r_1, \ldots, q_t, r_t, \alpha}$
        \State $p \gets$ \Call{PredictPerformance}{$\alpha, \pi$}
        \State $\Sigma \gets$ \Call{EvaluatePerformance}{$p$}
    \EndWhile
\EndFor
\EndProcedure
\end{algorithmic}
\caption{\textbf{CAT Framework}}
\label{algo}
\end{algorithm}

We make a cross validation of each model over 10 subsamples of students and 4 subsamples of questions (these constant values are parameters that may be changed). Thus, if we number student subsamples $I_i$ for $i = 1, \ldots, 10$ and questions subsamples $Q_j$ for $j = 1, \ldots, 4$, experiment $(i, j)$ consists in:

- train the evaluated model over all student subsamples except the $i$-th ($I_{train} = I \setminus I_i$);
- simulate adaptive tests on the $i$-th student subsample ($I_{test} = I_i$) using all questions subsamples except the $j$-th ($Q_j$), and evaluate after each question the error of the model over the $j$-th question subsample ($Q_{val} = Q_j$).

The error is given by the following formula, called score or log-loss:

$$ e(p, t) = \frac1{|Q_{val}|} \sum_{k \in Q_{val}} t_k \log p_k + (1 - t_k) \log (1 - p_k) $$

where $p$ is the predicted outcome over all $|Q|$ questions and $t$ is the true response pattern.

Il s'agit d'un problème de classification binaire, donc cette fonction d'erreur est courante.

In order to visualize the results, errors computed during experiment $(i, j)$ are stored in a matrix of size $10 \times 4$. Thus, computing the mean error for each column, we can see how models performed on a certain subset of questions, see Figure \ref{crossval}.

\begin{figure}
\centering
\includegraphics{figures/crossval.pdf}
\caption{Cross validation over 10 student subsamples and 4 question subsamples. Each case $(i, j)$ contains the results of the experiment $(i, j)$ for student test set ($I_{test} = I_i$) and question validation set ($Q_{val} = Q_j$).}
\label{crossval}
\end{figure}

## Jeux de données

For our experiments, we used two real datasets.

### SAT

Le SAT est un test standardisé aux États-Unis. Il est multidisciplinaire : mathématiques, biologie, histoire et français. Dans ce jeu de données, 296 apprenants ont répondu à 40 questions. Ce jeu a été étudié par @Winters2005 et @Desmarais2011 pour déterminer une q-matrice automatiquement via factorisation de matrices positives.

### ECPE

Il s'agit d'une matrice $2922 \times 28$ représentant les résultats de 2922 apprenants sur 28 questions d'anglais de l'examen ECPE (Examination for the Certificate of Proficiency in English). Ce test standardisé cherche à mesurer trois attributs, c'est pourquoi la q-matrice correspondante a 3 CC : règles morphosyntaxiques, règles cohésives, règles lexicales.

À titre d'exemple, les paramètres d'inattention et de chance ont été répertoriés Figure~\ref{ecpe-guess}.

### Fraction

Ce jeu de données regroupe les résultats de 536 collégiens sur 20 questions de soustraction de fractions. Les items et la q-matrice correspondante sont décrits dans @DeCarlo2010.

### TIMSS

Le TIMSS (Trends in International Mathematics and Science Study) effectue un test standardisé de mathématiques. Les données sont librement disponibles sur leur site pour les chercheurs. En l'occurrence, ce jeu de données provient de l'édition 2003 du TIMSS. C'est une matrice binaire de taille $757 \times 23$ qui regroupe les résultats de 757 apprenants du grade 8 sur 23 questions de mathématiques. La q-matrice a été définie par des experts du TIMSS et comporte 13 CC sur les 15 décrites dans @Su2013 : toutes sauf la 10\ieme{} et la 12\ieme.\bigskip

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
\multicolumn{3}{c|}{\textnormal{q-matrix}} & \textnormal{chance} & \textnormal{inattention} & \textnormal{taux de succès}\\
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
\caption{The q-matrix used for the ECPE dataset, together with the guess and slip parameters, and the success rate for each question. In bold, the highest guess value.}
\label{ecpe-guess}
\end{table}

## Modèles et détails d'implémentation

Le code est en Python, et fait appel à des fonctions en R au moyen du package RPy2.

### Rasch

Nous nous sommes basés sur les packages ``ltm`` et ``catR``.

### DINA

C'est ``CDM`` qui détermine à partir d'une q-matrice et d'une population, les meilleurs paramètres d'inattention et de chance.

Afin d'accélérer la procédure d'entraînement parfois coûteuse, nous utilisons le compilateur à la volée ``pypy``.
 
 Les paramètres sont initialisés à une certaine distribution a priori déterminée pendant la phase de test.

# Résultats

## Évaluation qualitative

Rasch

:   Le modèle de Rasch est unidimensionnel, n'a pas besoin de q-matrice pour fonctionner, fait un retour à l'apprenant sous la forme d'une valeur de niveau. Cela permet à l'apprenant de se situer au sein des autres apprenants mais pas de comprendre les points du cours qu'il doit approfondir. Les paramètres estimés peuvent être interprétés comme des valeurs de niveau pour les apprenants et de difficulté pour les questions, mais peuvent correspondre à des erreurs d'énoncé. Aussi, afin de calibrer les paramètres de difficulté des questions et de niveau des apprenants, le modèle de Rasch a besoin de données d'entraînement.

DINA

:   Le modèle DINA est multidimensionnel, requiert une q-matrice, fait un retour à l'apprenant sous la forme d'une probabilité de maîtriser chacune des composantes de connaissance. Ainsi, l'apprenant peut se situer vis-à-vis des objectifs du cours. Les paramètres estimés sont les probabilités de répondre correctement aux questions alors qu'on ne maîtrise pas les CC, et inversement. Grâce à la q-matrice, on peut interpréter les différentes dimensions, et les déductions sont faites de façon bayésienne, donc explicables. Si la q-matrice est mal définie, des valeurs aberrantes apparaîtront pour les paramètres d'inattention et de chance. Le modèle DINA peut fonctionner sans historique, en supposant un a priori uniforme.

La complexité est calculée selon plusieurs paramètres :

- le nombre d'apprenants $N_A$ ;
- le nombre de questions $N_Q$ ;
- le nombre de CC $K$ ;
- le nombre de valeurs non nulles de la q-matrice $|Q|$.

Par exemple, pour le modèle DINA, le choix de la question suivante coûte $O(K 2^K N_Q)$ opérations. La phase d'entraînement de DINA a une complexité $O(|I_{train}| N_Q^2 K 2^K)$ tandis que la phase de test $O(|I_{test}| \cdot |Q \setminus Q_{val}|^2 K 2^K)$.

## Évaluation quantitative

\begin{figure}
\centering
\caption{Évolution pour le dataset Castor}
\includegraphics[width=\linewidth]{figures/comp-castor}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=\linewidth]{figures/comp-fraction}
\caption{Évolution pour le dataset Fraction}
\end{figure}

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
\caption{Process time of train and test phases for each algorithm, over all dataset.}
\label{tab:time}
\end{table}

## Discussion

Selon le jeu de données, le meilleur modèle n'est pas le même.

# Conclusion

We presented several recent student models making it possible to use former assessment data in order to provide shorter, adaptive assessments. As @Rupp2012, we didn't aim to determine a best model for all uses, we just wanted to compare them in terms of shortness and predicting performance and see which model suits which use best. Please note that in this chapter, we focus on the assessment on a single learner. Readers interested in CSCL in group assessments may consider reading [@Goggins2015].

Most models using q-matrices are validated using simulated data. In this chapter, we compared the strategies on real data. Our experimental protocol could be tried on even more adaptive assessment models. It could also be generalized for testing multistage testing strategies.

According to the purpose of the test (beginning, middle of end of term), the most suitable model is not the same. In order to choose the best model, one should wonder: What knowledge do we have other the domain (dependency graph, q-matrix)? Is the knowledge of the learner evolving while he is sitting for the test? Do we want to estimate the knowledge components of the learner or do we want to measure learning progress while he is taking the test?

The models we described in this chapter come from various fields of the literature. Experts in the field should communicate more, in order to avoid giving different names to the same model in different fields. There is a need for more interdisciplinary research and methods from learning analytics and CAT should be combined in order to get richer and more complex models. Also, crowdsourcing techniques can be applied in order to harvest more data. One might imagine the following application of implicit feedback: "In order to solve this question, you seem to have spent a lot of time over the following lessons: [the corresponding list]. Which ones helped you answer this question?" Such data can help future learners experiencing difficulties over the same questions.

As we stated in the learning analytics section, we think more research should be done in interactive learning analytics models, giving more control back to the learner, inspired by CAT strategies.

The focus on modern learning analytics for personalization is not only on automated adaptation but also on increasing engagement and affect of learners in the system. This raises an open question on whether the platform should share everything it knows about the learner with the learner. One advantage would be to leverage trust and engagement, one risk would be that learners may change their behavior in consequence in order to game the system.

<!-- Calculé à partir des apprenants précédents
011 guess / slip
001 K = 3
8 vecteurs de bits 2^28 types de réponses
Ajuster slip et guess
Requérant les mêmes composantes de connaissances -->
