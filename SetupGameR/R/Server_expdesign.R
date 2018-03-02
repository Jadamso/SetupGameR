#------------------------------------------------------------------
##################
#' Make Market Structure 
################## 
#'
#' @param hdir home directory
#' @param i number of sellers
#' @param ngame number of games
#' @param ni number of buyers
#' @param gpass create participants passwords in gamefile
#'
#' @return nothing
# @examples
#' @export


game_setup <- compiler::cmpfun( function(
    hdir="~/DoubleAuction/Markets/",
    i,
    ngame=5,
    ni=12,
    gpass=FALSE){

    ## Make the Participant List for That Game
    message(i)
    mdir   <- paste0(hdir, "Market_",i,"")
    nstuds <- ni + i
    seed   <- i
    
    
    STUDS  <- SetupGameR::class_sample(1, ngame, nstuds )


    ## Create the Players
    PARTICIPANTS <- lapply( seq(STUDS), function(j){
        studs <- STUDS[[j]]
        gdir <- paste0(mdir,'_Game_',j,'/')
        SetupGameR::player_maker(gdir, studs)
    })
    # load(paste0(paste0(mdir,'Game_',3,'/'),"player_file.Rdata") )


    ## Create the PassWords
    if(gpass==TRUE){
        lapply( seq(PARTICIPANTS), function(j){
            #studs <- PARTICIPANTS[[j]]
            gdir <- paste0(mdir,'_Game_',j,'/')
            SetupGameR::passwd_maker(gdir=gdir)
            message(j)
        })
    }

    ## Create the Market Games
    Participants_List <- lapply( seq(PARTICIPANTS), function(j){
        qids <- list( seq(i), tail(seq(nstuds), -i))
        gdir <- paste0(mdir,'_Game_',j,'/')
        load(paste0(gdir,"player_file.Rdata") )
        SetupGameR::market_maker1(
            Participants,
            qids=qids,
            mdir=gdir)
    })

})


#------------------------------------------------------------------
##################
#' Make Experiment
################## 
#'
#' @param buyers,sellers number of students
#' @param classtime how long is the class
#' @param sessiontime how long will the games take
#'
#' @return nothing
# @examples
#' @export

exp_design <- compiler::cmpfun( function(
    buyers=c(1,2,12),
    sellers=12,
    classtime=75,
    sessiontime=10){

    ## Experimental Design
    M  <- as.matrix( expand.grid( buyers, sellers ) )
    MM <- cbind(M,rowSums(M))
    colnames(MM) <- c("buyers","sellers","total")
    
    ## How many sessions in a class
    sessions <- (classtime/nrow(MM))/sessiontime
    
    return(list(sessions=sessions, Expriment=MM))
    
})
