# GenMA, un modèle confirmatoire interprétable

\label{genma}

Comme nous l'avons vu lors de la comparaison qualitative menée à la section \ref{quali-comp}, le modèle MIRT est difficilement interprétable, et difficile à converger pour de grandes dimensions.

Nous allons définir ici un modèle qui suppose que l'on connaisse les composantes de connaissances (CC) mises en œuvre pour chaque question, sous la forme d'une q-matrice, dont l'élément $q_{jk}$ vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon.

## Rappels sur le modèle de diagnostic DINA

Le modèle DINA est un modèle cognitif basé sur une q-matrice, qui a été décrit à la section \ref{dina}. Ce modèle a été utilisé pour des tests adaptatifs et apprécié pour sa capacité à faire un retour à l'apprenant à la fin du test décrivant les composantes de connaissances qui semblent être maîtrisées et celles qui semblent ne pas l'être.

Dans le modèle DINA, l'apprenant est modélisé par un vecteur de bits appelé état indiquant pour chaque CC si elle est maîtrisée ou non. Ainsi, à tout moment du test, le modèle maintient une distribution de probabilité sur les $2^K$ états possibles, où $K$ est le nombre de CC, et chaque question est associée à un vecteur de bits correspondant aux CC qu'il faut avoir maîtrisées afin d'y répondre correctement.

## Modèle de diagnostic général

\label{gdm}

@Davier2005 a proposé un modèle de diagnostic cognitif dont la loi de probabilité est un cas particulier de TRIM (théorie de la réponse à l'item) et s'appuie sur un degré de maîtrise de chaque CC et d'une notion de difficulté des questions. Il s'agit du *modèle général de diagnostic* (*general diagnostic model for partial credit data*). La probabilité que l'apprenant $i$ réponde correctement à la question $j$, c'est-à-dire que $D_{ij} = 1$, est donnée par :

$$ Pr(D_{ij} = 1) = \Phi\left(\sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk} + \delta_j\right) $$

- $K$ est le nombre de CC évaluées par le test ;
- $\theta_{ik}$ son niveau dans la CC $k$ ;
- $q_{jk}$ l'élément $(j, k)$ de la q-matrice qui vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon ;
- $d_{jk}$ est la discrimination de la question $j$ selon la CC $k$ ;
- $\delta_j$ est la facilité de la question $j$.\bigskip

Lien avec TRIM

:   Si la q-matrice ne contient que des 1, alors tous les $q_{jk}$ valent 1, donc la probabilité que l'apprenant $i$ réponde correctement à la question $j$ devient :

$$ Pr(D_{ij} = 1) = \Phi\left(\sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk} + \delta_j\right) = \Phi\left(\mathbf{\theta_i} \cdot \mathbf{d_j} + \delta_j\right) $$

\noindent
qui est la loi de probabilité qui régit le modèle TRIM, voir section \ref{mirt}. 

Lien avec le modèle de Rasch

:   Si $K = 1$, que les paramètres de discrimination $d_{j1}$ et de q-matrice $q_{j1}$ sont tous fixés à 1, et que l'on remplace le paramètre de facilité $\delta_j$ par un paramètre de difficulté opposé $d_j = -\delta_j$, la probabilité que l'apprenant $i$ réponde correctement à la question $j$ devient :

$$ Pr(D_{ij} = 1) = \Phi\left(\sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk} + \delta_j\right) = \Phi\left(\theta_{i1} - d_j\right) $$

\noindent
qui est la loi de probabilité qui régit le modèle de Rasch, voir section \ref{irt}.

La phase de calibrage d'un tel modèle conduit à une extraction des caractéristiques de chaque question $j$ : $\mathbf{d_j} = (d_{j1}, \ldots, d_{jk})$ et $\delta_j$ similaire à TRIM de dimension $d = K$ mais la q-matrice force une contrainte supplémentaire : pour chaque entrée nulle de la q-matrice $q_{jk}$, la composante correspondante dans la caractéristique de la question $j$ est nulle : si $q_{jk} = 0$, alors $d_{jk} = 0$. Ainsi, il y a moins de paramètres à estimer.

Contrairement au modèle DINA, où il faut maîtriser toutes les composantes de connaissances mises en œuvre dans une question afin d'y répondre correctement[^1], le modèle de diagnostic général suppose que plus on maîtrise de composantes de connaissances mises en œuvre dans une question, plus grandes seront nos chances d'y répondre correctement. Et les paramètres de discrimination de chaque question permettent de favoriser certaines composantes plutôt que d'autres, dans le calcul de la probabilité de succès.

 [^1]: Pour rappel, le A de DINA signifie \og And \fg.

## Description du modèle

Nous proposons un nouveau modèle de test adaptatif basé sur le modèle général de diagnostic. GenMA requiert la spécification d'une q-matrice par un expert.

### Modèle de la probabilité de répondre correctement à chaque question

Pour la loi de probabilité de notre modèle, nous nous appuyons sur celle du modèle général de diagnostic, définie à la section \ref{gdm}.

### Caractéristiques de l'apprenant

L'apprenant $i$ est modélisé par un vecteur $\mathbf{\theta_i} = (\theta_{i1}, \ldots, \theta_{iK})$ de dimension $K$, où $\theta_{ik}$ représente son niveau selon chaque composante de connaissance $k$. Le niveau de l'apprenant selon une composante peut être positif, auquel cas ce paramètre participe à ce que l'apprenant réponde correctement aux questions qui requièrent cette composante. Il peut être négatif, auquel cas ce paramètre correspond à une lacune de l'apprenant, qui le pénalisera pour répondre correctement aux questions qui requièrent cette composante.

### Caractéristiques des questions

Au lieu d'associer à chaque question $j$ un vecteur de bits comme dans le modèle DINA, le modèle GenMA lui associe un vecteur de valeurs réelles $\mathbf{d_j} = (d_{j1}, \ldots, d_{jK})$, correspondant à des paramètres de discrimination selon chaque composante de connaissance (CC), et un paramètre de facilité $\delta_j$.

À titre d'exemple, supposons que le paramètre de discrimination d'une question $j$ soit très grand pour une CC $k$ mise en œuvre dans sa résolution ($q_{jk} = 1$ et $d_{jk}$ est très grand). Si l'apprenant a un petit niveau $\theta_{ik} = \varepsilon > 0$ selon la CC $k$, alors comme $\theta_{ik} q_{jk} d_{jk}$ est grand, l'apprenant a de bonnes chances de répondre correctement à la question $j$. Si en revanche $\theta_{ik} = -\varepsilon < 0$, c'est-à-dire que l'apprenant a une lacune selon la composante $k$, alors $\theta_{ik} q_{jk} d_{jk}$ est faible et l'apprenant a peu de chances de répondre correctement à la question $j$. Ainsi, le paramètre de discrimination permet d'indiquer qu'une CC est plus ou moins importante dans le calcul de la probabilité qu'une certaine question soit résolue correctement. Et comme indiqué à la section \ref{gdm}, si $q_{jk} = 0$ alors $d_{jk} = 0$, c'est-à-dire que le niveau de l'apprenant pour des composantes de connaissance non impliquées dans la résolution d'une question n'interviennent pas dans le calcul de ses chances d'y répondre correctement.

\begin{figure}
\centering
\includegraphics[width=\linewidth]{figures/genma.pdf}
\caption{Le modèle hybride GenMA, qui combine TRIM et une q-matrice.}
\label{fig-genma}
\end{figure}

### Calibrage des caractéristiques

Les paramètres de facilité $\delta_j$ et de discrimination $d_{jk}$ pour chaque question $j$ et composante de connaissances $k$ sont calibrés à partir des données des apprenants $D$, en utilisant l'algorithme de Metropolis-Hastings Robbins-Monro [@Chalmers2012; @Cai2010]. Pour notre implémentation, nous nous sommes basés sur le package ``mirt`` [@Chalmers2012].

Dans un test, chaque question fait habituellement appel à peu de CC, c'est-à-dire que la q-matrice est creuse : elle contient majoritairement des 0. C'est pourquoi le modèle GenMA est plus rapide à calibrer que le modèle de TRIM général : il y a moins de paramètres à estimer car la q-matrice spécifie les seules caractéristiques intéressantes à estimer, voir à nouveau la figure \ref{fig-genma}. Si la q-matrice contient $s$ entrées fixées à 1, alors au lieu de devoir estimer $nd$ caractéristiques pour les $n$ questions en dimension $d$, il suffit d'en estimer $s + n$ : $s$ paramètres de discrimination en tout, et 1 paramètre de facilité pour chacune des $n$ questions.

### Choix de la question suivante

Pour le choix de la question suivante dans le modèle GenMA, nous choisissons de maximiser le déterminant de l'information de Fisher à chaque étape. Il s'agit de la règle D spécifiée à la section \ref{mirt}.

Cela correspond à choisir la question qui va le plus réduire la variance sur le paramètre à estimer, c'est-à-dire les caractéristiques $\mathbf\theta$ de l'apprenant qui passe le test.

### Estimation des caractéristiques d'un nouvel apprenant

Après que l'apprenant $i$ a répondu à une question, en fonction de sa réponse on calcule les paramètres $(\theta_{i1}, \ldots, \theta_{iK})$ les plus vraisemblables, c'est-à-dire son niveau selon chaque composante de connaissance.

Pour cela, on calcule l'estimateur du maximum de vraisemblance, c'est-à-dire les paramètres $\mathbf{\theta_i}$ qui maximisent la probabilité d'observer ces résultats sachant $\mathbf{\theta_i}$ et l'expression de la probabilité que l'apprenant $i$ a répondu correctement à la question $j$, comme un modèle de type TRIM habituel, c'est-à-dire en utilisant une régression logistique.

### Retour à la fin du test

\label{genma-feedback}

À la fin du test, l'apprenant reçoit un diagnostic sous la forme de valeurs de niveau selon chaque composante de connaissances (CC). Il s'agit du vecteur $\mathbf{\theta_i} = (\theta_{i1}, \ldots, \theta_{iK})$. Si la valeur $\theta_{ik}$ selon la CC $k$ est négative, il s'agit d'une lacune. Sinon, il s'agit d'un degré de maîtrise.

Contrairement à un modèle de type TRIM habituel, complètement automatique et où il faudrait interpréter les composantes a posteriori, le modèle GenMA a été calibré de façon que chaque dimension corresponde à une colonne de la q-matrice spécifiée par un expert, donc à une CC bien définie. Ainsi, les composantes du vecteur de niveau sont directement interprétables. GenMA est donc un modèle formatif : le diagnostic qu'il fait à l'apprenant est plus utile pour la progression de l'apprenant qu'un simple score, car il indique ses éventuels points forts et lacunes.

# Validation

## Qualitative

GenMA est multidimensionnel donc mesure des valeurs selon plusieurs CC, contrairement à Rasch qui ne mesure qu'une unique valeur correspondant au niveau de l'apprenant sur tout le test.

Comme indiqué à la section \ref{genma-feedback}, le modèle GenMA est interprétable car semi-automatique. Au lieu de déterminer automatiquement toutes les caractéristiques, GenMA permet d'orienter le calibrage en laissant un expert spécifier les paramètres de discrimination à estimer au moyen d'une q-matrice, qui fait le lien entre les questions et les CC. GenMA est à la fois basé sur la théorie de la réponse à l'item et sur une représentation des composantes de connaissances mises en œuvre dans le test, c'est donc un modèle hybride.

Cette spécification permet en outre d'accélérer la convergence, car il y a moins de paramètres à estimer que dans un modèle général de type TRIM.

## Quantitative

Pour quantifier la réduction du nombre de questions posées par le modèle GenMA, et la validité du diagnostic qu'il fournit, nous avons suivi le protocole décrit au chapitre précédent avec les modèles suivants.

Rasch

:   Modèle unidimensionnel qui ne requiert pas de q-matrice.

MIRT

:   Modèle de dimension 2 exploratoire.

DINA

:   Le modèle DINA avec une q-matrice spécifiée par un expert.

GenMA

:   Notre modèle GenMA avec la même q-matrice.

Et les datasets suivants, décrits à la section \vref{datasets}.

Fraction

:   Pour ce jeu de données, nous avons comparé deux occurrences du modèle GenMA, l'une avec la q-matrice spécifiée par un expert, l'autre avec une q-matrice qui a été calculée automatiquement.

ECPE

:   Un test avec une q-matrice à 3 CC.

TIMSS

:   Un test avec une q-matrice à 13 CC.

Pour l'implémentation, nous utilisons le package ``mirt``, voir la section \vref{code} en annexe, qui permet de fixer les entrées non nulles à estimer (au moyen d'une q-matrice). Le package ``mirtCAT`` nous permet de poser les questions. Les résultats sont donnés dans les figures \ref{results-fraction} à \ref{results-timss}.

## Discussion

Sur chacun des jeux de données testés, GenMA a un plus grand pouvoir prédictif que les autres modèles formatifs. La réponse à une question donnée par l'apprenant apporte plus d'information sur son niveau car chaque question a, contrairement au modèle DINA, des paramètres de difficulté selon chaque composante de connaissance.

MIRT a un plus grand pouvoir prédictif mais il s'agit d'un modèle sommatif.

### Fraction

\begin{figure}[h]
\small
\centering
\includegraphics[width=0.8\textwidth]{figures/results/fraction-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/fraction-count}
\begin{tabular}{cccc}
& Après 4 questions & Après 7 questions & Après 10 questions\\
Rasch & $0.469 \pm 0.017$ (79 \%) & $0.457 \pm 0.017$ (79 \%) & $0.446 \pm 0.016$ (79 \%)\\
GenMA & $0.459 \pm 0.023$ (79 \%) & $0.355 \pm 0.017$ (85 \%) & $0.294 \pm 0.013$ (88 \%)\\
MIRT & $0.368 \pm 0.014$ (83 \%) & $0.325 \pm 0.012$ (86 \%) & $0.316 \pm 0.011$ (86 \%)\\
DINA & $0.441 \pm 0.014$ (80 \%) & $0.41 \pm 0.014$ (82 \%) & $0.406 \pm 0.014$ (82 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne de prédiction en fonction du nombre de questions posées, pour le jeu de données Fraction.}
\label{results-fraction}
\end{figure}

Dans le jeu de données Fraction, 4 questions sur 10 sont suffisantes pour prédire correctement 80 % en moyenne des réponses sur les 10 questions de l'ensemble de validation. À titre d'exemple, pour un des apprenants, après 4 questions, la performance prédite sur l'ensemble de validation est $[0.617, 0.123, 0.418, 0.127, 0.120]$ tandis que sa vraie performance est $[\textnormal{Correct}, \textnormal{Incorrect}, \textnormal{Correct}, \textnormal{Incorrect}, \textnormal{Incorrect}]$, ce qui correspond à une erreur de 0.350.

MIRT converge en 6 questions tandis que GenMA continue à apprendre car c'est un modèle de plus grande dimension.

Dans le jeu de données Fraction, on souhaite identifier l'état latent de l'apprenant parmi $2^8$ états possibles, en posant des questions qui portent sur peu de CC. Cela explique pourquoi DINA a besoin de beaucoup de questions pour converger. Pour ce jeu de données, le modèle de Rasch est plus prédictif qu'un modèle DINA basé sur une q-matrice qui a été calculée automatiquement.

### ECPE

\begin{figure}[h]
\small
\centering
\includegraphics[width=0.8\textwidth]{figures/results/ecpe-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/ecpe-count}
\begin{tabular}{cccc}
& Après 4 questions & Après 8 questions & Après 12 questions\\
MIRT & $0.509 \pm 0.005$ (76 \%) & $0.496 \pm 0.005$ (76 \%) & $0.489 \pm 0.005$ (77 \%)\\
DINA & $0.535 \pm 0.003$ (73 \%) & $0.526 \pm 0.003$ (74 \%) & $0.523 \pm 0.003$ (74 \%)\\
Rasch & $0.537 \pm 0.005$ (73 \%) & $0.527 \pm 0.005$ (74 \%) & $0.522 \pm 0.005$ (74 \%)\\
GenMA & $0.532 \pm 0.005$ (73 \%) & $0.507 \pm 0.004$ (75 \%) & $0.498 \pm 0.004$ (76 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne de prédiction en fonction du nombre de questions posées, pour le jeu de données ECPE.}
\label{results-ecpe}
\end{figure}

Dans le jeu de données ECPE, DINA et Rasch ont une performance similaire, ce qui est surprenant étant donné que Rasch ne requiert aucune connaissance du domaine. Nous supposons que cela apparaît car il n'y a que 3 CC décrites dans la q-matrice, donc le nombre d'états possibles pour un apprenant est $2^3 = 8$ pour $2^{28}$ motifs de réponse possibles. Ainsi, les paramètres d'inattention et de chance sont très hauts, voir la table \ref{guess}, ce qui explique pourquoi l'information gagnée à chaque question est basse. Par exemple, la question qui requiert les CC 2 et 3 a un grand taux de succès de 88 %, ce qui rend cette question plus facile à résoudre que des questions qui ne requièrent que la CC 2 ou 3, donc le seul moyen pour le modèle DINA d'exprimer ce comportement est d'accroître le paramètre de chance. À l'inverse, GenMA est un modèle plus expressif.

MIRT à 2 dimensions se débrouille mieux que GenMA, ce qui laisse entendre qu'un modèle prédictif n'est pas nécessairement explicatif. Toutefois afin de faire un retour à l'utilisateur, notre modèle fait un feedback correspondant davantage à la réalité qu'un modèle DINA basé sur les q-matrices.

Nous faisons l'hypothèse que la q-matrice a été mal spécifiée.

### TIMSS

\begin{figure}[h]
\small
\centering
\includegraphics[width=0.8\textwidth]{figures/results/timss-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/timss-count}
\begin{tabular}{cccc}
& Après 4 questions & Après 8 questions & Après 11 questions\\
Rasch & $0.576 \pm 0.008$ (70 \%) & $0.559 \pm 0.008$ (71 \%) & $0.555 \pm 0.008$ (71 \%)\\
GenMA & $0.537 \pm 0.006$ (72 \%) & $0.505 \pm 0.006$ (75 \%) & $0.487 \pm 0.006$ (77 \%)\\
DINA & $0.588 \pm 0.005$ (68 \%) & $0.57 \pm 0.006$ (70 \%) & $0.566 \pm 0.006$ (70 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne de prédiction en fonction du nombre de questions posées, pour le jeu de données TIMSS.}
\label{results-timss}
\end{figure}

Les modèles Rasch et DINA ont une erreur similaire mais GenMA est bien meilleur. C'est le seul qui progresse en précision.

<!-- raisons d'expressivité du modèle -->

<!-- DINA -->

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

<!-- ## Autres applications

Tableaux de bord.

Un apprenant peut demandé à être évalué sur seulement une partie des CC. -->

# Conclusion

Dans ce chapitre, nous avons présenté un modèle hybride de tests adaptatifs, que nous avons validé en utilisant plusieurs jeux de données réelles.

Interpréter le modèle DINA et le modèle de Rasch en termes d'apprentissage automatique nous a permis de proposer ce modèle, plus facile à calibrer qu'un modèle de théorie de la réponse à l'item général, puisque la q-matrice force le modèle à se restreindre au calcul des paramètres de difficulté de chaque question selon chaque composante de connaissance.

Calibrer un modèle TRIM en dimension 8 serait invraisemblable, mais avec GenMA c'est possible car le nombre de 1 dans la q-matrice est faible.
