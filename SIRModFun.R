# Gillespie models to see stocahstic liftoff dynamics/bistability

# Function from Weitz Biosciences textbook

stochsim_SIR = function(trange, y0, pars){
    # Simulates a SIR model via the Gillespie algorithm from t0 to tf in trange
    # given initial conditions in y = c(S0, I0, R)) and parameters in pars.
    # Returns the time and values
    # Conditions
    t0 = trange[1]
    tf = trange[2]
    # We rbind each new datapoint c(t, S, I, R) into a new row of a dataframe
    df.res = c(t0, y0)
    # Set up initials
    tcur = t0
    ycur = y0
    ind = 1
    # Model
    while(tcur<tf){
        # Check to see if there is an infection
        if(ycur[2] == 0){
            # Update ind and save
            ind = ind + 1
            df.res = rbind(df.res, c(tcur, ycur))
            break
        }
        # Rates
        infrate = pars$beta * ycur[1] # infection rate
        recrate = pars$gamma * ycur[2] # recovery rate
        totrate = infrate + recrate
        dt = -1/totrate * log(runif(1)) # Update time
        tcur = tcur + dt
        # Event type
        if(runif(1)<(infrate/totrate)){
            ycur[2] = ycur[2] + 1
            ycur[1] = ycur[1] - 1 
        }else{
            ycur[2] = ycur[2] - 1
            ycur[3] = ycur[3] + 1
        }
        # Update ind and save
        ind = ind + 1
        df.res = rbind(df.res, c(tcur, ycur))
    }
    rownames(df.res) = NULL
    colnames(df.res) = c('time', 'S', 'I', 'R')
    return(df.res)
}


shellpipes::saveEnvironment()
