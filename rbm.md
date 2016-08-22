% Lien entre MIRT et RBM

Pour le problème de classification binaire, on a vu dans cette thèse la théorie multidimensionnelle de la réponse à l'item, qui consiste à identifier :

$$ M \simeq \Phi(\Theta D^T) $$

# Machines de Boltzmann restreintes

Ce sont des modèles graphiques bipartis tentant d'extraire des caractéristiques cachées à partir de variables observées. Les machines de Boltzmann restreintes ont été découvertes en 1986 par @Smolensky1986 mais l'algorithme de calibrage découvert par @Hinton2006 est à la base de l'apprentissage profond.

L'implémentation en R du package mirt utilise un algorithme de Metropolis-Hastings Robbins-Monro pour calibrer ses paramètres @Cai2010 tandis que @Hinton2006 utilise une descente de gradient. Toutefois les formules sont les mêmes comme nous le prouvons dans ce chapitre.

$$ \,P(v_i=1|h) = \sigma \left(a_i + \sum_{j=1}^n w_{i,j} h_j \right) $$

Les entrées sont habituellement discrètes dans une MBR. Cette phase est non supervisée.
