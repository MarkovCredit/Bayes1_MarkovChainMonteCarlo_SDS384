## Read the data & define variables
# Data are at http://www.stat.columbia.edu/~gelman/arm/examples/election88
library ("arm")
polls.subset <- read.table ("C:/Users/jerry/Desktop/SDS384/polls.subset.dat")
attach(polls.subset)

 # Load in data for region indicators
 # Use "state", an R data file (type ?state from the R command window for info)
 #
 # Regions:  1=northeast, 2=south, 3=north central, 4=west, 5=d.c.
 # We have to insert d.c. (it is the 9th "state" in alphabetical order)

data (state)                  # "state" is an R data file
state.abbr <- c (state.abb[1:8], "DC", state.abb[9:50])
dc <- 9
not.dc <- c(1:8,10:51)
region <- c(3,4,4,3,4,4,1,1,5,3,3,4,4,2,2,2,2,3,3,1,1,1,2,2,3,2,4,2,4,1,1,4,1,3,2,2,3,4,1,1,3,2,3,3,4,1,3,4,1,2,4)

 # define other data summaries

y <- bush                  # 1 if support bush, 0 if support dukakis
n <- length(y)             # of survey respondents
n.age <- max(age)          # of age categories
n.edu <- max(edu)          # of education categories
n.state <- max(state)      # of states
n.region <- max(region)    # of regions

 # also include a measure of previous vote as a state-level predictor

library (foreign)
presvote <- read.dta ("C:/Users/jerry/Desktop/SDS384/presvote.dta")
attach (presvote)
v.prev <- presvote$g76_84pr
age.edu <- n.edu*(age-1) + edu

## Fit the model in Bugs

data <- list ("n", "n.age", "n.edu", "n.state", "n.region",
 "y", "female", "black", "age", "edu", "state", "region", "v.prev")

inits <- function () {list(
    b.0=rnorm(1), b.female=rnorm(1), b.black=rnorm(1), b.female.black=rnorm(1),
    a.age=rnorm(n.age), a.edu=rnorm(n.edu),
    a.age.edu=array (rnorm(n.age*n.edu), c(n.age,n.edu)),
    a.state=rnorm(n.state), a.region=rnorm(n.region),
    sigma.age=runif(1), sigma.edu=runif(1), sigma.age.edu=runif(1),
    sigma.state=runif(1), sigma.region=runif(1))
}

params <- c ("b.0", "b.female", "b.black", "b.female.black",
   "a.age", "a.edu", "a.age.edu", "a.state", "a.region",
   "sigma.age", "sigma.edu", "sigma.age.edu", "sigma.state", "sigma.region")
 
library(R2OpenBUGS)
library(lattice)
#election.ch17 <- bugs (data, inits, params, "model.txt", n.chains=3, n.iter=1000,debug=TRUE)
election.ch17 <- bugs (data, inits, params, "model.txt", codaPkg=TRUE,n.chains=3, n.iter=1000,debug=TRUE)
out.coda<-read.bugs(election.ch17)
library(coda)
jpeg('densityplotM2_b0_bfemale_bblack.jpg')
densityplot(out.coda)
dev.off()

jpeg('xy_M2_b0_bfemale_bblack.jpg')
xyplot(out.coda)
dev.off()

jpeg('auto_M2_b0_bfemale_bblack.jpg')
acfplot(out.coda)
dev.off()