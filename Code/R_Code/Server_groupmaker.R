#-------------------------------------------------------------------
##################
#'Create Fake Class
##################
#'
#' @param n number of students
#' @param len length of password
#' @param patt password pattern
#' @param ID student ids
#' @param gdir directory to save student list
#'
#' @return Class or name of saved file
# @examples
#' @export

create_playergroups <- compiler::cmpfun( 
    function(seed=0, game_dir=NA, groupsize=2,
    n=20, len=8, patt="[a-z]", ID=1:n){

    Class <- SetupGameR::create_class_fake(n, len, patt, ID)
    
    if( seed > 0 ){
        set.seed(seed)
        Class[['Group']] <- sample(rep( seq_len(n/groupsize),groupsize))
        GroupID <- outer(Class[['Group']], Class[['Group']], '==')
        diag(GroupID) <- FALSE
        GroupID <- (Class[['ID']] > apply(GroupID,groupsize,which) )+1
        
    } else {
        Class[['Group']] <- seq_len(n/groupsize)
        GroupID <- c(outer(rep(1,n/groupsize), 1:groupsize ))
    }

    Class[['GroupID']] <- GroupID
    
    if( is.na(game_dir)){
        return(Class)
    } else {
        cfile <- paste0( game_dir , 'Class.csv')
        write.csv(Class, row.names=FALSE, file=cfile)
        return(cfile)
    }
    
})
    
