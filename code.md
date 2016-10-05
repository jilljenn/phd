\label{code}

Tout le code pour effectuer la comparaison quantitative de modèles est disponible sur GitHub à l'adresse \url{http://github.com/jilljenn/qna}.

# Modèles de tests adaptatifs

Certains modèles sont implémentés en R, d'autres en Python. Nous avons donc utilisé le package RPy2 [@Gautier2008] qui permet d'appeler des fonctions R avec du code Python, afin de pouvoir comparer tous les modèles avec du code générique.

Rasch ``irt.py``

:    Le modèle de Rasch est implémenté au moyen des packages ``ltm`` [@Rizopoulos2006] (pour *latent trait models*) et ``catR`` [@MagisRaiche2012] (pour *computerized adaptive testing in R*).

DINA ``qmatrix.py``

:   Nous avons implémenté le modèle DINA en Python. Au départ, nous utilisions le package ``CDM`` [@Robitzsch2014] (pour *cognitive diagnosis modeling*) pour estimer les paramètres d'inattention et de chance, mais nous avons finalement implémenté notre propre code de calibration, après avoir reconnu qu'il s'agissait d'un problème d'optimisation convexe. Afin d'accélérer la procédure d'entraînement parfois coûteuse, nous utilisons ``pypy`` : il s'agit d'un interpréteur Python qui compile le code à la volée en code machine, afin de fournir une exécution plus rapide de code Python. Pour l'utiliser, il suffit de taper ``pypy fichier.py`` au lieu de ``python fichier.py``.

MIRT et GenMA ``mirt.py``

:   Les modèles MIRT et GenMA sont implémentés au moyen des packages ``mirt`` [@Chalmers2012] et ``mirtCAT`` [@Chalmers2015].

# Comparaison quantitative

\section*{Modèles}

Le code de validation bicroisée est implémenté en Python. Un fichier de configuration ``conf.py`` permet de spécifier le jeu de données sur lequel effectuer l'expérience, ainsi que des paramètres tels que le nombre de paquets d'apprenants et le nombre de paquets de questions pour lancer la validation bicroisée définie à la section \vref{bcv}.

Constitution des paquets

:   Un fichier ``subset.py`` construit les paquets d'apprenants et de questions pour la validation bicroisée.

Exécution des modèles

:   Pour faire tourner un modèle, il faut appeler ``python cat.py MODEL`` où ``MODEL`` désigne ``irt`` pour Rasch, ``qmspe`` pour DINA avec une q-matrice spécifiée par un expert, ``qm`` pour DINA avec une extraction automatique de q-matrice, ``mirt D`` pour MIRT de dimension ``D``, et enfin ``mirtq`` pour GenMA avec une q-matrice spécifiée par un expert.

Évaluation des performances

:   À la fin, ``combine.py`` permet de combiner toutes les expériences effectuées, ``stats.py`` calcule les taux d'erreurs et ``plot.py FOLDER TYPE`` trace la courbe de type ``TYPE`` pour l'expérience ``FOLDER``, où ``TYPE`` désigne ``mean`` si l'on souhaite tracer la *log loss*, ``count`` si l'on souhaite calculer le nombre de prédictions incorrectes ou ``delta``, la distance au diagnostic final comme définie à la section \vref{delta}.

\section*{Stratégies}

Toutes les stratégies de choix de $k$ questions notamment InitialD sont implémentées dans le fichier ``coldstart.py``.
