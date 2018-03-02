#------------------------------------------------------------------
##################
#' Format ID and Name into Empty Profile
##################
#' @param id_col Person ID
#' @param name_col Person Name
#' 
#' @return a list, Empty userProfile
# @examples
#' 
#' @export

idsheet_default <- compiler::cmpfun( function(id_col, name_col){

    PID <- list()

    PID$Name <- name_col
    PID$ID   <- id_col

    PID$History <- list(NA)

    return(PID)
})

#------------------------------------------------------------------
##################
#' Create Profile List from Classlist
##################
#' @param classlist matrix or data.frame indicating participants
#' @param idsheetfun which function to use
#' @param id column name with unique identifies
#' @param name column name with unique identifies
#' @param SIMPLIFY,USE.NAMES  passed to mapply 
#' @param ... arguments passed to idsheetfun
#' 
#' @return list of participants
# @examples
#' 
#' @export

IDsheet <- compiler::cmpfun( function(
    classlist,
    idsheetfun=idsheet_default,
    id="ID",
    name="Name",
    SIMPLIFY=FALSE,
    USE.NAMES=FALSE,
    ...){
    
    participants <- mapply(idsheetfun,
        classlist[,id], classlist[,name],
        SIMPLIFY=SIMPLIFY,
        USE.NAMES=USE.NAMES,
        ...)

    return(participants)
})

#------------------------------------------------------------------
##################
#' Format Class into Player Profiles
################## 
#'
#' @param gdir directory to save player_file: Market/Game
#' @param Class which class to include
#' @param IDsheetfun which function to use
#' @param idsheetfun which function to use
#' @param id column name with unique identifies
#' @param name column name with unique identifies
#' @param appendw what to append student ID's with
#' @param SAVE save the participants
#'
#' @return Participants
# @examples
#' @export

player_maker <- compiler::cmpfun( function(
    gdir=NA,
    Class,
    IDsheetfun=IDsheet,
    idsheetfun=idsheet_default,
    id="ID",
    name="Name",
    appendw="JA",
    SAVE=TRUE,
    ...){ 

    # Player Profiles
    ## Create a list of players with profiles
    ## Each player has a profile, identified by the student ID
    Class$ID <- paste0(appendw, Class$ID)
    Participants <- IDsheetfun(Class, idsheetfun, "ID", "Name", ...)
    cat(Class$ID, "\n")


    # Market Setup
    #source( paste0(pdir, Market, ".R") )
    #cat("Market: ", Market, "\n")

    # Save Output
    if(SAVE){
        save(Participants, file=paste0(gdir,"player_file.Rdata") )
        return(Participants)
    } else {
        return(Participants)
    }
} )

