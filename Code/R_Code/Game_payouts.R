#------------------------------------------------------------------
##################
#' Payouts
################## 
#' @param participants List of Participants
#' @param in0 first period to sample from (ignore early histories)
#' @param out0 last period to sample from
#' @param base a base rate to pay them (showup fee)
#' @param pass initial seed
#'
#' @return payouts for each person
# @examples
#' @export


random.payouts <- compiler::cmpfun( function(
    Participants,
    base=0,
    in0=2,
    out0=length(Participants[[1]]$History),
    randseed=NULL
    ){

    set.seed(randseed)
    randout <- sample(in0:out0, 1)
    cat("RandomHistory: ", randout, "\n")
    
    ## Calculate Payouts
    payouts <- sapply(Participants, function(i){
        profi  <- i$History[[randout]]
        profit <- sum(profi$Profit,na.rm=TRUE) + base
        names(profit) <- i$ID
        profit
    })
    #cat("Payouts:", payouts, "\n")
    
    return(payouts)
    ## post_global(payouts)
})



#------------------------------------------------------------------
##################
# UNUSED
################## 
# @param participants List of Participants
# @param period which history to grab
#
# @return matrix of columns
# @examples
        
nonrandom.payouts <- compiler::cmpfun( function(
    Participants, period=1, digits=0){

    payouts <- sapply(participants, function(person_i){
        history_i <- person_i$History[[period]]
        
        payoff_i <- round( sum(
            history_i[,c("Profit")], na.rm=TRUE),digits)
        
        return(payoff_i)
    })
    
    return(payouts)
})

