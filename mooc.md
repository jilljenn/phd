# Description du MOOC

Nous avons testé un modèle de test adaptatif sur de véritables données de MOOC issues d'un cours d'analyse fonctionnelle donné par Jean Cagnol, professeur à CentraleSupélec, sur la plateforme Coursera en 2014.

Le cours a accueilli 25354 inscrits.

Le cours était composé de 8 leçons, à la fin de chacune un quiz, plus un examen final. Nous avons ignoré les QCM au sein de chaque vidéo car elles avaient trop peu de réponses possibles.

# Extraction de données

Afin de fonctionner, notre système de tests a besoin de :

- le passé des notes des utilisateurs sur la plateforme : un ensemble de motifs de réponse binaires (vrai ou faux), sous la forme $(r_1, \ldots, r_n)$ où $n$ est le nombre de questions posées ;
- une représentation des connaissances mises en œuvre dans le cours ;
- un lien entre chaque question et la composante de connaissance principale qu'elle requiert.

En cours de test, les informations que nous avons sur un apprenant sont :

- le résultat (vrai ou faux) à chaque question que le système lui a posée ;
- une estimation de la maîtrise de chaque composante de connaissance par le candidat.

Parmi les multiples essais, nous avons choisi le premier. Nous avons ainsi obtenu pour chaque quiz une liste de motifs de réponse sur chaque question.

## Ajustements

Cependant, sur un MOOC, les apprenants ne participent pas à tous les quiz. Ainsi se pose la question de comment considérer les entrées manquantes. De plus, lorsque plusieurs essais sont enregistrés, on peut choisir de considérer le premier ou celui de score maximum [@Bergner2015]. Dans notre cas, nous avons considéré à chaque fois le premier essai, dans une optique de démarrage à froid.

Enfin, les réponses des candidats à un QCM ne reflètent pas nécessairement leur maîtrise d'un sujet, la réponse peut être facile à deviner ou inversement, un apprenant peut faire une erreur d'inattention. Ainsi, nous suggérons de considérer un paramètre de robustesse $\varepsilon$ correspondant à la probabilité de deviner la bonne réponse tandis que la composante de connaissance correspondante n'est pas maîtrisée, ainsi qu'à la probabilité de se tromper devant une question qui requiert une composante de connaissance maîtrisée.

## Données extraites

À partir de toute la base de données SQL du MOOC, nous avons pu extraire les tests suivants :

- Quiz 1 topologie : 5770 essais de 3672 étudiants sur 6 questions (5770 x 6).
- Quiz 2 espaces métriques et normés : 3296 x 7
- Quiz 3 espaces de Banach et fonctions linéaires continues : 2467 x 7 (dont une réponse ouverte)
- Quiz 4 espaces de Hilbert : 1807 x 6
- Quiz 5 lemme de Lax-Milgram : 1624 x 7
- Quiz 6 espaces $L_p$ : 1504 x 6
- Quiz 7 distributions et espaces de Sobolev : 1358 x 9
- Quiz 8 application à la simulation d'une membrane : 1268 x 7
- Exam : 599 x 10

# Tests adaptatifs

Dans cet article, la problématique qui nous intéresse est la suivante : si l'on se limite à un nombre fixé de questions à poser à l'utilisateur mais qu'on s'autorise à choisir la question suivante seulement après chacune de ses réponses, quelles questions choisir afin d'explorer au mieux ses connaissances, et lui faire un retour à la fin du test ?

On suppose que l'on a accès à une donnée du cours qui est une représentation hiérarchique des composantes de connaissance. Celle-ci est sous la forme d'un graphe $G = (V, E)$ où $V$ est l'ensemble des composantes de connaissance et une arête $u \rightarrow v$ désigne la relation de prérequis : \og $u$ doit être maîtrisé pour maîtriser $v$ \fg.

Étant donné cette structure, on peut modéliser un apprenant par un ensemble de valeurs comprises entre 0 et 1 (le degré de maîtrise de chaque composante de connaissance), et au fur et à mesure que l'apprenant répond à des questions, le système peut mettre à jour l'estimation qu'il se fait de son niveau. En d'autres termes, la connaissance des réponses aux questions permet à mettre à jour une information a priori du niveau de l'étudiant, de façon bayésienne. Plus formellement, à tout moment du test on maintient une distribution de probabilité sur les états possibles de l'apprenant (maîtrise ou non-maîtrise de chaque composante de connaissance).

\begin{figure}
\includegraphics[width=\linewidth]{figures/functional-analysis.png}
\caption{Un exemple de graphe de prérequis.}
\end{figure}

Certaines questions sont plus informatives que d'autres. Par exemple, poser une question reliée à une composante qui n'a pas d'arc sortant est peu avantageux car la probabilité que l'étudiant la maîtrise est faible, or une réponse fausse n'apportera pas beaucoup d'information. Il est possible de quantifier plus formellement l'information que chaque question peut apporter. En théorie de l'information, une manière de représenter l'incertitude est l'entropie. Pour une variable $X$ pouvant prendre des valeurs avec des probabilités $(p_i)_{1 \leq i \leq n}$ :

$$ H(X) = - \sum_{i = 1}^n p_i \log_2 p_i. $$

Par exemple, une pièce parfaitement équilibrée peut prendre la valeur Pile avec probabilité 50 % et Face avec la même probabilité, ainsi son entropie est de 1, tandis qu'une pièce pouvant prendre la valeur Pile avec probabilité 90 % a une entropie de 0,470. La pièce équilibrée est donc celle d'incertitude maximale. Dans notre cas, en choisissant la question faisant le plus abaisser l'entropie, on vise à converger rapidement vers l'état mental de l'apprenant.

Afin d'illustrer cette approche, voici un exemple de test adaptatif. Si l'on considère le graphe de prérequis de la figure 1 et que l'apprenant maîtrise les notions de produit scalaire, d'espace métrique et celle de complétude mais pas d'espace de Banach, un test minimisant l'entropie à chaque étape et s'arrêtant lorsqu'un état a atteint une probabilité de 95 % se déroulera comme suit :

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
- Alors, l'apprenant maîtrise Produit scalaire, Distance, Norme, Ouvert/fermé, Complétude, Produit scalaire, mais pas Banach, Hilbert.

Ainsi, 5 questions ont été posées au lieu de 9 afin de déterminer l'état mental de l'apprenant et lui faire un retour. Cette méthode a été décrite dans @Falmagne2006 et a été appliquée dans la plateforme ALEKS. Elle est également liée à la notion de modèle de hiérarchie sur les attributs, dans les modèles de diagnostic cognitif [@Leighton2004; @Su2013].

Afin de simplifier l'étude tout en conservant un grand nombre de réponses, nous avons considéré le graphe de prérequis à la figure 1 et avons choisi un sous-ensemble de 9 questions tirées des quiz 1 à 4 du MOOC. Cela nous a permis de construire une matrice de motifs de réponse binaires de 3713 étudiants sur ces 9 questions portant sur les 9 composantes de connaissance Banach, Complétude, Convergence, Distance, Espace métrique, Hilbert, Norme, Ouvert et fermé, Produit scalaire. Chaque question a été choisie pour couvrir une composante de connaissance (et toutes celles qui sont nécessaires à sa maîtrise), ainsi chaque question correspond à un nœud du graphe de prérequis. Le nombre de motifs de réponse de chaque type est donné dans la table 1 et sa non-uniformité laisse entendre qu'il existe des corrélations entre les réponses aux questions (sinon, le nombre d'occurrences serait le même d'un motif de réponse à un autre).

\begin{table}
\centering
\begin{tabular}{c|c}
motif de réponse & nombre d'occurrences\\
\hline
000000010 & 1129 \\
000000000 & 460 \\
010110110 & 271 \\
110111111 & 263 \\
010110010 & 122 \\
111111111 & 116 \\
110111011 & 77 \\
110110110 & 70 \\
110110010 & 42 \\
010010010 & 41 \\
010110000 & 40 \\
110111110 & 38 \\
010010110 & 37 \\
111111011 & 36 \\
111110110 & 35 \\
010110100 & 34 \\
000110010 & 27 \\
010100010 & 26 \\
111110010 & 21 \\
010010000 & 21 \\
110111001 & 21 \\
110011111 & 21 \\
100010001 & 20 \\
110111101 & 19 \\
000010000 & 18 \\
111011111 & 17 \\
111110011 & 16 \\
000010010 & 15 \\
111111101 & 15 \\
010100110 & 15 \\
\end{tabular}
\caption{Les 30 motifs de réponse les plus fréquents pour le jeu de données extrait du MOOC d'analyse fonctionnelle.}
\end{table}

## Validation

Deux métriques nous permettent de valider notre modèle de test adaptatif. La première est le nombre moyen de questions avant arrêt du test (appelé *temps de convergence moyen*), c'est-à-dire avant que le critère de terminaison soit validé. La deuxième est le nombre de prédictions incorrectes (appelé *erreur de prédiction*), car il faut vérifier que le test ne converge pas vers un diagnostic qui ne correspond pas à la réalité.

Pour chaque étudiant de notre jeu de données, nous le soumettons à notre modèle de test adaptatif qui consiste à choisir la question réduisant le plus son incertitude (entropie). Dès qu'un état mental dépasse la probabilité 95 %, le test s'arrête. Cela permet de déterminer le nombre de questions moyen avant arrêt, ainsi que le nombre de prédictions incorrectes. Les résultats sont donnés dans la table 2.

\begin{table}
\centering
\begin{tabular}{c|c|c}
Valeur de $\varepsilon$ & Temps de convergence moyen & Erreur de prédiction moyenne\\
\hline
0 & 5,009 $\pm$ 0,003 & 1,075 $\pm$ 0,04\\
0,01 & 5,43 $\pm$ 0,016 & 1,086 $\pm$ 0,041\\
0,02 & 6,879 $\pm$ 0,019 & 1,086 $\pm$ 0,041\\
0,03 & 7,671 $\pm$ 0,027 & 0,956 $\pm$ 0,037\\
0,04 & 7,807 $\pm$ 0,023 & 1,086 $\pm$ 0,041\\
0,05 & 8,671 $\pm$ 0,027 & 0,956 $\pm$ 0,037\\
\end{tabular}
\caption{Métriques principales pour la validation du modèle de test adaptatif sur les données du MOOC d'analyse fonctionnelle}
\end{table}

## Discussion

La valeur de robustesse $\varepsilon = 0$ correspond à un test où l'on suppose que si l'apprenant répond correctement à une question, alors il maîtrise la composante de connaissance correspondante. Un tel test converge en 5 questions en moyenne, et prédit correctement 8 des 9 réponses du motif de réponse. Ainsi, en ne posant que 55 % des questions du test en fonction des réponses précédentes, il obtient un succès de 89 %.

Une plus grande valeur de robustesse $\varepsilon$ n'améliore pas tellement les prédictions, ce qui peut être expliqué par le faible nombre d'états possibles (35). Le graphe des prérequis à la figure 1 est très rudimentaire, ce qui ne le permet pas d'exprimer les connaissances d'un tel domaine des mathématiques. Toutefois, cet exemple minimal semble correspondre aux données du MOOC.

# Conclusion

Nous avons présenté un modèle de test adaptatif, permettant de réduire le nombre de questions posées tout en garantissant la fiabilité d'un test. Ce modèle se distingue de ceux utilisés en psychométrie tels que le modèle de Rasch car il permet en outre de faire un retour à l'étudiant sur les points non maîtrisés.

Ce modèle requiert toutefois un graphe de prérequis qui peut être coûteux à construire selon la discipline dans laquelle l'apprenant est évalué. Mais considérer que toutes les composantes de connaissances (au nombre de $n$) sont indépendantes aboutit à un nombre d'états mentaux de $2^n$, qui devient impraticable pour de grandes valeurs de $n$.

## Perspectives

La représentation sous la forme d'un graphe de prérequis peut être vue comme une ontologie minimale. D'autres modèles de tests non adaptatifs considèrent des ontologies pour la représentation des connaissances, tels que @Mandin2014. Des variantes adaptatives pourraient être développées.

Certains chercheurs présagent que les tests explicites vont être abandonnés au profit d'un contrôle continu [@Redecker2013], afin d'éviter les apprenants opportunistes qui s'entraînent pour le test final sans réellement maîtriser le cours. Si l'apprenant est continuellement suivi par la plateforme, il devient inutile de le tester davantage. Quoi qu'il en soit, des tests adaptatifs de bienvenue seront toujours utiles pour s'attaquer au problème du démarrage à froid.

Envisager d'adapter le processus d'évaluation en fonction de caractéristiques du profil telles que le pays est un point sensible. Cela pourrait davantage réduire le nombre de questions, mais pourrait également induire de la discrimination involontaire [@Feldman2015].

Enfin, savoir si la plateforme aurait intérêt à partager tout ce qu'elle sait sur l'apprenant avec l'apprenant est un autre sujet sensible. Cela lui permettrait de mieux comprendre ses intérêts, éventuellement de rectifier des diagnostics incorrects de la part du système, mais risquerait aussi de l'inciter à adopter un comportement antagoniste, ce qui pourrait nuire à des tests à grands enjeux. En attendant, nous suggérons de nous limiter à des données de tests anonymes et non démographiques pour choisir les questions du test, afin d'éviter toute discrimination.
