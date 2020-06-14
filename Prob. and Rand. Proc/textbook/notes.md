here are notes covering contents not mentioned in Prob. and Rand. Proc.

#### Event classes

classical probability deals with finite sample spaces, and thus power set is sufficient
- definition of sigma field
    - Borel field: a sigma field from countable unions, intersections and complements of intervals, that has integrals

continuity of probability
- shown in mathematic analysis
- lim P(An) = P(lim An), given A1 < A2 < ... < An < ...

#### Entropy

expected value of the uncertainty of its outcomes
- sum/integrals of -pln(p)
- relative entropy: sum/integrals of pln(p/q)
    - equals to zero iff p == q for all x, a.e.
- minimum average number of bits required to establish the outcome of X

#### generating independent Gaussian RV

independent Rayleigh and uniform RV, R and theta, then transform to X and Y

correlated RV?
- Y = AX, X ~ zero mean and unit variance
- then cov(Y) = AtA
    - solve for AtA = Cov(y), done

#### convergence of sequence of RV

sure convergence
- for all eta in S, Xn(eta) -> X(eta), every eta converges

almost-sure convergence
- for all eta in S, except a set of prob. zero, Xn(eta) -> X(eta)

mean square convergence
- E(Xn(eta) - X(eta))^2 -> 0
- power of error signal

convergence in probability
- P(Xn(eta) - X(eta) greater than eps) -> 0
- sequence are not required to remain inside 2 eps corridor
    - some eta can exceed 2eps in [n, n + 1], while other eta in [n + 1, n + 2]
    - then every single eta does not necessarily converges

#### fourier series and karhunen-loeve expansion

refer to Wikipedia, I really need to take a signal processing course.
- ...or no need to? since fourier something is more of like a analysis thing than a statistic thing, and random process will possibly have little thing to do with my future study/research
- jumping to queueing theory
