## Caractérisation de la qualité d'un ensemble de questions

À la section \vref{mst}, nous avons mentionné les *tests à étapes multiples* qui consistent à poser un groupe de questions à l'apprenant, obtenir ses réponses en bloc, pour ensuite choisir le groupe suivant de questions à poser, plutôt que d'adapter le processus question après question. Cela permet d'avoir plus d'informations sur l'apprenant avant de réaliser la première estimation de son niveau qui permettra de choisir le groupe de questions suivant. De plus, cela permet à l'apprenant d'avoir plus de recul sur les exercices qui lui sont posés et de se relire avant de valider, plutôt que d'obtenir des questions portant sur des composantes de connaissances (CC) diverses question après question.

Ainsi, le problème devient : comment choisir les $k$ premières questions à présenter à un nouveau venu ? Elles doivent mesurer des CC diversifiées afin d'estimer au mieux le niveau de l'apprenant.

## Visualisation géométrique d'un test adaptatif

Pour mieux comprendre notre approche, voici une interprétation géométrique de ce qu'il se passe lorsqu'un test adaptatif multidimensionnel est administré.

Pour rappel, la phase d'apprentissage du modèle GenMA de dimension $K$ consiste à déterminer les caractéristiques $\boldsymbol{d_j} = (d_{j1}, \ldots, d_{jK})$ et $\delta_j$ de chaque question $j$ et les caractéristiques $\boldsymbol{\theta_i} = (\theta_{i1}, \ldots, \theta_{iK})$ de chaque apprenant $i$. La probabilité qu'un apprenant $i$ réponde correctement à une question $j$ est ensuite donnée par l'expression $\Phi(\boldsymbol{\theta_i} \cdot \boldsymbol{d_j})$. Pour visualiser, on peut représenter les questions par des points à coordonnées $(d_{j1}, \ldots, d_{jK})$ pour chaque $j$ et l'apprenant $i$ par le vecteur $\boldsymbol{\theta_i}$. Les questions qui ont le plus de chances d'être résolues par l'apprenant correspondent aux points qui se trouvent le plus dans la direction de $\boldsymbol{\theta_i}$.

Ainsi, poser un jeu de $k$ questions revient à choisir $k$ points de l'espace à présenter à l'apprenant, ce qui permettra après étiquetage par succès/échec en fonction de ses réponses de déterminer une première estimation de son vecteur de niveau $\boldsymbol{\theta}$.

Pour estimer les caractéristiques de l'apprenant, on souhaite choisir l'estimateur du maximum de vraisemblance. Mais si les réponses que l'apprenant a faites jusque-là sont toutes correctes ou toutes incorrectes, l'estimateur tend vers $\pm \infty$ et il faut choisir un autre estimateur. Ce problème avait déjà été mis en évidence par @Lan2014 et par @Magis2015.

## Stratégies de choix de $k$ questions

Aléatoire

:   Une première méthode naïve consiste à choisir $k$ questions au hasard.

Incertitude maximale

:   Une des méthodes en apprentissage automatique consiste à choisir les questions les plus incertaines, c'est-à-dire celles pour lesquelles la probabilité que l'apprenant réponde correctement est la plus proche de 0,5. Toutefois, cela risque d'apporter de l'information redondante [@Hoi2006].

Déterminant maximal

:   Une façon de choisir des questions peu corrélées les unes des autres consiste à choisir un ensemble de questions dont le parallélotope[^1] forme un grand volume. Le volume d'un parallélotope formé par des vecteurs $V = (\mathbf{v_1}, \ldots, \mathbf{v_n})$ où $\mathbf{v_1}, \ldots, \mathbf{v_n}$ sont les lignes de la matrice $V$, est donné par $Vol(\{\mathbf{v_i}\}_{i = 1, \ldots, n}) = \sqrt{\det V V^T}$.

 [^1]: Une généralisation du parallélogramme en dimension $n$ quelconque.

# Processus à point déterminantal

\label{dpp}

Nous allons présenter une loi de probabilité, tirée de la théorie des matrices aléatoires, qui a récemment été appliquée en apprentissage automatique [@Kulesza2012]. Cette loi permet, étant donné des objets munis de caractéristiques, d'échantillonner efficacement des éléments \og diversifiés \fg{} pour une certaine mesure de distance. Cela a par exemple des applications en recommandation pour sélectionner des produits diversifiés, dans les moteurs de recherche afin que les résultats en tête de la recherche portent sur des thèmes différents (par exemple, pour une requête « jaguar », l'animal et la voiture) ou encore en génération automatique de résumé, à partir d'un corpus de textes, par exemple des articles de presse dont on souhaiterait sélectionner les thèmes principaux.

Tout d'abord, il nous faut définir la notion de noyau, qui est une généralisation du produit scalaire. Soit $d \geq 1$ un entier, une fonction symétrique $K : \R^d \times \R^d \to \R$ est un *noyau* si pour tout $n$ entier, pour tous $\mathbf{x_1}, \ldots, \mathbf{x_n} \in \R^d$ et pour tous $(c_1, \ldots, c_n) \in \R^d$, $\sum_{i = 1}^n \sum_{j = 1}^n c_i c_j K(\mathbf{x_i}, \mathbf{x_j}) \geq 0.$\bigskip

Pour implémenter cet échantillonnage, il faut :

- un ensemble de $n$ éléments à échantillonner, identifiés par les indices $X = \{1, \ldots, n\}$
- pour chaque élément $i \in X$, un vecteur $\mathbf{x_i}$ de dimension $d$ correspondant aux caractéristiques de l'élément $i$ ;
- un noyau $K$ permettant de décrire une valeur de similarité pour chaque paire d'éléments. Ce noyau permet de définir une matrice symétrique $L$ telle que $L_{ij} = K(\mathbf{x_i}, \mathbf{x_j})$.\bigskip

Pour nos usages, nous avons utilisé le simple noyau linéaire $K(\mathbf{x_i}, \mathbf{x_j}) = \mathbf{x_i} \cdot \mathbf{x_j}$, mais il est possible d'utiliser le noyau gaussien :

\begin{equation}
K(\mathbf{x_i}, \mathbf{x_j}) = \exp\left(-\frac{{||\mathbf{x_i} - \mathbf{x_j}||}^2}{2\sigma^2}\right).
\end{equation}

\newacronym{ppd}{PPD}{processus à point déterminantal}

Formellement, un processus stochastique $Y \subset \{1, \ldots, n\}$ est un \gls{ppd} s'il vérifie pour tout ensemble $A \subset \{1, \ldots, n\}$ :

\begin{equation}
Pr(A \subset Y) \propto \det L_A
\end{equation}

\noindent
où $L_A$ est la sous-matrice carrée de $L$ indexée par les éléments de $A$ en ligne et colonne.

Dans notre cas, cette loi est intéressante car des éléments seront tirés avec une probabilité proportionnelle au carré du volume du parallélotope qu'ils forment. En effet, chaque élément $L_{ij}$ de la matrice $L$ vaut $L_{ij} = K(\mathbf{x_i}, \mathbf{x_j}) = \mathbf{x_i} \cdot \mathbf{x_j}$ donc si on note $B$ la matrice ayant pour lignes $\mathbf{x_1}, \ldots, \mathbf{x_n}$, on a $L = B B^T$. Si à présent on note $B_A$ la matrice ayant pour lignes les vecteurs $\mathbf{x_i}$ pour $i$ appartenant à $A$, $L_A = B_A B_A^T$ et donc $Pr(A \subset Y) \propto \det L_A = \det B_A B_A^T = {Vol(\{\mathbf{x_i}\}_{i \in A})}^2.$

Or, plus le volume d'un ensemble de vecteurs est grand, moins ces vecteurs sont corrélés. Ainsi, des éléments diversifiés auront plus de chances d'être tirés par un PPD. On peut encore le voir de la façon suivante : des vecteurs de questions similaires apportent une information similaire. Afin d'avoir le plus d'information possible au début du test il vaut mieux choisir des vecteurs écartés deux à deux.

Il existe des algorithmes efficaces pour échantillonner selon une PPD [@Kulesza2012], y compris lorsqu'on fixe à l'avance le nombre d'éléments qu'on souhaite sélectionner ($k$-PPD) : la complexité de tirage est $O(nk^3)$ où $n$ est le nombre de questions, à condition d'avoir calculé la diagonalisation de la matrice $L$ au préalable, ce qui peut se faire avec une complexité $O(n^3)$ par exemple avec la méthode de Gauss-Jordan. En revanche, le problème de déterminer le mode de cette distribution (c'est-à-dire l'ensemble $X$ de plus grande probabilité a posteriori) est un problème NP-difficile, c'est pourquoi des algorithmes d'approximation ont été développés. Ce n'est que récemment que les PPD sont appliqués à l'apprentissage statistique, mais surtout à des méthodes de diversification et de résumé.

Un autre avantage de cette méthode est que le choix de $k$ questions est probabiliste, ainsi on ne pose pas nécessairement les mêmes $k$ premières questions à tous les apprenants, ce qui présente certains avantages en termes de sécurité et de diversification de la banque de questions.

# Description de la stratégie InitialD

Notre contribution consiste à appliquer la méthode de tirage d'éléments diversifiés selon un PPD au choix de questions diversifiées au début d'un test, de façon automatique.

Étant donné des données d'apprenants $D$ correspondant à des succès et échecs de $m$ apprenants sur $n$ questions, et une q-matrice de taille $n \times K$, on calibre un modèle GenMA. On extrait donc des caractéristiques en dimension $K$ pour chacune des $n$ questions du test : chaque question $j$ a pour caractéristiques le vecteur $\boldsymbol{d_j} = (d_{j1}, \ldots, d_{jK})$.

La stratégie InitialD consiste à considérer les questions $X = \{1, \ldots, n\}$ et pour chaque question $j$ les caractéristiques $\boldsymbol{d_j} = (d_{j1}, \ldots, d_{jK})$. Le noyau choisi est le noyau linéaire : $K(\mathbf{d_i}, \boldsymbol{d_j}) = \mathbf{d_i} \cdot \boldsymbol{d_j}$, et nous cherchons à tirer $k$ questions parmi les $n$ selon un PPD. Nous faisons l'hypothèse que les questions ainsi choisies seront peu redondantes, donc constitueront un bon résumé des questions du test pour l'apprenant.

L'algorithme de tirage est tiré de [@Kulesza2012] et est implémenté en Python. Sa complexité est $O(nk^3)$ où $k$ est le nombre de questions sélectionnées et $n$ est le nombre de questions du test, après une coûteuse étape de diagonalisation de complexité $O(n^3)$. Ainsi, cette complexité convient à une grande base de questions comme peut l'être celle sur un MOOC, car l'étape de tirage est linéaire en le nombre de questions de la banque.

# Validation

À partir d'un jeu de données réelles des réponses des apprenants, nous allons comparer quatre stratégies pour choisir les $k$ premières questions. Le modèle de test adaptatif considéré est GenMA.

## Stratégies comparées

Nous avons comparé quatre stratégies. Les trois premières ne sont pas adaptatives, la quatrième l'est. Chacune des 3 premières correspond donc à une implémentation de la fonction \textsc{FirstBundle}.

Random

:   Les questions sont choisies au hasard.

Uncertainty

:   On suppose que l'apprenant est de niveau initial $(0, \ldots, 0)$ et on choisit $k$ questions de probabilité estimée proche de 0,5, c'est-à-dire d'incertitude maximale.

InitialD

:   L'algorithme présenté à la section précédente qui choisit les $k$ questions selon un processus à point déterminantal.

CAT

:   Enfin, nous ajoutons à ces trois stratégies la sélection adaptative habituelle, question par question, afin de comparer nos trois stratégies non adaptatives aux métriques obtenues avec la stratégie adaptative.

## Jeux de données réelles

Pour les jeux de données Fraction et TIMSS, grâce aux q-matrices et au modèle GenMA nous obtenons une représentation distribuée des questions de dimension 8, que nous utilisons pour calculer la matrice de similarité et échantillonner les questions.

## Protocole expérimental

Notre protocole est similaire à celui développé pour la comparaison de modèles de tests adaptatifs à la section \vref{comp-cat}, à l'exception d'une méthode \textsc{FirstBundle} qui prend en argument la stratégie $S$ choisie, le nombre de questions à poser $k$, les caractéristiques des questions $(\boldsymbol{d_j})_{j = 1, \ldots, n}$ et $(\delta_j)_{j = 1, \ldots, n}$, les caractéristiques initiales de l'apprenant $\boldsymbol{\theta} = (0, \ldots, 0) \in \R^K$ et renvoie un ensemble $Y$ de $k$ questions à poser à l'apprenant. Contrairement au chapitre précédent, ici nous ne comparons plus des modèles différents mais des stratégies différentes pour le même modèle GenMA.

Nous séparons les apprenants en deux ensembles d'entraînement et de test (80 % et 20 %) et calibrons le modèle GenMA avec les apprenants d'entraînement. Puis, pour chaque apprenant de test, nous choisissons $k$ premières questions à poser, récoltons ses réponses et estimons son vecteur de niveau (voir algorithme \ref{simu-pretest}).

Nous mesurons alors deux métriques, pour différentes valeurs du nombre de questions $k$.

### Qualité du diagnostic

Quelle est la performance des prédictions qui découlent de ce premier groupe de questions, en termes de *log loss* et de nombre de prédictions incorrectes ?

### Distance au diagnostic final

\label{delta}

Quelle est la différence entre le paramètre estimé à partir de $k$ questions et le paramètre estimé lorsqu'on a posé toutes les questions ? Cette valeur est calculée par @Lan2014 pour comparer les méthodes de sélection de questions.

\begin{algorithm}
\begin{algorithmic}
\Procedure{SimulatePretest}{stratégie $S$, $I_{train}$, $I_{test}$}
\State $(\boldsymbol{d_j})_j, (\delta_j)_j \gets \Call{TrainingStep}{D[I_{train}]}$
\For{tout apprenant $s$ de l'ensemble $I_{test}$}
    \For{$k$ de 1 à $n$}
        \State $\theta \gets \Call{PriorInitialization}$
        \State $Y \gets \Call{FirstBundle}{S, k, (\boldsymbol{d_j})_j, (\delta_j)_j, \theta}$
        \State Poser les questions $Y$ à l'apprenant $s$
        \State Récupérer les valeurs de succès ou échec correspondantes $(r_i)_{i \in Y}$ de ses réponses
        \State $\theta \gets \Call{EstimateParameters}{\{(i, r_i)\}_{i \in Y}, \theta}$
        \State $p \gets$ \Call{PredictPerformance}{$\theta, (\boldsymbol{d_j})_{j}$}
        \State $\sigma_k \gets$ \Call{EvaluatePerformance}{$p, D[s], \theta$}
    \EndFor
\EndFor
\EndProcedure
\end{algorithmic}
\caption{Simulation de choix des $k$ premières questions}
\label{simu-pretest}
\end{algorithm}

## Résultats

Les résultats sont donnés dans les figures \ref{initiald-timss-mean} à \ref{initiald-fraction-delta}.

### TIMSS

\begin{figure}[ht]
\centering
\includegraphics[width=\reducefigs\linewidth]{figures/initiald/timss-mean}
\caption{\emph{Log loss} du modèle GenMA après qu'un groupe de questions a été posé selon certaines stratégies pour le jeu de données TIMSS.}
\label{initiald-timss-mean}
%\end{figure}

%\begin{table}[ht]
\footnotesize
%\centering
\begin{tabular}{cccc} \toprule
& Après 3 questions & Après 12 questions & Après 20 questions\\ \midrule
CAT & $1,081 \pm 0,047$ (62 \%) & $0,875 \pm 0,050$ (66 \%) & $0,603 \pm 0,041$ (75 \%)\\
Uncertainty & $1,098 \pm 0,048$ (58 \%) & $0,981 \pm 0,046$ (68 \%) & $0,714 \pm 0,048$ (72 \%)\\
InitialD & $\mathbf{0,793 \pm 0,034}$ (61 \%) & $\mathbf{0,582 \pm 0,023}$ (70 \%) & $\mathbf{0,494 \pm 0,015}$ (74 \%)\\
Random & $1,019 \pm 0,050$ (58 \%) & $0,705 \pm 0,035$ (68 \%) & $\mathbf{0,512 \pm 0,017}$ (74 \%)\\ \bottomrule
\end{tabular}
\captionof{table}{Valeurs de \emph{log loss} obtenues pour le jeu de données TIMSS.}
\label{initiald-timss-mean-table}
\end{figure}

Dans la figure \ref{initiald-timss-mean}, InitialD est bien meilleur que Random, bien meilleur que CAT, bien meilleur que Uncertainty (voir \ref{initiald-timss-mean-table}). Dans les premières questions, CAT a une erreur comparable à celle de Uncertainty, car les deux modèles choisissent la question pour laquelle la probabilité que l'apprenant y réponde correctement est la plus proche de 0,5. Mais InitialD explore davantage en choisissant un groupe de questions diversifiées.

Dès la première question, InitialD a une meilleure performance. C'est parce que choisir la question de plus grand \og volume \fg{} correspond à choisir la question dont le vecteur caractéristique a la plus grande norme, ou encore : la question la plus discriminante.

\begin{figure}[ht]
\centering
\includegraphics[width=\reducefigs\linewidth]{figures/initiald/timss-delta}
\captionof{figure}{Distance au diagnostic final après qu'un groupe de questions a été posée selon certaines stratégies pour le jeu de données TIMSS.}
\label{initiald-timss-delta}
%\end{figure}

%\begin{table}[ht]
\footnotesize
%\centering
\begin{tabular}{cccc} \toprule
& Après 3 questions & Après 12 questions & Après 20 questions\\ \midrule
CAT & $1,894 \pm 0,050$ & $1,224 \pm 0,046$ & $\mathbf{0,464 \pm 0,055}$\\
Uncertainty & $1,937 \pm 0,049$ & $1,480 \pm 0,047$ & $0,629 \pm 0,062$\\
InitialD & $1,845 \pm 0,051$ & $\mathbf{0,972 \pm 0,039}$ & $\mathbf{0,465 \pm 0,034}$\\
Random & $1,936 \pm 0,052$ & $1,317 \pm 0,048$ & $0,590 \pm 0,043$\\ \bottomrule
\end{tabular}
\captionof{table}{Distances au diagnostic final obtenues pour le jeu de données TIMSS.}
\label{initiald-timss-delta-table}
\end{figure}

Dans la figure \ref{initiald-timss-delta}, on voit que InitialD converge plus vite vers le vrai paramètre que les autres stratégies (voir \ref{initiald-timss-delta-table}).

### Fraction

\begin{figure}[ht]
\centering
\includegraphics[width=\reducefigs\linewidth]{figures/initiald/fraction-mean}
\captionof{figure}{\emph{Log loss} du modèle GenMA après qu'un groupe de questions a été posé selon certaines stratégies pour le jeu de données Fraction.}
\label{initiald-fraction-mean}
%\end{figure}

%\begin{table}[ht]
\footnotesize
%\centering
\begin{tabular}{cccc} \toprule
& Après 3 questions & Après 8 questions & Après 15 questions\\ \midrule
CAT & $0,757 \pm 0,082$ (67 \%) & $0,515 \pm 0,060$ (82 \%) & $\mathbf{0,355 \pm 0,050}$ (88 \%)\\
Uncertainty & $0,882 \pm 0,095$ (72 \%) & $0,761 \pm 0,086$ (76 \%) & $0,517 \pm 0,067$ (86 \%)\\
InitialD & $\mathbf{0,608 \pm 0,055}$ (74 \%) & $\mathbf{0,376 \pm 0,027}$ (82 \%) & $\mathbf{0,302 \pm 0,023}$ (86 \%)\\
Random & $0,842 \pm 0,090$ (70 \%) & $0,543 \pm 0,070$ (80 \%) & $\mathbf{0,387 \pm 0,051}$ (86 \%)\\ \bottomrule
\end{tabular}
\captionof{table}{Valeurs de \emph{log loss} obtenues pour le jeu de données Fraction.}
\label{initiald-fraction-mean-table}
\end{figure}

Dans la figure \ref{initiald-fraction-mean}, InitialD est meilleur que les autres stratégies. Uncertainty est la stratégie de plus grande variance, tandis que Random a une erreur comparable à CAT (voir \ref{initiald-fraction-mean-table}).

\begin{figure}[ht]
\centering
\includegraphics[width=\reducefigs\linewidth]{figures/initiald/fraction-delta}
\captionof{figure}{Distance au diagnostic final après qu'un groupe de questions a été posée selon certaines stratégies pour le jeu de données Fraction.}
\label{initiald-fraction-delta}
%\end{figure}

%\begin{table}[ht]
\footnotesize
%\centering
\begin{tabular}{cccc} \toprule
& Après 3 questions & Après 8 questions & Après 15 questions\\ \midrule
CAT & $1,446 \pm 0,094$ & $1,015 \pm 0,101$ & $\mathbf{0,355 \pm 0,103}$\\
Uncertainty & $1,495 \pm 0,103$ & $1,190 \pm 0,112$ & $0,638 \pm 0,119$\\
InitialD & $1,355 \pm 0,080$ & $\mathbf{0,859 \pm 0,058}$ & $0,502 \pm 0,047$\\
Random & $1,467 \pm 0,095$ & $1,075 \pm 0,089$ & $0,620 \pm 0,083$\\ \bottomrule
\end{tabular}
\captionof{table}{Distances au diagnostic final obtenues pour le jeu de données Fraction.}
\label{initiald-fraction-delta-table}
\end{figure}

Dans la figure \ref{initiald-fraction-delta}, le modèle qui converge le plus vite vers le vrai paramètre est InitialD pour la première moitié des questions, et CAT pour la deuxième moitié des questions, ce qui semble être un compromis entre choisir un groupe de questions avant de faire la première estimation, et adapter pour converger plus vite vers le vrai paramètre à estimer (voir \ref{initiald-fraction-delta-table}).

## Discussion et applications

Si le nombre de questions à poser $k$, le nombre de questions disponibles $n$ et le nombre de dimensions $d$ sont des petites valeurs, il est possible de simuler tous les choix possibles de $k$ questions parmi $n$. Toutefois, en pratique, les banques de questions sur des plateformes de MOOC seront telles que la complexité de InitialD, $O(nk^3)$ après un précalcul de $O(n^3)$, sera un avantage.

La méthode proposée dans ce chapitre ne cherche pas à déterminer le meilleur ensemble de questions à poser, mais un bon ensemble de questions tiré au hasard. Ajouter de l'aléa dans cette technique présente plusieurs avantages : les premières questions posées à chaque candidat ne sont pas les mêmes. Si cela constitue une surcharge supplémentaire lorsqu'on doit corriger manuellement les exercices des apprenants, en revanche lorsqu'ils sont administrés automatiquement sur une plateforme, cela permet d'éviter que les apprenants ne s'échangent les réponses, ou de trop utiliser les mêmes exercices de sa banque.

La stratégie InitialD peut être améliorée en ne tirant pas un seul ensemble de $k$ questions mais plusieurs, et en conservant le meilleur des échantillons. Tirer $\ell$ fois $k$ questions a une complexité $O(\ell nk^3)$, déterminer le meilleur ensemble a une complexité $O(\ell k^3)$. Faire plusieurs tirages augmente la probabilité de déterminer ainsi le meilleur ensemble de questions.

### Génération automatique de fiches d'exercices

Le test préalable peut être également appliqué à la génération d'une fiche d'exercices \og diversifiée \fg{} étant donné un historique de réponses.

### Démarrage à froid de question

Cette méthode pourrait être appliquée au problème de démarrage à froid de la question : lorsqu'une nouvelle question est ajoutée à un test existant, on ne dispose d'aucune information concernant son niveau. Une méthode consiste à, de façon similaire, la poser à des apprenants qui ont des niveaux diversifiés pour estimer ses caractéristiques. C'est l'approche qu'adoptent @Anava2015 dans un contexte de filtrage collaboratif. On peut imaginer sur un MOOC repérer le nombre de personnes actuellement connectées et tirer un sous-ensemble d'apprenants à qui poser la question.

# Conclusion

Dans ce chapitre, nous avons présenté une nouvelle manière de choisir les $k$ premières questions à administrer à un nouvel apprenant, via InitialD, un algorithme probabiliste efficace inspiré de la littérature en apprentissage automatique. Grâce à la complexité de $O(nk^3)$ pour choisir $k$ questions à poser parmi $n$ (après un précalcul de complexité $O(n^3)$ qui peut être parallélisé car il s'agit d'une diagonalisation de matrice), notre méthode peut être appliquée à des grandes banques de questions, telles que celles que peut contenir un cours en ligne.

Nous avons également mis en évidence qu'un processus non adaptatif peut être utile pour les toutes premières questions, tandis qu'une évaluation adaptative peut donner de meilleurs résultats plus loin dans le test.
