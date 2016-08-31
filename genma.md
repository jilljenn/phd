# GenMA, un modèle confirmatoire interprétable

Nous considérons ici un modèle qui suppose que l'on connaisse les CC mises en œuvre pour chaque question, sous la forme d'une q-matrice, dont l'élément $q_{jk}$ vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon.

## Comparaison avec le modèle DINA

Le modèle DINA est un modèle cognitif basé sur une q-matrice, voir la section \ref{dina} pour une description précise. Ce modèle a été utilisé pour des tests adaptatifs et apprécié pour sa capacité à renvoyer un feedback à la fin de test comportant les composantes de connaissances maîtrisées ou non.

Pour rappel, on pouvait s'étonner du fait que ce modèle, bien que multidimensionnel, ait un pouvoir prédictif concurrencé par le modèle unidimensionnel de Rasch.

Dans le modèle DINA, l'apprenant est modélisé par un vecteur de bits appelé état indiquant pour chaque CC si elle est maîtrisée ou non. Ainsi, à tout moment du test, le modèle maintient une distribution de probabilité selon les $2^K$ états possibles, où $K$ est le nombre de CC, et chaque question est associée à un autre vecteur de bits, correspondant aux CC qu'il faut avoir maîtrisées afin d'y répondre correctement.

## GenMA

Nous proposons un nouveau modèle qui au lieu d'associer à une question un vecteur de bits, lui associe un vecteur de valeurs positives, correspondant à des paramètres de difficulté selon chaque composante de connaissance. Les entrées à 0 de la q-matrice permettent de fixer les entrées à 0 du vecteur de chaque question, c'est-à-dire que les composantes de connaissances non mises en œuvre dans une question ont une difficulté nulle pour cette question, ou encore que la compétence de l'apprenant selon cette composante ne sera pas prise en compte dans le calcul du score.

@Davier2005 a proposé un modèle qui unifie plusieurs modèles de théorie de la réponse à l'item ainsi que des modèles cognitifs : le modèle général de diagnostic (*general diagnostic model for partial credit data*) :

$$ Pr(\textnormal{``l'apprenant $i$ répond correctement à la question $j$''}) = \Phi\left(\beta_i + \sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk}\right) $$

où $K$ est le nombre de CC mises en œuvre dans le test, $\beta_i$ est la compétence principale de l'apprenant $i$, $\theta_{ik}$ sa compétence selon la CC $k$, $q_{jk}$ l'élément $(j,k)$ de la matrice qui vaut 1 si la CC $k$ est impliquée dans la résolution de la question $j$, 0 sinon, $d_{jk}$ la difficulté de la question $j$ selon la CC $k$. On peut remarquer que si la q-matrice a toutes ses entrées à 1, on retrouve le modèle MIRT mentionné plus haut.

À notre connaissance, ce modèle n'a pas été utilisé dans des tests adaptatifs [@Yan2014]. C'est ce que nous proposons dans ce chapitre, sous le nom de modèle GenMA.

## Calibrage

GenMA requiert la spécification d'une q-matrice par un expert. Les paramètres $d_{jk}$ pour chaque question $j$ et CC $k$ sont calibrés à partir d'un historique de réponses, en utilisant l'algorithme de Metropolis-Hastings Robbins-Monro [@Chalmers2012; @Cai2010]. Pour notre implémentation, nous nous sommes basés sur le package ``mirt`` [@Chalmers2012].

In real tests, items usually rely on only few KCs, hence there are fewer parameters to estimate than in a general MIRT model, which explains why the convergence is easy to obtain for ``GenMA``.

## Choix de la question suivante

For the selection item rule of ``GenMA``, we choose to maximize the Fisher information at each step, details of the implementation can be found in [@Chalmers2012].

<!-- The problem TeSR-PSP becomes: after $k$ questions asked to a certain learner $i$, how to estimate its main ability $\beta_i$ and ability for each KC $\theta_{ik}$ that can explain its behavior throughout the test? -->

## Retour à la fin du test

We can thus use the general diagnostic model to create an adaptive test that makes best of possible worlds: providing feedback under the form of degrees of proficiency over several KCs at the end of test, represented by the vector $\theta_i = (\theta_{i1}, \ldots, \theta_{iK})$, and being easy to converge. ``GenMA`` is both summative and formative, thus a hybrid model. Such feedback can be aggregated at various levels (e.g., from student, to class, to school, to city, to country) in order to enable decision-making [@Shute2015; @Verhelst2012].

![The GenMA hybrid model, combining item response theory and a q-matrix.](figures/genma.pdf)

# Validation

## Qualitative

GenMA est multidimensionnel donc mesure des valeurs selon plusieurs CC, contrairement à Rasch qui ne mesure qu'une unique valeur correspondant au niveau de l'apprenant sur tout le test.

Le modèle GenMA est aussi interprétable qu'un modèle DINA : au lieu de renvoyer des probabilités de maîtrise selon chaque CC, il renvoie une valeur de niveau selon chaque CC. Les dimensions sont directement interprétables car elles coïncident avec la q-matrice.

## Quantitative

GenMA a l'avantage multidimensionnel de MIRT tout en étant plus rapide à converger.

Pour la prédiction de performance, nous avons suivi le protocole décrit au chapitre précédent avec les modèles suivants :

- Rasch
- DINA
- GenMA

Et les datasets suivants :

- Fraction. Une matrice représentant les résultats sur des questions de soustraction de fraction.
- ECPE. Proficiency of English.
- TIMSS. Trends in Mathematics Studies.

\begin{figure}
\centering
\includegraphics[width=0.8\textwidth]{figures/results/fraction-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/fraction-count}
\begin{tabular}{cccc}
& After 4 questions & After 7 questions & After 10 questions\\
IRT & $0.469 \pm 0.017$ (79 \%) & $0.457 \pm 0.017$ (79 \%) & $0.446 \pm 0.016$ (79 \%)\\
MIRT & $0.459 \pm 0.023$ (79 \%) & $0.355 \pm 0.017$ (85 \%) & $0.294 \pm 0.013$ (88 \%)\\
MIRT & $0.368 \pm 0.014$ (83 \%) & $0.325 \pm 0.012$ (86 \%) & $0.316 \pm 0.011$ (86 \%)\\
QMatrix & $0.441 \pm 0.014$ (80 \%) & $0.41 \pm 0.014$ (82 \%) & $0.406 \pm 0.014$ (82 \%)\\
\end{tabular}
\caption{Évolution de la log-likelihood en fonction du nombre de questions posées}
\end{figure}

<!-- \begin{table}
\caption{Erreur moyenne sur le jeu Fraction}
\end{table} -->

\begin{figure}
\centering
\includegraphics[width=0.8\textwidth]{figures/results/ecpe-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/ecpe-count}
\begin{tabular}{cccc}
& After 4 questions & After 8 questions & After 12 questions\\
MIRT & $0.509 \pm 0.005$ (76 \%) & $0.496 \pm 0.005$ (76 \%) & $0.489 \pm 0.005$ (77 \%)\\
QMatrix & $0.535 \pm 0.003$ (73 \%) & $0.526 \pm 0.003$ (74 \%) & $0.523 \pm 0.003$ (74 \%)\\
IRT & $0.537 \pm 0.005$ (73 \%) & $0.527 \pm 0.005$ (74 \%) & $0.522 \pm 0.005$ (74 \%)\\
MIRT & $0.532 \pm 0.005$ (73 \%) & $0.507 \pm 0.004$ (75 \%) & $0.498 \pm 0.004$ (76 \%)\\
\end{tabular}
\caption{Évolution de la log-likelihood en fonction du nombre de questions posées}
\end{figure}

\begin{figure}
\centering
\includegraphics[width=0.8\textwidth]{figures/results/timss-mean}
%\includegraphics[width=0.5\textwidth]{figures/results/timss-count}
\begin{tabular}{cccc}
& After 4 questions & After 8 questions & After 11 questions\\
IRT & $0.576 \pm 0.008$ (70 \%) & $0.559 \pm 0.008$ (71 \%) & $0.555 \pm 0.008$ (71 \%)\\
MIRT & $0.537 \pm 0.006$ (72 \%) & $0.505 \pm 0.006$ (75 \%) & $0.487 \pm 0.006$ (77 \%)\\
QMatrix & $0.588 \pm 0.005$ (68 \%) & $0.57 \pm 0.006$ (70 \%) & $0.566 \pm 0.006$ (70 \%)\\
\end{tabular}
\caption{Évolution de la log-likelihood en fonction du nombre de questions posées}
\end{figure}

## Discussion

Sur les jeux de données testés, GenMA a un plus grand pouvoir prédictif que le DINA model. La réponse à une question apporte plus d'information car chaque item a un paramètre de difficulté qui lui est propre selon chaque composante de connaissance.

MIRT à 2 dimensions se débrouille mieux que GenMA, ce qui laisse entendre qu'un modèle prédictif n'est pas nécessairement explicatif. Toutefois afin de faire un retour à l'utilisateur, notre modèle fait un feedback correspondant davantage à la réalité qu'un modèle DINA basé sur les q-matrices.
