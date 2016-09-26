# GenMA, un modèle confirmatoire interprétable

Nous considérons ici un modèle qui suppose que l'on connaisse les CC mises en œuvre pour chaque question, sous la forme d'une q-matrice, dont l'élément $q_{jk}$ vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon.

## Comparaison avec le modèle DINA

Le modèle DINA est un modèle cognitif basé sur une q-matrice, qui a été décrit à la section \ref{dina}. Ce modèle a été utilisé pour des tests adaptatifs et apprécié pour sa capacité à faire un retour à l'apprenant à la fin du test décrivant les composantes de connaissances qui semblent être maîtrisées et celles qui semblent ne pas l'être.

Dans le modèle DINA, l'apprenant est modélisé par un vecteur de bits appelé état indiquant pour chaque CC si elle est maîtrisée ou non. Ainsi, à tout moment du test, le modèle maintient une distribution de probabilité sur les $2^K$ états possibles, où $K$ est le nombre de CC, et chaque question est associée à un vecteur de bits correspondant aux CC qu'il faut avoir maîtrisées afin d'y répondre correctement.

## Modèle de diagnostic général

@Davier2005 a proposé un modèle qui unifie plusieurs modèles de TRIM ainsi que des modèles cognitifs, en s'appuyant sur un degré de maîtrise de chaque CC et d'une notion de difficulté des questions. Il s'agit du modèle général de diagnostic (*general diagnostic model for partial credit data*) :

$$ Pr(\textnormal{``l'apprenant $i$ répond correctement à la question $j$''}) = \Phi\left(\beta_i + \sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk}\right) $$

\noindent
où $K$ est le nombre de CC évaluées par le test, $\beta_i$ est le niveau de l'apprenant $i$, $\theta_{ik}$ son niveau dans la CC $k$, $q_{jk}$ l'élément $(j, k)$ de la q-matrice qui vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon, et enfin $d_{jk}$ est la difficulté de la question $j$ selon la CC $k$. Si la q-matrice ne contient que des 1, ce modèle est équivalent à la TRIM. Sinon, les composantes de connaissances coïncident avec les dimensions du modèle, et les paramètres de difficulté de chaque question ne sont estimés que pour les CC mises en œuvre dans la résolution de cette question, les autres étant fixées à 0, voir figure \ref{fig-genma}.

À notre connaissance, ce modèle n'a pas été utilisé dans des tests adaptatifs [@Yan2014]. C'est ce que nous proposons dans ce chapitre, sous le nom de modèle GenMA.

## GenMA

Nous proposons un nouveau modèle de test adaptatif basé sur le modèle général de diagnostic. Au lieu d'associer à chaque question $j$ un vecteur de bits comme dans le modèle DINA, on va lui associer un vecteur de valeurs réelles $(d_{j1}, \ldots, d_{jK})$, correspondant à des paramètres de difficulté pour chaque composante de connaissance. Les entrées à 0 de la q-matrice permettent de fixer les entrées à 0 du vecteur de chaque question, c'est-à-dire que les composantes de connaissances non mises en œuvre dans une question ont une difficulté nulle pour cette question, ou encore que la compétence de l'apprenant selon cette composante ne sera pas prise en compte dans le calcul de sa propension à répondre correctement à la question, voir l'expression à la section précédente.

À l'issue du test, l'apprenant reçoit une estimation de son niveau selon chaque composante de connaissance. GenMA est donc un modèle hybride qui combine la TRIM et un modèle cognitif basé sur une q-matrice.
\label{genma}

\begin{figure}
\centering
\includegraphics[width=\linewidth]{figures/genma.pdf}
\caption{Le modèle hybride GenMA, qui combine TRIM et une q-matrice.}
\label{fig-genma}
\end{figure}

## Calibrage

GenMA requiert la spécification d'une q-matrice par un expert. Les paramètres $d_{jk}$ pour chaque question $j$ et CC $k$ sont calibrés à partir d'un historique de réponses, en utilisant l'algorithme de Metropolis-Hastings Robbins-Monro [@Chalmers2012; @Cai2010]. Pour notre implémentation, nous nous sommes basés sur le package ``mirt`` [@Chalmers2012].

Dans les tests, les questions font habituellement appel à peu de CC, c'est pourquoi le modèle GenMA est plus facile à calibrer que le modèle de TRIM général : il y a moins de paramètres à estimer.

## Choix de la question suivante

Pour le choix de la question suivante dans le modèle GenMA, nous choisissons de maximiser le déterminant de l'information de Fisher à chaque étape. Les détails d'implémentation peuvent être trouvés dans [@Chalmers2012].

## Estimation des paramètres

Après que l'apprenant $i$ a répondu à une question, en fonction de sa réponse il faut déterminer les paramètres $(\theta_{i1}, \ldots, \theta_{iK})$ les plus vraisemblables, c'est-à-dire son niveau selon chaque CC.

## Retour à la fin du test

À la fin du test, l'apprenant reçoit un retour sous la forme de valeurs de niveau selon chaque CC. Il s'agit du vecteur $\mathbf{\theta_i} = (\theta_{i1}, \ldots, \theta_{iK})$. GenMA est à la fois sommatif et formatif, donc un modèle hybride.

# Validation

## Qualitative

GenMA est multidimensionnel donc mesure des valeurs selon plusieurs CC, contrairement à Rasch qui ne mesure qu'une unique valeur correspondant au niveau de l'apprenant sur tout le test.

Le modèle GenMA est aussi interprétable qu'un modèle DINA : au lieu de renvoyer des probabilités de maîtrise selon chaque CC, il renvoie une valeur de niveau selon chaque CC. Les dimensions sont directement interprétables car elles coïncident avec les colonnes de la q-matrice.

## Quantitative

GenMA a l'avantage multidimensionnel de MIRT tout en étant plus rapide à converger.

Pour la prédiction de performance, nous avons suivi le protocole décrit au chapitre précédent avec les modèles Rasch, DINA avec une q-matrice spécifiée par un expert et notre modèle GenMA avec la même q-matrice.

- Rasch
- DINA
- GenMA

Et les datasets suivants, décrits à la section \ref{datasets} :

- **Fraction.** Pour ce jeu de données, nous avons comparé deux occurrences du modèle GenMA, l'une avec la q-matrice spécifiée par un expert, l'autre avec une q-matrice qui a été calculée automatiquement.
- **ECPE.**
- **TIMSS.**

Pour l'implémentation, nous utilisons le package ``mirt``, qui permet de fixer les entrées non nulles à estimer (au moyen d'une q-matrice). Le package ``mirtCAT`` nous permet de poser les questions. Les résultats sont donnés dans les figures \ref{results-fraction} à \ref{results-timss}.

\begin{figure}
\small
\centering
\includegraphics[width=0.8\textwidth]{figures/results/fraction-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/fraction-count}
\begin{tabular}{cccc}
& Après 4 questions & Après 7 questions & Après 10 questions\\
IRT & $0.469 \pm 0.017$ (79 \%) & $0.457 \pm 0.017$ (79 \%) & $0.446 \pm 0.016$ (79 \%)\\
MIRT & $0.459 \pm 0.023$ (79 \%) & $0.355 \pm 0.017$ (85 \%) & $0.294 \pm 0.013$ (88 \%)\\
MIRT & $0.368 \pm 0.014$ (83 \%) & $0.325 \pm 0.012$ (86 \%) & $0.316 \pm 0.011$ (86 \%)\\
QMatrix & $0.441 \pm 0.014$ (80 \%) & $0.41 \pm 0.014$ (82 \%) & $0.406 \pm 0.014$ (82 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne de prédiction en fonction du nombre de questions posées, pour le jeu de données Fraction.}
\label{results-fraction}
\end{figure}

\begin{figure}
\small
\centering
\includegraphics[width=0.8\textwidth]{figures/results/ecpe-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/ecpe-count}
\begin{tabular}{cccc}
& Après 4 questions & Après 8 questions & Après 12 questions\\
MIRT & $0.509 \pm 0.005$ (76 \%) & $0.496 \pm 0.005$ (76 \%) & $0.489 \pm 0.005$ (77 \%)\\
QMatrix & $0.535 \pm 0.003$ (73 \%) & $0.526 \pm 0.003$ (74 \%) & $0.523 \pm 0.003$ (74 \%)\\
IRT & $0.537 \pm 0.005$ (73 \%) & $0.527 \pm 0.005$ (74 \%) & $0.522 \pm 0.005$ (74 \%)\\
MIRT & $0.532 \pm 0.005$ (73 \%) & $0.507 \pm 0.004$ (75 \%) & $0.498 \pm 0.004$ (76 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne de prédiction en fonction du nombre de questions posées, pour le jeu de données ECPE.}
\label{results-ecpe}
\end{figure}

\begin{figure}
\small
\centering
\includegraphics[width=0.8\textwidth]{figures/results/timss-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/timss-count}
\begin{tabular}{cccc}
& Après 4 questions & Après 8 questions & Après 11 questions\\
IRT & $0.576 \pm 0.008$ (70 \%) & $0.559 \pm 0.008$ (71 \%) & $0.555 \pm 0.008$ (71 \%)\\
MIRT & $0.537 \pm 0.006$ (72 \%) & $0.505 \pm 0.006$ (75 \%) & $0.487 \pm 0.006$ (77 \%)\\
QMatrix & $0.588 \pm 0.005$ (68 \%) & $0.57 \pm 0.006$ (70 \%) & $0.566 \pm 0.006$ (70 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne de prédiction en fonction du nombre de questions posées, pour le jeu de données TIMSS.}
\label{results-timss}
\end{figure}

Sur les jeux de données testés, GenMA a un plus grand pouvoir prédictif que les autres modèles. La réponse à une question posée à l'apprenant apporte plus d'information car chaque question a des paramètres de difficulté selon chaque composante de connaissance.

Dans le jeu de données Fraction, 4 questions sur 10 sont suffisantes pour prédire correctement 80 % en moyenne des réponses sur les 10 questions de l'ensemble de validation. À titre d'exemple, pour un des apprenants, après 4 questions, la performance prédite sur l'ensemble de validation est $[0.617, 0.123, 0.418, 0.127, 0.120]$ tandis que sa vraie performance est $[\textnormal{Correct}, \textnormal{Incorrect}, \textnormal{Correct}, \textnormal{Incorrect}, \textnormal{Incorrect}]$, ce qui correspond à une erreur de 0.350.

# Discussion et applications

<!-- MIRT à 2 dimensions se débrouille mieux que GenMA, ce qui laisse entendre qu'un modèle prédictif n'est pas nécessairement explicatif. Toutefois afin de faire un retour à l'utilisateur, notre modèle fait un feedback correspondant davantage à la réalité qu'un modèle DINA basé sur les q-matrices. -->

Dans le jeu de données ECPE, DINA et Rasch ont une performance similaire, ce qui est surprenant étant donné que Rasch ne requiert aucune connaissance du domaine. Cela doit être parce qu'il n'y a que 3 CC décrites dans la q-matrice, donc le nombre d'états possibles pour un apprenant est $2^3 = 8$ pour $2^{28}$ motifs de réponse possibles. Ainsi, les paramètres d'inattention et de chance sont très hauts, voir la table \ref{guess}, ce qui explique pourquoi l'information gagnée à chaque question est basse. Par exemple, la question qui requiert les CC 2 et 3 a un grand taux de succès de 88 %, ce qui rend cette question plus facile à résoudre que des questions qui ne requièrent que la CC 2 ou 3, donc le seul moyen pour le modèle DINA d'exprimer ce comportement est d'accroître le paramètre de chance. À l'inverse, GenMA est un modèle plus expressif.

Dans le jeu de données Fraction, on souhaite identifier l'état latent de l'apprenant parmi $2^8$ états possibles, en posant des questions qui portent sur peu de CC. Cela explique pourquoi DINA a besoin de beaucoup de questions pour converger. Pour ce jeu de données, le modèle de Rasch est plus prédictif qu'un modèle DINA basé sur une q-matrice qui a été calculée automatiquement.

\begin{table}
\centering
\begin{tabular}{C{5mm}C{5mm}C{5mm}ccc} \toprule
\multicolumn{5}{c}{\textnormal{q-matrice}} & \multirow{2}{*}{\textnormal{taux de succès}} \\ \cmidrule(r){1-5}
\multicolumn{3}{c}{\textnormal{entrées}} & \textnormal{chance} & \multicolumn{1}{c}{\textnormal{inattention}} & \\ \midrule
%\hline
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
\textbf0 & \textbf1 & \textbf1 & \textbf{0.816} & \textbf{0.058} & \textbf{88\%}\\
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
0 & 0 & 1 & 0.659 & 0.086 & 81 \%\\ \bottomrule
\end{tabular}
\caption{Paramètres d'inattention et de chance pour la q-matrice du jeu de données ECPE. Les valeurs les plus hautes sont indiquées en gras.}
\label{guess}
\end{table}

\label{use-cases}

## Test adaptatif au début d'un MOOC

Au début d'un cours, il faut identifier les connaissances de l'apprenant avec le moins de questions possible. C'est un problème de démarrage à froid, où il faut identifier si l'apprenant a bien les prérequis du cours. Si un graphe de prérequis est dispoible, nous suggérons d'utiliser le modèle de @Falmagne2006, décrit à la section \ref{knowledge-space}. Si une q-matrice est disponible, nous suggérons d'utiliser le modèle GenMA ci-haut. Sinon, le modèle de Rasch permet au moins de classer les apprenants. Si aucun historique sur le test n'est disponible et qu'il s'agit de la première édition, les seuls modèles possibles sont celui de @Falmagne2006 qui nécessite un graphe de prérequis, ou le modèle DINA qui nécessite une q-matrice.

## Test adaptatif au milieu d'un MOOC

Les apprenants aiment pouvoir savoir sur quoi ils vont être testés, sous la forme d'une autoévaluation qui « ne compte pas ». Cet entraînement de passage de tests a un effet bénéfique sur leur apprentissage [@Dunlosky2013]. Il y a toutefois plusieurs scénarios à considérer. Si les apprenants ont accès au cours alors qu'ils passent ce test à faible enjeu, le modèle de test adaptatif doit prendre en compte le fait que le niveau de l'apprenant puisse changer alors qu'il passe le test, par exemple parce qu'il consulte son cours à chaque question. Dans ce cas, les modèles qui tentent de faire progresser le plus les élèves, tel que celui proposé par @Clement2015 décrit à la section \ref{bandits}, sont appropriés. Ils requièrent soit un graphe de prérequis, soit une q-matrice. Si les apprenants n'ont pas accès au cours pendant le test, le modèle GenMA convient, à condition qu'une q-matrice soit spécifiée.

## Test adaptatif à la fin d'un MOOC

Un test d'évaluation à la fin d'un cours peut se baser sur les modèles de tests adaptatifs usuels, de façon à mesurer les apprenants efficacement et leur attribuer une note. Pour ce dernier examen, nous supposons que le retour peut se limiter à un score.

<!-- ## Autres applications

Tableaux de bord.

Un apprenant peut demandé à être évalué sur seulement une partie des CC. -->

# Conclusion

Dans ce chapitre, nous avons présenté un modèle hybride de tests adaptatifs, que nous avons validé en utilisant plusieurs jeux de données réelles.

Interpréter le modèle DINA et le modèle de Rasch en termes d'apprentissage automatique nous a permis de proposer ce modèle, plus facile à calibrer qu'un modèle de théorie de la réponse à l'item général, puisque la q-matrice force le modèle à se restreindre au calcul des paramètres de difficulté de chaque question selon chaque composante de connaissance.
