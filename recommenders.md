# Démarrage à froid dans le filtrage collaboratif

Nous tirons notre inspiration du domaine du filtrage collaboratif, où comme nous l'avons décrit à la section \ref{collaborative-filtering}, il s'agit de s'aider d'une communauté pour déterminer les bons produits à présenter aux bonnes personnes. 

Les techniques de filtrage collaboratif permettent d'utiliser les préférences d'un utilisateur sur certains items pour faire des déductions sur son comportement sur d'autres items. Mais lorsque l'utilisateur vient d'arriver, la plateforme n'a aucune information le concernant, c'est ce qu'on appelle le démarrage à froid de l'utilisateur. Notamment, dans notre cadre, nous avons décidé de ne pas considérer d'informations sur l'apprenant telles que des données démographiques. Ainsi, afin d'avoir une idée plus précise du profil de l'utilisateur pour pouvoir faire des déductions pertinentes, la plateforme doit efficacement éliciter les préférences de l'utilisateur. Par exemple, un système de recommandation de films présentera un premier ensemble de films populaires à faire noter à l'utilisateur pour avoir une idée de ses goûts.

## Applications à un contexte éducatif

<!-- KDD Cup -->

Pour le challenge de la KDD Cup 2010, des approches basées sur le filtrage collaboratif avaient obtenu de bons résultats (3\ieme{} du classement). @ThaiNghe2011 voit le problème de prédire le résultat d'un utilisateur sachant ses actions passées comme un problème de filtrage collaboratif. Ils mentionnent le problème du démarrage froid, en disant que ce problème est moins critique dans des contextes éducatifs que dans des contextes de sites e-commerce où de nombreuses œuvres et utilisateurs arrivent chaque jour. Toutefois, depuis l'arrivée des cours en ligne massifs (MOOC) en novembre 2011, ce problème est devenu aussi important que sur les plateformes marchandes.

Plusieurs éléments doivent toutefois être mis en évidence avant d'adapter les systèmes de recommandation à des contextes éducatifs.

Incertitude des motifs de réponses

:   On ne peut pas accorder une confiance aussi grande dans le fait qu'un utilisateur apprécie une œuvre que dans le fait qu'un utilisateur a réussi à répondre correctement à une question. En effet, on peut répondre correctement à une question par chance, sans avoir maîtrisé ce qui est évalué ; ou inversement faire une erreur d'inattention.

<!-- maîtrise les choses associées -->

Mouvance des connaissances

:   Dans les systèmes de recommandation, les goûts certes évoluent : plusieurs années plus tard, les œuvres aimées ne sont pas nécessairement les mêmes. Toutefois, cette évolution est beaucoup plus lente que sur une plateforme d'apprentissage où l'on est censé, à terme, être capable de répondre correctement à toutes les questions.

Différence d'objectif

:   Contrairement à un système qui cherche strictement à déterminer les profils des gens, une plateforme éducative cherche à faire progresser ses utilisateurs au moyen de ressources éducatives.

Cependant, en formalisant notre problème d'une façon qui ressemble davantage à un problème d'apprentissage automatique, nous allons pouvoir importer des techniques qui nous seront utiles.
