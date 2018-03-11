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

idsheet_simple <- compiler::cmpfun( function(id_col, name_col){

    PID <- list()

    PID$Name <- name_col
    PID$ID   <- id_col

    PID$History  <- NA


    return(PID)
})


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

idsheet <- compiler::cmpfun( function(id_col, name_col){

    PID <- list()

    PID$Name <- name_col
    PID$ID   <- id_col

    PID$type  <- NA
    PID$class <- NA

    PID$spreadsheet <- NA

    PID$valuesheet  <- NA

    PID$record <- NA
    PID$finalvalue <- NA

    return(PID)
})

#------------------------------------------------------------------
##################
#' Create Profile List from Classlist
##################
#' @param classlist matrix or data.frame indicating participants
#' @param idsheetfun which function to use
#' @param id column name with unique identifies
#' @param name vector indicating columnnames
#' 
#' @return list of participants
# @examples
#' 
#' @export

IDsheet <- compiler::cmpfun( function(
    classlist,
    idsheetfun=idsheet,
    id="ID",
    name="Name"){
    
    participants <- mapply(idsheetfun,
        classlist[,id], classlist[,name],
        SIMPLIFY=FALSE, USE.NAMES=FALSE)

    return(participants)
})

#------------------------------------------------------------------
##################
#' Split Students int Market Structure
##################
#' @param Participants List of userProfiles
#' @param shares vector of shares indiciting market structure
#' 
#' @return vector indicating persons group
# @examples
#' 
#' @export

qid_fun <- compiler::cmpfun( function(
    Participants,
    shares=c(.5,.5) ){
    
    npart <- seq(Participants )
    probs <- diffinv(shares)

    quants <- quantile(npart, probs=probs, type=1)
   
    qcuts <- cut(npart, quants, include.lowest=T)
    qids  <- split(npart, qcuts)
    names(qids) <- tail(names(quants), -1)

    return(qids)
})

#------------------------------------------------------------------
##################
#' Filling In Empty Profile
##################
#' @param qid from qid_fun
#' @param PID list of profiles
#' @param typ buying or selling
#' @param clas type details, i.e. sellers_type2
#' 
#' @return 
# @examples
#' 
#' @export

TYPEsheet <- compiler::cmpfun( function(qid, PID, typ, clas){

    PIDsub <- PID[qid]
    PIDpersons <- sapply(PID, function(e) e$ID )
    PIDtyp <- lapply(PIDsub, function(i){
        i$type <- typ
        i$class <- list()
        i$class$name <- clas
        i$class$rank <- which(PIDpersons==i$ID)
        return(i)
    })
    
    return( PIDtyp)
})

