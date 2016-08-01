% A review of recent advances in adaptive testing
% Jill-Jênn Vie \and Fabrice Popineau \and Éric Bruillard \and Yolaine Bourda
% June 10, 2016

<!-- \keywords{Latent knowledge extraction; item response theory; q-matrix; cognitive diagnosis models; adaptive testing; knowledge space theory} -->

\label{state of the art}

# Introduction

Today, assessments are often automatized, making it possible to store and analyze student data in order to provide more accurate and shorter assessments for future learners. The learning analytics process consists in collecting data about learners, discovering hidden patterns that can help provide a more effective learning experience, and constantly refining models using new data [@Chatti2012]. In terms of adaptive testing, learning analytics have certain, well-defined objectives: improve the efficiency and effectiveness of the learning process, and tell learners what to do next by adaptively organizing instructional activities [@Chatti2012]. Reducing the length of tests is even more needed as students are today overtested [@Zernike2015], thus leaving fewer time for instruction.

In this chapter, we focus on using assessment data, under the form of dichotomous response patterns (learners answering correctly or incorrectly questions) to provide better assessments. We want to train user models so they can help uncover the latent knowledge of the examinees using fewer, carefully-chosen questions, and provide useful feedback at the end of the test. Such feedback can be aggregated at various levels (e.g., from student, to class, to school, to district, to state, to country) in order to enable decision-making [@Shute2015].

Traditionally, models used for adaptive testing (such as the ones encountered in item response theory [@Hambleton1985]) have been mostly summative: they measure or rank effectively examinees, but do not provide any other feedback. Recent advances have focused on formative assessments [@Ferguson2012; @Huebner2010], providing more useful feedback for both the learner and the teacher, thus of greater interest to the learning analytics community. Indeed, @Tempelaar2015 have shown that computer-assisted formative assessments have high predictive power for detecting underperforming students and academic performance. We prove that such adaptive strategies can be applied to formative assessments, in order to improve efficiency and test reduction.

This chapter is organized as follows. First, we mention the learning analytics methods that will be used in the chapter, then we describe the models used for adaptive testings found in diverse fields ranging from psychometrics to machine learning, and their limitations. Later, we present an experimental protocol to compare adaptive testing strategies for predicting student performance, and our results. Finally, we highlight which models suit which use cases, describe what could be the future of assessment, and eventually draw our conclusions.

# Learning Analytics

In the possible objectives of learning analytics (LA), @Chatti2012 describe the need for intelligent feedback in assessment, and the problem of choosing the next activity to present to the learner. To address these needs, they highlighted the following classes of methods: statistics, information visualization (IV), data mining (DM) and social network analysis (SNA).

adaptive testing allows better personalization by organizing learning resources. For example, curriculum sequencing consists in defining learning paths in a space of learning objectives [@Desmarais2012]. It aims to use skills assessment to tailor the learning content with the least possible amount of evidence. As stated by @Desmarais2012, "The ratio of the amount of the evidence to the breadth of the assessment is particularly critical for systems that cover a large array of skills, as it would be unacceptable to ask hours of questions before making a usable assessment."

In educational systems, there is a highlight on the difference between adaptivity, the ability to modify course materials using different parameters and a set of pre-defined rules, and adaptability, the possibility for learners to personalize the course materials by themselves. @Chatti2012 precise that "more recent literature in personalized adaptive learning have criticized that traditional approaches are very much top-down and ignore the crucial role of the learners in the learning process." There should be a better balance between giving the learner what he needs to learn (i.e. adaptivity) and giving the learner what he wants to learn (i.e. adaptability), the way he wants to learn it (whether he prefers more examples, or more exercises). Anyway, learner profiling is a crucial task.

As a use case scenario, let us consider a newcomer arriving on a massive online open course (MOOC). She may have acquired knowledge from really diverse backgrounds, some prerequisites of the course might not be mastered while some chapters of the lesson could be skipped. Therefore, it would be useful to adaptively assess their needs and preferences in order to filter the content of the course accordingly and minimize information overload. @Lynch2014 describe such an algorithm that uncovers the latent knowledge state of a learner by asking few questions at the beginning of a course.

In learning analytics, the data mining category includes machine learning techniques such as regression trees for prediction. As an example, one may want to use a gradient boosting tree to highlight what variables can explain best the obtention or non-obtention of a certificate for a learner in a MOOC. Gradient boosting trees have been successful to tackle prediction problems, notably in data science challenges, because they can integrate heterogeneous values (categorical variables and numerical variables) and they are robust to outliers. We were surprised to see in the learning analytics methods so many models interested in the prediction of a certain objective from a fixed set of variables and so few models assessing the learner about his needs and preferences. We believe that a lot of research has yet to be done towards more interactive models in learning analytics.

Recommender systems, that aggregate data about users in order to recommend relevant resources (such as movies, products), are increasingly used in technology-enhanced learning research as a core objective of learning analytics [@Chatti2012; @Manouselis2011; @Verbert2011]. Most recommender systems rely on collaborative filtering, a method that makes automated predictions about the interest of a user, based on information collected from many users. The intuition is that a user may like items that similar users have liked in the past. In our case, a learner may face difficulties similar to the ones learners with similar response patterns have faced. There are open research questions on how algorithms and methods have to be adapted from the field of commercial recommendations. Still, we believe that existing techniques can be applied to adaptive testing.

Response time within assessment has been studied in cognitive psychology, because the amount time a person needs to answer an item is believed to indicate some aspects about the cognitive process. It requires sophisticated statistical models [@Chang2014] that we did not consider in this chapter.

# Adaptive Testing Models

In our case, we want to filter the questions to ask to a learner. Instead of asking the same questions to everyone, the so-called computer adaptive tests (CAT) [@VDL2010] select the next question to ask according to the previous answers, thus allowing adaptivity at each step. Their design relies on two criteria: a *termination criterion*, and a *next item criterion*. While the termination criterion is not satisfied (such as asking a certain number of questions), questions are asked according to the next item criterion (such as asking questions which bring the most information about the learner's ability or knowledge). @Lan2014 have proven that such adaptive tests could achieve same prediction accuracy using fewer questions than non-adaptive tests.

Shorter tests are useful for both the system, which needs to balance load, and the learner, which may be frustrated or bored by providing too many answers [@Lynch2014; @Chen2015]. Thus, adaptive testing is getting more and more necessary in the current age of MOOCs, where motivation plays an important role [@Lynch2014]. In real-case scenarios though, the following additional constraints apply: the computation of criteria should be done in a reasonable time, thus the time complexity of the approaches is important. Also, when assessing skills, uncertainty is an important factor. A learner may slip, which means accidentally or carelessly fail an item he is supposed to solve; or guess, which means correctly answer an item by chance. This is why a simple binary search over the ability of the learner (asking a more difficult question if the learner succeeds and a easier question if he fails) is not feasible, and more robust methods needs to be considered, such as probabilistic models for skill assessment.

CATs have been extensively studied over the past years and put into practice. As an example, 238,536 such adaptive tests have been administered through the GMAT by the Graduate Management Admission Council in 2012--2013 [@GMAT2013]. Given a student model [@Pena2014], the objective is to provide an accurate measurement of the parameters of an upcoming student while minimizing the number of questions asked. This problem has been referred to as *test-size reduction* [@Lan2014] and is also related to predicting student performance [@Bergner2012; @ThaiNghe2011]. In machine learning, this approach has been referred to as *active learning*: adaptively query informative labels of a training set in order to optimize learning.

According to the purpose of the assessment, several models are available, whether we want to estimate a general level of proficiency, provide diagnostic information, or characterize knowledge [@Mislevy2012]. In what follows, we describe those models under the following categories: item response theory for summative assessment, cognitive models for formative assessment, more complex knowledge structures, exploration and exploitation trade-off and multistage testing.

## Psychometrics: Measuring Proficiency using Item Response Theory

The most simple model for adaptive testing is the Rasch model, also known as 1-parameter logistic model, thus falling into the DM category of LA. It models the behavior of a learner with a single latent trait called ability, and the items or tasks with a single parameter called difficulty. The tendency for a learner to solve a task only depends on the difference between the difficulty and the ability. Thus, if a learner $i$ has ability $\theta_i$ and wants to solve an item $j$ of difficulty $d_j$:

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi(\theta_i - d_j) $$

where $\Phi : x \mapsto 1 / (1 + e^{-x})$ is the so-called logistic function.

<!-- \begin{figure}
\includegraphics[width=\linewidth]{difficulty.png}
\caption{Item response curves for various values of the difficulty parameter $d$ of the Rasch model.}
\end{figure} -->

Specifying all difficulty values by hand would be costly for an expert, and would provide subjective values that may fit student data poorly. Fortunately, this model allows an efficient parameter estimation: using former student data, it is possible to calibrate the item difficulties and learner abilities automatically, computing the maximum likelihood estimates. In particular, no domain knowledge is needed.

When a newcomer takes a test, the observed variables are its outcomes over the questions that are asked to him, and the hidden variable we want to estimate is his ability, given the known difficulty parameters. Estimation is usually performed using maximum likelihood, easy to compute using Newton's method to find the zeroes of the derivative of the likelihood function. Therefore, the adaptive process becomes: given an estimate over the ability of the learner, what question outcome will be the most useful to refine this estimate? It is indeed possible to quantify the information that each item $j$ provides over the ability parameter, called Fisher information, defined as the variance of the gradient of the log-likelihood with respect to the ability parameter:

$$ I_j(\theta_i) = E\left[{\left(\frac\partial{\partial\theta} \log f(X_j, \theta_i)\right)}^2 \bigg| \theta_i \right] $$

where $X_j$ is the binary outcome of the learner $i$ over the item $j$ and $f(X_j, \theta_i)$ is the probability function for $X_j$ depending on $\theta_i$ : $f(X_j, \theta_i) = \Phi(\theta_i - d_j)$.

Therefore, an adaptive testing can be designed the following way: given the learner's current ability estimate, pick the question that brings the most information over the ability, update the estimate according to the outcome (right or wrong), and so on. At the end of the test, one can visualize the whole process like in Figure \ref{irt}. As we can see, the confidence interval over the ability estimate is refined after each outcome.

<!--
\begin{figure}
\includegraphics[width=\linewidth]{irt.pdf}
\caption{Evolution of the ability estimate throughout an adaptive test based on the Rasch model.}
\label{irt}
\end{figure}
-->

Being a unidimensional model, the Rasch model is not suitable for cognitive diagnosis. Still, it is really popular because of its simplicity, its stability and its sound mathematical framework [@Desmarais2012; @Bergner2012]. Also, @Verhelst2012 has showed that if the items are splitted into categories, it is possible to provide to the examinee a useful deviation profile, specifying which category subscores were lower or higher than expected. More precisely, if we consider that in each category, an answer gives one point if correct, no point otherwise, we can compute the number of points obtained by the learner in each category (the subscores), which sum up to his total score. Given the Rasch model only, it is possible to compute the expected subscore of each category, given the total score. Finally, the deviation profile, defined as the difference between the observed and expected subscores, provides a nice visualization of the categories that need further work, see Figure \ref{deviation}. Such deviation profiles can be aggregated in order to highlight the strong and weak points of the students at the level of a country, witnessing a possible deficiency in the national curriculum. Studies of international assessments, such as the Trends in International Mathematics and Science Study (TIMSS), allow for worldwide comparisons. An example is given over the TIMSS 2011 dataset of proficiency in mathematics, see Figure \ref{deviation}, highlighting the fact that Romania is stronger in Algebra than expected, while Norway is weaker in Algebra than expected. This belongs to the information visualization class of learning analytics methods, and shows what can be done using the most simple psychometric model and the student data only.

In adaptive testing though, we do not observe all student responses but only the answers to the subset of questions we asked, which may differ from a student to another. It is still possible to compute the deviation profile within this subset, but it can't be aggregated to a higher level, because of the bias induced by the adaptive process.

<!--
\begin{figure}
\centering
\includegraphics[width=0.5\linewidth]{profil.png}\\
\includegraphics[width=\linewidth]{profilpays.png}
\caption{Above, the deviation profile of a single learner. Below, the deviation profile of different countries on the TIMSS 2011 math dataset, from the presentation of N.D. Verhelst. at the Psychoco 2016 conference.}
\label{deviation}
\end{figure}
-->

\label{mirt}

It is natural to extend the Rasch model to multidimensional abilities. In Multidimensional Item Response Theory (MIRT) [@Reckase2009], both learners and items are modelled by vectors of a certain dimension $d$, and the tendency for a learner to solve an item depends only on the dot product of those vectors. Thus, a learner has greater chance to solve items correlated with its ability vector, and asking a question brings information in the direction of its item vector.

\def\R{\textbf{R}}

Thus, if learner $i \in \{1, \ldots, n\}$ is modelled by vector $\vec{\theta_i} \in \R^d$ and item $j \in \{1, \ldots, m\}$ is modelled by vector $\vec{d_j} \in \R^d$:

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi(\vec{\theta_i} \cdot \vec{d_j}). $$

Using this model, the Fisher information becomes a matrix, of which one wants to maximize either the determinant ("D-rule") or the trace ("T-rule"). The item with maximum determinant provides the maximum volume of information thus the largest reduction of volume in the variance of the ability estimate, while the item with maximum trace attempts to increase the average information about each component of the ability, by ignoring the covariation between components.

Restated as a matrix factorization problem, MIRT becomes:

$$ M \simeq \Phi(\Theta D^T) $$

where $M$ is the $n \times m$ student data, $\Theta$ is the $n \times r$ learner matrix of all learners vectors and $D$ is the $m \times r$ item matrix of all item vectors.

Nevertheless, those richer models involve many more parameters : if $d$ parameters are estimated for each of the $n$ learners, and $d$ parameters are estimated for each of the $m$ items. Thus, this model has proven to be much harder to calibrate [@Desmarais2012; @Lan2014].

## Cognitive Diagnosis: adaptive testing with Feedback

Cognitive diagnosis models rely on the assumption that the resolution of learning tasks in a test can be explained by the mastery or non-mastery of some knowledge components (KC), thus allowing a transfer of evidence from one item to another. For instance, a learner that solves $1/7 + 8/9$ correctly can add and put fractions at same denominator, while a learner that solves $1/7 + 8/7$ only needs to know how to add. These cognitive models require a specification of the KCs involved in the resolution of the items proposed in the test, in the form of a binary matrix called q-matrix, which simply maps items to KCs: it is a transfer model. See Table \ref{fraction-qmatrix} for a real-world example of q-matrix.

\begin{table}
\centering
\begin{minipage}{0.46\textwidth}
$$ \begin{array}{cccccccc}
0 & 0 & 0 & 1 & 0 & 1 & 1 & 0\\
0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\
0 & 0 & 0 & 1 & 0 & 0 & 1 & 0\\
0 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
0 & 1 & 0 & 1 & 0 & 0 & 1 & 1\\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
1 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 0 & 0 & 0 & 0\\
0 & 1 & 0 & 0 & 1 & 0 & 1 & 1\\
0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 1\\
0 & 1 & 0 & 1 & 1 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
1 & 0 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 0 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 1 & 0 & 1 & 0\\
0 & 1 & 0 & 0 & 1 & 1 & 1 & 0\\
1 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
0 & 1 & 1 & 0 & 1 & 0 & 1 & 0\\
\end{array} $$
\end{minipage}
\begin{minipage}{0.46\textwidth}
Description of the knowledge components:
\begin{itemize}
\item convert a whole number to a fraction
\item separate a whole number from a fraction
\item simplify before subtracting
\item find a common denominator
\item borrow from whole number part
\item column borrow to subtract the second numerator from the first
\item subtract numerators
\item reduce answers to simplest form
\end{itemize}
\end{minipage}
\caption{The q-matrix corresponding to Tatsuoka's (1984) fraction subtraction data set of 536 middle school students over 20 fraction subtraction test items spanned over 8 knowledge components.}
\label{fraction-qmatrix}
\end{table}

The DINA model ("deterministic input noisy and") assumes that the learner will solve a certain item $i$ with probability $1 - s_i$ if he masters every KC involved in its resolution and with probability $g_i$ otherwise. The parameter $g_i$ is called the guess parameter of item $i$, it represents the probability of guessing the right answer to item $i$ while not being able to solve it, while $s_i$ is called the slip parameter of items $i$ and represents the probability of slipping on item $i$ while mastering the correct KCs. The DINO model ("deterministic input noisy or") only requires the mastery of one KC involved in the resolution of an item in order to solve it with probability $1 - s_i$. If no KC involved is mastered, the probability of solving the item is $g_i$.

The latent state of a learner is represented by a vector of $K$ bits $(c_1, \ldots, c_K)$ where $K$ is the number of KCs involved, indicating the KCs that are mastered: for each $KC$ $k$, $c_k$ is 1 if the learner masters the $k$-th KC, 0 otherwise. Each answer that the learner gives on an item brings us information about his probable latent state. @Xu2003 have used adaptive testing strategies in order to infer the latent state of the learner using few questions, coined as cognitive diagnosis computerized adaptive testing (CD-CAT). Knowing the mental state of a learner, we can infer his behavior over the remaining questions in the test, and choose questions accordingly. At each moment, the system keeps a probability distribution over the $2^K$ possible latent states and refines it after each question using the Bayes' rule. A usual measure of uncertainty is entropy:

$$ H(\mu) = - \sum_{c \in \{0, 1\}^K} \mu(c) \log \mu(c). $$

Therefore, in order to converge quickly into the true latent state, the best item to ask is the one that reduces average entropy the most [@Doignon2012; @Huebner2010]. Other criteria have been tried such as the question that maximizes the Kullback-Leibler divergence, which is a measure of the difference between two probability distributions [@Cheng2009]:

$$ D_{KL}(P||Q) = \sum_i P(i) \log \frac{P(i)}{Q(i)}. $$

As @Chang2014 states, "A survey conducted in Zhengzhou found that CD-CAT encourages critical thinking, making students more independent in problem solving, and offers easy to follow individualized remedy, making learning more interesting."

Maintaining the probability distribution over the $2^K$ states may be intractable for large values of $K$, therefore $K \leq 10$ in practice [@Su2013]. It is possible to reduce the complexity by assuming prerequisites between KCs: if the mastery of some KC implies the mastery of another KC, the number of possible states decreases and so does the complexity. This approach is called the Attribute Hierarchy Model [@Leighton2004], and has allowed more accurate knowledge representations that fit the data better [@Rupp2012].

The q-matrix may be costly to build. Thus, devising a q-matrix automatically has been an open field of research. @Barnes2005 used a hill-climbing technique while [@Winters2005; @Desmarais2011] tried non-negative matrix factorization techniques to recover q-matrices from real and simulated multidisciplinary assessment data. They discovered that for topics well separated such as French and Mathematics, these techniques can separate well items that belong to these categories. On the contrary, on another dataset of assessments from the general knowledge game Trivial Pursuit, the results are no better than chance. As a recall, non-negative matrix factorization tries to devise matrices with non-negative coefficients $W$ and $Q$ such that the original matrix $M$ verifies $M \simeq WQ^T$. But other matrix factorization techniques can be tried such as sparse PCA [@Zou2006], which tries to devise a factorization under the form $M \simeq WQ^T$ where $Q$ is sparse, the intuition being: only few knowledge components are involved in the resolution of one task. On the datasets we tried, the expert-specified q-matrix fit better than a q-matrix devised automatically using sparse PCA. Even if we had an automatically devised q-matrix that fits the data better, we would not be able to name the knowledge components anyway. @Lan2014 tried to circumvent this issue by trying to interpret a posteriori the lines of the q-matrix, using expert-specified tags. A more recent work from @Koedinger2012 managed to combine q-matrices from several experts using crowdsourcing in order to find better cognitive models that are still explainable.

One may desire a model that encompasses both the mastery of a knowledge component and a notion of difficulty. To address this need, unified models have been designed, such as the general diagnostic model for partial credit data [@Davier2005] that takes MIRT and some cognitive models as special cases:

$$ Pr(\textnormal{``learner $i$ answers item $j$''}) = \Phi\left(\beta_i + \sum_{k = 1}^K \theta_{ik} q_{jk} d_{jk}\right) $$

where $K$ is the number of KCs involved in the test, $\beta_i$ is the main ability of learner $i$, $\theta_{ik}$ its ability for KC $k$, $q_{jk}$ is the $(j,k)$ entry of the q-matrix which is 1 if KC $k$ is involved in the resolution of item $j$, 0 otherwise, $d_{jk}$ the difficulty of item $j$ over KC $k$. Please note that this model is similar to the MIRT model specified above, but the dot product is computed only on part of the components. The intuition is to consider a MIRT model where the number of dimensions is the number of KCs of the q-matrix ($d = K$). When we calibrate the feature vector of dimension $d$ of an item, only the components that correspond to KCs involved in the resolution of this item are taken into account, see Figure \ref{fig-genma}. Hence, the fact that few components are required to solve each item allows the MIRT parameter estimation to converge. @Vie2016 used it in adaptive testing under the name GenMA. Another advantage is that the ability estimate at some point in the test represents degrees of proficiency for each knowledge component. The GenMA model is therefore a hybrid model that combines the Rasch model and a cognitive model.
\label{genma}

<!--
\begin{figure}
\centering
\includegraphics[width=\linewidth]{genma.pdf}
\caption{The GenMA hybrid model, combining item response theory and a q-matrix.}
\label{fig-genma}
\end{figure}
-->

## Competence-based Knowledge Space Theory and Applications
\label{knowledge-space}

@Doignon2012 have developed knowledge space theory, an abstract theory that relies on a partial order between subsets of a discrete knowledge space. Formally, let us assume that there is a certain number of KCs to learn, following a dependency graph specifying which KCs needs to be mastered before learning a certain KC, see Figure \ref{dependency}. From this dependency graph, one can compute the feasible knowledge states, i.e., the KCs that are actually mastered by the learner. For example, $\{a, b\}$ is a feasible knowledge state while the singleton $\{b\}$ is not, because $a$ needs to be mastered before $b$. Thus, for this example there are 10 feasible knowledge states: $\emptyset, \{a\}, \{b\}, \{a, b\}, \{a, c\}, \{a, b, c\}, \{a, b, c, d\}, \{a, b, c, e\}, \{a, b, c, d, e\}$. An adaptive testing can then uncover the knowledge state of the examinee, in a similar fashion to the Attribute Hierarchy Model described above. Once the knowledge subset of a learner has been identified, this model can suggest to him the next knowledge components to learn in order to help him progress, through a so-called learning path, see Figure \ref{dependency}. From the knowledge state $\{a\}$, the learner can choose whether he wants to learn the KC $b$ or the KC $c$ first.

@Falmagne2006 provide an adaptive test in order to guess effectively the knowledge space using entropy minimization, which is however not robust to careless errors. This model has been implemented in practice in the ALEKS system, which is said to be used by millions of users today [@Kickmeier2015; @Desmarais2012].

<!--
\begin{figure}
\centering
\includegraphics{knowledge-space.pdf}
\qquad
\includegraphics[width=0.4\textwidth]{learning-path.pdf}
\caption{On the left, the precedence diagram for algebra problems. On the right, the corresponding learning paths.}
\label{dependency}
\end{figure}
-->

@Lynch2014 have implemented a similar adaptive pretest at the beginning of a MOOC in order to guess what the learner already masters and help them jump directly to useful materials in the course. To address slip and guess parameters, they combine models from knowledge space theory and item response theory.

There has been a tendency for more fine-grained models for adaptive testing that consider an even richer domain representation such as an ontology [@Mandin2014; @Kickmeier2015] of the domain covered by the test. However, such knowledge representations are costly to make.

## Adaptive testing in recommender systems

Recommender systems can recommend new items to a user based on his preferences on other items. Two approaches are used:

\begin{enumerate}
\item content-based recommendations, that analyze the content of the items in order to devise a measure of similarity between items;
\item collaborative filtering, where the similarity between items depend solely on the preferences of the users: items with common aficionados are assumed similar.
\end{enumerate}

Overall, the aim is to predict the preference of a user over an unseen item, based on his preferences over a fraction of the items he knows. In our case, we want to predict the performance of a user over an unasked question, based on his previous performance. Collaborative filtering techniques have been applied on student data in an user-to-resource fashion [@Manouselis2011; @Verbert2011] and in an user-to-task fashion [@Toscher2010; @ThaiNghe2011; @Bergner2012].

All recommender systems face the user cold-start problem: given a new user, how to quickly recommend new relevant items to him? In technology-enhanced learning, the problem becomes: given a new learner, how to quickly identify the resources that he will need? To the best of our knowledge, the only reference to the cold-start problem within educational environments has been coined by @ThaiNghe2011: "In the educational environment, the cold-start problem is not as harmful than in the e-commerce environment where [new] users and items appear every day or even hour, thus, the models need not to be re-trained continuously." However, this article predates the advent of MOOCs, therefore this statement is no longer true.

Among the most famous approaches to tackle the cold-start problem, one method of particular interest is an adaptive interview that presents some items to the learner and asks him to rate them. @Golbandi2011 builds a decision tree that starts an interview process with the new user in order to quickly identify users similar to him. The best items are the ones that bisect the population into roughly two halves, and are in a way similar to discriminative items in item response theory. If we transfer this problem to adaptive testing with test-size reduction, it becomes: what questions should we ask to a new learner in order to infer its whole vector of answers? The core difference with an e-commerce environment is that learners might try to game the system more than in a commercial environment, thus their answers might not fit their ability estimate.

Most collaborative filtering techniques assume the user-to-item matrix $M$ is of low rank $r$ and look for a low-rank approximation under the matrix factorization $M \simeq UV^T$ where $U$ and $V$ are assumed of width $r$. Please note that if $M$ is binary and the loss function for the approximation is the logistic loss, we get back to the MIRT model (as a generalized linear model), see Section \ref{mirt}.

\paragraph{Diversity} Recommender systems have been criticized to "put the user in a box" and harm serendipity. But since then, there has been more research into diversity (finding a set of diverse items to recommend) and explained recommendations. More recently, there has been a need of more interactive recommender systems, giving back power to the user by letting him steer the recommendations towards other directions. The application to learner systems is straightforward: we could help the learner navigate in the course.

\paragraph{Implicit feedback} In e-commerce use cases, recommender systems differentiate explicit feedback given willingly by the user, such as "this user liked this item", from implicit feedback resulting from unintentional behavior, such as "this user stayed a lot of time on this page". The fact that a user stays a lot of time on a page may indicate that he is interested in the content of this page. Therefore, such implicit feedback data is used by e-commerce websites in order to know their clients better. In technology-enhanced learning use cases, explicit feedback data is often sparse, thus implicit feedback techniques are attractive candidates to improve recommender performance, using for example the time spent on a page, search terms used by the user, information about downloaded resources and comments posted by the user [@Verbert2011]. Such data may be of interest when recorded while the test is administered, for example for a learner browsing the course content while attempting a low-stake adaptive testing.

\paragraph{Adding external information} Some recommender systems embed additional information in their learning models such as the description of the item, or even the musical content itself in the scope of music recommendation. In order to improve prediction over the test, one could consider extracting any features from the problem statements of the items and incorporate them within the feature vector.

## Adaptive strategies for exploration-exploitation tradeoff
\label{bandits}

In some applications, one wants to maximize a certain objective function while asking questions. There is a tradeoff between knowing the user more by exploring the space of items and exploiting what we know in order to maximize a certain reward. @Clement2015 applied these techniques to intelligent tutoring systems: they personalize sequences of learning activities in order to uncover the knowledge components of the learner while maximizing his learning progress, as a function of the performance over the latest tasks. They use two models based on multi-armed bandits, one that relies on Vigotsky’s zone of proximal development [@Vygotsky1980] under the form of a dependency graph, the second on a q-matrix. They tested both approaches on 400 real students between 7 and 8 years old. They discovered quite surprisingly that the dependency graph performed better than the model using the expert-specified q-matrix. Their technique provided a great gain in learning for populations of students with larger variety and stronger difficulties.

## Multistage testing

So far, we only considered questions asked one after another. But the first ability estimate, using only the first answer, has high bias. Thus ongoing psychometrics research tends to consider asking pools of questions at each step, allowing adaptation only once sufficient information has been gathered. This approach has been referred to as multistage testing (MST) [@Yan2014]. After the first stage of $k_1$ questions, according to his performance, the learner moves to another stage of $k_2$ questions that depend only on his performance, and so on, see Figure \ref{mst}. MST presents another advantage: the learner can revise his answers before moving to the next stage without the need of complicated models for response revision [@Han2013; @Wang2015]. In clinical trials, MST design can be viewed as a group sequential design while a CAT can be viewed as a fully sequential design. The item selection is performed automatically, but the test developers can review the assembled test forms before administration.

@Wang2016 suggests to ask a group of questions at the beginning of the test, when little information about learner ability is available, and progressively reduce the number of questions of each stage in order to increase opportunities to adapt. Also, asking pools of questions allow to do content balancing at each stage instead of jumping from one knowledge component to the other after every question.

<!--
\begin{figure}
\centering
\includegraphics{mst.pdf}
\caption{In multistage testing, questions are asked in a group sequential design.}
\label{mst}
\end{figure}
-->
