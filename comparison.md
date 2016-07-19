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

# Comparison of adaptive testing models

Adaptive assessment models need to be validated on real data, in order to guarantee that the model accurately assesses the constructs that it is thought to assess [@Desmarais2012]. A common validation relies in the assessment's ability to predict future performance within the learning system.

In order to compare the models described above on real data, they can be embedded in a unified framework: all of them can be seen as decision trees [@Ueno2010; @Yan2014], where nodes are possible states of the test and edges are followed according to the answers provided by the learner, like a flowchart. Thus, within a node, we have access to an incomplete response pattern and want to infer the behavior of the learner over the remaining questions using our student model. The best model is the one that classifies remaining outcomes with minimal error.

Formally, let us consider students, from a set $I$, that answer questions from a set $Q$. Our student data is a binary matrix $D$ of size $|I| \times |Q|$ where $D_{iq}$ is 1 if student $i$ answered question $q$, 0 otherwise. An adaptive test can be formalized the following way.\bigskip

\noindent
\textsc{Test}(student $i \in I$) :  
\indent \textbf{While} some questions remain to be asked  
\indent \indent \textsc{Ask} to student $i$ the next question\bigskip

We want to compare the predictive power of different adaptive testing algorithms that model the probability of student $i$ solving question $j$. Thus, for our cross validation, we need to define:

- a student train set $I_{train} \subset I$;
- a student test set $I_{test} \subset I$;
- a validation question set $Q_{val} \subset Q$.

These sets will stay the same for all considered models.\bigskip

\noindent
\textsc{EvaluateModel}(model $M$, $I_{train}$, $I_{test}$, $Q_{val}$) :  
\indent \textsc{Train} model using lines $I_{train}$ of $D$  
\indent \textbf{For each} student $i$ of $I_{test}$ \textbf{do}  
\indent \indent \textbf{While} not all questions $\in Q \setminus Q_{val}$ have been asked  
\indent \indent \indent \textsc{ChooseNextItem} and ask it to student $i$  
\indent \indent \indent Evaluate predictions of model $M$ over questions $Q_{val}$.\bigskip

We make a cross validation of each model over 10 subsamples of students and 4 subsamples of questions (these constant values are parameters that may be changed). Thus, if we number student subsamples $I_i$ for $i = 1, \ldots, 10$ and questions subsamples $Q_j$ for $j = 1, \ldots, 4$, experiment $(i, j)$ consists in:

- train the evaluated model over all student subsamples except the $i$-th ($I_{train} = I \setminus I_i$);
- simulate adaptive tests on the $i$-th student subsample ($I_{test} = I_i$) using all questions subsamples except the $j$-th ($Q_j$), and evaluate after each question the error of the model over the $j$-th question subsample ($Q_{val} = Q_j$).

The error is given by the following formula, called score or log-loss:

$$ e(p, t) = \frac1{|Q_{val}|} \sum_{k \in Q_{val}} t_k \log p_k + (1 - t_k) \log (1 - p_k) $$

where $p$ is the predicted outcome over all $|Q|$ questions and $t$ is the true response pattern.

In order to visualize the results, errors computed during experiment $(i, j)$ are stored in a matrix of size $10 \times 4$. Thus, computing the mean error for each column, we can see how models performed on a certain subset of questions, see Figure \ref{crossval}.

<!--
\begin{figure}
\centering
\includegraphics{crossval.pdf}
\caption{Cross validation over 10 student subsamples and 4 question subsamples. Each case $(i, j)$ contains the results of the experiment $(i, j)$ for student test set ($I_{test} = I_i$) and question validation set ($Q_{val} = Q_j$).}
\label{crossval}
\end{figure}
-->

# Results

## Datasets and models

For our experiments, we used two real datasets.

**ECPE.** This student dataset is a $2922 \times 28$ binary matrix representing the results of 2922 learners over 28 questions. The corresponding q-matrix has only 3 skills: morphosyntactic rules, cohesive rules, lexical rules.

**Fraction.** This student dataset is a $536 \times 20$ binary matrix representing the results of 536 learners over 20 questions. The corresponding q-matrix has 8 skills.

Models considered are the Rasch model, the DINA model with an expert-specified q-matrix and the GenMA model with the same q-matrix. For the fraction matrix, we compared two occurrences of the GenMA model, one with the original expert q-matrix, the other one with another one which was computed using sparse PCA. The results are given in Figure \ref{curves}.

<!--
\begin{figure}
\includegraphics[width=\textwidth]{plot-ecpe.png}\\
\includegraphics[width=\textwidth]{plot-fraction.png}
\caption{Mean error (negative log-likelihood) after a certain number of questions have been asked.}
\label{curves}
\end{figure}
-->

\begin{table}
$$ \begin{array}{C{5mm}C{5mm}C{5mm}|cc|c}
\multicolumn{3}{c|}{\textnormal{q-matrix}} & \textnormal{guess} & \textnormal{slip} & \textnormal{success rate}\\
\hline
1 & 1 & 0 & 0.705 & 0.085 & 80 \%\\
0 & 1 & 0 & 0.724 & 0.101 & 83 \%\\
1 & 0 & 1 & 0.438 & 0.266 & 57 \%\\
0 & 0 & 1 & 0.480 & 0.162 & 70 \%\\
0 & 0 & 1 & 0.764 & 0.040 & 88 \%\\
0 & 0 & 1 & 0.717 & 0.066 & 85 \%\\
1 & 0 & 1 & 0.544 & 0.085 & 72 \%\\
0 & 1 & 0 & 0.802 & 0.040 & 89 \%\\
0 & 0 & 1 & 0.534 & 0.199 & 70 \%\\
1 & 0 & 0 & 0.483 & 0.163 & 65 \%\\
1 & 0 & 1 & 0.556 & 0.099 & 72 \%\\
1 & 0 & 1 & 0.195 & 0.305 & 43 \%\\
1 & 0 & 0 & 0.633 & 0.122 & 75 \%\\
1 & 0 & 0 & 0.517 & 0.212 & 65 \%\\
0 & 0 & 1 & 0.749 & 0.040 & 88 \%\\
1 & 0 & 1 & 0.549 & 0.126 & 70 \%\\
\textbf0 & \textbf1 & \textbf1 & \textbf{0.816} & \textbf{0.058} & \textbf{88 \%}\\
0 & 0 & 1 & 0.729 & 0.086 & 84 \%\\
0 & 0 & 1 & 0.473 & 0.150 & 71 \%\\
1 & 0 & 1 & 0.239 & 0.295 & 46 \%\\
1 & 0 & 1 & 0.621 & 0.097 & 75 \%\\
0 & 0 & 1 & 0.322 & 0.188 & 63 \%\\
0 & 1 & 0 & 0.637 & 0.075 & 81 \%\\
0 & 1 & 0 & 0.313 & 0.322 & 53 \%\\
1 & 0 & 0 & 0.512 & 0.272 & 61 \%\\
0 & 0 & 1 & 0.555 & 0.211 & 70 \%\\
1 & 0 & 0 & 0.265 & 0.369 & 44 \%\\
0 & 0 & 1 & 0.659 & 0.086 & 81 \%\\
\end{array} $$
\caption{The q-matrix used for the ECPE dataset, together with the guess and slip parameters, and the success rate for each question. In bold, the highest guess value.}
\label{guess}
\end{table}

## Discussion

In all experiments, the hybrid model GenMA with the expert q-matrix performs the best. For example, in the Fraction dataset, 4 questions over 15 are enough to provide a feedback that predicts correctly 4 questions over 5 in average in the validation set. As an example, after 4 questions, the predicted performance over the validation question set of one of the test students is $[0.617, 0.123, 0.418, 0.127, 0.120]$ while his true performance is $[1, 0, 1, 0, 0]$, thereby yielding a mean error of 0.350.

In the ECPE dataset, DINA and Rasch have similar predictive power, which is quite surprising given that Rasch does not require any domain knowledge. It may be because in this dataset, there are only 3 skills, thus the number of possible states for a learner is $2^3 = 8$, for many possible response patterns ($2^{28}$). Consequently, the estimated guess and slip parameters are really high (see Table \ref{guess}), which explains why the information gained at each question is low. Indeed, the item which requires KC 2 and 3 is really easy to solve (88% success rate), even easier than items that require only KC 2 or only KC 3, thus the only way for the DINA model to express this behavior is to boost the guess parameter. On the contrary, GenMA calibrates one difficulty value per knowledge component thus it is a more expressive model. The same reason may explain why the mean error of GenMA converges after 11 questions: this 3-dimensional model may not be rich enough to comprehend the dataset, while in the Fraction dataset, the 8-dimensional GenMA model learns after every question.

In the Fraction dataset, we want to identify the latent state of the learner over $2^8$ possible states, asking questions over few KCs at each step. This may explain why DINA requires several questions in order to converge. Rasch and GenMA-expert have similar predictive power in the early questions, but at least GenMA-expert can provide useful feedback while Rasch cannot. The automatically-devised q-matrix used in GenMA-auto has lower predictive power, therefore for this dataset, Rasch provides a better adaptive assessment model than a q-matrix that is computed automatically (DINA or GenMA-auto), the three of them being able to provide explicable feedback.

\paragraph{Adaptive pretest at the beginning of a course} At the beginning of a course, we have to fully explore the knowledge of the learner, in order to identify his static latent knowledge using as few questions as possible. This is a cold-start problem, where we have to identify whether the learner holds the prerequisites of the course, and possibly his weak and strong points. If a dependency graph is available, we suggest to use Doignon and Falmagne's adaptive assessment model (see Section \ref{knowledge-space}). If a q-matrix is available, we suggest to use the GenMA model (see Section \ref{genma}). Otherwise, the Rasch model provides a way to at least measure the level of the learner.

\paragraph{Adaptive test at the middle of a course} Learners are interested in having a look at the tasks they are expected to be able to solve in the final test, in the form of a self-assessment that "does not count". There are several scenarios to consider. If learners have access to the course while taking this low-stake test, an adaptive assessment should take into account the fact that the level of the learner may change while he is taking the test, for example because he is checking the course lessons of the course during the test. Therefore, models measuring the progress of the learner (such as @Clement2015 mentioned in Section \ref{bandits}) are of interest. As a recall, they require either a dependency graph or a q-matrix. If learners do not check the course content while taking the test, for example because they have limited time, the GenMA model can ask them few questions and provide feedback, under the condition that a q-matrix is available.

\paragraph{Adaptive test at the end of a course} A high-stake at the end of the course might rely on the usual adaptive assessment strategies in item response theory, in order to measure examinees effectively and give them a mark. On this last examination, we assume that feedback is not so useful.

# The future of assessment

We described several models that could be used for adaptive assessment. A promising application is low-stakes adaptive formative assessments: before high-stakes assessments, learners like to train themselves in order to know what they are expected to know in order to complete the course. Such adaptive tests would be able to quickly identify the components that need further work and help the learner prepare for the final high-stake test. It would be interesting to couple this work with automatic item generation. Thus, learners could keep asking variants of the same problem until they master the skills involved. The results of these adaptive tests may be recorded anonymously in order to let the student "erase the blackboard" without any tracking. Indeed, no learner would like their mistakes to be recorded for their entire lives [@Obama2014].

<!-- PhD : débattre là-dessus avec un paragraphe parce que ça va un peu à l'encontre des learning analytics -->

With the help of learning analytics, explicit testing may be progressively replaced with embedded assessment, using multiple sources of data to predict student performance and tailor education accordingly [@Shute2015; @Redecker2013]. Indeed, if the learner is continuously monitored by the platform and if a digital tutor can answer their questions and recommend activities, they can be full actors of their continually-changing progress and there is no need for an explicit test at the end of the course.

But we will still need adaptive pretests for a specific usage such as international certifications (GMAT, GRE) or for newcomers at the beginning of a course, in order to identify effectively the latent knowledge they acquired in their past experience [@Baker2014; @Lynch2014].

<!-- multistage testing ; can specify the number of questions per stage -->

Our adaptativity rules only take as input the answers given so far by the learner, not their previous performances, allowing a learner to start from scratch. Using profile information such as the country to select the questions may lead to more accurate performance predictions (for example, from one country to another, the way to compute divisions is not the same). But allowing such sensible information to influence the assessment might result in disparate impact and other inadvertent discrimination.

<!-- ask python questions no need; éviter de reposer des questions -->
<!-- allowing -->

In the future, an online platform could first ask the learner about their presumed knowledge. Then, verify if the self-assessment holds and provide arguments for any possible disagreement. The learner could then possibly rectify this by proving it actually masters the knowledge components required, and possibly learn more material.

# Conclusion

We presented several recent student models making it possible to use former assessment data in order to provide shorter, adaptive assessments. As @Rupp2012, we didn't aim to determine a best model for all uses, we just wanted to compare them in terms of shortness and predicting performance and see which model suits which use best. Please note that in this chapter, we focus on the assessment on a single learner. Readers interested in CSCL in group assessments may consider reading [@Goggins2015].

Most models using q-matrices are validated using simulated data. In this chapter, we compared the strategies on real data. Our experimental protocol could be tried on even more adaptive assessment models. It could also be generalized for testing multistage testing strategies.

According to the purpose of the test (beginning, middle of end of term), the most suitable model is not the same. In order to choose the best model, one should wonder: What knowledge do we have other the domain (dependency graph, q-matrix)? Is the knowledge of the learner evolving while he is sitting for the test? Do we want to estimate the knowledge components of the learner or do we want to measure learning progress while he is taking the test?

The models we described in this chapter come from various fields of the literature. Experts in the field should communicate more, in order to avoid giving different names to the same model in different fields. There is a need for more interdisciplinary research and methods from learning analytics and CAT should be combined in order to get richer and more complex models. Also, crowdsourcing techniques can be applied in order to harvest more data. One might imagine the following application of implicit feedback: "In order to solve this question, you seem to have spent a lot of time over the following lessons: [the corresponding list]. Which ones helped you answer this question?" Such data can help future learners experiencing difficulties over the same questions.

As we stated in the learning analytics section, we think more research should be done in interactive learning analytics models, giving more control back to the learner, inspired by CAT strategies.

The focus on modern learning analytics for personalization is not only on automated adaptation but also on increasing engagement and affect of learners in the system. This raises an open question on whether the platform should share everything it knows about the learner with the learner. One advantage would be to leverage trust and engagement, one risk would be that learners may change their behavior in consequence in order to game the system.

<!-- Calculé à partir des apprenants précédents
011 guess / slip
001 K = 3
8 vecteurs de bits 2^28 types de réponses
Ajuster slip et guess
Requérant les mêmes composantes de connaissances -->
