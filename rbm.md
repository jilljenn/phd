% Lien entre MIRT et RBM

- Théorie multidimensionnelle de la réponse à l'item
- Machines de Boltzmann restreintes

Ce sont des modèles graphiques bipartis tentant d'extraire des caractéristiques cachées à partir de variables observées. Les machines de Boltzmann restreintes ont été découvertes en 1986 par @Smolensky1986 mais l'algorithme de calibrage découvert par @Hinton2006 est à la base de l'apprentissage profond.

L'implémentation en R du package mirt utilise un algorithme de Metropolis-Hastings Robbins-Monro pour calibrer ses paramètres @Cai2010 tandis que @Hinton2016 utilise une descente de gradient. Toutefois les formules sont les mêmes comme nous le prouvons dans ce chapitre.
