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


create_class_fake <- compiler::cmpfun( function( 
    n=20, len=8, patt="[a-z]", ID=1:n,
    gdir=NA){

    ## Create Class List
    Class <- data.frame(
        Name=stringi::stri_rand_strings(
            n=n,
            length=len,
            pattern=patt),
        ID=ID)

    ## Save or Return
    if( is.na(gdir) ){
        return(Class)
    } else {
        studir <- paste0(gdir,"ClassList.csv")
        write.csv(Class, studir, row.names=F)
        return(studir)
    }
} )

#------------------------------------------------------------------
##################
#' Format Class into Player Profiles
################## 
#'
#' @param hdir directory holding master list of class
#' @param classname which class to include
#' #param cid which subset of players to include
#'
#' @return nothing
# @examples
#' @export

class_sample <- compiler::cmpfun( function(
    seed=33,
    ngame=5,
    nstuds=12,
    hdir="/home/shiny/DoubleAuction/Students/",
    classname="ClassList.csv"){ 
        
    
    ## Load Database
    Class <- read.csv( paste0(hdir, classname) )
    cat("required columns: Name, ID \n")
    cat("ID must be unique \n")

    set.seed(seed)
    ClassList <- lapply( 1:ngame, function(i){
        cid <- sample(Class$Name,nstuds)
        Class[Class$Name %in% cid,]
    })
    
    ## Which Students
    #if( is.na(cid) ){ cid <- 1:nrow(Class)}

    return(ClassList)
})


#------------------------------------------------------------------
##################
#' Clean the Class
################## 
#'
#' @param hdir directory holding master list of class
#' @param classname which class to include
#' @param name_id class names
#' @param name_id class ids
#'
#' @return nothing
# @examples
#' @export

class_cleaner <- compiler::cmpfun( function(
    hdir="/home/shiny/DoubleAuction/Students/",
    classname="ClassList_orig.csv",
    name_id="Username",
    ID_id="Student.ID",
    omits=NA){ 

    cfile <- paste0(hdir, classname) 
    
    # Load Database
    Class <- read.csv( cfile )
    cat("required columns: Name, ID \n")
    cat("ID must be unique \n")
    
    NewClass <- Class[,c(name_id, ID_id)]
    names(NewClass) <- c("Name", "ID")
    
    ## Omit Never Shows
    if(!is.na(omits)){
        Omits <- read.csv( paste0(hdir, omits), header=F)$V
        NewClass <- NewClass[ !(NewClass$Name %in% Omits),]
    }
    
    Newcfile <- paste0(hdir, "ClassList.csv") 
    write.csv(NewClass, file=Newcfile, row.names=FALSE)

})



