# Un prétest non adaptatif

Une variante des tests adaptatifs appelée *test à étapes multiples* consiste à poser un groupe de questions avant de choisir le groupe suivant, et ainsi de suite, plutôt que d'adapter le processus après chaque question. Cela permet d'avoir plus d'information sur l'apprenant avant de réaliser la première estimation de son niveau. De plus, cela permet à l'apprenant d'avoir plus de recul sur les exercices qui lui sont posés et de se relire avant de lancer le processus adaptatif, plutôt que d'obtenir des questions portant sur des CC diverses question après question.

Ainsi, le problème devient : comment choisir les $k$ premières questions à présenter à un nouveau venu ? Elles doivent porter sur des sujets diversifiés afin de varier le plus possible l'information obtenue.

## Visualisation géométrique d'un test adaptatif

Pour mieux comprendre notre approche, voici une interprétation géométrique de ce qu'il se passe lorsqu'un test adaptatif multidimensionnel est administré.

Pour rappel, la phase d'apprentissage d'un modèle TRIM de dimension $K$ consiste à déterminer un vecteur $\mathbf{d_j} = (d_{j1}, \ldots, d_{jK})$ comme paramètre de chaque question $j$ et un vecteur $\mathbf{\theta_i} = (\theta_{i1}, \ldots, \theta_{iK})$ pour chaque apprenant $i$. La probabilité qu'un apprenant $i$ réponde correctement à une question $j$ est ensuite donnée par l'expression $\Phi(\mathbf{\theta_i} \cdot \mathbf{d_j}))$. Pour visualiser, on peut représenter les questions par des points à coordonnées $(d_{j1}, \ldots, d_{jK})$ pour chaque $j$ et l'apprenant $i$ par le vecteur $\theta_i$. Les questions qui ont le plus de chances d'être résolues par l'apprenant correspondent aux points le plus dans la direction de $\theta_i$, voir la figure \ref{viz-mirt}.

\begin{figure}
\centering
\includegraphics[width=\linewidth]{figures/2d}
\caption{Test adaptatif en 2 dimensions}
\label{viz-mirt}
\end{figure}

Ainsi, poser un jeu de $k$ questions revient à choisir $k$ points de l'espace à présenter à l'apprenant, ce qui permettra après étiquetage par succès/échec en fonction de ses réponses de déterminer une première estimation de son vecteur de niveau $\mathbf{\theta}$.

Pour estimer les paramètres de l'apprenant, on souhaite choisir l'estimateur du maximum de vraisemblance. Mais si les réponses que l'apprenant a faites jusque-là sont toutes correctes ou toutes incorrectes, l'estimateur tend vers $\pm \infty$ et il faut choisir un autre estimateur. Ce problème avait déjà été mis en évidence par @Lan2014 et par @Magis2015.

## Stratégies de choix de $k$ questions

Aléatoire

:   Une première méthode naïve consiste à choisir $k$ questions au hasard.

<!-- un modèle qui donne la probabilité -->

Incertitude maximale

:   Une des méthodes en apprentissage automatique consiste à choisir les questions les plus incertaines, c'est-à-dire celles de probabilité prédite la plus proche de 0,5. Toutefois, cela risque d'apporter de l'information redondante [@Hoi2006].

Déterminant maximal

:   Une façon de choisir des questions peu corrélées les unes des autres consiste à choisir un ensemble de questions dont le parallélotope forme un grand volume. Le volume d'un parallélotope formé par des vecteurs $V = (\mathbf{v_1}, \ldots, \mathbf{v_n})$ où $\mathbf{v_1}, \ldots, \mathbf{v_n}$ sont les lignes de la matrice $V$, est donné par $Vol(\{\mathbf{v_i}\}_{i = 1, \ldots, n}) = \sqrt{\det V V^T}$.

# Processus à point déterminantal

Nous allons présenter une loi de probabilité, tirée de la théorie des matrices aléatoires, qui a récemment été appliquée en apprentissage automatique [@Kulesza2012]. Cette loi permet, étant donné des objets munis de caractéristiques, d'échantillonner efficacement des éléments \og diversifiés \fg{} pour une certaine mesure de distance. Cela a par exemple des applications en recommandation pour sélectionner des produits diversifiés, dans les moteurs de recherche afin que les résultats en tête de la recherche portent sur des thèmes différents (par exemple, pour une requête « jaguar », l'animal et la voiture) ou encore en génération automatique de résumé, à partir d'un corpus de textes, par exemple des articles de presse dont on souhaiterait sélectionner les thèmes principaux.

Implémenter cet échantillonnage requiert la donnée d'une valeur de similarité pour chaque paire d'éléments à échantillonner d'un ensemble $X = \{\mathbf{x_1}, \ldots, \mathbf{x_n}\}$ : une matrice symétrique $L$ telle que $L_{ij} = K(\mathbf{x_i}, \mathbf{x_j})$ où $K$ est la fonction (noyau, donc symétrique) de similarité. Pour nos usages, nous avons utilisé le simple noyau linéaire $K(\mathbf{x_i}, \mathbf{x_j}) = \mathbf{x_i} \cdot \mathbf{x_j}$, mais il est possible d'utiliser le noyau gaussien :

$$ K(\mathbf{x_i}, \mathbf{x_j}) = \exp\left(-\frac{{||\mathbf{x_i} - \mathbf{x_j}||}^2}{2\sigma^2}\right). $$

À titre d'exemple, la Figure \ref{dpp-u} montre ce qu'on obtient si l'on échantillonne selon un processus à point déterminantal des points équirépartis sur le cercle unité en dimension 2. On voit que la méthode PPD échantillonne des points plus éloignés les uns des autres qu'un échantillonnage selon une loi uniforme. Les points échantillonnés avec le noyau gaussien sont davantage répulsifs sur cet exemple.

\begin{figure}
\includegraphics[width=\linewidth]{figures/dpp-u.png}
\caption{Points échantillonnés sur le cercle unité. À gauche, les points sont choisis aléatoirement, selon une loi uniforme. Au milieu, les points sont échantillons sont tirés selon un PPD avec noyau gaussien. À droite, l'échantillonnage se fait selon un PPD avec noyau linéaire.}
\label{dpp-u}
\end{figure}

Formellement, $P$ est un processus à point déterminantal (PPD) s'il vérifie pour tout ensemble $Y \subset \{1, \ldots, n\}$ :\nomenclature{PPD}{processus à point déterminantal}

$$ Pr(Y \subset X) \propto \det L_Y $$

\noindent
où $L_Y$ est la sous-matrice carrée de $L$ indexée par les éléments de $Y$ en ligne et colonne.

Dans notre cas, cette loi est intéressante car des éléments seront tirés avec une probabilité proportionnelle au carré du volume du parallélotope qu'ils forment. En effet, chaque élément $\ell_{ij}$ de la matrice $L$ vaut $\ell_{ij} = K(\mathbf{x_i}, \mathbf{x_j}) = \mathbf{x_i} \cdot \mathbf{x_j}$ donc si on note $B$ la matrice ayant pour lignes $\mathbf{x_1}, \ldots, \mathbf{x_n}$, on a $L = B B^T$. Si à présent on note $B_Y$ la matrice ayant pour lignes les $\mathbf{x_i}$ pour $i$ appartenant à $Y$, $L_Y = B_Y B_Y^T$ et donc $Pr(Y \subset X) \propto \det L_Y = \det B_Y B_Y^T = {Vol(\{\mathbf{x_i}\}_{i \in Y})}^2.$

Or, plus le volume d'un ensemble de vecteurs est grand, moins ces vecteurs sont corrélés. Ainsi, des éléments diversifiés auront plus de chances d'être tirés par un PPD. On peut encore le voir de la façon suivante : des vecteurs de questions similaires apportent une information similaire. Afin d'avoir le plus d'information possible au début du test il vaut mieux choisir des vecteurs écartés deux à deux.

Il existe des algorithmes efficaces pour échantillonner selon une PPD [@Kulesza2012], y compris lorsqu'on fixe à l'avance le nombre d'éléments qu'on souhaite sélectionner ($k$-PPD) : la complexité de tirage est $O(nk^3)$ où $n$ est le nombre de questions, à condition d'avoir calculé la diagonalisation de la matrice $L$ au préalable, ce qui peut se faire avec une complexité $O(N^3)$ par exemple avec la méthode de Gauss-Jordan. En revanche, le problème de déterminer le mode de cette distribution (c'est-à-dire l'ensemble $X$ de plus grande probabilité a posteriori) est un problème NP-difficile, c'est pourquoi des algorithmes d'approximation ont été développés. Ce n'est que récemment que les PPD sont appliqués à l'apprentissage statistique, mais surtout à des méthodes de diversification et de résumé.

Un autre avantage de cette méthode est que le choix de $k$ questions est probabiliste, ainsi on ne pose pas nécessairement les mêmes $k$ premières questions à tous les apprenants, ce qui présente certains avantages : sécurité, diversification de la banque de questions.

# InitialD

Notre contribution consiste à appliquer la méthode de tirage d'éléments diversifiés selon un PPD au choix de questions diversifiées au début d'un test, de façon automatique.

Étant donné un calibrage de type TRIM, et donc une représentation distribuée des $n$ questions du test en dimension $d$, on tire $k$ questions parmi celles-là selon PPD. Nous faisons l'hypothèse que les questions ainsi choisies seront peu redondantes, donc constitueront un bon résumé des questions du test pour l'apprenant.

Ainsi, nos éléments à tirer sont les questions qui sont des vecteurs de dimensions $d$ : si TRIM a réalisé la factorisation $M \simeq \Phi(\Theta D^T)$, alors les lignes de $D$ sont les vecteurs $(\mathbf{d_1}, \ldots, \mathbf{d_n})$ correspondant aux questions et $L = D D^T$ est la matrice de similarité dont l'élément $(i, j)$ vaut $\mathbf{d_i} \cdot \mathbf{d_j}$.

L'algorithme de tirage est tiré de [@Kulesza2012] et est implémenté en Python. Sa complexité est $O(nk^3)$ où $k$ est le nombre de questions sélectionnées et $n$ est le nombre de questions du test, après une coûteuse étape de diagonalisation de complexité $O(n^3)$. Ainsi, cette complexité convient à une grande base de questions comme peut l'être celle sur un MOOC.

# Validation

À partir des données dichotomiques des apprenants, nous allons comparer trois stratégies pour choisir les $k$ premières questions, selon une méthode \textsc{FirstBulk} qui renvoie un ensemble de $k$ questions en fonction du paramètre a priori de l'apprenant.

Comme modèle de l'apprenant, nous choisissons les paramètres calibrés par la première phase de GenMA.

## Stratégies comparées

Nous avons comparé quatre stratégies. Les trois premières ne sont pas adaptatives, la quatrième l'est.

Random

:   Les questions sont choisies au hasard.

Uncertainty

:   On suppose que l'apprenant est du niveau moyen de l'historique et on choisit $k$ questions de probabilité estimée proche de 0,5, c'est-à-dire d'incertitude maximale.

InitialD

:   L'algorithme présenté à la section précédente qui choisit les $k$ questions selon un processus à point déterminantal.

CAT

:   Enfin, nous ajoutons à ces trois stratégies la sélection adaptative habituelle, question par question, afin de comparer nos trois stratégies non adaptatives à la stratégie adaptative.

## Protocole expérimental

La méthode que nous avons utilisée est similaire à celle de validation bicroisée présentée à la section \ref{algo}. Nous séparons les apprenants en deux ensembles d'entraînement et de test (80 % et 20 %) et calibrons le modèle GenMA avec les apprenants d'entraînement. Puis, pour chaque apprenant de test, nous choisissons $k$ premières questions à poser, récoltons ses réponses et estimons son vecteur de niveau, cf. algorithme \ref{simu-pretest}.

Nous mesurons alors les différentes valeurs, pour différentes valeurs du nombre de questions $k$ :

- quelle est la performance des prédictions qui découlent de ce premier groupe de questions : log loss et nombre de prédictions incorrectes ;
- quelle est la différence entre le paramètre estimé à partir de $k$ questions et le paramètre estimé lorsqu'on a posé toutes les questions ; cette valeur est calculée par @Lan2014 pour comparer les méthodes de sélection de questions.

Pour les jeux de données Fraction et TIMSS, grâce aux q-matrices et au modèle GenMA nous obtenons une représentation distribuée des questions de dimension 8, que nous utilisons pour calculer la matrice de similarité et échantillonner les questions.

\begin{algorithm}
\begin{algorithmic}
\Procedure{SimulerPretest}{$train, test$}
\State $\alpha \gets \Call{TrainingStep}{train}$
\State $t \gets 0$
\For{tout étudiant $s$ de l'ensemble de $test$}
    \For{$k$ de 0 à $|Q| - 1$}
        \State $\pi \gets \Call{PriorInitialization}$
        \State $S \gets \Call{FirstBulk}{k, \alpha, \pi}$
        \State Poser les questions $S = (q_i)_{i = 1, \ldots, k}$ à l'apprenant $s$
        \State Récupérer les valeurs de succès ou échec correspondantes $(r_i)_{i = 1, \ldots, k}$ de sa réponse
        \State $\pi \gets \Call{EstimateParameters}{\{(q_i, r_i)\}_{i = 1, \ldots, k}, \alpha}$
        \State $p \gets$ \Call{PredictPerformance}{$\alpha, \pi$}
        \State $\Sigma \gets$ \Call{EvaluatePerformance}{$p$}
    \EndFor
\EndFor
\EndProcedure
\end{algorithmic}
\caption{Simulation de prétests non adaptatifs}
\label{simu-pretest}
\end{algorithm}

## Résultats

Les résultats sont donnés dans les figures \ref{initiald-timss-mean} à \ref{initiald-fraction-delta}.

\begin{figure}
\footnotesize
\centering
\includegraphics[width=\linewidth]{figures/initiald-timss-mean}
\begin{tabular}{cccc}
& Après 3 questions & Après 12 questions & Après 20 questions\\
CAT & $1.081 \pm 0.047$ (62 \%) & $0.875 \pm 0.05$ (66 \%) & $0.603 \pm 0.041$ (75 \%)\\
Uncertainty & $1.098 \pm 0.048$ (58 \%) & $0.981 \pm 0.046$ (68 \%) & $0.714 \pm 0.048$ (72 \%)\\
InitialD & $\mathbf{0.793 \pm 0.034}$ (61 \%) & $\mathbf{0.582 \pm 0.023}$ (70 \%) & $\mathbf{0.494 \pm 0.015}$ (74 \%)\\
Random & $1.019 \pm 0.05$ (58 \%) & $0.705 \pm 0.035$ (68 \%) & $\mathbf{0.512 \pm 0.017}$ (74 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne du modèle GenMA après qu'un certain nombre de questions ont été posées selon certaines stratégies pour le jeu de données TIMSS. Entre parenthèses, le nombre de prédictions incorrectes.}
\label{initiald-timss-mean}
\end{figure}

Dans la figure \ref{initiald-timss-mean}, InitialD est bien meilleur que Random, bien meilleur que CAT, bien meilleur que Uncertainty. Dans les premières questions, CAT a une erreur comparable à celle de Uncertainty, car les deux modèles choisissent la question de probabilité la plus proche de 0,5. Mais InitialD explore davantage en choisissant un groupe de questions diversifiées.

\begin{figure}
\footnotesize
\centering
\includegraphics[width=\linewidth]{figures/initiald-timss-delta}
\begin{tabular}{cccc}
& Après 3 questions & Après 12 questions & Après 20 questions\\
CAT & $1.894 \pm 0.05$ & $1.224 \pm 0.046$ & $\mathbf{0.464 \pm 0.055}$\\
Uncertainty & $1.937 \pm 0.049$ & $1.48 \pm 0.047$ & $0.629 \pm 0.062$\\
InitialD & $1.845 \pm 0.051$ & $\mathbf{0.972 \pm 0.039}$ & $\mathbf{0.465 \pm 0.034}$\\
Random & $1.936 \pm 0.052$ & $1.317 \pm 0.048$ & $0.59 \pm 0.043$\\
\end{tabular}
\caption{Évolution de la distance au vrai paramètre après qu'un certain nombre de questions ont été posées selon certaines stratégies pour le jeu de données TIMSS.}
\label{initiald-timss-delta}
\end{figure}

Dans la figure \ref{initiald-timss-delta}, on voit que InitialD converge plus vite vers le vrai paramètre que les autres stratégies.

\begin{figure}
\footnotesize
\centering
\includegraphics[width=\linewidth]{figures/initiald-fraction-mean}
\begin{tabular}{cccc}
& Après 3 questions & Après 8 questions & Après 15 questions\\
CAT & $0.757 \pm 0.082$ (67 \%) & $0.515 \pm 0.06$ (82 \%) & $\mathbf{0.355 \pm 0.05}$ (88 \%)\\
Uncertainty & $0.882 \pm 0.095$ (72 \%) & $0.761 \pm 0.086$ (76 \%) & $0.517 \pm 0.067$ (86 \%)\\
InitialD & $\mathbf{0.608 \pm 0.055}$ (74 \%) & $\mathbf{0.376 \pm 0.027}$ (82 \%) & $\mathbf{0.302 \pm 0.023}$ (86 \%)\\
Random & $0.842 \pm 0.09$ (70 \%) & $0.543 \pm 0.07$ (80 \%) & $\mathbf{0.387 \pm 0.051}$ (86 \%)\\
\end{tabular}
\caption{Évolution de l'erreur moyenne du modèle GenMA après qu'un certain nombre de questions ont été posées selon certaines stratégies pour le jeu de données Fraction. Entre parenthèses, le nombre de prédictions incorrectes.}
\label{initiald-fraction-mean}
\end{figure}

Dans la figure \ref{initiald-fraction-mean}, InitialD est meilleur que les autres stratégies. Uncertainty est la stratégie de plus grande variance, tandis que Random a une erreur comparable à CAT.

\begin{figure}
\footnotesize
\centering
\includegraphics[width=\linewidth]{figures/initiald-fraction-delta}
\begin{tabular}{cccc}
& Après 3 questions & Après 8 questions & Après 15 questions\\
CAT & $1.446 \pm 0.094$ & $1.015 \pm 0.101$ & $\mathbf{0.355 \pm 0.103}$\\
Uncertainty & $1.495 \pm 0.103$ & $1.19 \pm 0.112$ & $0.638 \pm 0.119$\\
InitialD & $1.355 \pm 0.08$ & $\mathbf{0.859 \pm 0.058}$ & $0.502 \pm 0.047$\\
Random & $1.467 \pm 0.095$ & $1.075 \pm 0.089$ & $0.62 \pm 0.083$\\
\end{tabular}
\caption{Évolution de la distance au vrai paramètre après qu'un certain nombre de questions ont été posées selon certaines stratégies pour le jeu de données Fraction.}
\label{initiald-fraction-delta}
\end{figure}

Dans la figure \ref{initiald-fraction-delta}, le modèle qui converge le plus vite vers le vrai paramètre est InitialD pour la première moitié des questions, et CAT pour la deuxième moitié des questions, ce qui semble être un compromis entre choisir un groupe de questions avant de faire la première estimation, et adapter pour converger plus vite vers le vrai paramètre à estimer.

## Discussion et applications

Il est possible d'incorporer des caractéristiques telles que le contenu des questions pour avoir des vecteurs plus précis, en plus grande dimension. En filtrage collaboratif, c'est l'approche qu'adopte @Van2013 pour résoudre le problème du démarrage à froid de l'utilisateur. Pour leur système de recommandation de musiques, ils intègrent des informations supplémentaires telles que le contenu de la musique pour obtenir de meilleures représentations distribuées des musiques.

Si le nombre de questions à poser $k$, le nombre de questions disponibles $n$ et le nombre de dimensions $d$ sont des petites valeurs, il est possible de simuler tous les choix possibles de $k$ questions parmi $n$. Toutefois, en pratique, les banques de questions sur des plateformes de MOOC seront telles que la complexité de InitialD, $O(nk^3)$ après un précalcul de $O(n^3)$, sera un avantage.

La méthode proposée dans ce chapitre ne cherche pas à déterminer le meilleur ensemble de questions à poser, mais un bon ensemble aléatoire. Ajouter de l'aléa dans cette technique présente plusieurs avantages : les premières questions posées à chaque candidat ne sont pas les mêmes. Si cela constitue une surcharge supplémentaire lorsqu'on doit corriger manuellement les exercices des apprenants, en revanche lorsqu'ils sont administrés automatiquement sur une plateforme, cela permet d'éviter que les apprenants s'échangent les réponses ou que l'apprenant se lasse, ou tout simplement de trop utiliser les mêmes exercices de sa banque.

La stratégie InitialD peut être améliorée en ne tirant pas un seul ensemble de $k$ questions mais plusieurs, et en conservant le meilleur des échantillons. Tirer $\ell$ fois $k$ questions a une complexité $O(\ell nk^3)$, déterminer le meilleur ensemble a une complexité $O(\ell k^3)$. Faire plusieurs tirages augmente la probabilité de déterminer ainsi le meilleur ensemble de questions.

### Génération de testlets

Le test préalable peut être également appliqué à la génération d'une planche d'exercices \og diversifiée \fg{} étant donné un historique de réponses.

### Démarrage à froid de question

Cette méthode pourrait être appliquée au problème de démarrage à froid de la question : lorsqu'une nouvelle question est ajoutée à un test existant, on ne dispose d'aucune information concernant son niveau. Une méthode consiste à, de façon similaire, la poser à des apprenants qui ont des niveaux diversifiés pour estimer son paramètre. C'est l'approche qu'adopte @Anava2015 dans un contexte de filtrage collaboratif. On peut imaginer sur un MOOC repérer le nombre de personnes actuellement connectées et tirer un sous-ensemble d'apprenants à qui poser la question[^1].

 [^1]: Cela ressemble un peu à de la publicité ciblée, sauf qu'on ne connaît aucune information personnelle sur les apprenants.

# Conclusion

Dans ce chapitre, nous avons présenté une nouvelle manière de choisir les $k$ premières questions à administrer à un nouvel apprenant, via un algorithme probabiliste efficace tiré de la littérature en apprentissage automatique.

Grâce à la complexité de $O(nk^3)$ pour choisir $k$ questions à poser parmi $n$ (après un précalcul de complexité $O(n^3)$ qui peut être parallélisé car il s'agit d'une diagonalisation de matrice), notre méthode peut être appliquée à des grandes banques de questions, telles que celles que peut contenir un cours en ligne.

Également, nous avons mis en évidence qu'un processus non-adaptatif peut être utile pour les premières questions, tandis qu'une évaluation adaptative peut donner de meilleurs résultats plus loin dans le test. Il serait utile de comparer différentes stratégies de tests à étapes multiples.

Cette méthode peut convenir à un professeur cherchant à tirer un bon ensemble de $k$ questions à poser pour construire une planche d'exercices, pour un cours de travaux dirigés par exemple.
