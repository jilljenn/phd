% Comparaison de modèles

# Différents composants du test adaptatif

- Calibrage
- Choix de la question initiale
- Choix de la question suivante
- Estimation de la probabilité de répondre correctement à chaque question

# Apprentissage statistique

Lorsqu'on cherche à utiliser un modèle statistique afin d'accomplir une tâche, par exemple reconnaître un chiffre sur une image, il faut d'abord calibrer ses paramètres sur un jeu de données d'entraînement. Ensuite, on peut tester ce modèle sur un jeu de données de test afin de vérifier qu'il a correctement appris.

Dans des variantes plus interactives, le modèle statistique peut choisir les éléments à étiqueter afin d'améliorer son apprentissage. Cette approche s'appelle apprentissage actif (*active learning*).

# Double validation croisée

- On entraîne sur un jeu de données
- On teste sur un autre jeu de données : en posant des questions sauf sur un sous-ensemble de validation

# Bornes théoriques de problèmes similaires

## Recherche binaire généralisée

Le problème d'identification d'une cible en posant la question qui minimise l'entropie à chaque tour s'appelle la recherche dichotomique généralisée. On peut considérer des erreurs iid mais pour des erreurs persistentes, ce problème est peu connu théoriquement.

## Sous-modularité

Toutefois, on a une borne théorique dans le cas où les apprenants répondent sans erreur.

# Comparaison de modèles sur un jeu de données réel

Selon le type de test, le meilleur modèle n'est pas le même.