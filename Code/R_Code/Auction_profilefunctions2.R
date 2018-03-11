#------------------------------------------------------------------
##################
#' Creating Empty Inventory
##################
#' @param nunit number of units of each type
#' 
#' @return vector
# @examples
#' 
#' @export

spreadsheet <- compiler::cmpfun( function(nunit=10){

    sDF <- data.frame(
        Quantity=1:nunit,
        Remaining=TRUE)
    return(sDF)
})

#' @rdname spreadsheet
spreadnames <- compiler::cmpfun( function(nunit){

    sName <- sapply(seq_along(nunit),
        function(i){paste0("Q",i)})
    return(sName)
})

#------------------------------------------------------------------
##################
#' Creating Empty Inventory
##################
#' @param nunits vector of number of units of each type
#' @param PID list of profiles
#' @param snames custom names of goods
#' 
#' @return vector
# @examples
#' 
#' @export

SPREADsheet <- compiler::cmpfun( function(
    PID,
    nunits=c(4,4),
    snames=NA){
    
    sSheet <- lapply(nunits, spreadsheet)
    if(is.na(snames)){
        names(sSheet) <- spreadnames(nunits)
    } else {
        names(sSheet) <- snames
    }
    
    sPID <- lapply(PID, function(pid) {
        pid$spreadsheet <- sSheet
        return(pid)
    })
    
    return(sPID)
})
#------------------------------------------------------------------
##################
#' Fill in userProfile with values
##################
#' @param i individual userProfile
#' @param fun what utility/production funtion to use
#' @param ... options passed to fun
#' 
#' @return updated userProfile
# @examples
#' 
#' @export


valuesheet <- compiler::cmpfun( function(i, fun, ...){
        Q  <- sapply(i$spreadsheet, function(e) {
            e$Quantity})
        Qall <- expand.grid(as.data.frame(Q))
        U    <- apply(Qall, 1, fun, ...)
        #DU <- diff( c(0,U))
        i$valuesheet <- cbind(Qall,U)[order(U),]

        ## Name Change
        if(i$type=="seller"){
            Uname <- "Cost"
        } else if(i$type=="buyer") {
            Uname <- "Benefit"
        } else {
            message("type not set properly")
            Uname <- NA
        }
        names(i$valuesheet) <- gsub("U", Uname,
            names(i$valuesheet) )
        return( i )
})

#------------------------------------------------------------------
##################
#' Filled In List of Profiles
##################
#' @param PID list of profiles
#' @param fun what utility/production funtion to use
#' @param ... options passed to fun
#' 
#' @return list of profiles
# @examples
#' 
#' @export

VALUEsheet <- compiler::cmpfun( function(PID, fun, ...){
    PIDval <- lapply(PID, valuesheet, fun, ...)
    PIDval
})

