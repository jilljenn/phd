# Spécification du test adaptatif

## Modèle de la probabilité de répondre correctement à chaque question

Les choix que font le système et la calibration des paramètres dépendent du modèle de probabilité de réponse d'un apprenant sur une question.

## Calibrage à partir d'un historique ou ensemble d'entraînement

Pour fonctionner, certains modèles de test adaptatif nécessitent de calibrer leurs paramètres à l'aide d'un historique de réponses (aussi appelé *ensemble d'entraînement*) d'une population $I$ d'apprenants face à des questions d'un ensemble $Q$, sous la forme d'une matrice $I \times Q$ dont l'élément $m_{ij}$ vaut 1 si l'apprenant $i$ a répondu correctement à la question $j$, 0 sinon.

Cela leur permet ensuite de positionner un nouvel apprenant par rapport à la population donnée en historique.

## Choix de la question initiale

Au début d'un test adaptatif, le système n'a aucune information sur l'apprenant, car aucune question de lui a encore été posée, et que nous ne considérons pas de métadonnées sur l'apprenant.

Pour choisir la première question à poser, le système peut en choisir une au hasard, ou bien supposer initialiser les paramètres de l'apprenant à la valeur moyenne rencontrée dans la population donnée en historique. Nous avons fait ce second choix afin d'avoir un processus déterministe qui utilise toute l'information à disposition.

## Choix de la question suivante

À un certain moment du test, le système doit, à partir des questions déjà posées et de leurs résultats, choisir la question suivante. Ainsi, la fonction qui choisit la question suivante prend en paramètre une liste de couples $\{(i_k, r_k)\}_k$ où $r_k$ désigne 1 si l'apprenant a répondu correctement à la question $i_k$, 0 sinon.

## Nature du retour fait à la fin du test

Selon le modèle, l'apprenant obtient à la fin du test un retour qui lui sera utile ou non pour s'améliorer. Par exemple le modèle de Rasch renvoie une information de niveau tandis que le modèle DINA indique la probabilité que le candidat maîtrise chacune des CC.

Pour visualiser cette information, diverses méthodes sont employées. Par exemple, pour le modèle de Rasch, on peut indiquer où l'apprenant où il se trouve au sein de la population (par exemple, dans les 10 % meilleurs). Pour le modèle DINA, on peut lui renvoyer des jauges de compétences à partir de la probabilité qu'il maîtrise chacune des CC.

<!-- # Bornes théoriques de problèmes similaires

## Recherche binaire généralisée

Le problème d'identification d'une cible en posant la question qui minimise l'entropie à chaque tour s'appelle la recherche dichotomique généralisée. On peut considérer des erreurs iid mais pour des erreurs persistantes, ce problème est peu connu théoriquement.

## Sous-modularité

Toutefois, on a une borne théorique dans le cas où les apprenants répondent sans erreur. -->

# Comparaison de modèles sur des jeux de données réels

Nous allons employer un vocabulaire qui vient de l'apprentissage automatique pour définir notre problème.

## Apprentissage automatique à partir d'exemples

Lorsqu'on cherche à modéliser un phénomène naturel, on peut utiliser un modèle statistique, dont on estime les paramètres en fonction des occurrences observées. Par exemple, si on suppose qu'une pièce suit une loi de Bernoulli et tombe sur Face avec probabilité $p$ et Pile avec probabilité $1 - p$, on peut estimer $p$ à partir de l'historique des occurrences des lancers de la pièce. On appelle *estimateur du maximum de vraisemblance* la valeur des paramètres qui maximise la vraisemblance, c'est-à-dire qui maximise la probabilité d'obtenir les résultats observés. À partir de ce modèle, il est possible de faire des prédictions sur les futurs lancers de pièce.

On distingue deux types d'apprentissage automatique. L'*apprentissage supervisé* consiste à disposer d'échantillons étiquetés, c'est-à-dire appariés avec une variable d'intérêt, et à devoir prédire les étiquettes d'échantillons inédits. L'*apprentissage non supervisé* consiste à ne pas savoir quelle variable prédire, et donc à déterminer des motifs récurrents au sein des échantillons ou en extraire des caractéristiques pour faire de l'apprentissage.

En apprentissage supervisé, on appelle *classifieur* un modèle qui prédit une variable discrète, et régresseur un modèle qui prédit une variable continue. Ainsi, à partir des *caractéristiques* d'un échantillon $\mathbf{x} = (x_1, \ldots, x_d)$, par exemple les couleurs des pixels d'une image, un classifieur peut prédire une variable $y$ dite *étiquette*, par exemple le chiffre 1 si l'image est un chat, 0 sinon. Une fois ce modèle entraîné sur des exemples de caractéristiques $\mathbf{x}^{(1)}, \ldots, \mathbf{x}^{(e)}$ étiquetées par les variables $y^{(1)}, \ldots, y^{(e)}$, on peut s'en servir pour prédire les étiquettes d'échantillons inédits $\mathbf{x'}^{(1)}, \ldots, \mathbf{x'}^{(t)}$. Ainsi on distingue les données d'entraînement $X_{train} = (\mathbf{x}^{(1)}, \ldots, \mathbf{x}^{(e)})$, sous la forme d'une matrice de taille $e \times d$ où $e$ est le nombre d'exemples et $d$ la dimension des caractéristiques, et leurs étiquettes $\mathbf{y}_{train} = (y^{(1)}, \ldots, y^{(e)})$ des données de test $X_{test} = (\mathbf{x'}^{(1)}, \ldots, \mathbf{x'}^{(t)})$.

En ce qui nous concerne, nous disposons des résultats de plusieurs apprenants sur les questions d'un test, et cherchons à prédire les résultats d'un nouvel apprenant alors qu'il passe le test. Notre problème commence par une phase d'apprentissage non supervisé, car à partir du simple historique des résultats au test, il faut extraire des caractéristiques sur les apprenants et les questions qui expliquent ces résultats. Puis, le problème devient supervisé pour un nouvel apprenant car il s'agit d'un problème de classification binaire : on cherche à prédire à partir des réponses que donne l'apprenant ses résultats (vrai ou faux) sur le reste des questions du test. Une particularité est que l'apprentissage est ici interactif, dans la mesure où c'est le système qui choisit les questions à poser (c'est-à-dire, les éléments à faire étiqueter à l'apprenant) afin d'améliorer son apprentissage. Cette approche s'appelle apprentissage actif (*active learning*).

## Extraction automatique de q-matrice

Il peut arriver que pour un test donné, on ne dispose pas de q-matrice. Certaines approches en fouille de données pour l'éducation consistent à la calculer automatiquement pour ensuite en interpréter les CC correspondant aux colonnes. @Barnes2005 fait une escalade de colline, mais la complexité de cette opération est grande. @Desmarais2011 fait une factorisation de matrices positives.

Nous avons testé des approches plus génériques. @Zou2006 présente un algorithme pour l'analyse de composantes principales creuses, qui détermine deux matrices $W$ et $H$ tels que :

$$M \simeq WH \textnormal{ et } H \textnormal{ est creuse}. $$

@Lee2010 propose une analyse de composantes principales creuses avec une fonction de lien logistique, ce qui est plus approprié pour notre problème où la matrice que nous cherchons à approximer est binaire.

$$M \simeq \Phi(WH) \textnormal{ et } H \textnormal{ est creuse}. $$

Dans ces deux cas, $H$ est composée majoritairement de 0. Pour en extraire une q-matrice, nous fixons à 1 les entrées non nulles.

## Validation bicroisée

Pour valider un modèle d'apprentissage supervisé, une méthode courante consiste à estimer ses paramètres à partir d'une fraction des données et leurs étiquettes, calculer les prédictions faites sur les données restantes et les comparer avec les vraies étiquettes. Cette méthode s'appelle *validation croisée*. Ainsi, le jeu de données $X$ est divisé en deux parties $X_{train}$ et $X_{test}$, le modèle est entraîné sur $X_{train}$ et ses étiquettes $\mathbf{y}_{train}$ et fait une prédiction sur les données $X_{test}$ appelée $\mathbf{y}_{pred}$, qui est ensuite comparée aux vraies valeurs $\mathbf{y}_{test}$ pour validation. S'il s'agit d'un problème de régression, on peut utiliser par exemple la fonction de coût RMSE (*root mean squared error*) :

$$ RMSE(\mathbf{y}^*, \mathbf{y}) = \sqrt{\frac1n \sum_{k = 1}^n (y^*_i - y_i)^2} $$

où $\mathbf{y} = (y_1, \ldots, y_n)$ et $\mathbf{y}^* = (y^*_1, \ldots, y^*_n)$.

S'il s'agit d'un problème de classification binaire, on utilise habituellement la fonction de coût *log-loss* (aussi appelée coût logistique ou perte d'entropie mutuelle) :

$$ logloss(\mathbf{y}^*, \mathbf{y}) = \frac1n \sum_{k = 1}^n \log (1 - |y^*_k - y_k|). $$

Toutes les valeurs prédites étant comprises entre 0 et 1, cette fonction pénalise beaucoup plus une grosse différence entre valeur prédite (comprise entre 0 ou 1) et valeur réelle (égale à 0 ou 1) que la RMSE, voir Figure \ref{rmse-ll}.

Afin d'obtenir une validation plus robuste, il faut s'assurer que la proportion de 0 et de 1 soit la même dans les étiquettes d'entraînement et dans les étiquettes d'évaluation. Pour une validation encore meilleure, on peut recourir à une validation croisée à $k$ paquets : le jeu de données $X$ est divisé en $k$ paquets, et $k$ validations croisées sont faites en utilisant $k - 1$ paquets parmi les $k$ pour entraîner le modèle et le paquet restant pour l'évaluer.

\begin{figure}
\centering
\includegraphics[width=0.6\linewidth]{figures/traintest}
\caption{Jeu de données séparé pour la validation bicroisée. En ligne, les apprenants d'entraînement et de test. Pour chaque apprenant de test, seules les questions grises sont posées, les questions rouges étant conservées pour validation.}
\label{traintest}
\end{figure}

Dans notre cadre, nous avons deux types de populations : les apprenants de l'historique, pour lesquels nous avons observé les résultats à toutes les questions, et les apprenants pour lesquels on souhaite évaluer le modèle de test adaptatif. Nous faisons donc une validation bicroisée, car nous séparons les apprenants en deux groupes d'entraînement et de test, et également les questions en deux groupes de test et de validation, voir figure \ref{traintest}. Pour chaque apprenant du groupe d'entraînement, nous connaissons toutes ses réponses et pouvons entraîner nos modèles à partir de ces données. Pour chaque apprenant du groupe de test, nous simulons un test adaptatif qui choisit les questions à poser parmi les questions de test. Nous vérifions alors, à chaque étape du test adaptatif pour l'apprenant, les prédictions du modèle sur son comportement sur l'ensemble des questions de validation.

Notre comparaison de modèles a deux aspects : qualitatifs en termes d'interprétabilité ou d'explicabilité et quantitatifs en termes de vitesse de convergence de la phase d'entraînement et performance des prédictions.

## Évaluation qualitative

Plusieurs aspects font qu'on peut préférer un modèle de test adaptatif plutôt qu'un autre. Par exemple, la mise en œuvre d'un modèle de test peut requérir la construction d'une q-matrice, ce qui peut être coûteux si l'on a plusieurs milliers de questions à apparier avec une dizaine de composantes de connaissance.

Multidimensionalité

:   Est-ce que le modèle mesure une ou plusieurs dimensions ?

Interprétabilité

:   Dans les évaluations formatives, il est important de pouvoir nommer les CC dont l'apprenant a dû faire preuve, de façon satisfaisante ou insatisfaisante. Disposer d'une q-matrice spécifiée par un humain permet d'accroître l'interprétabilité du système, car il est alors possible d'identifier les lacunes de l'apprenant soulignées par le test.

Explicabilité

:   Un modèle explicable est capable de justifier le processus qui l'a fait aboutir à son diagnostic. On reproche parfois aux modèles d'apprentissage statistique de faire des prédictions correctes sans pouvoir les expliquer (on parle de modèles \og boîte noire \fg). Si le modèle prédictif est linéaire ou log-linéaire, il est possible de justifier ses prédictions. S'il est non linéaire, on ne peut pas expliquer les prédictions.

Besoin d'un historique

:   Est-ce que le modèle a besoin d'un historique d'apprenants pour fonctionner ou est-ce que le test peut être adaptatif dès sa première administration ?

## Évaluation quantitative et implémentation

Complexité

:   Quelle est la complexité en temps et mémoire de ce modèle ?

Rapidité de convergence vers un diagnostic

:   Un modèle convergera plus vite vers son diagnostic qu'un modèle plus compliqué.

Pouvoir prédictif

:   Est-ce que le diagnostic permet effectivement d'expliquer les résultats qu'on aurait obtenus si on avait continué le test ?

Nous cherchons à comparer le pouvoir prédictif de différents modèles de tests adaptatifs qui modélisent la probabilité qu'un certain apprenant résolve une certaine question d'un test. Ces modèles sont comparés sur un jeu de données réel $D$ de taille $|I| \times |Q|$ où $D_{iq}$ vaut 1 si l'apprenant $i$ a répondu correctement à la question $q$, 0 sinon. Pour faire une validation bicroisée, nous séparons les apprenants de l'ensemble $I$ en $U$ paquets et les questions de l'ensemble $Q$ en $V$ paquets. Ainsi, si on numérote les paquets d'apprenants $I_i$ pour $i = 1, \ldots, U$  et les paquets de questions $Q_j$ pour $j = 1, \ldots, V$, l'expérience $(i, j)$ consiste à, pour chaque modèle $T$ :

1. entraîner le modèle $T$ sur tous les paquets d'apprenants sauf le $i$-ième (l'ensemble d'apprenants d'entraînement $I_{train} = I \setminus I_i$) ;
2. simuler des tests adaptatifs sur les apprenants du $i$-ième paquet (l'ensemble d'apprenants de test $I_{test} = I_i$) en utilisant les questions de tous les paquets sauf le $j$-ième, et après chaque réponse de l'apprenant, en évaluant l'erreur du modèle $T$ sur le $j$-ième paquet de questions (l'ensemble de questions de validation $Q_{val} = Q_j$), voir figure \ref{predict}. On fait donc un appel à \textsc{Simuler}($train, test$), voir l'algorithme \ref{algo}.

\begin{figure}
\includegraphics[width=\linewidth]{figures/predict}
\caption{Phase de test. Après que la question de probabilité plus proche de 0,5 a été choisie puis posée, les paramètres de l'apprenant sont mis à jour, une prédiction est faite sur l'ensemble de questions de validation et cette prédiction est évaluée étant donnée la vraie performance de l'apprenant.}
\label{predict}
\end{figure}

\begin{algorithm}
\begin{algorithmic}
\Procedure{Simuler}{$train, test$}
\State $\alpha \gets \Call{TrainingStep}{train}$
\State $t \gets 0$
\For{all students $s$ in $test$}
    \State $\pi \gets \Call{PriorInitialization}$
    \While{\textsc{TerminationRule} is not satisfied}
        \State $q_{t + 1} \gets \Call{NextItem}{\{(q_k, r_k)\}_{k = 1, \ldots, t}, \alpha, \pi}$
        \State Ask question $q_{t + 1}$ to the student $s$
        \State Get reply $r_{t + 1}$
        \State $\pi \gets \Call{EstimateParameters}{q_1, r_1, \ldots, q_t, r_t, \alpha}$
        \State $p \gets$ \Call{PredictPerformance}{$\alpha, \pi$}
        \State $\Sigma \gets$ \Call{EvaluatePerformance}{$p$}
    \EndWhile
\EndFor
\EndProcedure
\end{algorithmic}
\caption{\textbf{Simulation d'un modèle de tests adaptatifs}
\label{algo}
\end{algorithm}

Pour chaque modèle testé, nous avons implémenté les routines suivantes :

- **TrainingStep**($I_{train}$) : calibrer le modèle sur l'historique des apprenants $I_{train}$ et renvoyer les paramètres $\alpha$ ;
- **PriorInitialization**($\alpha$) : initialiser les paramètres de l'apprenant au début de son test et renvoyer ses paramètres $\pi$ ;
- **NextItem**($\{(q_k, r_k)\}_k, \alpha, \pi$) : choisir la question à poser de probabilité la plus proche de 0,5 [@Chang2014], en fonction des réponses précédentes de l'apprenant et de l'estimation en cours de son niveau ;
- **UpdateParameters**($\{(q_k, r_k)\}_k, \pi$) : mettre à jour les paramètres de l'apprenant en fonction de ses réponses aux questions posées ;
- **PredictPerformance**($\alpha, \pi$) : calculer pour chacune des questions du test la probabilité que l'apprenant en cours de test y réponde correctement et renvoyer le vecteur de probabilités obtenu ;
- **EvaluatePerformance**($p$) : comparer la performance prédite à la vraie performance de l'apprenant sur l'ensemble de questions de validation, de façon à évaluer le modèle. La fonction d'erreur peut être la log loss ou le nombre de prédictions incorrectes.

De façon à visualiser les questions posées par un modèle de tests adaptatifs, on peut construire l'arbre binaire de décision correspondant. La racine est la première question posée, puis chaque réponse fausse renvoie vers le nœud gauche, chaque réponse vraie renvoie vers le nœud droit [@Ueno2010; @Yan2014]. En chaque nœud on peut calculer l'erreur en cours du modèle sur l'ensemble des questions de validation, et le meilleur modèle est celui dont l'erreur moyenne est minimale.

\noindent
\textsc{EvaluateModel}(model $M$, $I_{train}$, $I_{test}$, $Q_{val}$) :  
\indent \textsc{Train} model using lines $I_{train}$ of $D$  
\indent \textbf{For each} student $i$ of $I_{test}$ \textbf{do}  
\indent \indent \textbf{While} not all questions $\in Q \setminus Q_{val}$ have been asked  
\indent \indent \indent \textsc{ChooseNextItem} and ask it to student $i$  
\indent \indent \indent Evaluate predictions of model $M$ over questions $Q_{val}$.\bigskip

Pour calculer l'erreur, nous avons choisi la log loss, courante pour les problèmes de classification binaire :

$$ e(p, t) = \frac1{|Q_{val}|} \sum_{k \in Q_{val}} t_k \log p_k + (1 - t_k) \log (1 - p_k) $$

où $p$ est la performance prédite sur les $|Q_val|$ questions et $t$ est le vrai motif de réponse de l'apprenant en cours.

Lors de chaque expérience $(i, j)$, on enregistre pour chaque apprenant $t$ valeurs d'erreurs où $t$ est le nombre de questions posées, soit $|Q \setminus Q_{val}|$. Ainsi, on peut déterminer l'erreur moyenne que chaque modèle a obtenu après avoir posé un certain nombre de questions. Ces valeurs sont stockées dans une matrice de taille $U \times V$ dont chaque case correspond à l'expérience $(i, j)$, voir figure \ref{crossval}. En calculant l'erreur moyenne selon chaque colonne, on peut visualiser comment les modèles se comportent pour chaque ensemble de question de validation. On calcule la moyenne de toutes les cases pour tracer les courbes correspondant à chaque modèle.

\begin{figure}
\centering
\includegraphics{figures/crossval.pdf}
\caption{Validation bicroisée selon 5 paquets d'apprenants et 4 paquets de questions. Chaque case $(i, j)$ contient les résultats de l'expérience $(i, j)$ d'ensemble d'apprenants d'entraînement $I_{test} = I_i$ et l'ensemble de questions de validation $Q_{val} = Q_j$.}
\label{crossval}
\end{figure}

## Jeux de données
\label{datasets}

Pour nos expériences, nous avons utilisé les jeux de données suivants.

### SAT

Le SAT est un test standardisé aux États-Unis. Il est multidisciplinaire, car les questions portent sur 4 catégories : mathématiques, biologie, histoire et français. Dans ce jeu de données, 296 apprenants ont répondu à 40 questions. Ce jeu a été étudié par @Winters2005 et @Desmarais2011 pour déterminer une q-matrice automatiquement via une factorisation de matrices positives.

### ECPE

Il s'agit d'une matrice $2922 \times 28$ représentant les résultats de 2922 apprenants sur 28 questions d'anglais de l'examen ECPE (*Examination for the Certificate of Proficiency in English*). Ce test standardisé cherche à mesurer trois attributs, c'est pourquoi la q-matrice correspondante a 3 CC : règles morphosyntaxiques, règles cohésives, règles lexicales.\nomenclature{ECPE}{\emph{Examination for the Certificate of Proficiency in English}}

À titre d'exemple, les paramètres d'inattention et de chance déterminés lors de l'entraînement ont été répertoriés dans la figure \ref{ecpe-guess}.

### Fraction

Ce jeu de données regroupe les résultats de 536 collégiens sur 20 questions de soustraction de fractions. Les items et la q-matrice correspondante sont décrits dans @DeCarlo2010.

### TIMSS

Le TIMSS (*Trends in International Mathematics and Science Study*) effectue un test standardisé de mathématiques. Les données sont librement disponibles sur leur site pour les chercheurs. En l'occurrence, ce jeu de données provient de l'édition 2003 du TIMSS. C'est une matrice binaire de taille $757 \times 23$ qui regroupe les résultats de 757 apprenants du grade 8 sur 23 questions de mathématiques. La q-matrice a été définie par des experts du TIMSS et comporte 13 CC sur les 15 décrites dans @Su2013 : toutes sauf la 10\ieme{} et la 12\ieme.

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

Chaque apprenant a un paramètre : son niveau, chaque question a un paramètre de difficulté.

TrainingStep

:   La phase d'apprentissage consiste à déterminer l'estimateur du maximum de vraisemblance pour les paramètres des apprenants et des questions. Comme le modèle est simple, l'expression de la dérivée de la vraisemblance est simple et le zéro est calculé par la méthode de Newton. Cette partie est effectuée par le package ``ltm``.

PriorInitialization

:   Lorsqu'un nouvel apprenant passe le test, on initialise son niveau à 0.

NextItem

:   Comme pour chaque modèle, la question choisie est celle de probabilité la plus proche de 0,5.

UpdateParameters

:   Après chaque réponse de l'apprenant, l'estimation est faite par le maximum de vraisemblance. Si trop peu de réponses ont été fournies, l'estimation est bayésienne. Cette estimation est faite par le package ``catR``.

PredictPerformance

:   Pour rappel, la formule est donnée par l'expression :

$$ Pr(success_{ij}) = \Phi(\theta_i - d_j). $$

### DINA

Chaque apprenant a un paramètre qui est son état latent, et chaque question a pour paramètres sa ligne correspondante dans la q-matrice, ainsi qu'un paramètre d'inattention et un paramètre de chance.

C'est ``CDM`` qui détermine à partir d'une q-matrice et d'une population, les meilleurs paramètres d'inattention et de chance.

Afin d'accélérer la procédure d'entraînement parfois coûteuse, nous utilisons le compilateur à la volée ``pypy``.

TrainingStep

:   Si l'on dispose d'une q-matrice, la phase d'apprentissage consiste à déterminer les états latents des apprenants d'entraînement, ainsi que les paramètres d'inattention et de chance des questions les plus vraisemblables. La calibration des paramètres des questions est effectuée par le package ``CDM``, à partir des motifs de réponse des apprenants d'entraînement et de la q-matrice. Pour déterminer les états latents des apprenants, on simule le fait de leur poser toutes les questions en utilisant le modèle DINA. Si on ne dispose pas de q-matrice, nous la calculons automatiquement en itérant plusieurs phases d'optimisation de la q-matrice via escalade de colline, des paramètres d'inattention et de chance via optimisation convexe, et des états latents des apprenants.

PriorInitialization

:   Lorsqu'un nouvel apprenant passe le test, on suppose qu'il a une probabilité moyenne d'être dans chaque état latent, étant donné la population d'entraînement. On va maintenir une distribution de probabilité sur les $2^K$ états latents possibles, initialisée à cette distribution a priori.

NextItem

:   Comme pour chaque modèle, la question choisie est celle de probabilité la plus proche de 0,5.

UpdateParameters

:   Après chaque réponse de l'apprenant, une mise à jour de la distribution de probabilité est faite, de façon bayésienne. Voir la section \ref{dina-update} pour les formules utilisées.

PredictPerformance

:   Pour rappel, la formule est donnée par l'expression :

$$ Pr(success_{ij}) = \left\{\begin{array}{ll}
1 - s_j & \textnormal{ si l'apprenant $i$ maîtrise toutes les CC requises pour répondre à la question $j$}\\
g_j & \textnormal{ sinon.}
\end{array}\right. $$

# Résultats

## Évaluation qualitative

Rasch

:   Le modèle de Rasch est unidimensionnel, n'a pas besoin de q-matrice pour fonctionner, fait un retour à l'apprenant sous la forme d'une valeur de niveau. Cela permet à l'apprenant de se situer au sein des autres apprenants mais pas de comprendre les points du cours qu'il doit approfondir. Les paramètres estimés peuvent être interprétés comme des valeurs de niveau pour les apprenants et de difficulté pour les questions, mais peuvent correspondre à des erreurs d'énoncé. Aussi, afin de calibrer les paramètres de difficulté des questions et de niveau des apprenants, le modèle de Rasch a besoin de données d'entraînement.

DINA

:   Le modèle DINA est multidimensionnel, requiert une q-matrice, fait un retour à l'apprenant sous la forme d'une probabilité de maîtriser chacune des composantes de connaissance. Ainsi, l'apprenant peut se situer vis-à-vis des objectifs du cours. Les paramètres estimés sont les probabilités de répondre correctement aux questions alors qu'on ne maîtrise pas les CC, et inversement. Grâce à la q-matrice, on peut interpréter les différentes dimensions, et les déductions sont faites de façon bayésienne, donc explicables. Si la q-matrice est mal définie, des valeurs aberrantes apparaîtront pour les paramètres d'inattention et de chance. Le modèle DINA peut fonctionner sans historique, en supposant une distribution uniforme a priori sur les états latents possibles.

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
\caption{Temps de calcul des phases d'entraînement et de test pour chaque modèle, sur le jeu de données Fraction.}
\label{tab:time}
\end{table}

## Discussion

Selon le jeu de données, le meilleur modèle n'est pas le même.

Il est utile de remarquer que si $K = 1$, l'apprenant peut être modélisé par une probabilité d'avoir l'unique CC ou non. Si la question ne requiert aucune CC, il a une probabilité constante $1 - s_i$ d'y répondre. Sinon, sa probabilité est $(1 - p) g_i + p (1 - s_i) = g_i + p (1 - s_i - g_i)$ soit une valeur qui croît entre $g_i$ et $1 - s_i$ de façon linéaire avec $p$. On retrouve les paramètres de chance et d'inattention du modèle logistique à 4 paramètres.

# Conclusion

Dans ce chapitre, nous avons détaillé les différents points récurrents dans la conception d'un système de test adaptatif, nous permettant de comparer différents modèles de tests adaptatifs sur un même jeu de données. La méthode de validation que nous proposons, la validation bicroisée, est inspirée du domaine du filtrage collaboratif.

Comme @Rupp2012, nous ne cherchons pas à déterminer un meilleur modèle pour tous les usages, nous cherchons à identifier quel modèle convient le mieux à quel usage et avons proposé une méthologie pour comparer leur capacité à efficacement réduire la taille des tests.

Dans la littérature, nous avons observé que la plupart des modèles qui se basent sur des q-matrices sont évalués sur des données simulées. Ici, nous ne considérons que des données réelles d'apprenants, et notre protocole expérimental peut être testé sur n'importe quel jeu de données de test dichotomique. Il peut également être généralisé à des tests non adaptatifs comme nous le verrons à la section \ref{initiald}. Le fait de considérer seulement les réussites ou échecs d'apprenants face à des questions ou tâches permet d'appliquer un modèle de test adaptatif à des données issues d'interfaces plus complexes telles que des jeux sérieux. Si l'on dispose d'un générateur automatique de niveau qui prend en argument les composantes de connaissances que le niveau est censé évaluer, alors le modèle de test adaptatif pourra présenter à l'apprenant un niveau inédit basé sur les composantes de connaissances que le système souhaite évaluer, en fonction de la performance de l'apprenant jusqu'alors.
