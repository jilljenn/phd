% DPP
% JJV
% 13 juillet

# Test à étapes multiples

Une variante des tests adaptatifs consiste à poser un groupe de questions avant de choisir le suivant, et ainsi de suite, plutôt que de choisir la question suivante. Cela permet en effet d'éviter d'adapter le processus tout de suite après une information peu fiable. De plus, cela permet d'éviter de sauter d'une question à une autre qui n'a rien à voir, et permet à l'apprenant de vérifier ses réponses avant de déclencher le jeu de questions suivant.

Ainsi, le problème devient : comment choisir les $k$ premières questions à présenter à un nouveau venu ? Elles doivent porter sur des sujets diversifiés afin de varier le plus possible l'information obtenue.

# Visualisation d'un test adaptatif

\begin{figure}
\centering
\includegraphics[width=\linewidth]{figures/2d}
\caption{Test adaptatif en 2 dimensions}
\end{figure}

Ainsi, un jeu de questions sera informatif s'il réalise un maillage de l'espace des questions.

L'information de Fisher désigne la variance du score, c'est-à-dire du gradient de la log-vraisemblance.

Une des méthodes en machine learning consiste à faire un échantillon selon l'incertitude, c'est-à-dire choisir l'entrée sur laquelle le système est le moins sûr. Ainsi, étant donné l'estimateur du maximum de vraisemblance, on va choisir un élément de probabilité prédite la plus proche de 0,5.

Toutefois, deux problèmes se présentent :

Échantillonnage de plusieurs questions

:   Si l'on pose plusieurs questions en une seule fois, prendre plusieurs questions de probabilité prédite de 0,5 risque d'apporter de l'information redondante. @Hoi2006 choisit une approche gloutonne en approximant la fonction objectif par une fonction sous-modulaire.

Existence de l'estimateur du maximum de vraisemblance

:   L'estimateur du maximum de vraisemblance n'est pas sûr d'exister, notamment si toutes les réponses jusque-là ont été vraies ou si elles ont été toutes fausses. Ce problème avait déjà été mis en évidence par @Lan2014 et par @Magis2015.

C'est pourquoi on préférerait poser des questions peu corrélées afin de maximiser nos chances d'obtenir une réponse fausse et une réponse vraie.

# Processus à point déterminantal

Ces processus, tirés de la théorie des matrices aléatoires, ont des applications en processus de Markov, etc. Ils permettent d'échantillonner des éléments diversifiés pour une certaine mesure de distance. Cela a par exemple des applications en recommandation pour sélectionner des éléments diversifiés, dans les moteurs de recherche afin que les résultats en tête portent sur des thèmes différents (par exemple, pour une requête « jaguar », l'animal et la voiture) ou encore en génération de résumé, à partir d'un corpus de textes, par exemple des articles de presse dont on souhaiterait sélectionner les thèmes principaux.

Formellement, $P$ est un processus à point déterminantal (PPD) s'il vérifie pour tout ensemble $Y \subset \{1, \ldots, n\}$ :

$$ Pr(Y \subset X) \propto \det K_Y $$

où $K_Y$ est la sous-matrice carrée de $K$ indexée par les éléments de $Y$ en ligne et colonne.

Une intuition est que le déterminant d'une matrice est le volume du parallélotope formé par ses lignes (ou colonnes). Ainsi, moins les vecteurs de similarité seront corrélés, plus grand sera leur volume. On peut encore le voir de la façon suivante : des vecteurs de questions similaires apportent une information similaire. Afin d'avoir le plus d'information possible au début du test il vaut mieux choisir des vecteurs écartés deux à deux.

Il existe des algorithmes efficaces pour échantillonner selon une PPD @Kulesza2012, y compris lorsqu'on fixe à l'avance le nombre d'éléments qu'on souhaite sélectionner ($k$-PPD). En revanche, le problème de déterminer le mode de cette distribution (c'est-à-dire l'ensemble $X$ de plus grande probabilité a posteriori) est un problème NP-difficile, néanmoins des algorithmes d'approximation ont été développés. Ce n'est que récemment que les PPD sont appliqués à l'apprentissage statistique, mais surtout à des méthodes de diversification et de résumé.

Un autre avantage de cette méthode est qu'on garantit que le choix de $k$ questions est randomisé, donc on ne pose pas les mêmes premières questions à tout le monde, ce qui permet d'éviter de griller trop d'items. Cela s'appelle le taux d'exposition des questions.

# InitialD

Notre contribution consiste à appliquer la méthode de tirage d'éléments diversifiés PPD au choix de questions diversifiées au début d'un test, de façon automatique.

Étant donné un calibrage de type MIRT, et donc une représentation distribuée des questions en dimension $d$, on tire $k$ vecteurs parmi ceux-là selon PPD. Nous émettons l'hypothèse qu'en choisissant ainsi, les réponses de l'apprenant auront de grandes chances de ne pas être que vraies ou que fausses mais alternées, ce qui permettra de faire converger l'estimateur du maximum de vraisemblance.

# Validation

## Protocole

À partir des données des apprenants, nous comparons 3 manières de choisir les $k$ premières questions à poser, étant donné un modèle de tests adaptatifs MIRT :

- random
- information de Fisher proche de 0,5
- PPD

La méthode est similaire à la méthode de double validation croisée présentée dans un chapitre ultérieur. Nous entraînons le modèle avec 80 % des apprenants et pour les apprenants restants nous simulons un démarrage à froid avec un choix de $k$ questions à faire.

Les valeurs que nous mesurons, pour différentes valeurs du nombre de questions $k$ :

- quelle est l'entropie de la distribution des vrai et des faux dans les réponses de l'apprenant ;
- quelle est la performance des prédictions qui découlent de ce premier groupe de questions.

## Résultats

## Discussion

Nous avons donc proposé une nouvelle méthode pour choisir les $k$ premières questions à poser.
