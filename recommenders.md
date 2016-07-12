% Recommender systems
% JJV
% 11 juillet 2016
---
lang: french
babel-lang: french
---

# Systèmes de recommandation

La plupart des sites marchands peuvent recommander des œuvres étant donné les œuvres précédentes notées par un utilisateur. Ils s'attaquent au problème : étant donné un immense catalogue, comment faire le tri entre ce qui est susceptible de m'intéresser et ce qui risque de ne pas l'être ? On distingue deux types de systèmes de recommandation.

Basés sur le contenu

:   Cela consiste à utiliser de l'information sur les œuvres (descriptions, auteurs, etc.) afin de calculer des valeurs de similarité entre œuvres. À partir de cela, il est possible de recommander à un utilisateur des œuvres similaires à celles qu'il a aimées.

Filtrage collaboratif

:   Cela consiste à utiliser uniquement des informations de notation des œuvres, sous la forme « l'user $i$ a attribué à l'œuvre $j$ la note $r_{ij}$ ». Ces notes peuvent être catégoriques (aimé, pas aimé) ou continues (une note entre 1 et 5 par exemple). On obtient alors une matrice creuse (1 % des valeurs sont renseignées) dont on cherche à deviner les entrées manquantes : ainsi, un motif de réponse d'un utilisateur partiellement rempli pourra être complété afin de déterminer des œuvres susceptibles de lui plaire à partir des autres notes de la communauté. On distingue ici des approches de filtrage collaboratif basées sur les utilisateurs (qui reposent sur des calculs de similarité entre utilisateurs) ou basées sur les œuvres (qui reposent sur des calculs de similarité entre œuvres à partir des notations de la communauté et non de leur contenu).

## Calcul de pertinence des recommandations

Lorsque les notes sont catégoriques (aimé, pas aimé), habituellement la prédiction revêt la forme d'une probabilité que l'utilisateur aime l'œuvre, et le score est la log-perte. D'autres approches [@Karypis] utilisent une fonction d'erreur qui pénalise davantage les faux positifs que les faux négatifs. Lorsque les notes sont continues, on utilise habituellement la RMSE (*root mean square error*).

## Démarrage à froid et élicitation des préférences

Lorsqu'un nouvel utilisateur se rend sur un site de recommandation, celui-ci n'a aucune information et doit donc solliciter l'utilisateur afin d'obtenir ces informations. Afin que le processus soit efficace, il est préférable de poser un minimum de questions, donc tout l'enjeu est de déterminer des œuvres discriminantes permettant au système d'avoir une idée précise des goûts de l'utilisateur. @Golbandi2011 fait ainsi un arbre de décision qui vise à répartir les utilisateurs dans des groupes au sein desquels la RMSE est faible.

## Compromis exploration-exploitation

## Applications à un contexte éducatif

Pour le challenge de la KDD Cup 2010, des approches basées sur le filtrage collaboratif avaient obtenu de bons résultats (3\ieme du classement). @ThaiNghe2011 voit le problème de prédire le résultat d'un utilisateur sachant ses actions passées comme un problème de filtrage collaboratif. Ils mentionnent le problème du démarrage froid, en disant que ce problème est moins critique dans les contextes éducatifs que marchands où de nombreuses œuvres et utilisateurs arrivent chaque jour. Toutefois, depuis l'arrivée des cours en ligne massifs (MOOC) en novembre 2011, ce problème est devenu aussi important que sur les plateformes marchandes.

Plusieurs éléments doivent toutefois être mis en évidence avant d'adapter les systèmes de recommandation à des contextes éducatifs.

Incertitude des motifs de réponses

:   On ne peut pas accorder une confiance aussi grande dans le fait qu'un utilisateur apprécie une œuvre que dans le fait qu'un utilisateur a réussi à répondre correctement à une question. En effet, on peut répondre correctement à une question par chance, sans avoir maîtrisé ce qui est évalué ; ou inversement faire une erreur d'inattention.

Mouvance des connaissances

:   Dans les systèmes de recommandation, les goûts certes évoluent : plusieurs années plus tard, les œuvres aimées ne sont pas nécessairement les mêmes. Toutefois, cette évolution est beaucoup plus lente que sur une plateforme d'apprentissage où l'on est censé, à terme, être capable de répondre correctement à toutes les questions.

Différence d'objectif

:   Contrairement à un système qui cherche strictement à déterminer les profils des gens, une plateforme éducative cherche à faire progresser ses utilisateurs au moyen de ressources éducatives.
