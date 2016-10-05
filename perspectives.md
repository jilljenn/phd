# Conclusion

## Travaux effectués

Dans cette thèse, nous avons décidé de poser le regard de l'apprentissage automatique sur l'évaluation adaptative des apprenants. Cela nous a permis d'avoir un point de vue générique, nous permettant de comparer différents modèles sur les mêmes données de tests et de fournir des stratégies originales. Cela nous permettra également d'importer de nombreux autres modèles tels que des machines à vecteurs de support[^1], ou des machines à hausse de gradient[^2]. Les modèles d'apprentissage automatique ont parfois une mauvaise réputation due à la difficulté d'interpréter leurs déductions, mais ce n'est pas le cas de modèles linéaires ou log-linéaires tels que la régression logistique, qui est pourtant déjà un exemple de modèle d'apprentissage automatique.

 [^1]: En anglais, *support vector machine*.

 [^2]: En anglais, *gradient boosting machine*.

Nous avons mis en évidence à la section \vref{use-cases} que selon le type de test : au début d'un MOOC, au milieu d'un MOOC ou à la fin d'un MOOC, le modèle le plus approprié n'était pas le même. Pour choisir un modèle, il faut se poser les questions suivantes :

- De quelle représentation du domaine dispose-t-on ? Un graphe de prérequis sur les composantes de connaissances (CC) développées dans le cours ? Ou bien une q-matrice, qui fait le lien entre questions et CC requises ?
- S'agit-il de la première administration du test ou dispose-t-on déjà de données d'apprenants y ayant répondu ?
- Est-ce que les connaissances de l'apprenant évoluent alors qu'il passe le test ? Par exemple, a-t-il accès à des notes de cours ?
- Souhaite-t-on poser peu de questions pour identifier les connaissances de l'apprenant ou le faire progresser le plus possible alors qu'il passe le test ?

Les modèles de tests adaptatifs que nous avons étudiés proviennent de divers domaines de la littérature. Les angles sous lesquels nous avons choisi de les comparer qualitativement (voir section \vref{quali-comp}) nous ont permis de repérer que certains modèles nommés différemment étaient presque identiques (par exemple, la théorie des espaces de connaissances et le modèle de hiérarchie sur les attributs, voir section \vref{ahm}).

Comparer le modèle de diagnostic général aux modèles de théorie de la réponse à l'item (voir section \vref{gdm}), et étudier comment le modèle DINA, au départ un simple modèle de diagnostic cognitif, a été utilisé dans des tests adaptatifs, nous a permis de proposer le modèle de tests adaptatifs GenMA, tirant parti des avantages des autres modèles. GenMA est formatif, fournit un diagnostic plus vraisemblable que le modèle DINA car il incorpore des notions de discrimination selon chaque composante de connaissances, et est plus rapide à calibrer que les modèles habituels de théorie de réponse à l'item multidimensionnelle (MIRT).

Voir la phase de calibrage de GenMA comme un problème d'apprentissage non supervisé à partir des réponses des apprenants, nous a permis de redéfinir le problème de choisir les $k$ premières questions d'une façon géométrique. Nous avons ainsi pu proposer la stratégie InitialD, basée sur un algorithme d'échantillonnage de processus à point déterminantal, récemment utilisé en apprentissage automatique pour sa faible complexité [@Kulesza2012]. InitialD peut tirer un ensemble de $k$ questions diversifiées parmi $n$ avec une complexité $O(nk^3)$, qui permettent au modèle de diagnostic GenMA de converger vers un diagnostic plus vraisemblable des stratégies usuelles.

## Limitations

Dans les tests adaptatifs, nous n'observons pas toutes les réponses mais seulement celles aux questions que nous avons posées. Or, dans toutes les approches développées dans cette thèse requérant des données, nous avons supposé que nous disposions des réponses de tous les apprenants à toutes les questions. Certains modèles se comportent différemment si tous les apprenants n'ont pas répondu à toutes les questions. En filtrage collaboratif où les utilisateurs notent en moyenne 1 % de tous les produits, on est cependant habitué à traiter ce problème des matrices creuses. Ainsi, on pourrait appliquer ces techniques à notre problème.

Dans cette thèse, nous nous sommes concentrés sur l'évaluation d'un seul apprenant. Certaines méthodes en analytique de l'apprentissage s'intéressent à la manière dont un groupe de personnes résout un problème donné [@Goggins2015], à partir des traces d'utilisation de la plateforme et de l'utilisation d'une plateforme de discussion.

# Perspectives

## Extraction de q-matrice automatique

Pour nos expériences, nous avons dû extraire des q-matrices automatiquement. La méthode que nous avons testée a fourni de bons résultats, mais ce domaine reste à explorer : en effet, les q-matrices que nous avons obtenues n'ont aucune garantie d'être les meilleures q-matrices possibles et sont parfois difficilement interprétables.

## Tester différentes initialisations des modèles de tests adaptatifs

Nous nous sommes rendus compte qu'entre considérer un a priori dans le modèle DINA (par exemple, \og 86 % des apprenants ont pour état latent ``0010`` \fg) fournissait de moins bons résultats qu'un a priori uniforme. C'est une piste de recherche à explorer.

De même, dans GenMA nous considérons qu'au démarrage du test, l'apprenant est de niveau 0. Il serait intéressant de supposer qu'il est de niveau moyen au sein de la population.

## Différents noyaux pour InitialD

Dans notre expérience menée à la section \vref{dpp}, nous avons considéré un noyau linéaire. Il serait intéressant de tester d'autres noyaux : noyau gaussien, ou d'autres noyaux. Peut-être permettraient-ils de déterminer un meilleur ensemble de $k$ questions.

## Largeur optimale du prétest non adaptatif

Nous pourrions déterminer pour un jeu de données quelle valeur de $k$ permet d'obtenir le meilleur diagnostic initial avant de procéder à un test adaptatif (voir figure \vref{initiald-fraction-delta}).

## Généralisation de la théorie de la réponse à l'item multidimensionnelle

La théorie de la réponse à l'item est basée sur un produit scalaire entre les caractéristiques de l'apprenant $\mathbf{\theta_i}$ et les caractéristiques des questions $\mathbf{\delta_j}$. Or, on pourrait généraliser cela en appliquant la méthode du noyau, comme dans les machines à vecteur de support.

Faire cela aurait sans doute un meilleur pouvoir prédictif, mais l'on perdrait l'interprétation du diagnostic, car les caractéristiques estimées de l'apprenant ne correspondraient plus à des degrés de maîtrise ou des lacunes. Ainsi, on pourrait repérer des apprenants susceptibles d'avoir des lacunes, mais on ne pourrait pas leur expliquer pourquoi. Cela peut être utile dans certaines applications où un enseignant doit détecter les apprenants qui ont besoin d'aide.

## Prendre en compte la progression de l'apprenant pendant le test

La théorie de la réponse à l'item suppose l'indépendance locale entre les questions : les réponses aux questions sont indépendantes, conditionnellement à son niveau. Cela suppose, entre autres, que chaque apprenant répond de la même manière aux questions peu importe l'ordre dans lequel on les pose, et que le niveau de l'apprenant reste le même tout au long du test. Cette hypothèse est raisonnable dans le cadre d'un test de positionnement au début d'un cours ou d'un test rapide de diagnostic de connaissances en mi-parcours. Toutefois, dans les systèmes de tuteurs intelligents on observe plutôt des modèles temporels, où le niveau de l'apprenant peut évoluer alors qu'il accomplit des tâches : bandits à plusieurs bras [@Clement2015], *Bayesian Knowledge Tracing* [@Koedinger2012], modèles de Markov cachés. Par exemple, @Clement2015 tentent de maximiser le progrès de l'apprenant alors que des questions lui sont posées, avec des méthodes de bandit qui résolvent un compromis entre exploration des connaissances de l'apprenant et exploitation de ces données pour faire progresser l'apprenant. Ces modèles proviennent de l'apprentissage par renforcement, issu de l'apprentissage automatique, et nous pourrions nous en inspirer pour proposer des tests adaptatifs dans des systèmes de tuteurs intelligents.

## Incorporer des informations supplémentaires sur les questions et les apprenants

Plus le système a de données sur les apprenants, meilleures sont les prédictions. Ainsi il serait intéressant d'intégrer d'autres informations de l'apprenant dans son profil : à l'aide de ces données supplémentaires, les caractéristiques des apprenants seraient enrichies, et les modèles potentiellement plus prédictifs. Toutefois, le système risque de favoriser une classe d'apprenants plutôt qu'une autre, ce qui pose des problèmes d'impact disparate, c'est-à-dire de discrimination involontaire [@Feldman2015]. Si par exemple, le système enregistre qu'en Norvège, le score en algèbre est plus faible que dans les autres pays et administre un test à un nouvel apprenant norvégien, il risque de ne pas poser de questions en algèbre et d'avoir un a priori négatif sur l'apprenant pour cette composante de connaissances.

Pour s'attaquer au problème de démarrage à froid de l'apprenant, on peut incorporer des liens entre les questions comme ce que font @Van2013 sur des musiques. Par exemple, on pourrait faire de la fouille de données sur les mots de l'énoncé, ou bien accoler des mots-clés aux questions, qui seraient un premier moyen d'aller vers une q-matrice. Toutes ces données sont autant de caractéristiques qui permettront d'enrichir le système, c'est-à-dire de déterminer des vecteurs de plus grande dimension.

## Considérer une représentation plus riche du domaine

Dans cette thèse, nous avons considéré des q-matrices comme représentation du domaine évalué par le test. Certaines approches utilisent des représentations plus riches telles que des ontologies, sur lesquelles il est possible de faire des inférences [@Mandin2014]. Ce genre de structure est difficile à construire, et surtout à combiner. Nous apprécions l'approche q-matrice, qui permet à plusieurs experts de partager et de combiner leur représentation du domaine [@Koedinger2012]. Il y a donc un compromis entre l'information apportée en tant que représentation du domaine évalué, et la facilité de mise en œuvre du test.

De telles représentations plus riches permettraient d'administrer un test sans besoin de données précédentes. C'est une piste de recherche à explorer.

## Incorporer des générateurs automatiques d'exercices

Il est parfois utile de répéter les questions, par exemple lorsqu'on apprend du vocabulaire au moyen de cartes de support visuel, et de systèmes par répétitions espacées [@Altiner2011]. Notre approche correspond davantage à l'apprentissage d'une compétence plutôt que d'un item particulier. Aussi, ne pas poser la même question plusieurs fois mais plutôt des variantes, par exemple en mathématiques en changeant l'opération à effectuer, permet de réduire le risque que l'apprenant devine la bonne réponse. Il serait intéressant de coupler cela avec des générateurs automatiques d'exercices [@Cable2013] : à partir d'un système pouvant générer un exercice à partir des CC que l'on souhaite évaluer, la plateforme pourrait diversifier les questions qu'elle pose et les apprenants pourraient demander de nouveaux exercices jusqu'à ce qu'ils maîtrisent les CC. Cela conviendrait au modèle DINA, mais pas aux modèles GenMA et Rasch qui ont besoin d'un historique de passage sur un item pour fonctionner.

## Incorporer des systèmes de recommandation de ressources

Les tests adaptatifs permettent une meilleure personnalisation en organisant les ressources d'apprentissage. Le séquençage du programme (*curriculum sequencing*) consiste à définir des parcours d'apprentissage dans un espace d'objectifs d'apprentissage [@Desmarais2012]. Cela consiste à faire passer des évaluations de compétences pour adapter le contenu d'apprentissage à partir d'un minimum de faits observés. Par exemple, à l'issue d'un diagnostic de connaissances, le système a une idée plus précise des composantes de connaissances que maîtrise l'apprenant et peut ainsi filtrer le contenu du cours qui lui sera utile pour s'améliorer.

Si l'on disposait d'une base de données faisant le lien entre des ressources éducatives et les composantes de connaissances sur lesquelles elles portent, il serait possible d'orienter un apprenant vers des ressources utiles, à partir des lacunes identifiées par notre système après un passage de test adaptatif. Si de plus, les ressources étaient évaluées par d'autres apprenants sous la forme de retours du type : \og Cette ressource m'a été utile / ne m'a pas été utile pour comprendre \fg, on se ramènerait à la conception d'un système de recommandation.

Les sites d'e-commerce font la distinction entre le retour explicite donné par un apprenant, par exemple \og J'ai apprécié ce produit \fg{} et le retour implicite, tel que \og Cette personne est restée longtemps sur cette page \fg, ce qui peut indiquer qu'il est intéressé par son contenu. Ainsi, ces données d'utilisation sont traitées par les plateformes d'e-commerce à l'insu des utilisateurs pour mieux connaître leurs clients. Dans des plateformes d'apprentissage en ligne, il y a rarement de retour explicite [@Verbert2011], donc ces techniques de retour implicite sont des méthodes d'intérêt pour améliorer la pertinence des recommandations de ressources d'apprentissage, en utilisant par exemple le temps passé sur une page, les recherches d'un apprenant, la liste des ressources téléchargées et les commentaires postés. Pour l'évaluation des apprenants, on pourrait imaginer qu'après avoir résolu correctement une question, l'apprenant reçoit une question supplémentaire : \og Pour résoudre cette question, vous semblez avoir consulté les ressources suivantes : […] Lesquelles vous ont été utiles pour résoudre cette question ? \fg{} Ces données peuvent aider à recommander des ressources utiles à de futurs apprenants ayant des difficultés pour résoudre ces questions.

## Considérer des interfaces plus riches pour l'évaluation

Dans cette thèse, nous avons considéré que les données d'évaluations des apprenants étaient sous la forme de succès ou échecs d'apprenants sur des questions. Cela comprend les tests comportant des questions à choix multiples, ou bien des questions à réponse ouverte courte. Mais nous supposons que nos modèles peuvent être réutilisés tels quels pour l'analyse de données d'évaluations d'apprenants ayant résolu correctement ou non des tâches, telles que des niveaux de jeux sérieux, ou des interfaces plus complexes comme celles que l'on peut trouver dans le concours d'informatique Castor. Un exemple est donné à la figure \ref{castor-calc} : le problème à résoudre consiste à construire le nombre 51 en partant de zéro à l'aide d'une calculette qui ne contient que les boutons $+1$ et $\times 2$. Les examinés doivent aboutir au résultat en appuyant sur un nombre minimum de boutons pour obtenir tous les points. Tant qu'ils n'ont pas déterminé le nombre optimal, l'interface les invite à recommencer, sachant que chaque essai infructueux ne fait pas perdre de point. Cette activité très ludique est bénéfique pour l'apprentissage, car la tâche à résoudre est bien définie et l'examiné peut soit jouer avec l'interface, soit tenter de résoudre le problème sur papier. Lorsque l'examiné a résolu l'exercice, un texte lui explique qu'il vient de faire de l'informatique au moyen d'un paragraphe (en l'occurrence, pour cet exercice, il s'agit du système binaire).

\begin{figure}
\includegraphics{figures/castor-calcul}
\caption{Exemple d'interface d'évaluation tirée du concours Castor.}
\label{castor-calc}
\end{figure}

Ces tâches, paramétrisables (dans cet exemple, on peut demander d'abord à l'apprenant de construire le nombre 5), peuvent être liées à des composantes de connaissances, et à des notions de difficulté. On peut considérer que l'apprenant réussit la tâche s'il a obtenu le score maximal, 0 sinon, et ainsi se ramener aux hypothèses que nous avons considérées pendant cette thèse.

Il est également possible d'enregistrer tous les essais infructueux de l'apprenant pour détecter s'il a eu du mal à trouver la bonne réponse, et choisir l'activité suivante à lui présenter en conséquence. Nous aimerions explorer cette piste de recherche.

## Évaluation furtive dans les jeux sérieux

@Shute2011 décrit la notion d'évaluation furtive. Le principe est de collecter les données d'une plateforme éducative alors que des apprenants sont en train de l'utiliser, sous la forme d'actions et de leurs résultats, et de faire des inférences sur le niveau de l'apprenant selon les différentes compétences associées à ces actions. On peut citer par exemple le Packet Tracer de Cisco étudié par @Rupp2012 (voir figure \ref{cisco}) permettant de comprendre par la pratique comment fonctionne le routage des paquets dans un réseau ou *Newton's Playground* [@Shute2013], où les apprenants jouent avec une interface leur faisant découvrir des notions de physique. L'approche est basée sur deux éléments principaux : la conception d'une évaluation centrée sur les faits, et le retour fait à l'apprenant pour soutenir l'apprentissage.

\begin{figure}
\includegraphics[width=\linewidth]{figures/cisco}
\caption{Capture d'écran de Packet Tracer, développé par Cisco.}
\label{cisco}
\end{figure}

@Shute2011 insiste sur la capacité de l'évaluation furtive via les jeux vidéo à entretenir le flux (*flow*), c'est-à-dire l'état mental atteint par une personne lorsqu'elle est complètement absorbée par une activité, telle qu'une résolution de problème, et se trouve dans un état maximal de concentration, de plein engagement et de satisfaction dans son accomplissement. Ils motivent leur recherche par le fait qu'aujourd'hui, les problèmes auxquels nous sommes confrontés nécessitent de réfléchir de façon créative, critique, collaborative et systémique. Ainsi, comme dit @Shute2011, \og apprendre et réussir dans un monde complexe et dynamique ne peut être facilement mesuré par un test de connaissances composé de questions à choix multiple. \fg Ils proposent plutôt de repenser la notion d'évaluation, en identifiant les *compétences clés du 21\ieme{} siècle* et les façons d'évaluer leur acquisition par les apprenants.

### Évaluation centrée sur les faits et réseaux bayésiens

La conception d'une évaluation centrée sur les faits a été formalisée par @Mislevy2012. Les lignes principales sont les suivantes.

Modèle de compétences

:   Quelles connaissances et compétences sont censées être évaluées ?

Modèle des faits

:   Quels comportements ou performance devraient révéler ces constructions ?

Modèle des tâches

:   Quelles tâches devraient éliciter ces comportements qui constituent les faits observés ?

Afin de modéliser les liens entre compétences et faits, @Shute2011 utilise des réseaux bayésiens. Nous pensons toutefois que cette approche est coûteuse à construire et doit être reproduite pour chaque nouvelle interface d'évaluation. De plus, elle impose de fixer a priori un modèle d'évaluation auquel un apprenant pourrait ne pas adhérer. Toutefois, cela permet de proposer un diagnostic alors même que l'on ne dispose d'aucun historique d'évaluation : le diagnostic n'a besoin que du modèle de compétences pour fonctionner. @Rupp2012 comparent, pour le Packet Tracer, une méthode de diagnostic utilisant des réseaux bayésiens avec une approche utilisant le modèle de hiérarchie sur les attributs décrit à la section \vref{ahm} qui requiert une q-matrice, et montre que les approches sont complémentaires.

Nous aimerions déterminer si notre approche peut s'appliquer dans ce cadre où il y a plusieurs moyens d'aboutir à la bonne réponse, et que deux chemins de résolution requièrent des composantes de connaissances différentes.

# Le futur de l'évaluation

Une application prometteuse de notre recherche est la conception d'autoévaluation formative adaptative : avant les évaluations à fort enjeu en fin de cours, les apprenants aiment s'entraîner à passer des tests, afin d'avoir une idée de ce qui sera attendu d'eux. Cela a d'ailleurs un effet bénéfique sur l'apprentissage [@Dunlosky2013]. Concevoir des exercices ou spécifier des valeurs de difficulté ou de discrimination est coûteux pour l'enseignant, mais nous avons vu dans cette thèse différentes méthodes pour automatiser ces processus : s'aider de l'historique de passage d'un test pour calibrer automatiquement des paramètres de discrimination, générer des fiches d'exercices diversifiées.

Les tests que nous proposons ne supposent aucune connaissance sur l'apprenant, ainsi les résultats peuvent être enregistrés de façon anonyme, ce qui permet à l'apprenant de faire table rase et de ne pas craindre que ses erreurs le poursuivent tout au long de la vie, ce qui est une crainte de nombreux parents d'élèves aujourd'hui [@Obama2014]. Nos modèles de tests permettent à l'apprenant d'avoir une photographie de ses connaissances à un certain moment, et un diagnostic afin de l'aider à se positionner sur une carte de compétences et comprendre ce qu'il aurait intérêt à apprendre ensuite.

Dans la communauté de l'analytique de l'apprentissage, certains argumentent qu'à partir du moment où une même plateforme enregistrera tout ce qu'on fait, des tests explicites disparaîtront au profit d'une *évaluation intégrée*, un contrôle continu automatique utilisant les données à disposition pour prédire la performance de l'étudiant et proposer une éducation sur mesure [@Shute2016; @Redecker2013]. En effet, si l'apprenant est continuellement observé par la plateforme et si un tuteur numérique peut répondre à ses questions et recommander des activités [@Korn2016], ils peuvent être les seuls acteurs de leur progrès et il n'y a plus besoin d'évaluer leurs connaissances à la fin du cours.

Nous pensons toutefois que même dans un futur où l'évaluation intégrée est possible, il y aura toujours besoin de tests adaptatifs, pour un usage ponctuel tel qu'un test standardisé (GMAT, GRE) ou pour les nouveaux apprenants au début d'un cours, dans la mesure où les plateformes en ligne seront amenées à avoir des apprenants de tous âges et profils, et qu'il faudra avoir en peu de temps une idée des connaissances qu'ils ont emmagasinées dans leur expérience [@Baker2014; @Lynch2014]. Une comparaison peut être faite avec les tests de positionnement en langues dans les grandes écoles, qui consistent à répartir les apprenants en différents groupes de niveaux.

Dans le futur, une plateforme pourra d'abord demander à l'apprenant les composantes de connaissances (CC) qu'il pense maîtriser. À partir de ces informations, la plateforme pourra lancer un test adaptatif, à l'issue duquel elle pourra lui faire un retour de type : \og Vous avez dit que vous maîtrisiez cette CC pourtant j'ai posé cette question et vous n'y avez pas répondu correctement. \fg{} Ainsi, la plateforme pourra argumenter sur ce désaccord. L'apprenant pourra à son tour rectifier le diagnostic en prouvant à la plateforme qu'il maîtrise effectivement cette CC, et ainsi de suite. Nous pensons qu'il devrait y avoir plus de recherche en analytique de l'apprentissage pour de tels systèmes, plus interactifs.

Après un test, la plateforme peut fournir à l'apprenant un diagnostic composé de points à retravailler. Mais l'apprenant peut décider de vouloir aller plus loin dans ce qu'il maîtrise. La plateforme pourra alors lui proposer un parcours pédagogique en prenant en compte ce que l'apprenant doit renforcer et ce qu'il souhaite apprendre. Il faut trouver le bon équilibre entre permettre à l'apprenant de naviguer dans le cours sans le décourager devant l'immensité de ce qu'il peut apprendre. Afin que l'apprenant puisse être maître de son apprentissage, la plateforme doit lui redonner du contrôle en étant plus transparente sur les déductions qu'elle fait à partir de ses réponses aux tests.

Aujourd'hui, l'analytique de l'apprentissage ne se concentre pas que sur une adaptation automatique mais aussi des moyens de renforcer la motivation et l'humeur des apprenants. Cela pose des questions ouvertes quant au partage des informations que la plateforme emmagasine sur l'apprenant. Une autre question est de savoir à quel point la plateforme devrait communiquer à l'apprenant les informations qu'elle déduit de son comportement. Un avantage serait la confiance que l'apprenant a dans le système, mais un risque serait que les apprenants modifient leur comportement en conséquence de façon à truquer et contourner le système.
