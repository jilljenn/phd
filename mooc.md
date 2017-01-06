Nous avons simulé un modèle de test adaptatif sur de véritables données de MOOC issues d'un cours d'analyse fonctionnelle donné par John Cagnol, professeur à CentraleSupélec, sur la plateforme Coursera en 2014.

Le cours a accueilli 25354 inscrits et était composé de 8 leçons, à la fin de chacune un quiz, plus un examen final.

### Extraction de données

Nous avons tenté d'extraire un maximum de données de test, à l'exception des QCM qui se trouvaient au sein de chaque vidéo car elles avaient trop peu de réponses possibles. Ainsi, pour chaque test il nous fallait récupérer les succès et échecs des apprenants sur la plateforme : un ensemble de motifs de réponse binaires (vrai ou faux), sous la forme $(r_1, \ldots, r_n)$ où $n$ est le nombre de questions posées dans un test.

Cependant, sur un MOOC, les apprenants ne participent pas à tous les quiz. Ainsi, il faut se demander comment considérer les entrées manquantes. De plus, parfois les apprenants tentent plusieurs fois de répondre à un quiz. Ainsi, il faut choisir quel essai considérer, le premier ou celui de score maximum [@Bergner2015]. Dans notre cas, nous avons considéré à chaque fois le premier essai, le dernier ayant de grandes chances d'être un succès.

À partir de la base de données SQL de ce MOOC, nous avons ainsi pu extraire les tests suivants :

- Quiz 1 topologie : 5770 essais de 3672 étudiants sur 6 questions.
- Quiz 2 espaces métriques et normés : $3296 \times 7$
- Quiz 3 espaces de Banach et fonctions linéaires continues : $2467 \times 7$ (dont une réponse ouverte)
- Quiz 4 espaces de Hilbert : $1807 \times 6$
- Quiz 5 lemme de Lax-Milgram : $1624 \times 7$
- Quiz 6 espaces $L_p$ : $1504 \times 6$
- Quiz 7 distributions et espaces de Sobolev : $1358 \times 9$
- Quiz 8 application à la simulation d'une membrane : $1268 \times 7$
- Exam : $599 \times 10$

### Représentation du domaine

Nous souhaitions nous placer dans le cas où un nouvel apprenant apparaît sur un MOOC et souhaite tester ses connaissances afin de déterminer s'il peut se passer de certaines parties du cours. Pour ce faire, il nous a fallu construire :

- une représentation des connaissances mises en œuvre dans le cours, sous la forme d'un graphe de prérequis $G = (V, E)$ où $V$ est l'ensemble des composantes de connaissances et une arête $u \rightarrow v$ désigne la relation de prérequis : \og $u$ doit être maîtrisé pour maîtriser $v$ \fg ;
- un lien entre chaque question et les composantes de connaissances (CC) qu'elle requiert. Pour simplifier, nous avons considéré que chaque question requérait une CC principale, et le graphe de prérequis permet d'indiquer quels sont les CC qu'il faut avoir maîtrisé pour maîtriser cette CC principale.

Cela nous a permis de construire un modèle de hiérarchie sur les attributs, défini à la section \vref{ahm} et similaire au modèle de théorie des espaces de connaissances. Ainsi, à partir de ce modèle de test adaptatif, pour chaque apprenant qui passe le test, les informations dont nous disposons sur lui sont :

- le résultat (vrai ou faux) à chaque question que le système lui a posée ;
- une distribution de probabilité $\pi$ sur les états latents possibles dans lesquels peut se trouver l'apprenant, c'est-à-dire : quels CC il semble maîtriser et quels CC il semble ne pas maîtriser (voir section \vref{dina}).

### Spécification des paramètres

Les réponses des candidats à un QCM ne reflètent pas nécessairement leur maîtrise d'un sujet, la réponse peut être facile à deviner ou inversement, un apprenant peut faire une erreur d'inattention. Ainsi, nous avons considéré un paramètre $\varepsilon$ correspondant à la probabilité de deviner la bonne réponse tandis que toutes les CC requises ne sont pas maîtrisées, ainsi qu'à la probabilité de se tromper bien qu'on ait toutes les CC requises. C'est-à-dire que tous les paramètres d'inattention et de chance sont fixés à une valeur unique $\varepsilon$.

### Déroulement du test adaptatif

Au fur et à mesure que l'apprenant répond à des questions, le système peut mettre à jour l'estimation qu'il se fait de son état latent. Chaque réponse à une question posée à l'apprenant permet de mettre à jour une information a priori sur ses états latents possibles, de façon bayésienne.

\begin{figure}[ht]
\centering
\includegraphics[width=0.7\linewidth]{figures/fa}
\caption{Un exemple de graphe de prérequis.}
\label{coursera-graph}
\end{figure}

Certaines questions sont plus informatives que d'autres. Par exemple, poser une question reliée à une composante qui n'a pas d'arc sortant est peu avantageux car la probabilité que l'étudiant la maîtrise est faible, or une réponse fausse n'apportera pas beaucoup d'information. Il est possible de quantifier plus formellement l'information que chaque question peut apporter. En théorie de l'information, une manière de représenter l'incertitude est l'entropie. Pour une variable $X$ pouvant prendre des valeurs avec des probabilités $(p_i)_{1 \leq i \leq n}$ :

\begin{equation}
H(X) = - \sum_{i = 1}^n p_i \log_2 p_i.
\end{equation}

Par exemple, une pièce parfaitement équilibrée peut prendre la valeur Pile avec probabilité 50 % et Face avec la même probabilité, ainsi son entropie est de 1, tandis qu'une pièce pouvant prendre la valeur Pile avec probabilité 90 % a une entropie de 0,470. La pièce équilibrée est donc celle d'incertitude maximale. Dans notre cas, en choisissant la question faisant le plus abaisser l'entropie, on vise à converger rapidement vers l'état latent de l'apprenant.

### Exemple de déroulement

Afin d'illustrer cette approche, voici un exemple de déroulement de test adaptatif. Si l'on considère le graphe de prérequis de la figure \ref{coursera-graph} et que l'apprenant maîtrise les notions de produit scalaire, d'espace métrique et celle de complétude mais pas d'espace de Banach, un test minimisant l'entropie à chaque étape et s'arrêtant lorsqu'un état a atteint une probabilité de 95 % se déroulera comme suit :

- **Q1.** Est-ce que l'apprenant maîtrise \og Produit scalaire \fg ?
- Oui.
- **Q2.** Est-ce que l'apprenant maîtrise \og Norme \fg ?
- Oui.
- **Q3.** Est-ce que l'apprenant maîtrise \og Complétude \fg ?
- Oui.
- **Q4.** Est-ce que l'apprenant maîtrise \og Banach \fg ?
- Non.
- **Q5.** Est-ce que l'apprenant maîtrise \og Espace métrique \fg ?
- Oui.
- Alors, l'apprenant maîtrise Produit scalaire, Distance, Norme, Ouvert/fermé, Complétude, Produit scalaire, mais pas Banach, Hilbert.\bigskip

Ainsi, 5 questions ont été posées au lieu de 9 afin de déterminer l'état mental de l'apprenant et lui faire un retour.

### Protocole expérimental

Afin de simplifier l'étude tout en conservant un grand nombre de réponses, nous avons considéré le graphe de prérequis à la figure \ref{coursera-graph} et avons choisi un sous-ensemble de 9 questions tirées des quiz 1 à 4 du MOOC. Cela nous a permis de construire une matrice de motifs de réponse binaires de 3713 étudiants sur ces 9 questions portant sur les 9 composantes de connaissances Banach, Complétude, Convergence, Distance, Espace métrique, Hilbert, Norme, Ouvert et fermé, Produit scalaire.

Chaque question a été choisie pour couvrir une composante de connaissances (et toutes celles qui sont nécessaires à sa maîtrise), ainsi chaque question correspond à un nœud du graphe de prérequis. Le nombre de motifs de réponse de chaque type est donné dans la table \ref{coursera-patterns} et sa non-uniformité laisse entendre qu'il existe des corrélations entre les réponses aux questions (sinon, le nombre d'occurrences serait le même d'un motif de réponse à un autre).

\begin{table}
\centering
\begin{tabular}{cc} \toprule
Motif de réponse & Nombre d'occurrences\\ \midrule
000000010 & 1129 \\
000000000 & 460 \\
010110110 & 271 \\
110111111 & 263 \\
010110010 & 122 \\
111111111 & 116 \\
110111011 & 77 \\
110110110 & 70 \\
110110010 & 42 \\
010010010 & 41 \\ \bottomrule
\end{tabular}
\caption{Les 10 motifs de réponse les plus fréquents pour le jeu de données extrait du MOOC d'analyse fonctionnelle.}
\label{coursera-patterns}
\end{table}

### Validation

Deux métriques nous permettent de valider notre modèle de test adaptatif. La première est le nombre moyen de questions avant arrêt du test (appelé *temps de convergence moyen*), c'est-à-dire avant que le critère de terminaison soit validé. La deuxième est le nombre de prédictions incorrectes (appelé *erreur de prédiction*), car il faut vérifier que le test ne converge pas vers un diagnostic qui ne correspond pas à la réalité.

Pour chaque apprenant de notre jeu de données, nous simulons un test adaptatif à l'aide du modèle de hiérarchie sur les attributs, qui choisit la question qui réduit le plus son incertitude (entropie). Dès qu'un état mental dépasse la probabilité 95 %, le test s'arrête. Cela permet de déterminer le nombre de questions moyen avant arrêt, ainsi que le nombre de prédictions incorrectes. Les résultats sont donnés dans la table \ref{coursera-results}.

\begin{table}
\centering
\begin{tabular}{ccc} \toprule
Valeur de $\varepsilon$ & Temps de convergence & Erreur de prédiction\\ \midrule
0 & 5,009 $\pm$ 0,003 & 1,075 $\pm$ 0,04\\
0,01 & 5,43 $\pm$ 0,016 & 1,086 $\pm$ 0,041\\
0,02 & 6,879 $\pm$ 0,019 & 1,086 $\pm$ 0,041\\
0,03 & 7,671 $\pm$ 0,027 & 0,956 $\pm$ 0,037\\
0,04 & 7,807 $\pm$ 0,023 & 1,086 $\pm$ 0,041\\
0,05 & 8,671 $\pm$ 0,027 & 0,956 $\pm$ 0,037\\ \bottomrule
\end{tabular}
\caption{Métriques principales pour la validation du modèle de test adaptatif sur les données du MOOC d'analyse fonctionnelle}
\label{coursera-results}
\end{table}

### Discussion

La valeur de robustesse $\varepsilon = 0$ correspond à un test où l'on suppose que si l'apprenant répond correctement à une question, alors il maîtrise la composante de connaissances correspondante. Un tel test converge en 5 questions en moyenne, et prédit correctement 8 des 9 réponses du motif de réponse. Ainsi, en ne posant que 55 % des questions du test en fonction des réponses précédentes, il obtient un succès de 89 %.

Une plus grande valeur de robustesse $\varepsilon$ n'améliore pas tellement les prédictions, ce qui peut être expliqué par le faible nombre d'états possibles (35). Le graphe des prérequis à la figure \ref{coursera-graph} est rudimentaire, ce qui ne lui permet pas d'exprimer les connaissances d'un tel domaine des mathématiques. Toutefois, cet exemple minimal de test adaptatif réduit le nombre de questions posées de façon satisfaisante, tout en garantissant la fiabilité du test. Ce modèle est à préférer au modèle de Rasch car il permet d'indiquer à l'apprenant les composantes de connaissances qu'il semble maîtriser. Cela requiert toutefois un graphe de prérequis qui peut être coûteux à construire selon la discipline dans laquelle l'apprenant est évalué.
