# Description du modèle GenMA

\label{genma}

Nous proposons un nouveau modèle de test adaptatif basé sur un modèle de diagnostic cognitif. GenMA est hybride dans la mesure où il tire son inspiration d'un modèle de la théorie de la réponse à l'item, et requiert la spécification d'une q-matrice : on suppose que l'on connaît les composantes de connaissances (CC) mises en œuvre pour chaque question, sous la forme d'une q-matrice, dont l'élément $q_{jk}$ vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon.

Comme pour chaque modèle de test adaptatif, il nous faut spécifier les points suivants.

Modèle de réponse

:   Un modèle de la probabilité de répondre correctement à chaque question, basé sur une représentation du domaine et des caractéristiques de l'apprenant et des questions à identifier.

TrainingStep

:   Une phase d'apprentissage de ces caractéristiques à partir des données d'entraînement, c'est-à-dire des données d'apprenants ayant répondu aux questions du test par le passé.

PriorInitialization

:   Une méthode qui définit les caractéristiques initiales d'un nouvel apprenant.

NextItem

:   Un critère de sélection de la question suivante.

EstimateParameters

:   Une méthode d'estimation des caractéristiques de l'apprenant, c'est-à-dire son diagnostic, à partir des données observées : ses réponses aux questions posées.

Retour

:   Un retour fait à la fin du test.

## Modèle de réponse de l'apprenant sur une question

### Caractéristiques de l'apprenant

L'apprenant $i$ est modélisé par un vecteur $\boldsymbol{\theta_i} = (\theta_{i1}, \ldots, \theta_{iK})$ de dimension $K$, où $\theta_{ik}$ représente son niveau selon chaque composante de connaissances $k$. Le niveau de l'apprenant selon une composante peut être positif, auquel cas ce paramètre participe à ce que l'apprenant réponde correctement aux questions qui requièrent cette composante. Il peut être négatif, auquel cas ce paramètre correspond à une lacune de l'apprenant, qui le pénalisera lorsqu'il répondra aux questions qui requièrent cette composante.

### Caractéristiques des questions

Au lieu d'associer à chaque question $j$ un vecteur de bits comme dans le modèle DINA, le modèle GenMA lui associe un vecteur de valeurs réelles $\boldsymbol{d_j} = (d_{j1}, \ldots, d_{jK})$, correspondant à des paramètres de discrimination selon chaque composante de connaissances, et un paramètre de facilité $\delta_j$.

### Modèle de diagnostic général

\label{gdm}

@Davier2005 a proposé un modèle de diagnostic cognitif dont la loi de probabilité est un cas particulier de MIRT (théorie de la réponse à l'item multidimensionnelle) et s'appuie sur un degré de maîtrise de chaque CC et d'une notion de difficulté des questions. Il s'agit du *modèle général de diagnostic* (*general diagnostic model for partial credit data*). La probabilité que l'apprenant $i$ réponde correctement à la question $j$, c'est-à-dire que $D_{ij} = 1$, est donnée par :

\begin{equation}
Pr(D_{ij} = 1) = \Phi\left(\sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk} + \delta_j\right)
\end{equation}

- $K$ est le nombre de CC évaluées par le test ;
- $\theta_{ik}$ son niveau dans la CC $k$ ;
- $q_{jk}$ l'élément $(j, k)$ de la q-matrice qui vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon ;
- $d_{jk}$ est la discrimination de la question $j$ selon la CC $k$ ;
- $\delta_j$ est la facilité de la question $j$.\bigskip\nomenclature{$q_{jk}$}{entrée $(j, k)$ de la q-matrice}

Lien avec MIRT

:   Si la q-matrice ne contient que des 1, alors tous les $q_{jk}$ valent 1, donc la probabilité que l'apprenant $i$ réponde correctement à la question $j$ devient :

\begin{equation}
Pr(D_{ij} = 1) = \Phi\left(\sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk} + \delta_j\right) = \Phi\left(\boldsymbol{\theta_i} \cdot \boldsymbol{d_j} + \delta_j\right)
\end{equation}

\noindent
qui est la loi de probabilité qui régit le modèle MIRT, voir section \vref{mirt}. 

Lien avec le modèle de Rasch

:   Si $K = 1$, que les paramètres de discrimination $d_{j1}$ et de q-matrice $q_{j1}$ sont tous fixés à 1, et que l'on remplace le paramètre de facilité $\delta_j$ par un paramètre de difficulté opposé $d_j = -\delta_j$, la probabilité que l'apprenant $i$ réponde correctement à la question $j$ devient :

\begin{equation}
Pr(D_{ij} = 1) = \Phi\left(\sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk} + \delta_j\right) = \Phi\left(\theta_{i1} - d_j\right)
\end{equation}

\noindent
qui est la loi de probabilité qui régit le modèle de Rasch, voir section \vref{irt}.

La phase de calibrage d'un tel modèle conduit à une extraction des caractéristiques de chaque question $j$ : $\boldsymbol{d_j} = (d_{j1}, \ldots, d_{jk})$ et $\delta_j$ similaire à MIRT de dimension $d = K$ mais la q-matrice force une contrainte supplémentaire : pour chaque entrée nulle de la q-matrice $q_{jk}$, la composante correspondante dans la caractéristique de la question $j$ est nulle : si $q_{jk} = 0$, alors $d_{jk} = 0$. Ainsi, il y a moins de paramètres à estimer (voir figure \ref{fig-genma}).

Contrairement au modèle DINA, où il faut maîtriser toutes les composantes de connaissances mises en œuvre dans une question afin d'y répondre correctement[^1], le modèle de diagnostic général suppose que plus on maîtrise de composantes de connaissances mises en œuvre dans une question, plus grandes seront nos chances d'y répondre correctement. Et les paramètres de discrimination de chaque question permettent de favoriser certaines composantes plutôt que d'autres, dans le calcul de la probabilité de succès.

 [^1]: Pour rappel, le A de DINA signifie \og And \fg.

À titre d'exemple, supposons que le paramètre de discrimination d'une question $j$ soit très grand pour une CC $k$ mise en œuvre dans sa résolution ($q_{jk} = 1$ et $d_{jk}$ est très grand). Si l'apprenant a un petit niveau $\theta_{ik} = \varepsilon > 0$ selon la CC $k$, alors comme $\theta_{ik} q_{jk} d_{jk}$ est grand, l'apprenant a de bonnes chances de répondre correctement à la question $j$. Si en revanche $\theta_{ik} = -\varepsilon < 0$, c'est-à-dire que l'apprenant a une lacune selon la composante $k$, alors $\theta_{ik} q_{jk} d_{jk}$ est faible et l'apprenant a peu de chances de répondre correctement à la question $j$. Ainsi, le paramètre de discrimination permet d'indiquer qu'une CC est plus ou moins importante dans le calcul de la probabilité qu'une certaine question soit résolue correctement. Et comme indiqué à la section \vref{gdm}, si $q_{jk} = 0$ alors $d_{jk} = 0$, c'est-à-dire que le niveau de l'apprenant pour des composantes de connaissances non impliquées dans la résolution d'une question n'interviennent pas dans le calcul de ses chances d'y répondre correctement.

\begin{figure}
\centering
\includegraphics[width=\linewidth]{figures/genma.pdf}
\caption{Le modèle hybride GenMA, qui combine MIRT et une q-matrice.}
\label{fig-genma}
\end{figure}

## Calibrage des caractéristiques

Les paramètres de facilité $\delta_j$ et de discrimination $d_{jk}$ pour chaque question $j$ et composante de connaissances $k$ sont calibrés à partir des données des apprenants $D$, en utilisant l'algorithme de Metropolis-Hastings Robbins-Monro [@Chalmers2012; @Cai2010].

Dans un test, chaque question fait habituellement appel à peu de CC, c'est-à-dire que la q-matrice est creuse : elle contient majoritairement des 0. C'est pourquoi le modèle GenMA est plus rapide à calibrer que le modèle MIRT général : il y a moins de paramètres à estimer car la q-matrice spécifie les seules caractéristiques intéressantes à estimer, voir à nouveau la figure \ref{fig-genma}. Si la q-matrice contient $s$ entrées fixées à 1, alors au lieu de devoir estimer $nd$ caractéristiques pour les $n$ questions en dimension $d$, il suffit d'en estimer $s + n$ : $s$ paramètres de discrimination en tout, et 1 paramètre de facilité pour chacune des $n$ questions.

## Initialisation des paramètres d'un nouvel apprenant

Au début du test, on suppose que l'apprenant est de niveau nul : $\boldsymbol{\theta} = (0, \ldots, 0)$. Ainsi, pour chaque question $j$, la probabilité que l'apprenant y réponde correctement ne dépend que de son paramètre de facilité $\delta_j$.

## Choix de la question suivante

Pour le choix de la question suivante dans le modèle GenMA, nous choisissons de maximiser le déterminant de l'information de Fisher à chaque étape. Il s'agit de la règle D spécifiée à la section \vref{mirt}.

Cela correspond à choisir la question qui va le plus réduire la variance sur le paramètre à estimer, c'est-à-dire les caractéristiques $\boldsymbol{\theta}$ de l'apprenant qui passe le test.

## Estimation des caractéristiques d'un nouvel apprenant

Après que l'apprenant $i$ a répondu à une question, en fonction de sa réponse on calcule les paramètres $(\theta_{i1}, \ldots, \theta_{iK})$ les plus vraisemblables, c'est-à-dire son niveau selon chaque composante de connaissances.

Pour cela, on calcule l'estimateur du maximum de vraisemblance, c'est-à-dire les paramètres $\boldsymbol{\theta_i}$ qui maximisent la probabilité d'observer ces résultats sachant $\boldsymbol{\theta_i}$ et l'expression de la probabilité que l'apprenant $i$ a répondu correctement à la question $j$, comme un modèle de type MIRT habituel, c'est-à-dire en utilisant une régression logistique.

On suppose que le calibrage des questions a été effectué sur des données d'entraînement, et qu'on dispose des caractéristiques des questions dans une matrice $V$ de taille $m \times d$ dont la ligne $V_j$ correspond aux caractéristiques de la question $j$. À un certain moment du test, on a posé les questions $(q_1, \ldots, q_t)$ de caractéristiques $V_{q_1}, \ldots, V_{q_t}$ pour lesquelles on a observé les réponses $(r_1, \ldots, r_t) \in \{0, 1\}^t$ et on se demande quelle va être la performance de l'apprenant sur une certaine question $j$ de caractéristiques $V_j$.\nomenclature{$V$}{caractéristiques des questions dans MIRT, GenMA}

On cherche donc à estimer les caractéristiques de l'apprenant $\hat{\boldsymbol{\theta}}$ tels que pour chaque $k = 1, \ldots, t$, $\Phi(\hat{\boldsymbol{\theta}} \cdot V_{q_k}) = r_k$. Ainsi, on pourra calculer la probabilité que l'apprenant réponde correctement à la question $j$ de caractéristiques $V_j$, donnée par l'expression $\Phi(\hat{\boldsymbol{\theta}} \cdot V_j)$.

Il s'agit d'un problème d'apprentissage automatique, appelé *classification binaire*. Le modèle MIRT permet de résoudre ce problème en faisant une régression logistique.

Régression logistique

:   Le modèle de régression logistique est utilisé pour la prédiction de variables dichotomiques (vrai ou faux), telles que les réponses des apprenants dans notre cas. Lorsqu'on a $n$ éléments de dimension $d$ $(\mathbf{x_1}, \ldots, \mathbf{x_n})$ pour lesquels on observe des résultats vrai/faux $\mathbf{y} = (y_1, \ldots, y_n) \in \{0, 1\}^n$, la régression logistique consiste à estimer un paramètre $\boldsymbol{\theta} \in \R^d$ tel que $\Phi(\boldsymbol{\theta}^T X) = \mathbf{y}$ où $X$ est la matrice ayant pour lignes les vecteurs $(\mathbf{x_1}, \ldots, \mathbf{x_n})$. Ce modèle est apprécié pour sa propriété de généralisation à partir de peu de données.

Notre problème est directement encodable ainsi :

- il y a $n = t$ échantillons ;
- les échantillons $\mathbf{x_i}$ sont les caractéristiques $V_{q_1}, \ldots, V_{q_t}$ des questions ;
- les étiquettes des échantillons sont les réponses correspondantes de l'apprenant $r_1, \ldots, r_t$.

## Retour à la fin du test

\label{genma-feedback}

À la fin du test, l'apprenant reçoit un diagnostic sous la forme de valeurs de niveau selon chaque composante de connaissances (CC). Il s'agit du vecteur $\boldsymbol{\theta_i} = (\theta_{i1}, \ldots, \theta_{iK})$. Si la valeur $\theta_{ik}$ selon la CC $k$ est négative, il s'agit d'une lacune. Sinon, il s'agit d'un degré de maîtrise.

Contrairement à un modèle de type MIRT habituel, complètement automatique et où il faudrait interpréter les composantes a posteriori, le modèle GenMA a été calibré de façon que chaque dimension corresponde à une colonne de la q-matrice spécifiée par un expert, donc à une CC bien définie. Ainsi, les composantes du vecteur de niveau sont directement interprétables. GenMA est donc un modèle formatif : le diagnostic qu'il fait à l'apprenant est plus utile pour la progression de l'apprenant qu'un simple score, car il indique ses éventuels points forts et lacunes.

# Validation

## Qualitative

Nous avons suivi l'analyse qualitative menée à la section \vref{quali-comp}. Les résultats sont répertoriés dans la table \ref{genma-quali}.

GenMA est multidimensionnel donc mesure des valeurs selon plusieurs CC, contrairement à Rasch qui ne mesure qu'une unique valeur correspondant au niveau de l'apprenant sur tout le test.

Comme indiqué à la section \vref{genma-feedback}, le modèle GenMA est interprétable car semi-automatique. Au lieu de déterminer automatiquement toutes les caractéristiques, GenMA permet d'orienter le calibrage en laissant un expert spécifier les paramètres de discrimination à estimer au moyen d'une q-matrice, qui fait le lien entre les questions et les CC. GenMA est à la fois basé sur la théorie de la réponse à l'item et sur une représentation des composantes de connaissances mises en œuvre dans le test, c'est donc un modèle hybride.

Cette spécification permet en outre d'accélérer la convergence, car il y a moins de paramètres à estimer que dans un modèle général de type MIRT. Si la matrice a en moyenne $k$ entrées non nulles par ligne, GenMA estime pour ses questions $kn$ paramètres de discrimination et $n$ paramètres de facilité.

\begin{table}
\centering
\begin{tabular}{cccccc} \toprule
& Dimension & Calibrage & De zéro & Nombre de paramètres\\ \midrule
Rasch & 1 & Auto & Non & $n$\\
MIRT & $K \leq 4$ & Auto & Non & $(K + 1)n$\\ \midrule
DINA & $K \leq 15$ & Manuel & Oui & $2n$\\
GenMA & $K \leq 15$ & Semi-auto & Non & $(k + 1)n$\\ \bottomrule
\end{tabular}
\caption{Comparaison qualitative des modèles de tests adaptatifs}
\label{genma-quali}
\end{table}

## Modèles comparés

Pour quantifier la réduction du nombre de questions posées par le modèle GenMA, et la validité du diagnostic qu'il fournit, nous avons suivi le protocole décrit au chapitre précédent avec les modèles suivants.

Rasch

:   Modèle unidimensionnel qui ne requiert pas de q-matrice.

MIRT

:   Modèle de dimension 2 automatique.

DINA

:   Le modèle DINA avec une q-matrice spécifiée par un expert.

GenMA

:   Notre modèle GenMA avec la même q-matrice.

## Jeux de données

Les jeux de données réelles suivants sont décrits plus en détail à la section \vref{datasets}.

Fraction

:   $m = 536$ collégiens, $n = 20$ questions, q-matrice $K = 8$ CC.

ECPE

:   $m = 2922$ apprenants, $n = 28$ questions, q-matrice $K = 3$ CC.

TIMSS

:   $m = 757$ collégiens, $n = 23$ questions, q-matrice $K = 13$ CC.

## Implémentation

Pour l'implémentation, nous utilisons le package ``mirt``, voir la section \vref{code} en annexe, qui permet de fixer les entrées non nulles à estimer (au moyen d'une q-matrice). Le package ``mirtCAT`` nous permet de poser les questions. Les résultats sont donnés dans les figures \ref{genma-fraction} à \ref{genma-timss}. Les valeurs obtenues de la *log loss* sont répertoriées dans les tables \ref{genma-fraction-table} à \ref{genma-timss-table}.

La validation croisée est faite sur 5 paquets d'apprenants et 2 paquets de questions.

## Résultats et discussion

Sur chacun des jeux de données testés, GenMA a un plus grand pouvoir prédictif que l'autre modèle formatif DINA. La réponse à une question donnée par l'apprenant apporte plus d'information sur son niveau car chaque question a, contrairement au modèle DINA, des paramètres de discrimination selon chaque composante de connaissances.

### Fraction

\begin{figure}[h]
\centering
\includegraphics[width=0.8\textwidth]{figures/genma/fraction-mean}
%\includegraphics[width=0.5\textwidth]{figures/genma/fraction-count}
\caption{Évolution de la \emph{log loss} moyenne de prédiction en fonction du nombre de questions posées, pour le jeu de données Fraction.}
\label{genma-fraction}
\end{figure}

\begin{table}[h]
\centering
\small
\begin{tabular}{cccc} \toprule
& Après 4 questions & Après 7 questions & Après 10 questions\\ \midrule
Rasch & $0,469 \pm 0,017$ (79 \%) & $0,457 \pm 0,017$ (79 \%) & $0,446 \pm 0,016$ (79 \%)\\
DINA & $0,441 \pm 0,014$ (80 \%) & $0,41 \pm 0,014$ (82 \%) & $0,406 \pm 0,014$ (82 \%)\\
MIRT & $0,368 \pm 0,014$ (83 \%) & $0,325 \pm 0,012$ (86 \%) & $0,316 \pm 0,011$ (86 \%)\\
GenMA & $0,459 \pm 0,023$ (79 \%) & $0,355 \pm 0,017$ (85 \%) & $0,294 \pm 0,013$ (88 \%)\\ \bottomrule
\end{tabular}
\caption{Évolution de la \emph{log loss} en fonction du nombre de questions posées, pour le jeu de données Fraction. Entre parenthèses, le nombre de questions prédites correctement.}
\label{genma-fraction-table}
\end{table}

Dans le jeu de données Fraction, 4 questions sur 10 sont suffisantes pour prédire correctement 80 % en moyenne des réponses sur les 10 questions de l'ensemble de validation (voir table \ref{genma-fraction-table}).

Les modèles Rasch, MIRT et DINA convergent en 4 ou 5 questions tandis que GenMA continue à apprendre car c'est un modèle de plus grande dimension que les autres. DINA est de dimension 8 comme GenMA mais c'est un modèle discret.

### ECPE

\begin{figure}[h]
\centering
\includegraphics[width=0.8\textwidth]{figures/genma/ecpe-mean}
%\includegraphics[width=0.5\textwidth]{figures/genma/ecpe-count}
\caption{Évolution de la \emph{log loss} en fonction du nombre de questions posées, pour le jeu de données ECPE.}
\label{genma-ecpe}
\end{figure}

\begin{table}[h]
\centering
\small
\begin{tabular}{cccc} \toprule
& Après 4 questions & Après 8 questions & Après 12 questions\\ \midrule
DINA & $0,535 \pm 0,003$ (73 \%) & $0,526 \pm 0,003$ (74 \%) & $0,523 \pm 0,003$ (74 \%)\\
MIRT & $0,509 \pm 0,005$ (76 \%) & $0,496 \pm 0,005$ (76 \%) & $0,489 \pm 0,005$ (77 \%)\\
GenMA & $0,532 \pm 0,005$ (73 \%) & $0,507 \pm 0,004$ (75 \%) & $0,498 \pm 0,004$ (76 \%)\\
Rasch & $0,537 \pm 0,005$ (73 \%) & $0,527 \pm 0,005$ (74 \%) & $0,522 \pm 0,005$ (74 \%)\\ \bottomrule
\end{tabular}
\caption{Valeurs obtenues pour le jeu de données ECPE.}
\label{genma-ecpe-table}
\end{table}

Dans la figure \ref{genma-ecpe}, DINA et Rasch ont une performance similaire, ce qui est surprenant étant donné que Rasch ne requiert aucune connaissance du domaine. Nous supposons que cela apparaît car il n'y a que 3 CC décrites dans la q-matrice, donc le nombre d'états possibles pour un apprenant est $2^3 = 8$ pour $2^{28}$ motifs de réponse possibles. Ainsi, les paramètres d'inattention et de chance sont très hauts (voir la table \ref{guess}), ce qui explique pourquoi l'information gagnée à chaque question est basse. Par exemple, la question qui requiert les CC 2 et 3 a un grand taux de succès de 88 %, ce qui rend cette question plus facile à résoudre que d'autres questions qui ne requièrent que la CC 2 ou 3, donc le seul moyen pour le modèle DINA d'exprimer ce comportement est d'accroître le paramètre de chance. À l'inverse, GenMA est un modèle plus expressif.

MIRT à 2 dimensions a un taux d'erreur plus faible que GenMA, ce qui laisse entendre qu'un modèle prédictif n'est pas nécessairement explicatif. Toutefois afin de faire un retour à l'utilisateur, notre modèle fait un diagnostic correspondant davantage à la réalité qu'un modèle DINA basé sur les q-matrices.

Nous faisons l'hypothèse que la q-matrice a été mal spécifiée.

\begin{table}
\centering
\begin{tabular}{C{5mm}C{5mm}C{5mm}ccc} \toprule
\multicolumn{5}{c}{\textnormal{q-matrice}} & \multirow{2}{*}{\textnormal{taux de succès}} \\ \cmidrule(r){1-5}
\multicolumn{3}{c}{\textnormal{entrées}} & \textnormal{chance} & \multicolumn{1}{c}{\textnormal{inattention}} & \\ \midrule
%\hline
1 & 1 & 0 & 0,705 & 0,085 & 80 \%\\
0 & 1 & 0 & 0,724 & 0,101 & 83 \%\\
1 & 0 & 1 & 0,438 & 0,266 & 57 \%\\
0 & 0 & 1 & 0,480 & 0,162 & 70 \%\\
0 & 0 & 1 & 0,764 & 0,040 & 88 \%\\
0 & 0 & 1 & 0,717 & 0,066 & 85 \%\\
1 & 0 & 1 & 0,544 & 0,085 & 72 \%\\
0 & 1 & 0 & 0,802 & 0,040 & 89 \%\\
0 & 0 & 1 & 0,534 & 0,199 & 70 \%\\
1 & 0 & 0 & 0,483 & 0,163 & 65 \%\\
1 & 0 & 1 & 0,556 & 0,099 & 72 \%\\
1 & 0 & 1 & 0,195 & 0,305 & 43 \%\\
1 & 0 & 0 & 0,633 & 0,122 & 75 \%\\
1 & 0 & 0 & 0,517 & 0,212 & 65 \%\\
0 & 0 & 1 & 0,749 & 0,040 & 88 \%\\
1 & 0 & 1 & 0,549 & 0,126 & 70 \%\\
\textbf0 & \textbf1 & \textbf1 & \textbf{0,816} & \textbf{0,058} & \textbf{88 \%}\\
0 & 0 & 1 & 0,729 & 0,086 & 84 \%\\
0 & 0 & 1 & 0,473 & 0,150 & 71 \%\\
1 & 0 & 1 & 0,239 & 0,295 & 46 \%\\
1 & 0 & 1 & 0,621 & 0,097 & 75 \%\\
0 & 0 & 1 & 0,322 & 0,188 & 63 \%\\
0 & 1 & 0 & 0,637 & 0,075 & 81 \%\\
0 & 1 & 0 & 0,313 & 0,322 & 53 \%\\
1 & 0 & 0 & 0,512 & 0,272 & 61 \%\\
0 & 0 & 1 & 0,555 & 0,211 & 70 \%\\
1 & 0 & 0 & 0,265 & 0,369 & 44 \%\\
0 & 0 & 1 & 0,659 & 0,086 & 81 \%\\ \bottomrule
\end{tabular}
\caption{Paramètres d'inattention et de chance pour la q-matrice du jeu de données ECPE. Les valeurs les plus hautes sont indiquées en gras.}
\label{guess}
\end{table}

### TIMSS

\begin{figure}[h]
\small
\centering
\includegraphics[width=0.8\textwidth]{figures/genma/timss-mean}
%\includegraphics[width=0.5\textwidth]{figures/genma/timss-count}
\caption{Évolution de la \emph{log loss} en fonction du nombre de questions posées, pour le jeu de données TIMSS.}
\label{genma-timss}
\end{figure}

\begin{table}[h]
\small
\begin{tabular}{cccc} \toprule
& Après 4 questions & Après 8 questions & Après 11 questions\\ \midrule
Rasch & $0,576 \pm 0,008$ (70 \%) & $0,559 \pm 0,008$ (71 \%) & $0,555 \pm 0,008$ (71 \%)\\
DINA & $0,588 \pm 0,005$ (68 \%) & $0,57 \pm 0,006$ (70 \%) & $0,566 \pm 0,006$ (70 \%)\\
GenMA & $0,537 \pm 0,006$ (72 \%) & $0,505 \pm 0,006$ (75 \%) & $0,487 \pm 0,006$ (77 \%)\\
MIRT & $0,53 \pm 0,008$ (73 \%) & $0,509 \pm 0,008$ (75 \%) & $0,503 \pm 0,008$ (75 \%)\\ \bottomrule
\end{tabular}
\caption{Valeurs obtenues sur le jeu de données TIMSS.}
\label{genma-timss-table}
\end{table}

Dans la figure \ref{genma-timss}, Rasch a une erreur plus faible que DINA. Dès 4 questions, GenMA a une erreur beaucoup plus faible, comparable à celle obtenue par MIRT.

Les modèles Rasch, DINA et MIRT convergent en 4 questions, tandis que GenMA continue à affiner son diagnostic : à la 11\ieme{} question, GenMA est le modèle le plus précis, car il prédit correctement 77 % des réponses sur l'ensemble de validation (voir table \ref{genma-timss-table}).

MIRT a une bonne propriété de généralisation à partir de peu de questions mais le diagnostic en deux dimensions qu'il crée n'est pas formatif, car ses dimensions ne sont pas interprétables sans intervention d'un expert. En revanche, les 13 dimensions du modèle GenMA correspondent chacune à une composante de connaissances de la matrice.

# Conclusion

Dans ce chapitre, nous avons proposé un modèle hybride de tests adaptatifs, que nous avons validé en utilisant plusieurs jeux de données réelles, au moyen de notre système de comparaison défini à la section \vref{comp-cat}.

Comme indiqué dans la comparaison qualitative, le modèle MIRT ne peut pas facilement converger lorsqu'on le lance sur un grand nombre de dimensions. GenMA en revanche estime un nombre plus faible de paramètres, seulement ceux qui font le lien entre les questions et les composantes de connaissances (CC). C'est pourquoi il est possible de calibrer un modèle de plus grande dimension et faire un diagnostic plus riche à l'apprenant pour s'améliorer. GenMA est ainsi un modèle semi-automatique : un expert peut spécifier une q-matrice pour orienter la calibration des paramètres.

À présent que nous avons identifié un bon modèle pour faire du diagnostic adaptatif de connaissances, nous allons comparer différentes stratégies pour choisir les premières questions à poser dans un test.
