# Conclusion

## Travaux effectués

Dans cette thèse, nous avons décidé d'adopter le formalisme de l'apprentissage automatique pour définir le problème de l'évaluation adaptative des apprenants. Cela nous a permis d'avoir un point de vue générique, nous permettant de comparer différents modèles sur les mêmes données de tests. Cette différence de formalisme permettra également d'importer de nombreux autres modèles tels que des machines à vecteurs de support, ou des machines à hausse de gradient[^1]. Les modèles d'apprentissage automatique ont parfois une mauvaise réputation due à la difficulté d'interpréter certains modèles, mais ce n'est pas le cas de modèles plus simples tels que la régression logistique, qui est déjà un exemple de modèle d'apprentissage automatique.

 [^1]: En anglais, *gradient boosting machine*.

Nous avons mis en évidence à la section \vref{use-cases} que selon le but du test : au début d'un MOOC, au milieu d'un MOOC ou à la fin d'un MOOC, le modèle plus approprié n'était pas le même. Pour choisir un modèle, il faut se poser les questions suivantes :

- Quelle connaissance du domaine est disponible ? Un graphe de prérequis sur les CC développées dans le cours ? Ou bien une q-matrice ?
- Est-ce que la connaissance de l'apprenant évolue alors qu'il passe le test ? Par exemple, a-t-il accès à des notes de cours ?
- Souhaite-t-on poser peu de questions pour explorer les connaissances de l'apprenant ou le faire progresser le plus possible alors qu'il passe le test ?

Les modèles que nous avons décrits proviennent de divers domaines de la littérature. Les experts des domaines devraient communiquer davantage, de façon à éviter à donner des noms différents au même modèle dans des domaines différents (par exemple, théorie des espaces de connaissances à la section \ref{knowledge-space} et modèle de hiérarchie sur attributs à la section \ref{ahm}). Des méthodes de l'analytique de l'apprentissage devraient s'inspirer des travaux en psychométrie, les travaux en psychométrie devraient s'inspirer des travaux en apprentissage automatique.

Voir le modèle de Rasch comme un cas particulier de modèle de théorie de la réponse à l'item multidimensionnel à la section \vref{rasch-mirt}, et comparer le modèle DINA à un paramètre avec le modèle de Rasch \ref{discu-comp} nous a permis de proposer le modèle GenMA, tirant parti des avantages des autres modèles.

Voir le modèle GenMA comme un cas particulier de modèle de théorie de la réponse à l'item multidimensionnel, et la phase de calibrage de MIRT comme une méthode d'apprentissage non supervisé qui extrait automatiquement des caractéristiques des questions (qu'on appelle représentation distribuée en apprentissage automatique) à partir des réponses des apprenants, nous a permis d'appliquer un algorithme d'échantillonnage de processus à point déterminantal, récemment utilisée en apprentissage automatique [@Kulesza2013].

## Limitations

Dans les tests adaptatifs, nous n'observons pas toutes les réponses mais seulement celles aux questions que nous avons posées. Or, dans toutes les approches développées dans cette thèse, nous avons supposé que nous disposions des réponses de tous les apprenants à toutes les questions. Certains modèles se comportent différemment si tous les apprenants n'ont pas répondu à toutes les questions. En filtrage collaboratif, on est cependant habitué à traiter des matrices creuses, car les utilisateurs notent en moyenne 1 % de tous les produits.

Dans cette thèse, nous nous sommes concentrés sur l'évaluation d'un seul apprenant. Certaines méthodes en analytique de l'apprentissage s'intéressent à la manière dont un groupe de personnes résout un problème donné [@Goggins2015], à partir des traces d'utilisation de la plateforme et de l'utilisation d'une plateforme de discussion sur le côté.

<!-- De plus, des techniques de crowdsourcing devraient être utilisées pour qu'un groupe d'enseignants puisse collaborer pour définir la représentation d'un domaine, en s'inspirant sur les travaux de @Koedinger2012 de combinaison de q-matrices. -->

# Perspectives

## Progression de l'apprenant pendant le test

La théorie de la réponse à l'item suppose l'indépendance locale entre les questions : sachant le niveau de l'étudiant, ses réponses aux questions sont indépendantes. Cela suppose entre autres que les apprenants répondent de la même manière aux questions peu importe l'ordre dans lequel on les pose, et que le niveau de l'apprenant reste le même tout au long du test. Cette hypothèse est raisonnable dans le cadre d'un test de positionnement au début d'un cours ou d'un test rapide de diagnostic de connaissances en mi-parcours. Toutefois dans les systèmes de tuteurs intelligents on observe plutôt des modèles temporels, où le niveau de l'apprenant peut évoluer alors qu'il accomplit des tâches : bandits à plusieurs bras [@Clement2015], traçage de connaissances bayésien [@Koedinger2012], modèles de Markov cachés. Par exemple, @Clement2015 tente de maximiser le progrès de l'apprenant alors que des questions lui sont posées, avec des méthodes de bandit qui résolvent un compromis entre exploration des connaissances de l'apprenant et exploitation de ces données pour faire progresser l'apprenant. Ces modèles proviennent de l'apprentissage par renforcement, sous-branche de l'apprentissage automatique.

## Incorporer des informations supplémentaires sur les questions et les apprenants

Plus le système a de données sur les apprenants, meilleures sont les prédictions. Ainsi il serait intéressant d'intégrer des informations démographiques dans le profil : à l'aide de ces données supplémentaires, les caractéristiques des apprenants seraient enrichies. Toutefois, cela présente des problèmes de confidentialité : le système risque de favoriser une classe d'apprenants plutôt qu'une autre, ce qui pose des problèmes d'impact disparate, c'est-à-dire de discrimination involontaire.

Pour s'attaquer au problème de démarrage à froid lorsqu'on ne dispose pas d'informations sur les apprenants, on peut incorporer des liens entre les questions comme ce que fait @Van2013 sur des musiques. Par exemple on pourrait faire de la fouille de données (tf-idf) sur les mots de l'énoncé, ou bien accoler des mots-clés aux questions, qui seraient un premier moyen d'aller vers une q-matrice. Toutes ces données sont autant de caractéristiques qui permettront d'enrichir le système, c'est-à-dire déterminer des vecteurs de plus grande dimension.

## Considérer une représentation plus riche du domaine

Dans cette thèse, nous avons considéré des q-matrices comme représentation du domaine évalué par le test. Certaines approches utilisent des représentations plus riches telles que des ontologies, sur lesquelles il est possible de faire de l'inférence [@Mandin2014]. Ce genre de structure est difficile à construire, et surtout à combiner. Nous apprécions l'approche q-matrice, qui permet à plusieurs experts de partager et de combiner leur représentation du domaine [@Koedinger2012].

## Incorporer des générateurs automatiques d'exercices

Il est parfois utile de répéter les questions, par exemple lorsqu'on apprend du vocabulaire au moyen de cartes de support visuel, et de systèmes par répétitions espacées [@Altiner2011]. Notre approche correspond davantage à l'apprentissage d'une compétence plutôt que d'un item particulier. Aussi, ne pas poser la même question plusieurs fois mais plutôt des variantes, par exemple en mathématiques en changeant l'opération à effectuer, permet de réduire le risque que l'apprenant devine la bonne réponse. Il serait intéressant de coupler ça avec des générateurs automatiques d'exercices : à partir d'un système pouvant générer un exercice à partir des CC que l'on souhaite évaluer, la plateforme pourrait diversifier ses items et les apprenants pourraient demander de nouveaux exercices jusqu'à ce qu'ils maîtrisent les CC. Cela conviendrait au modèle DINA, mais pas au modèle GenMA ou Rasch qui a besoin d'un historique de passage sur un item pour fonctionner.

## Incorporer des systèmes de recommandation de ressources

Si l'on disposait d'une base de données faisant le lien entre des ressources éducatives et les composantes de connaissances sur lesquelles elles portent, il serait possible d'orienter un apprenant vers des ressources utiles, à partir des lacunes identifiées par notre système après un passage de test adaptatif. Si de plus, les ressources étaient évaluées par d'autres apprenants sous la forme de retours du type : \og Cette ressource m'a été utile / ne m'a pas été utile pour comprendre \fg, on se ramènerait à un problème de filtrage collaboratif.

Les sites d'e-commerce font la distinction entre le retour explicite donné par un apprenant, par exemple \og J'ai apprécié ce produit \fg{} et le retour implicite, tel que \og Cette personne est restée longtemps sur cette page \fg, ce qui peut indiquer qu'il est intéressé par son contenu. Ainsi, ces données d'utilisation sont traitées par les plateformes d'e-commerce à l'insu des utilisateurs pour connaître leurs clients mieux. Dans des plateformes d'apprentissage en ligne, il y a très rarement de retour explicite, donc ces techniques de retour implicite sont des méthodes d'intérêt pour améliorer la pertinence des recommandations de ressources d'apprentissage, en utilisant par exemple le temps passé sur une page, les recherches d'un utilisateur, la liste des ressources téléchargées par un apprenant et les commentaires postés [@Verbert2011]. Pour l'évaluation des apprenants, on pourrait imaginer qu'après avoir résolu correctement une question, l'apprenant reçoit une question supplémentaire : \og Pour résoudre cette question, vous semblez avoir consulté les ressources suivantes : […] Lesquelles vous ont été utiles pour résoudre cette question ? \fg{} Ces données peuvent aider à recommander des ressources utiles à de futurs apprenants ayant des difficultés pour résoudre ces questions.

## Considérer des interfaces plus riches pour l'évaluation

Dans cette thèse, nous avons considéré que les données d'évaluations des apprenants étaient sous la forme de succès ou échecs d'apprenants sur des questions. Cela comprend les tests comportant des questions à choix multiple, ou bien des questions à choix ouverts. Mais nos modèles peuvent être réutilisés tels quels pour l'analyse de données d'évaluations d'apprenants ayant résolu correctement ou non des tâches, telles que des niveaux de jeux sérieux, ou des interfaces plus complexes comme celles que l'on peut trouver dans le concours d'algorithmique Castor. Un exemple est donné à la figure \ref{castor-calc} : le problème à résoudre consiste à construire le nombre 51 en partant de zéro à l'aide d'une calculette qui ne contient que les boutons $+1$ et $\times 2$. Les examinés doivent aboutir au résultat en appuyant sur un nombre minimum de boutons pour obtenir tous les points. Tant qu'ils n'ont pas déterminé le nombre optimal, l'interface les invite à recommencer, sachant que chaque essai infructueux ne fait pas perdre de point. Cette activité très ludique est bénéfique pour l'apprentissage, car la tâche à résoudre est bien définie et l'examiné peut soit jouer avec l'interface, soit tenter de résoudre le problème sur papier. Lorsque l'examiné a résolu l'exercice, un texte lui explique qu'il vient de faire de l'informatique au moyen d'un paragraphe (en l'occurrence, pour cet exercice, il s'agit du système binaire).

\begin{figure}
\includegraphics{figures/castor-calcul}
\caption{Exemple d'interface d'évaluation tirée du concours Castor.}
\label{castor-calc}
\end{figure}

Ces tâches, paramétrisables (dans cet exemple, on peut demander d'abord à l'apprenant de construire le nombre 5), peuvent être liées à des composantes de connaissance, et à des notions de difficulté. On peut considérer que l'apprenant réussit la tâche s'il a obtenu le score maximal, 0 sinon, et ainsi se ramener aux hypothèses que nous avons considérées pendant cette thèse.

Il est également possible d'enregistrer tous les essais infructueux de l'apprenant pour détecter s'il a eu du mal à trouver la bonne réponse, et choisir l'activité suivante à lui présenter en conséquence. Nous détaillons à présent ce domaine qui consiste à évaluer les apprenants dans des jeux sérieux, appelé *évaluation furtive*.

# Évaluation furtive dans les jeux sérieux

@Shute2011 décrit la notion d'évaluation furtive. Le principe est de collecter les données d'une plateforme éducative alors que des apprenants sont en train de l'utiliser, sous la forme d'actions et de leurs résultats, et de faire des inférences sur le niveau de l'apprenant selon les différentes compétences associées à ces actions. On peut citer par exemple le Packet Tracer de Cisco étudié dans @Rupp2012, cf. Figure \ref{cisco} permettant de comprendre par la pratique comment fonctionne le routage des paquets dans un réseau ou *Newton's Playground* [@Shute2013], où les apprenants jouent avec une interface leur faisant découvrir des notions de physique. L'approche est basée sur deux éléments principaux : la conception d'une évaluation centrée sur les faits, et le retour fait à l'apprenant pour soutenir l'apprentissage.

\begin{figure}
\includegraphics[width=\linewidth]{figures/cisco}
\caption{Capture d'écran de Packet Tracer, développé par Cisco.}
\label{cisco}
\end{figure}

@Shute2011 insiste sur la capacité de l'évaluation furtive via les jeux vidéo à entretenir le flux (*flow*), c'est-à-dire l'état mental atteint par une personne lorsqu'elle est complètement absorbée par une activité, telle qu'une résolution de problème, et se trouve dans un état maximal de concentration, de plein engagement et de satisfaction dans son accomplissement. Ils motivent leur recherche par le fait qu'aujourd'hui, les problèmes auxquels nous sommes confrontés nécessitent de réfléchir de façon créative, critique, collaborative et systémique. Ainsi, comme dit @Shute2011, \og apprendre et réussir dans un monde complexe et dynamique ne peut être facilement mesuré par un test de connaissances composé de questions à choix multiple. \fg Ils proposent plutôt de repenser la notion d'évaluation, en identifiant les *compétences clés du 21\ieme{} siècle* et les façons d'évaluer leur acquisition par les apprenants.

## Évaluation centrée sur les faits et réseaux bayésiens

La conception d'une évaluation centrée sur les faits ont été formalisées par Mislevy. Les lignes principales sont les suivantes.

Modèle de compétences

:   Quelles connaissances et compétences doivent être évaluées ?

Modèle des faits

:   Quels comportements ou performance devraient révéler ces constructions ?

Modèle des tâches

:   Quelles tâches devraient éliciter ces comportements qui constituent les faits observés ?

Afin de modéliser les liens entre compétences et faits, @Shute2011 utilise des réseaux bayésiens. Nous pensons toutefois que cette approche est coûteuse à construire et doit être refaite pour chaque nouvelle interface d'évalution. De plus, elle impose une fixation a priori d'un modèle d'évaluation auquel un apprenant pourrait ne pas adhérer. Toutefois, cela permet de proposer un diagnostic alors même que l'on ne comporte d'aucun historique d'évaluation : le diagnostic n'a besoin que du modèle de compétences pour fonctionner. @Rupp2012 compare, pour le Packet Tracer, une méthode de diagnostic utilisant des réseaux bayésiens avec une approche utilisant le modèle hiérarchique d'attributs décrit à la Section \ref{ahm} qui requiert une q-matrice, et montre que les approches sont complémentaires.

# Le futur de l'évaluation

Une application prometteuse de notre recherche est la conception d'autoévaluation formative adaptative : avant les évaluations à fort enjeu en fin de cours, les apprenants aiment s'entraîner à passer des tests, afin d'avoir une idée de ce qui sera attendu d'eux. Cela a d'ailleurs un effet bénéfique sur l'apprentissage [@Dunlosky2013]. Le problème est que concevoir des exercices ou les calibrer est coûteux pour l'enseignant, mais nous avons vu dans cette thèse différentes méthodes pour automatiser ces processus : s'aider de l'historique de passage d'un test, générer automatiquement des exercices, tirer des planches d'exercices diversifiés.

Ces tests ne supposent aucune connaissance sur l'apprenant, ainsi les résultats peuvent être enregistrés de façon anonyme, ce qui permet à l'apprenant de faire table rase et de ne pas craindre que ses erreurs le poursuivent tout au long de la vie, ce qui est une crainte de nombreux parents d'élèves aujourd'hui [@Obama2014]. Nos modèles de tests permettent à l'apprenant d'avoir une photographie de sa connaissance à un certain moment, et un diagnostic afin de l'aider à se positionner sur une carte de compétences et comprendre ce qu'il aurait intérêt à apprendre ensuite.

Dans la communauté de l'analytique de l'apprentissage, certains argumentent qu'à partir du moment où une même plateforme enregistrera tout ce qu'on fait, des tests explicites disparaîtront au profit d'une *évaluation intégrée*, un contrôle continu automatique utilisant les données à disposition pour prédire la performance de l'étudiant et proposer une éducation sur mesure [@Shute2016; @Redecker2013]. En effet, si l'apprenant est continuellement observé par la plateforme et si un tuteur numérique peut répondre à leurs questions et recommander des activités (comme [le bot de GeorgiaTech](http://www.wsj.com/articles/if-your-teacher-sounds-like-a-robot-you-might-be-on-to-something-1462546621)), ils peuvent être les seuls acteurs de leur progrès et il n'y a plus besoin d'évaluer leurs connaissances à la fin du cours.

Nous pensons toutefois que même dans un futur où l'évaluation intégrée est possible, il y aura toujours besoin de tests adaptatifs, pour un usage ponctuel tel qu'un test standardisé (GMAT, GRE) ou pour les nouveaux apprenants au début d'un cours, dans la mesure où les plateformes en ligne seront amenées à avoir des apprenants de tous âges et profils, et qu'il faudra avoir en peu de temps une idée des connaissances qu'ils ont emmagasinées dans leur expérience [@Baker2014; @Lynch2014]. Une comparaison peut être faite avec les tests de positionnement en langues dans les grandes écoles, qui consistent à répartir les apprenants en différents groupes de niveaux.

<!-- multistage testing ; can specify the number of questions per stage -->

<!-- ask python questions no need; éviter de reposer des questions -->
<!-- allowing -->

Dans le futur, une plateforme pourra d'abord demander à l'apprenant les CC qu'il semble maîtriser. Des travaux à LAK 2016 ont toutefois montré que les apprenants ont du mal à s'autoévaluer. À partir de ces informations, la plateforme pourra lancer un test adaptatif, à l'issue duquel elle pourra lui faire un retour de type : \og Vous avez dit que vous maîtrisiez votre connaissance sur cette CC pourtant j'ai posé cette question et vous n'y avez pas répondu correctement. \fg{} Ainsi, la plateforme pourra argumenter sur ce désaccord. L'apprenant pourra à son tour rectifier le diagnostic en prouvant à la plateforme qu'elle maîtrise effectivement cette CC, et par là même pourra apprendre. Nous pensons qu'il devrait y avoir plus de recherche en analytique de l'apprentissage pour de tels systèmes, plus interactifs.

Également, il y a un compromis entre l'adaptativité, c'est-à-dire le processus qui s'adapte lui-même en fonction de son diagnostic de l'apprenant, et l'adaptabilité, qui consiste à laisser l'apprenant adapter le contenu lui-même [@Chatti2012]. Par exemple, après un test, la plateforme peut fournir à l'apprenant un diagnostic composé de points à retravailler. Mais l'apprenant peut décider de vouloir aller plus loin dans ce qu'il maîtrise. La plateforme pourra alors lui proposer un parcours pédagogique en faisant le compromis entre ce que l'apprenant doit renforcer et ce qu'il souhaite apprendre. Il faut trouver le bon équilibre entre permettre à l'apprenant de naviguer dans le cours sans le décourager devant l'immensité de ce qu'il peut apprendre. Afin que l'apprenant puisse être maître de son apprentissage, la plateforme doit lui redonner du contrôle en étant plus transparent sur les déductions qu'elle fait à partir de ses réponses aux tests.

<!-- Most collaborative filtering techniques assume the user-to-item matrix $M$ is of low rank $r$ and look for a low-rank approximation under the matrix factorization $M \simeq UV^T$ where $U$ and $V$ are assumed of width $r$. Please note that if $M$ is binary and the loss function for the approximation is the logistic loss, we get back to the MIRT model (as a generalized linear model), see Section \ref{mirt}. -->

<!-- \paragraph{Diversity} Recommender systems have been criticized to "put the user in a box" and harm serendipity. But since then, there has been more research into diversity (finding a set of diverse items to recommend) and explained recommendations. More recently, there has been a need of more interactive recommender systems, giving back power to the user by letting him steer the recommendations towards other directions. The application to learner systems is straightforward: we could help the learner navigate in the course. -->

<!-- \paragraph{Adding external information} Some recommender systems embed additional information in their learning models such as the description of the item, or even the musical content itself in the scope of music recommendation. In order to improve prediction over the test, one could consider extracting any features from the problem statements of the items and incorporate them within the feature vector. -->

Aujourd'hui, l'analytique de l'apprentissage ne se concentre pas que sur une adaptation automatique mais aussi des moyens de renforcer la motivation et l'humeur des apprenants. Cela pose des questions ouvertes quant au partage des informations que la plateforme a sur l'apprenant. Un avantage serait la confiance que l'apprenant a dans le système, mais un risque serait que les apprenants modifient leur comportement en conséquence de façon à truquer et contourner le système.
