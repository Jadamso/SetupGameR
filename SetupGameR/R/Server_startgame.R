#-------------------------------------------------------------------
##################
#' Game Length Function Helper
##################
#'
#' @param H,M,S integers for hours,minutes,seconds
#'
#' @return Class or name of saved file
# @examples
#' @export

etime_fun <- compiler::cmpfun( function(H,M,S){
    #if(any( !is.integer( c(H,M,S) ) ) ){message("Choose Integers")}
    et <- as.difftime(paste(H,M,S,sep=':'),'%H:%M:%S',units='min')
    return(et)
})


#------------------------------------------------------------------
##################
#' GameLength
##################
#'
#' @param etime how long does the game endure?
#' @param gdir directory of game
#' @param param_file name of file with game parameters
#'
#' @return nothing
#'
# @examples
#' @export

GameLength <- compiler::cmpfun( function(
    etime=etime_fun("00","10","00"),
    u_timer=60000,
    gdir="/srv/shiny-server/DoubleAuction/Game/",
    param_file=paste0(gdir,"time_file.RData"),
    ...)
{
    ## Read by server.R 
    save(file=param_file,
        etime,
        u_timer,
        ...,
        precheck=FALSE)
   
    cat("GameLength: ", etime, "\n")
} )

#------------------------------------------------------------------
##################
#' Initiate Game
##################
#'
#' @param TradePeriod starting what trading period is the game?
#' @param startTime when to start game
#' @param gdir directory of game
#' @param game_file name of game to initiate
#' @param nperiods,npractice lengths of periods 
#' @param u_timer,efreq timing parameters
#'
#' @return string, Name of Game File
#'
# @examples
#' @export


GameInit <- compiler::cmpfun( function(
    TradePeriod=Sys.time(),
    startTime=Sys.time(),
    SessionName="Trial",
    etime=SetupGameR::etime_fun("00","10","00"),
    gdir="/srv/shiny-server/DoubleAuction/Game/",
    param_file=paste0(gdir,"time_file.RData"),
    u_timer=60000,
    efreq=1000,
    nperiods=20,
    npractice=2,
    ...){
    
    ## Read by server.R 
    save.image(file=param_file)
   
    cat("GameLength: ", etime, "\n")
})



GameInit_deprecated <- compiler::cmpfun( function(
    TradePeriod=Sys.time(),
    startTime=Sys.time(),
    gdir="/srv/shiny-server/DoubleAuction/Game/",
    game_file=paste0(gdir,"game_file.RData")){

    ## Read by server.R 
    save(file=game_file,
        TradePeriod,
        startTime,
        precheck=FALSE)

    return(game_file)
    cat('Game Init: \n')
    cat( game_file, "\n" )
    cat( TradePeriod, startTime, "\n")
})


#------------------------------------------------------------------
##################
#' Initiate Game
##################

#' @rdname  GameInit
#' param u_timer,nperiods,efreq misc parameters for period updating/ending
#' @export

GameInit0 <- compiler::cmpfun( function(
    TradePeriod=Sys.time(),
    startTime=Sys.time(),
    SessionName="Trial",
    etime=etime_fun("00","10","00"),
    gdir="/srv/shiny-server/DoubleAuction/Game/",
    param_file=paste0(gdir,"time_file.RData"),
    u_timer=60000,
    nperiods=20,
    efreq=100,
    ...){
    
    ## Read by server.R 
    save(file=param_file,
        etime,
        u_timer,
        TradePeriod,
        startTime,
        nperiods,
        efreq,
        SessionName,
        ...,
        precheck=FALSE)
   
    cat("GameLength: ", etime, "\n")
})


