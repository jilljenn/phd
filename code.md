\label{code}

Tout le code pour effectuer la comparaison qualitative de modèles est disponible sur GitHub. \url{http://github.com/jilljenn/qna}

# Packages R utilisés

- catR : computerized adaptive testing in R
- CDM : cognitive diagnosis modeling
- ltm : latent trait models
- mirt : multidimensional item response theory
- mirtCAT : multidimensional item response theory computerized adaptive tests

Afin d'accélérer la procédure d'entraînement parfois coûteuse, nous utilisons ``pypy`` : il s'agit d'un interpréteur Python qui compile le code à la volée en code machine, afin de fournir une exécution plus rapide de code Python. Pour l'utiliser, il suffit de taper ``pypy fichier.py`` au lieu de ``python fichier.py``.

 <!-- Cette partie est effectuée par le package ``ltm``. -->

La calibration des paramètres des questions est effectuée par le package R ``CDM`` (pour *cognitive diagnosis modelling*), à partir des motifs de réponse des apprenants d'entraînement et de la q-matrice. 