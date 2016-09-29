# Tests adaptatifs

La personnalisation de l'enseignement et de l'évaluation est un fort enjeu de notre siècle. Donner la même feuille d'exercices à tous les élèves d'une classe conduit à des situations où certains élèves finissent très vite et demandent d'autres exercices, tandis que d'autres peinent à résoudre un exercice. Il serait plus profitable pour les élèves d'avoir des feuilles d'exercices personnalisées. Mais le travail consistant à piocher des exercices dans une banque de façon à maintenir un certain équilibre pour une unique feuille universelle est déjà difficile pour un professeur, alors concevoir des feuilles d'exercices différentes pour chaque étudiant peut sembler complexe à gérer. Heureusement, les progrès en traitement de l'information rendent cela possible. On voit ainsi aujourd'hui des professeurs d'université distribuer des énoncés différents à tous leurs étudiants lors d'un examen [@Zeileis2012], ce qui pose toutefois des questions d'impartialité de l'évaluation. Personnaliser l'évaluation permet également de poser moins de questions à chaque apprenant [@Chang2014], ce qui est d'autant plus utile que les apprenants passent aujourd'hui trop de temps à être testés [@Zernike2015].

Avec l'arrivée des cours en ligne ouverts massifs (MOOC), ce besoin en évaluation adaptative s'est accentué. Des cours de nombreuses universités à travers le monde peuvent être suivis par des centaines de milliers d'étudiants. Mais la pluralité des profils de ces apprenants, notamment leurs âges et leurs parcours, fait qu'il devient crucial d'identifier les connaissances que les apprenants ont accumulées dans le passé, afin de personnaliser leur expérience d'apprentissage et d'aider le professeur à mieux connaître sa classe pour améliorer son cours. Or, répondre à de nombreuses questions d'un test de positionnement au début d'un cours risque de paraître fastidieux pour les apprenants [@Desmarais2012]. Il est alors encouragé de ne poser des questions que lorsque c'est nécessaire, par exemple ne pas poser des questions trop difficiles tant que l'apprenant n'a pas répondu à des questions faciles, et ne pas poser des questions requérant des compétences que l'apprenant semble déjà maîtriser, au vu de ses réponses précédentes [@Chang2014].

Cette réduction du nombre de questions d'un test a été étudiée depuis longtemps en psychométrie. La théorie de la réponse à l'item suppose qu'un faible nombre de variables peut expliquer les réponses d'un étudiant à plusieurs questions, et cherche à déterminer les questions les plus informatives pour dévoiler les facteurs latents de l'étudiant [@Hambleton1985]. Cette théorie a ainsi permis de développer des modèles de tests *adaptatifs*, qui posent une question à un apprenant, évaluent sa réponse et choisissent en fonction de celle-ci la question suivante à lui poser. Alors que la théorie de la réponse à l'item remonte aux années 50, ces tests sont aujourd'hui utilisés en pratique par le GMAT, une certification administrée à des centaines de milliers d'étudiants chaque année. Toutefois, les enjeux de ces tests sont davantage liés à l'évaluation qu'à la formation : leur objectif est de mesurer les apprenants afin de leur remettre ou non un certificat, plutôt que de leur faire un retour sur leur lacunes. Un tel retour leur serait plus utile pour s'améliorer, et également renforcerait leur engagement. Ainsi, les organismes de certification se placent davantage du côté des institutions, qui décident d'une barre d'admissibilité et d'un quota d'entrants, tandis qu'une plateforme de MOOC se place davantage du côté de ses utilisateurs, les apprenants.

On distingue deux types de tests adaptatifs. Des tests adaptatifs *sommatifs* mesurent l'apprenant et lui renvoient un simple score, tandis que des tests adaptatifs *formatifs* font un diagnostic des connaissances de l'apprenant afin qu'il puisse s'améliorer, par exemple sous la forme de points à retravailler.

Les tests adaptatifs qui se contentent de mesurer l'apprenant opèrent de façon purement statistique, agnostique du domaine. En revanche, les tests formatifs ont besoin d'une représentation du domaine qui fait le lien entre les questions et les composantes de connaissances impliquées dans leur résolution.

# Analytique de l'apprentissage

En technologies de l'éducation, il existe deux domaines très proches qui sont celui de la fouille de données éducatives[^1] et l'analytique de l'apprentissage[^2]. La première consiste à se demander comment extraire de l'information à partir de données éducatives, en utilisant les modèles mathématiques adéquats. La deuxième se veut plus holistique et s'intéresse aux effets que les systèmes éducatifs ont sur l'apprentissage, et comment représenter les informations récoltées sur les apprenants de façon à ce qu'elles puissent être utilisées par des apprenants, des professeurs ou des administrateurs et législateurs.

 [^1]: En anglais, *educational data mining*.

 [^2]: En anglais, *learning analytics*.

Plus généralement, l'analytique de l'apprentissage consiste à se demander comment utiliser les données récoltées sur les apprenants pour améliorer l'apprentissage, au sens large.

# Apprentissage automatique

Lorsqu'on cherche à modéliser un phénomène naturel, on peut utiliser un modèle statistique, dont on estime les paramètres en fonction des occurrences observées. Par exemple, si on suppose qu'une pièce suit une loi de Bernoulli et tombe sur Face avec probabilité $p$ et Pile avec probabilité $1 - p$, on peut estimer $p$ à partir de l'historique des occurrences des lancers de la pièce. Plus l'historique est grand, meilleure sera l'estimation de $p$. À partir de ce modèle, il est possible de faire des prédictions sur les futurs lancers de la pièce.

L'apprentissage automatique consiste à construire des modèles à partir d'ex\-emples capables de prédire des caractéristiques sur des données inédites, par exemple : reconnaître des chiffres sur des codes postaux, ou des chats sur des images. Plus il y a d'exemples pour entraîner le modèle, meilleures sont ses prédictions.

En ce qui nous concerne, nous souhaitons utiliser l'historique des réponses d'apprenants sur un test pour permettre de concevoir automatiquement un test adaptatif composé des mêmes questions. Dans le cadre d'un MOOC, par exemple, il sera possible de réutiliser les données des apprenants d'une session pour proposer des tests plus efficaces pour la session suivante.

## Systèmes de recommandation

\label{collaborative-filtering}

Une application de l'apprentissage automatique est l'élaboration de systèmes de recommandation, capables de recommander des ressources à des utilisateurs en fonction d'autres ressources qu'ils ont appréciées. En technologies de l'éducation, de tels systèmes sont appliqués à la recommandation de ressources pédagogiques [@Chatti2012; @Manouselis2011; @Verbert2011]. Pour concevoir de tels systèmes, une technique possible est celle du *filtrage collaboratif*. À partir des données communiquées par les autres internautes (*collaboratif*), il est possible de faire le tri de façon automatique (*filtrage*) pour un nouvel utilisateur, par exemple en identifiant des internautes ayant un profil similaire à celui-ci et en lui suggérant des ressources qui les ont satisfaits.

Il y a dans ce domaine de recherche des objectifs similaires au nôtre : en effet, nous cherchons justement à positionner un nouvel apprenant par rapport aux autres en peu de questions, ce qui consiste à faire le tri parmi les questions à poser. Certains services recourent à des tests adaptatifs de façon similaire aujourd'hui, par exemple Facebook suggère à ses utilisateurs des amis à ajouter au moyen de questions de type : « Vous connaissez peut-être… » car le fait qu'ils connaissent certaines personnes implique une forte probabilité qu'ils en connaissent certaines autres.

En filtrage collaboratif, on fait l'hypothèse que l'on dispose d'utilisateurs ayant noté certains objets : $m_{ui}$ désigne la note que l'utilisateur $u$ affecte à l'objet $i$. La matrice observée $M = (m_{ui})$ est creuse, c'est-à-dire qu'une faible partie de ses entrées est renseignée. Le problème consiste à déterminer les entrées manquantes de $M$ (voir figure \ref{matrix-completion}). Afin d'accomplir cette tâche, on suppose en général que $M$ a un faible rang, c'est-à-dire que les notes des utilisateurs sont dans un espace de faible dimension, ou encore qu'on peut les exprimer par un faible nombre de composantes.

\begin{figure}
\includegraphics[width=\linewidth]{figures/cf.jpg}
\caption{Un exemple de problème de filtrage collaboratif appliqué à la complétion de matrice.}
\label{matrix-completion}
\end{figure}

L'historique d'un test peut également être représenté par une matrice $M = (m_{ui})$ où l'élément $m_{ui}$ représente 1 si l'apprenant $u$ a répondu correctement à la question $i$, 0 sinon. Administrer un test adaptatif à un nouvel apprenant revient à ajouter une ligne dans la matrice et choisir les composantes à révéler (les questions à poser) de façon à inférer les composantes restantes (les questions qui n'ont pas été posées, voir figure \ref{test-history}).

\begin{figure}
\includegraphics[width=\linewidth]{figures/history}
\caption{Un modèle de test adaptatif vu comme un problème de complétion de matrice.}
\label{test-history}
\end{figure}

On peut citer de nombreuses différences : les connaissances évoluent plus vite que les goûts ; il y aura toujours des discordes entre les goûts des utilisateurs, tandis qu'en éducation, on aimerait que tout le monde puisse passer d'un état où il ne répond pas correctement partout à un état où il répond correctement partout. Mais comme nous le verrons dans cette thèse, plusieurs stratégies issues du filtrage collaboratif pourront être appliquées à notre problème.

<!-- ## Comparaison de méthodes par validation croisée

Une question récurrente est de savoir comment comparer deux algorithmes de filtrage collaboratif. La méthode de *validation croisée* consiste à séparer les notes dont on dispose en deux parties : notes d'entraînement et de test, et de tenter de prédire les notes de test à partir des notes d'entraînement. Ainsi, les notes de test ne sont considérées que pour l'évaluation des algorithmes. Dans cette thèse, nous appliquons cette méthode à l'évaluation de modèles de tests adaptatifs.

## Démarrage à froid

Lorsqu'un nouvel utilisateur se rend sur un site de recommandation, le système n'a aucune information sur ses goûts et doit donc solliciter l'utilisateur afin d'obtenir ces informations : c'est le problème du *démarrage à froid* de l'utilisateur. Afin que le processus soit efficace, il est préférable de poser un minimum de questions, donc tout l'enjeu est de déterminer des œuvres discriminantes permettant au système d'avoir une idée précise des goûts de l'utilisateur. @Golbandi2011 construit ainsi un arbre de décision qui vise à répartir les utilisateurs dans des groupes au sein desquels le taux d'erreur des prédictions est faible. Il est également possible d'incorporer des informations supplémentaires sur les produits (descriptions, auteurs, thèmes, etc.) afin de calculer des valeurs de similarité entre œuvres et pouvoir déterminer par inférence des œuvres susceptibles de plaire à l'utilisateur.

Ce problème du démarrage à froid pour l'utilisateur est analogue à notre problème de choisir les meilleures questions à poser à un apprenant.

## Obtenir des recommandations diversifiées

Enfin, dans les systèmes de recommandation on cherche parfois à déterminer un ensemble diversifié de recommandations : plutôt que de trier les résultats par pertinence, un moteur de recherche, qui n'est autre qu'un système de recommandation de pages Web, a plutôt intérêt à présenter des éléments diversifiés. Si l'on trie par pertinence les résultats associés à la recherche \og jaguar \fg, on risque de se retrouver avec seulement des liens associés à l'animal, ou seulement des liens à la marque de voiture, alors qu'on aimerait pouvoir récapituler les résultats de recherche à ces deux catégories, afin de maximiser les chances que l'internaute trouve ce qu'il recherche.

Ce problème de récapitulation des items pour l'utilisateur est analogue à notre recherche de la réduction du nombre des questions à présenter à un apprenant. -->

# Problèmes

Nous nous sommes intéressés aux problèmes suivants.

Réduction du nombre de questions d'un test

:   Si un intervenant ne peut poser que $k$ questions d'une banque de $n$ questions (où $k < n$) à un apprenant, lesquelles choisir ? Pour ce problème, nous avons considéré des tests adaptatifs ainsi que des tests non adaptatifs. Laquelle de ces approches fournit les meilleurs résultats en fonction de $k$ ?

Méthodologie de comparaison de modèles

:   Comment comparer des modèles de tests adaptatifs différents sur un même jeu de données ? Quels critères considérer pour la comparaison ? Quels sont les avantages et limitations des modèles de tests adaptatifs ?

Méthodologie de choix de modèles

:   Dans une situation donnée, en fonction des données dont un intervenant dispose et de ses objectifs, quel modèle de test adaptatif a-t-il intérêt à choisir ?

Élaboration d'un test adaptatif dans un MOOC

:   Dans le cas pratique d'une utilisation d'un test adaptatif dans un MOOC, comment pourrait-on procéder ?

# Contributions

## Système de comparaison de tests adaptatifs

Nous avons conçu un système permettant de comparer la capacité prédictive de plusieurs modèles de tests adaptatifs sur un même jeu de données et nous l'avons mis en œuvre sur différents jeux de données. Cela a permis de mettre en évidence que selon le type de jeu de données, le meilleur modèle n'est pas le même.

## GenMA, un modèle explicatif plus prédictif

(General Multidimensional Adaptive) La comparaison que nous avons effectuée a permis de mettre en exergue les limitations des différents modèles : par exemple, un modèle plus explicatif réalise des prédictions moins bonnes. Cela nous a permis de proposer un nouveau modèle hybride pour administrer des tests adaptatifs, plus précis car prenant en compte à la fois la difficulté des questions et une représentation des connaissances qu'évalue le test.\nomenclature{GenMA}{\emph{General Multidimensional Adaptive}}

## InitialD, tirer les $k$ premières questions pour démarrer

(Initial Determinant) Adapter le processus d'évaluation dès la première question peut conduire à des estimations biaisées du niveau de l'apprenant, car celui-ci peut faire des fautes d'inattention ou deviner la bonne réponse. Une variante des tests adaptatifs nommée tests à étapes multiples consiste à poser plusieurs questions avant d'estimer le niveau de l'apprenant pour minimiser l'erreur du premier diagnostic. Nous proposons une nouvelle approche pour choisir les $k$ premières questions reposant sur une mesure de diversité que l'on retrouve dans les systèmes de recommandation.\nomenclature{InitialD}{\emph{Initial Determinant}}

## Méthodologie de mise un œuvre d'un test adaptatif dans un MOOC

Afin de montrer ce qu'il est possible de faire à partir des données d'un véritable MOOC, nous avons mis en pratique les approches proposées, et l'avons illustré par une simulation d'un test adaptatif sur les données d'un MOOC de Coursera.

# Publications

### Poster à EDM 2015

\fullcite{Vie2015}.

### Workshop à EAEI 2015

\fullcite{Vie2015b}.

### Conférence à EC-TEL 2016

\fullcite{Vie2016}.

### Chapitre de journal Springer 2016

\fullcite{Vie2016b}.

### Revue STICEF 2016

\fullcite{Vie2016c}.

# Plan

Cette thèse est construite comme suit. Dans le chapitre 1, nous introduisons les tests adaptatifs et les techniques d'apprentissage automatique dont nous nous sommes inspirés, ainsi que les problèmes auxquels nous nous sommes attaqués et les contributions que nous avons proposées.

Dans le chapitre 2, nous décrivons les différents modèles de tests adaptatifs que nous avons rencontrés dans des communautés scientifiques différentes (théorie de la réponse à l'item, modèles basés sur des composantes de connaissances, apprentissage automatique), ainsi que leurs limitations.

Dans le chapitre 3, nous proposons une méthode pour comparer des modèles de tests adaptatifs différents de façon qualitative et quantitative sur un même jeu de données. Nous l'appliquons à la comparaison de deux modèles, un issu de la théorie de la réponse à l'item, un autre basé sur des composantes de connaissances.

Dans le chapitre 4, nous présentons un nouveau modèle de test adaptatif, qui peut être vu à la fois comme issu de la théorie de la réponse à l'item multidimensionnelle et comme un modèle basé sur des composantes de connaissance. En utilisant le système de comparaison décrit au chapitre 3, nous montrons qu'il a une capacité plus prédictive que les autres modèles, sur tous les jeux de données testés.

Dans le chapitre 5, nous présentons une nouvelle stratégie de choix des $k$ premières questions pour le modèle GenMA, basée sur une métrique qui quantifie à quel point un ensemble de questions peut être informatif. Nous montrons qu'elle permet de converger plus vite vers un diagnostic de l'apprenant.

Enfin, dans le chapitre 6, nous décrivons les perspectives de notre travail, et nos futures pistes de recherche.
