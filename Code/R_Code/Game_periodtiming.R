#------------------------------------------------------------------
##################
#' How much time left in trading session
################## 
#' @param period_timer a time object
#' @param tfreq how often to update in milliseconds

#' @return numeric object showing time in seconds
# @examples
#' @export

utimeLeft <- compiler::cmpfun( function(
    period_timer,
    tfreq=1000,
    units="secs"){

    invalidateLater(tfreq)
    
    ltime <- difftime( period_timer, Sys.time(), units=units)
    
    return(ltime)
    
})


#------------------------------------------------------------------
##################
#' How much time left in trading session
################## 
#' @param startTime a time object
#' @param etime a time object EndTime
#' @param units what units to return
#' @return numeric object showing time in minutes
# @examples
#' @export

timeLeft <- compiler::cmpfun( function(
    startTime,
    etime,
    units="mins"){

    elapsedTime <- Sys.time() - startTime
    leftTime <- etime - elapsedTime
    ltime <- as.numeric(leftTime, units=units)
    
    return(ltime)
    
})
                
#------------------------------------------------------------------
##################
#' Gate Keeper
################## 
#' 
#' @param startTime a time object of what time this game started
#' @param etime a time object EndTime
#' @param tfreq how often to update in milliseconds
#' @param ctime_title what to print
#' @param TradePeriod which trading period is this?
#' @param savepath file to save to, normally tempdir() or getwd()
#' @param GameName name of file
#' 
#' @return Message of time left in trading session or Save and Exit
# @examples
#' @export

ctimeLeft <- compiler::cmpfun( function(
    startTime=Sys.time(),
    etime,
    tfreq=1000,
    ctime_title="Minutes Remaining: ",
    TradePeriod=Sys.time(),
    savepath=paste0(getwd(), "/"),
    GameName="Game_"){

    invalidateLater(tfreq)
    
    ltime <- timeLeft(startTime, etime)
    
    if(ltime > 0){ 
        paste0(ctime_title, round(ltime,1) )
    } else {
    
        Message <<- c("Trading Over", "error")
        paste0(Message[1])
        stopApp(0)
        paste0(Message[1])
        
        savegame(
            startTime=startTime,
            TradePeriod=TradePeriod,
            savepath=savepath,
            GameName=GameName)
        cat( paste0("Saved To: ", savepath ) )
    }
})

#------------------------------------------------------------------
##################
#' Gate Keeper
################## 
#' 
#' @rdname ctimeLeft
#' @return Message of time left in trading session or Message
# @examples
#' @export

ctimeLeft0 <- compiler::cmpfun( function(
    startTime=Sys.time(),
    etime,
    tfreq=1000,
    ctime_title="Minutes Remaining: "){
    #postr="

    invalidateLater(tfreq)
    ltime <- timeLeft(startTime, etime)
    
    if( ltime > 0 ){ 
        mess <- paste0(ctime_title, round(ltime,1) )
    } else {
        Message <<- c("Trading Over", "error")
        mess <- Message[1]        
    }
    return( mess )
})

#------------------------------------------------------------------
##################
#' Update Global Environment
################## 
#' @param ... objects to post to the global environment
#'
#' @return Nothing
# @examples
#' @export

post_global <- compiler::cmpfun( function( ... ) {
    arg.list <- list(...)
    names    <- all.names(match.call())[-1]
    for (i in seq_along(names)) {
        assign(names[i], arg.list[[i]], .GlobalEnv)
    }
})




#------------------------------------------------------------------
##################
#' Check if current time is in a list of times 
################## 
#' @param stimes list of times to check
#' @param e degree of rounding
#'
#' @return TRUE/FALSE
# @examples
#' @export

stime_function <- compiler::cmpfun( function(stimes,e=0){
    stime_0 <- Sys.time() - stimes
    stime_n <- round( as.numeric( stime_0, units="secs"), e)
    stime_test <- any( stime_n == 0 ) 
    return(stime_test)
 })
     
     
