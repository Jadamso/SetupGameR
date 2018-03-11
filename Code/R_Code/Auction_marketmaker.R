#------------------------------------------------------------------
##################
#' Make Symmetric Market 
################## 
#'
#' @param Participants 
#' @param qids
#' @param shares market shares if wids is FALSE
#' @param ThetaA,ThetaB vectors of preferences for each good
#' @param Ab,As total factor productivity
#' @param ngoods number of goods
#' @param mdir save to mdir if not NA
#'
#' @return Participants
# @examples
#' @export

market_maker1 <- compiler::cmpfun( function(
    Participants,
    qids=NA,
    shares=c(.5,.5),
    thetaB=c(.5,.7,.9),
    Ab=.5,
    thetaS=c(.5,.7,.9),
    As=.5,
    ngoods=c(10,10,10),
    mdir=NA
    ){
    
    # Division of Students
    if( ! is.na(qids[[1]]) ){
        qids <- qid_fun(Participants, shares)
    }
    # Market Setup
    BuyersT  <- TYPEsheet(qids[[1]], Participants,
        "buyer", "Buyers")
    SellersT <- TYPEsheet(qids[[2]], Participants, 
        "seller", "Sellers")

    # Payoff Setup
    Buyers  <- SPREADsheet(BuyersT, ngoods)
    Sellers <- SPREADsheet(SellersT, ngoods)

    # Profile Setup
    Buyers  <- VALUEsheet(Buyers, cobbdouglas_fun,
        theta=thetaB, A=Ab)
    Sellers <- VALUEsheet(Sellers, sep_fun,
        theta=thetaS, A=As)


    Participants <- c(Buyers, Sellers)
    
    if( is.na(mdir) ){
        return(Participants)
    } else {
        save(Participants, file=paste0(mdir,"player_file.Rdata") )
        return(Participants)
    }

})

#------------------------------------------------------------------
##################
#' Make Market Structure 
################## 
#'
#' @param gdir file to save player_file to
#' @param pdir file holding market structures
#' @param Market name of market structure
#'
#' @return nothing
# @examples
#' @export


market_maker2 <- compiler::cmpfun( function(
    Participants,
    shares=c(.5,.25,.25),
    thetaB=c(.5,.7),
    Ab=.5,
    thetaS=list(2,1),
    As=list(.2, .4),
    ngoods=c(10,10),
    ngood_names=c("Q1","Q2")){

    # Market Setup
    qids      <- qid_fun(Participants, shares)
    BuyersT   <- TYPEsheet(qids[[1]], Participants,
        "buyer" , "Buyers")
    Sellers1T <- TYPEsheet(qids[[2]], Participants,
        "seller", "Sellers1")
    Sellers2T <- TYPEsheet(qids[[3]], Participants,
        "seller", "Sellers2")

    # Payoff Setup
    Buyers   <- SPREADsheet(BuyersT, ngoods)
    Sellers1 <- SPREADsheet(Sellers1T, ngoods[1], ngood_names[1])
    Sellers2 <- SPREADsheet(Sellers2T, ngoods[2], ngood_names[2])

    #Profile Setup
    Buyers   <- VALUEsheet(Buyers, cobbdouglas_fun,
        theta=thetaB, A=Ab )
    Sellers1 <- VALUEsheet(Sellers1, linear_fun,
        theta=thetaS[[1]], A=As[[1]])
    Sellers2 <- VALUEsheet(Sellers2, linear_fun,
        theta=thetaS[[2]], A=As[[2]])


    Participants <- c(Buyers, Sellers1, Sellers2)
    return(Participants)
    
})
