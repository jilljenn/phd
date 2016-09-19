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

Incertitude maximale

:   Une des méthodes en apprentissage automatique consiste à choisir les questions les plus incertaines, c'est-à-dire celles de probabilité prédite la plus proche de 0,5. Toutefois, cela risque d'apporter de l'information redondante [@Hoi2006].

Déterminant maximal

:   Une façon de choisir des questions peu corrélées les unes des autres consiste à choisir un ensemble de questions dont le parallélotope forme un grand volume. Le volume d'un parallélotope formé par des vecteurs $V = (\mathbf{v_1}, \ldots, \mathbf{v_n})$ où $\mathbf{v_1}, \ldots, \mathbf{v_n}$ sont les lignes de la matrice $V$, est donné par $Vol(\{\mathbf{v_i}\}_{i = 1, \ldots, n}) = \sqrt{\det V V^T}$.

# Processus à point déterminantal

Nous allons présenter une loi de probabilité, tirée de la théorie des matrices aléatoires, qui a récemment été appliquée en apprentissage automatique. Cette loi permet, étant donné des objets munis de caractéristiques, d'échantillonner efficacement des éléments \og diversifiés \fg{} pour une certaine mesure de distance. Cela a par exemple des applications en recommandation pour sélectionner des produits diversifiés, dans les moteurs de recherche afin que les résultats en tête de la recherche portent sur des thèmes différents (par exemple, pour une requête « jaguar », l'animal et la voiture) ou encore en génération automatique de résumé, à partir d'un corpus de textes, par exemple des articles de presse dont on souhaiterait sélectionner les thèmes principaux.

Implémenter cet échantillonnage requiert la donnée d'une valeur de similarité pour chaque paire d'éléments à échantillonner d'un ensemble $X = \{\mathbf{x_1}, \ldots, \mathbf{x_n}\}$ : une matrice symétrique $L$ telle que $L_{ij} = K(\mathbf{x_i}, \mathbf{x_j})$ où $K$ est la fonction (noyau, donc symétrique) de similarité. Pour nos usages nous avons utilisé la simple similarité cosinus du produit scalaire $K(\mathbf{x_i}, \mathbf{x_j}) = \mathbf{x_i} \cdot \mathbf{x_j}$ aussi appelé noyau linéaire, mais il est possible d'utiliser le noyau gaussien :

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

Il existe des algorithmes efficaces pour échantillonner selon une PPD [@Kulesza2012], y compris lorsqu'on fixe à l'avance le nombre d'éléments qu'on souhaite sélectionner ($k$-PPD) : la complexité de tirage est $O(nk^3)$ où $n$ est le nombre de questions, à condition d'avoir calculé la diagonalisation de la matrice $L$ au préalable, ce qui se fait avec une complexité $O(N^3)$. En revanche, le problème de déterminer le mode de cette distribution (c'est-à-dire l'ensemble $X$ de plus grande probabilité a posteriori) est un problème NP-difficile, néanmoins des algorithmes d'approximation ont été développés. Ce n'est que récemment que les PPD sont appliqués à l'apprentissage statistique, mais surtout à des méthodes de diversification et de résumé.

Un autre avantage de cette méthode est que le choix de $k$ questions est probabiliste, ainsi on ne pose pas nécessairement les mêmes $k$ premières questions à tous les apprenants, ce qui présente certains avantages : sécurité, diversification de la banque de questions.

# InitialD

Notre contribution consiste à appliquer la méthode de tirage d'éléments diversifiés selon un PPD au choix de questions diversifiées au début d'un test, de façon automatique.

Étant donné un calibrage de type MIRT, et donc une représentation distribuée des $n$ questions du test en dimension $d$, on tire $k$ questions parmi celles-là selon PPD. Nous faisons l'hypothèse que les questions ainsi choisies seront peu redondantes, donc constitueront un bon résumé des questions du test pour l'apprenant.

Ainsi, nos éléments à tirer sont les questions qui sont des vecteurs de dimensions $d$ : si MIRT a réalisé la factorisation $M \simeq \Phi(\Theta D^T)$, alors les lignes de $D$ sont les vecteurs $(\mathbf{d_1}, \ldots, \mathbf{d_n})$ correspondant aux questions et $L = D D^T$ est la matrice de similarité dont l'élément $(i, j)$ vaut $\mathbf{d_i} \cdot \mathbf{d_j}$.

L'algorithme de tirage est tiré de [@Kulesza2012] et est implémenté en Python. Sa complexité est $O(nk^3)$ où $k$ est le nombre de questions sélectionnées et $n$ est le nombre de questions du test, après une coûteuse étape de diagonalisation de complexité $O(n^3)$. Ainsi, cette complexité convient à une grande base de questions comme peut l'être celle sur un MOOC.

# Validation

À partir des données dichotomiques des apprenants, nous allons comparer trois stratégies pour choisir les $k$ premières questions, selon une méthode \textsc{FirstBulk} qui renvoie un ensemble de $k$ questions en fonction du paramètre a priori de l'apprenant.

Comme modèle de l'apprenant, nous choisissons la première phase de GenMA.

## Stratégies comparées

Aléatoire

:   Les questions sont choisies au hasard.

Incertitude maximale

:   On suppose que l'apprenant est du niveau moyen de l'historique et on choisit $k$ questions de probabilité estimée proche de 0,5.

PPD

:   L'algorithme présenté à la section précédente.

Adaptative

:   Enfin, nous ajoutons à ces trois stratégies la sélection adaptative habituelle, question par question, afin de comparer nos trois stratégies non adaptatives à la stratégie adaptative.

## Protocole expérimental

La méthode est similaire à la méthode de validation bicroisée présentée à la section \ref{algo}. Nous séparons les apprenants en deux ensembles d'entraînement et de test (80 % et 20 %) et calibrons le modèle GenMA avec les apprenants d'entraînement. Puis, pour chaque apprenant de test, nous choisissons $k$ premières questions à poser, récoltons ses réponses et estimons son vecteur de niveau.

Nous mesurons alors les différentes valeurs, pour différentes valeurs du nombre de questions $k$ :

- quelle est la performance des prédictions qui découlent de ce premier groupe de questions : log loss et nombre de prédictions incorrectes ;
- quelle est la différence entre le paramètre estimé à partir de $k$ questions et le paramètre estimé lorsqu'on a posé toutes les questions ; cette valeur est calculée par @Lan2014 pour comparer les méthodes de sélection de questions.

Pour le jeu de données Fraction, grâce à la q-matrice et au modèle GenMA nous obtenons une représentation distribuée des questions de dimension 8, que nous utilisons pour calculer la matrice de similarité et échantillonner les questions.

## Résultats

\begin{figure}
\includegraphics[width=\linewidth]{figures/dpp-delta}
\caption{Évolution de la différence.}
\end{figure}

\begin{figure}
\includegraphics[width=\linewidth]{figures/dpp-mean}
\caption{Évolution de l'erreur moyenne.}
\end{figure}

\begin{table}
\begin{tabular}{cc}
Dataset & Fraction\\
\hline
Random & $0.433 \pm 0.051$\\
PPD & $0.359 \pm 0.032$\\
CAT & $0.416 \pm 0.044$\\
\hline
\end{tabular}
\caption{Erreur sur l'ensemble de validation.}
\end{table}

PPD aboutit à une erreur plus faible. Dans cette expérience, 5 questions ont été posées.

## Discussion et applications

Nous avons donc proposé une nouvelle méthode pour choisir les $k$ premières questions à poser.

Il est possible d'incorporer des caractéristiques telles que le contenu des questions pour avoir des vecteurs à plus grande dimension. En filtrage collaboratif, c'est l'approche qu'adopte @Van2013.

Bien sûr cette méthode est plus adaptée à des vecteurs de grande dimension. Si le nombre de questions à poser $k$, le nombre de questions disponibles $n$ et le nombre de dimensions $d$ est assez petit, il est possible de simuler tous les choix possibles de $k$ questions parmi $n$. Toutefois, en pratique, les banques de questions sur des plateformes de MOOC seront telles qu'il faudra recourir à ce genre d'échantillonnage.

La méthode proposée dans ce chapitre ne cherche pas à déterminer le meilleur ensemble de questions à poser selon une certaine métrique, mais un bon ensemble aléatoire. Ajouter de l'aléa dans cette technique présente plusieurs avantages : les premières questions posées à chaque candidat ne sont pas les mêmes. Si cela constitue une surcharge supplémentaire lorsqu'on doit corriger manuellement les exercices des apprenants, en revanche lorsqu'ils sont administrés automatiquement sur une plateforme, cela permet d'éviter un comportement de triche, ou tout simplement de trop utiliser les mêmes exercices de sa banque.

### Génération de testlets

Le test préalable peut être également appliqué à la génération d'une planche d'exercices \og diversifiée \fg{} étant donné un historique de réponses.

### Démarrage à froid de question

Cette méthode pourrait être appliquée au problème de démarrage à froid de la question : lorsqu'une nouvelle question est ajoutée à un test existant, on ne dispose d'aucune information concernant son niveau. Une méthode consiste à, de façon similaire, la poser à des apprenants qui ont des niveaux disjoints. C'est l'approche qu'adopte @Anava2015 dans un contexte de filtrage collaboratif. On peut imaginer sur un MOOC repérer le nombre de personnes actuellement connectées et échantillonner auxquelles il faut poser la question[^1].

 [^1]: Ça ressemble un peu à de la publicité ciblée, sauf qu'on ne connaît aucune information personnelle sur les apprenants.
