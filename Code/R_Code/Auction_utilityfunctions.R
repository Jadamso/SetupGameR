#------------------------------------------------------------------
##################
#' linear values with noise
##################
#' @param base parameter
#' @param scale parameter
#' @param players parameter
#' @param het parameter
#' 
#' @return matrix
# @examples
#' 
#' @export
unit_values_linear_fun <- compiler::cmpfun( function(
    base=1,
    scale,
    players,
    het=1) {
    
    heterogen <- (players/max(players))*het
    res <- round(heterogen, 2)
    val <- base*scale + res
    
    return(val)
})

#------------------------------------------------------------------
##################
#' Many linear values with noise
##################
#' @param units number of different goods
#' @param players number of players
#' @param value_assign vector of values
#' @param scale parameter
#' @param demand is person buying or selling
#' 
#' @return 
# @examples
#' 
#' @export

unit_values_linear <- compiler::cmpfun( function(
    units,
    players,
    value_assign,
    scale,
    demand=TRUE) {
    
    if(demand){
        runits <- rev(units)
    } else {
        runits <- units
    }
    
    uvals <- c( sapply( runits,
        value_assign, scale, players ) )
        
    return(uvals)
})

#------------------------------------------------------------------
##################
#' Functions
##################
#' @param inputs matrix of inputs
#' @param theta parameter vector
#' @param A "technology" parameter
#' 
#' @return matrix
# @examples
#' 
#' @export

#CES: micEconCES
#Cobb-Douglas: micEcon

# Cobb-Douglass
cobbdouglas_fun <- compiler::cmpfun( function(
    inputs, theta, A=1){
    
    A*prod(inputs**theta)
})

#' @rdname cobbdouglas_fun
#' @export
lncobbdouglas_fun <- compiler::cmpfun( function(
    inputs, theta, A=1){
    
    A + sum(inputs**theta)
})


#' @rdname cobbdouglas_fun
#' @export
power_fun <- compiler::cmpfun( function(
    inputs, theta, A=1, B=1){
    
     A + B*prod(inputs**theta)
})

#' @rdname cobbdouglas_fun
#' @export
linear_fun <- compiler::cmpfun( function(
    inputs, theta, A=1){
     A + prod(inputs*theta)
})


#' @rdname cobbdouglas_fun
#' @export
sep_fun <- compiler::cmpfun( function(
    inputs, theta, A=0){
     A + sum(inputs*theta)
})



