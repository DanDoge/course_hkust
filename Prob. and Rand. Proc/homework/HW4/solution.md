### ELEC 2600 HW4 solution

###### Huang Daoji 20623420

1.

​	a. 

- From Chebyshev Inequality, we have $P(|X - m| > 0.05) \leq \frac{p(1-p)}{n 0.05^2} \leq 0.02$, so $n \geq p(1-p) * 50 * 400$, for all possible $p$

- From $p(1-p) \leq 0.25$, we have $n \geq 0.25 * 50 * 400 = 5,000$

    b.

- From Central Limit Theorem, we have $P(|M_n - p| < 0.05) = 1 - 2Q(\frac{0.05}{{(p(1-p)/n)}^{1/2}}) \geq 0.98$

- Refer to Q function table, we have $\frac{0.05}{{(p(1-p)/n)}^{1/2}} \geq 2.30, n \geq 2116 * p(1-p)$

- From $p(1-p) \leq 0.25$, we have $n \geq 0.25 * 2116 = 529$

    c.

- The Chebyshev Inequality gives an absulote number that makes sure the estimated value falls in in its neighbourhood, while the Central Limit Theorem does not guarantee this.

- From this definition(and intuition), Chebyshev Inequality should result in larger number to satisfy a stronger condition.

2.

​	a.  The plot below shows the possible values of $(X(1), Y(1))$ and $(X(2), Y(2))$, where the inner circle is the former and the outer circle the latter.

![1557415489430](C:\Users\AndrewHuang\AppData\Roaming\Typora\typora-user-images\1557415489430.png)

​	b.  From the question, we have $(X(t), Y(t)) = (t\cos\theta, t\sin\theta)$, so $P[Y(2) > 1] = P[2\sin\theta > 1] = (\pi/3)/(\pi/2) = 2/3$

​	c. Similar to b., we have$P[X(2) > \sqrt{2}] = (\pi/4)(\pi/2) = 1/2$

​	d. $P[\{Y(2) > 1\} \cap \{X(2) > \sqrt{2}\}] = P[\theta \in [\pi/6, \pi/4]] = (\pi/12)/(\pi/2) = 1/6$

​	e. We have $P[\{Y(2) > 1\} | \{X(2) > \sqrt{2}\}] = (\pi/12) / (\pi/4) = 1/3$



3.

​	a. Let $X_i$ be a Bernoulli random varible with $p = 0.15$, $E[S_{10}] = E[\sum_{1}^{10}X_{i}] = \sum_{1}^{10}E[X_i] = 0.15 * 10 = 1.5$. $Var[S_{10}] = Var[\sum_{1}^{10}X_i] = \sum_{1}^{10}Var[X_i] = 10 * 0.15 * (1 - 0.15) = 1.275$

$Cov(S_5, S_{10}) = 5 * 0.15 * 0.85 = 0.6375$

​	b. $P[S_{5} \leq 1] = P[S_{5} = 0] + P[S_{5} = 1] = 0.85^5 + 5 * 0.85^4 * 0.15 = 0.83521$

​	c. From the definition of binomial counting process, we have $P[S_{10} = 3 | S_{5} = 1] = P[S_{5} = 2] = 0.85^3 * 0.15^2 * 10 = 0.138178125$

​	d. From the porperty of binomial counting process, we have $P[S_{10} = 3\ \cap\ S_{5} = 1] = P[S_{5} = 1] * P[S_{5} = 2] = 0.5296828125$



4.

​	a. the number of requests is given by $P[N(t) = k] = \frac{(\lambda t)^{k}}{k!}e^{-\lambda t} = \frac{(10t)^k}{k!}e^{-10t}$, where $t$ is measured in minutes, so $P[N(0.5) = 8] = \frac{(10 * 0.5)^8}{8!}e^{-10 * 0.5} = 0.0652780393481587$

​	b. from the porperty of Poission random process, we have $P[N(0.5) = 8\ \cap\ N(1) = 16] = P[N(0.5) = 8]^2 = 0.0652780393481587^2 \\ = 0.00426122242113975551479308038569$

​	c. From the fact that $P[N(3/60) = 0] = \frac{(10/20)^0}{0!}e^{-10/20} = e^{-1/2}$, we have $P[N(3/60) > 0] = 1 - e^{-1/2}$

​	d. $P[N(1/60) = 0\ \cap\ N(3/60) \geq 1] \\= P[N(1/60) = 0] * (1 - P[N(2/60) = 0]) = e^{-1/6}(1 - e^{-1/3})$

​	e. $P[N(6/60) \geq 2] = 1 - P[N(1/10) = 0] - P[N(1/10) = 1] = 1 - e^{-1} - e^{-1} = 1 - 2e^{-1}$



5.

​	a. The mean of $Y_n$ is $E[Y_n] = E[0.6X_n + 0.4X_{n - 1}] = 0.6 * 0 + 0.4 + 0 = 0$

​	The autocorrelation $R_{Y}(n_1, n_2) = E[Y_{n_1} Y_{n_{2}}] = E[(0.6X_{n_1} + 0.4X_{n_1 - 1})(0.6X_{n_2} + 0.4X_{n_2 - 1})]$

- when $n_1 = n_2$, it is $E[Y_{n_1}^2] = Var[Y_{n_1}] + E[Y_{n_1}]^2 = 2.08$

- when $|n_1 - n_2| = 1$, it is $0.24E[X_{n}^2] = 0.96$

- otherwise, $0$

    The auto covariance function is the same as autocorrelation function, since $E[Y_n] = 0$



​	b. The mean of $Y_n$ is also $0$. 

​	The varience of $Y_n$ is $Var[Y_n] = E[Y_n^2] = E[(0.6X_{n} + 0.4X_{n - 1})^2]$

- From the autocorrelation function of $X$,we have $E[X_{n}^2] = R_X(n, n) = 4$, and $E[X_nX_{n - 1}] = 4e^{-1/2}$

    thus $Var[Y_n] = (0.36 + 0.16) * 4 + 0.24 * 2 * 4e^{-1/2} = 2.08 + 1.92e^{-1/2}$

    $E[Y_nY_{n - 1}] \\= E[(0.6X_{n} + 0.4X_{n - 1})(0.6X_{n - 1} + 0.4X_{n - 2})] \\= (0.36 + 0.16)R_{X}(n, n - 1) + 0.24R_{X}(n, n) + 0.24R_{X}(n, n - 2)\\= 0.24 * 4 + 0.52 * 4e^{-1/2} + 0.24 * 4e^{-1}\\= 0.96 +2.08e^{-1/2} + 0.96e^{-1}$

