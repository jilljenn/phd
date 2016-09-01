# Perspectives

La théorie de la réponse à l'item suppose l'indépendance locale entre les questions : sachant le niveau de l'étudiant, ses réponses aux questions sont indépendantes. Cela suppose entre autres que les apprenants répondent de la même manière aux questions peu importe l'ordre dans lequel on les pose, et que le niveau de l'apprenant reste le même tout au long du test. Cette hypothèse est raisonnable dans le cadre d'un test de positionnement au début d'un cours ou d'un test rapide de diagnostic de connaissances en mi-parcours. Toutefois dans les systèmes de tuteurs intelligents on observe plutôt des modèles temporels, où le niveau de l'apprenant peut évoluer alors qu'il accomplit des tâches : bandits à plusieurs bras [@Clement2015], traçage de connaissances bayésien, modèles de Markov cachés.

Plus le système a de données sur les apprenants, meilleures sont les prédictions. Ainsi il serait intéressant d'intégrer des informations démographiques dans le profil, qui permettraient de mieux comprendre les erreurs. Toutefois, cela présente des problèmes de confidentialité. Aussi un risque d'impact disparate, de discrimination involontaire.

Pour répondre à ce démarrage à froid lorsqu'on ne dispose pas d'informations sur les apprenants, on peut incorporer des liens entre les questions comme ce que fait @Van2013 sur des musiques. Par exemple on pourrait faire un tf-idf sur les mots de l'énoncé, ajouter des mots-clés.

Avoir des représentations plus compliquées comme une ontologie [@Mandin2014]. Ce genre de structure est difficile à construire. Nous apprécions l'approche q-matrice, qui permet à plusieurs experts de partager et de combiner leur représentation du domaine [@Koedinger2012].

Il est parfois utile de répéter les questions, par exemple lorsqu'on apprend du vocabulaire au moyen de cartes de support visuel, et de systèmes par répétitions espacées [@Altiner2011]. Notre approche correspond davantage lorsqu'on cherche à apprendre une compétence plutôt qu'un item particulier. Aussi, ne pas poser la même question plusieurs fois mais plutôt des variantes, par exemple en mathématiques en changeant l'opération à effectuer, permet de réduire le risque que l'apprenant devine la bonne réponse. Il serait intéressant de coupler ça avec des générateur automatiques d'exercices.

# Le futur de l'évaluation

We described several models that could be used for adaptive assessment. A promising application is low-stakes adaptive formative assessments: before high-stakes assessments, learners like to train themselves in order to know what they are expected to know in order to complete the course. Such adaptive tests would be able to quickly identify the components that need further work and help the learner prepare for the final high-stake test. It would be interesting to couple this work with automatic item generation. Thus, learners could keep asking variants of the same problem until they master the skills involved. The results of these adaptive tests may be recorded anonymously in order to let the student "erase the blackboard" without any tracking. Indeed, no learner would like their mistakes to be recorded for their entire lives [@Obama2014].

<!-- PhD : débattre là-dessus avec un paragraphe parce que ça va un peu à l'encontre des learning analytics -->

With the help of learning analytics, explicit testing may be progressively replaced with embedded assessment, using multiple sources of data to predict student performance and tailor education accordingly [@Shute2015; @Redecker2013]. Indeed, if the learner is continuously monitored by the platform and if a digital tutor can answer their questions and recommend activities, they can be full actors of their continually-changing progress and there is no need for an explicit test at the end of the course.

But we will still need adaptive pretests for a specific usage such as international certifications (GMAT, GRE) or for newcomers at the beginning of a course, in order to identify effectively the latent knowledge they acquired in their past experience [@Baker2014; @Lynch2014].

<!-- multistage testing ; can specify the number of questions per stage -->

Our adaptativity rules only take as input the answers given so far by the learner, not their previous performances, allowing a learner to start from scratch. Using profile information such as the country to select the questions may lead to more accurate performance predictions (for example, from one country to another, the way to compute divisions is not the same). But allowing such sensible information to influence the assessment might result in disparate impact and other inadvertent discrimination.

<!-- ask python questions no need; éviter de reposer des questions -->
<!-- allowing -->

In the future, an online platform could first ask the learner about their presumed knowledge. Then, verify if the self-assessment holds and provide arguments for any possible disagreement. The learner could then possibly rectify this by proving it actually masters the knowledge components required, and possibly learn more material.
