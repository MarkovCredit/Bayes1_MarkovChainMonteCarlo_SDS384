#SDS384
I ran the M2.R file in R using the model.txt file to generate a Markov Chain Monte Carlo simulation in R and OpenBUGS for my course in Bayesian Statistical Methods (SDS 384) at UT-Austin. I used the R package R2OpenBUGS to call OpenBUGS from R

For the plots in OpenBUGS, there are 3 colors: red, green, and blue, indicating 3 different initial values. The plots show whether the 3 different simulations converge or not, depending on whether their values are close to each other at the end of the iterations

By default, the number of burn-in iterations that get discarded is half the total number of iterations in OpenBUGS. You can set the number of burn-ins


Looking at the trace plots in OpenBUGS, we can see that many of the plots of each variable do not converge after 1000 iterations

For M2.R with model.txt, I tried to use R to print out all of the trace plots in one jpeg file, but the plots for each variable were too small. I had to only plot 3 variables at a time to get plots that were readable

For example, I chose the variable b.0, b.female, and b.black. To generate the trace plots in R, I had to use the coda extension and then used “xyplot”. As seen in “xy_M2_b0_bfemale_bblack”, only b.female converges while b.0 clearly does not.

To check if the density plots are well-defined, I used the densityplot command to produce “densityplotM2_b0_bfemale_bblack”. Deviance, b.female, and b.black come somewhat close to resembling the normal distributions that we expect. However, b.0 clearly does not resemble normal distributions

To check if the auto-correlation of the times series converge to zero, I used the acfplot and the output is “auto_M2_b0_bfemale_bblack.jpg”. Deviance appears to converge to 0 while b.black comes close to converging to 0, while the others clearly do not converge to 0.

When I use M4.R and model2.txt instead, less of the plots show convergence. Thus, M2.R and model1.txt provide the better model


#NBAproject
For my SDS 384 course project, I am trying to implement a Markov Chain Monte Carlo simulation on NBA basketball data. Before performing a Bayesian regression, I tried to determine which variables (such as STL, AST, REB, etc) best predict wins (Winpct) by implementing the Best Subset method and Forward Step methods on a linear regression. Then, I used Jags to run the MCMC and then make sure it is correct by checking the history plots and autocorrelation plots

The completed report is the file "Report.pdf". I also completed analyses using Principal Component Analysis, Ridge regression, and Lasso regression. They are in the files "PCA.r" and "RidgeLasso.r"

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jk34/bayes_markovchainmontecarlo_sds384/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

