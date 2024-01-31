# list of initial conditions
pars = list()
pars$c = 4 # contacts per unit time
pars$p = 0.005 # probability of an infectious contact
pars$beta = pars$c*pars$p # transmission rate
pars$gamma = 1/10 # recovery rate
pars$basR0 = pars$beta/pars$gamma

pars$N = 1000
pars$I0 = 25
pars$S0 = pars$N - pars$I0

# and (not sure if this is where this shd go) directions to run the model
# run the model for `ts` timesteps
ts <- 60
t=0:ts
y0=c("Susceptible"=pars$S0,"Infected"=pars$I0,"Recovered"=0)