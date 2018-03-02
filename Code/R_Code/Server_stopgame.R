#------------------------------------------------------------------
##################
#' Save Game
##################
#'
#' @param startTime what time did this game start at?
#' @param TradePeriod which trading period is this?
#' @param savepath file to save to
#' @param GameName,PeriodName name of file
#'
#' @return string, Name of Game File
#'
#' @details see https://shiny.rstudio.com/articles/persistent-data-storage.html, format(Sys.time(), "%Y-%m-%d_%H-%M-%S")
# @examples
#' @export

savegame <- compiler::cmpfun( function(
    startTime=as.character(Sys.time()),
    TradePeriod=as.character(Sys.time()),
    savepath=paste0(tempdir(), "/"),
    GameName="Game_",
    PeriodName="_Period_"){

    TimeStamp <- gsub(" ", "_",  startTime)
    if(TradePeriod==startTime){
        GameStamp <- "" 
    } else {
        GameStamp <- paste0(PeriodName, 
            gsub(" ", "_", TradePeriod) )
    }
    
    Game <- paste0( GameName, TimeStamp, GameStamp, ".RData")
    GameFile <- paste0(savepath,Game)

    save.image(file=GameFile)
    message(GameFile)
    return(GameFile)
})



#------------------------------------------------------------------
##################
#' Stop Game and Manage Output
##################
#'
#' @param SAVE save data
#' @param RM remove objects in session?
#' @param EXCEPT exceptions not to be removed
#' @param startTime what time did this game start at?
#' @param TradePeriod which trading period is this?
#' @param savepath file to save to
#' @param GameName name of file
#'
#' @return string, Name of Game File
#'
# @examples
#' @export

shutdown <- compiler::cmpfun( function(
    SAVE=TRUE,
    RM=FALSE,
    EXCEPT=NULL,
    startTime=Sys.time(),
    TradePeriod=Sys.time(),
    savepath=paste0(tempdir(), "/"),
    GameName="Game_"){

    if(SAVE){
        GameFile <- savegame(
            startTime=startTime,
            TradePeriod=TradePeriod,
            savepath=savepath,
            GameName=GameName)
    } else {
        GameFile <- NA
    }

    if(RM){ MiscUtils::rmall(EXCEPT=EXCEPT) }
    
    return(GameFile)
})



# Write a file in your working directory
#users_data <- data.frame(START = Sys.time())
#end_fun <- function() {
#    users_data$END <- Sys.time()
#    write.table(x = users_data,
#        file=file.path(tempdir(), "users_data.txt"),
#        append= TRUE,
#        row.names= FALSE,
#        col.names= FALSE,
#        sep= "\t")
#}


#------------------------------------------------------------------
##################
#' Stop A Game with a Pause
##################
#'
#' @param game_file which game file to load
#' @param savepath file to save to
#' @param GameName name of file
#' @param SAVE save data
#' @param RM remove objects in session?
#' @param EXCEPT exceptions not to be removed
#' @param period_rest seconds to pause after shutdown
#'
#' @return nothing
#'
# @examples
#' @export

GameStop <- compiler::cmpfun( function(
    game_file=paste0(gdir,"game_file.RData"),
    EXCEPT=c("gdir", "GameInit", "Game"),
    savepath=paste0(tempdir(), "/"),
    GameName="Game_",
    RM=FALSE,
    SAVE=TRUE,
    period_rest=5)
{

    load(game_file)

    shutdown(
        SAVE=SAVE,
        startTime=startTime,
        TradePeriod=TradePeriod,
        RM=RM,
        EXCEPT=EXCEPT,
        savepath=savepath,
        GameName=GameName)

    Sys.sleep(period_rest)
})

#------------------------------------------------------------------
##################
#' Initiate and Stop Game
##################
#'
#' @param gdir directory of game files
#'
#' @return nothing
#'
# @examples
#' @export

Game <- compiler::cmpfun( function(gdir){
    #GameLength()
    GameInit( game_file=paste0(gdir, "game_file.RData") )
    shiny::runApp( paste0(gdir) )
    #runGitHub( "Jadamso/DoubleAuction", subdir="Game")
    GameStop( game_file=paste0(gdir, "game_file.RData"))
})

