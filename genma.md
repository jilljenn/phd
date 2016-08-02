% Un nouveau modèle

# Modèles confirmatoires interprétables

## Modèle DINA basé sur une q-matrice

## GenMA

La q-matrice considère un vecteur de bits par item, considérant si la composante de connaissance intervient ou pas. Ici nous nous proposons de remplacer cela par des poids.

@Davier2005 has proposed a unified model that takes many existing IRT models and cognitive models as special cases: the general diagnostic model for partial credit data:

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi\left(\beta_i + \sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk}\right) $$

where $K$ is the number of KCs involved in the test, $\beta_i$ is the main ability of learner $i$, $\theta_{ik}$ its ability for KC $k$, $q_{jk}$ is the $(j,k)$ entry of the q-matrix which is 1 if KC $k$ is involved in the resolution of item $j$, 0 otherwise, $d_{jk}$ the difficulty of item $j$ over KC $k$. Please note that this model is similar to the MIRT model specified above, but only parameters that correspond to a nonzero entry in the q-matrix are taken into account.

To the best of our knowledge, this model has not been used in adaptive testing [@Yan2014]. This is what we present in this paper: ``GenMA`` relies on a general diagnostic model, thus requires the specification of a q-matrix by an expert. The parameters $d_{jk}$ for every item $j$ and KC $k$ are calibrated using the history of answers from a test and the Metropolis-Hastings Robbins-Monro algorithm [@Chalmers2012; @Cai2010]. For the selection item rule of ``GenMA``, we choose to maximize the Fisher information at each step, details of the implementation can be found in [@Chalmers2012]. The problem TeSR-PSP becomes: after $k$ questions asked to a certain learner $i$, how to estimate its main ability $\beta_i$ and ability for each KC $\theta_{ik}$ that can explain its behavior throughout the test?

In real tests, items usually rely on only few KCs, hence there are fewer parameters to estimate than in a general MIRT model, which explains why the convergence is easy to obtain for ``GenMA``. We can thus use the general diagnostic model to create an adaptive test that makes best of possible worlds: providing feedback under the form of degrees of proficiency over several KCs at the end of test, represented by the vector $\theta_i = (\theta_{i1}, \ldots, \theta_{iK})$, and being easy to converge. ``GenMA`` is both summative and formative, thus a hybrid model. Such feedback can be aggregated at various levels (e.g., from student, to class, to school, to city, to country) in order to enable decision-making [@Shute2015; @Verhelst2012].

![The GenMA hybrid model, combining item response theory and a q-matrix.](figures/genma.pdf)

# Validation

## Qualitative

Le modèle GenMA est aussi interprétable qu'un modèle DINA. Et plus explicable si l'on suppose admises les valeurs de difficulté.

## Quantitative

GenMA a l'avantage multidimensionnel de MIRT tout en étant rapide à converger. Aussi, les dimensions sont directement interprétables car elles coïncident avec la q-matrice.

## Discussion

MIRT à 2 dimensions se débrouille mieux que GenMA, ce qui laisse entendre qu'un modèle prédictif n'est pas nécessairement explicatif. Toutefois afin de faire un retour à l'utilisateur, notre modèle fait un feedback correspondant davantage à la réalité qu'un modèle DINA basé sur les q-matrices.
