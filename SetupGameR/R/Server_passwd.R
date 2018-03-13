#------------------------------------------------------------------
##################
#' Create Password for Individual Player
##################
#'
#' @param user who to create a password for
#' @param passwd what password
#' @param create overwrite and create new passwd_file 
#' @param sys if TRUE execute the bash script
#' @param passfile what file holds the passwords
#' 
#' @return a string to be executed by system()
# @examples
#' 
#' @export

sspasswd <- compiler::cmpfun( function(
    user,
    passwd,
    create=FALSE,
    sys=TRUE,
    passfile="/srv/shiny-server/passwd")
{
    if(create==TRUE){
        sscreate <- " -c "
    } else {
        sscreate <- ""
    }
    
    sys_cmd <- paste0(
        "echo ", passwd,
        " | /opt/shiny-server/bin/sspasswd ",
        sscreate,
        passfile, " ", user )

    if(sys==FALSE){
        return(sys_cmd)
    } else {
        system(sys_cmd)
    }
})


#------------------------------------------------------------------
##################
#' Create Passwords for List of Players
##################
#'
#' @param Participants list of participants
#' @param passwd what password
#' @param create overwrite and create new passwd_file 
#' @param sys if TRUE execute the bash script
#' @param passfile what file holds the passwords
#'
#' @return a string to be executed by system()
# @examples
#' 
#' @export

sspasswd_cmd <- compiler::cmpfun( function(
    Participants,
    passwd,
    create=FALSE,
    sys=FALSE,
    passfile="/srv/shiny-server/passwd"
    ){

    ## Which Students 
    USERS   <- sapply(Participants, function(e) e$ID)
    ## What PassWords
    PASSWDS <- rep(passwd, length(USERS))
    
    ## Lunix Command
    SYS_CMD <- mapply(sspasswd, USERS, PASSWDS,
        MoreArgs=list(
            create=create,
            passfile=passfile,
            sys=sys))
    
    return(SYS_CMD)
    #if(sys==FALSE){
    #    return(SYS_CMD)    
    #} else {
    #    sapply(SYS_CMD, system)
    #}
    
})


#------------------------------------------------------------------
##################
#' Create Passwords for List of Players
##################
#'
#' @param Participants student participants
#' @param passwd what password
#' @param gdir location of host Game folder
#' @param pfile name of file to hold the passwords

#' @return a string to be executed by system()
# @examples
#' 
#' @export

passwd_maker <- compiler::cmpfun( function(
    Participants=NA,
    passwd="TrialAuction",
    gdir="/etc/shiny-server/",
    pfile="passwd") {

    
    ## Create File with Me
    passfile <- paste0(gdir,pfile)
    sspasswd("admin", passwd,
        create=TRUE, sys=TRUE, passfile=passfile)

    ## Add Students
    if( is.na(  unlist(Participants)[1] ) ){
        load(file=paste0(gdir,"player_file.Rdata") )
    }
    
    ## Players created in DoubleAuction/PlayerSetup/PlayerSetup.R
    ## "JA" was appended to each ID
    sspasswd_cmd(Participants, passwd,
        create=FALSE, sys=TRUE, passfile=passfile)
    
    return(passwd)

})




#------------------------------------------------------------------
##################
#' Create Passwords for List of Players
##################
#' @rdname passwd_maker
#' @param n number of student participants
#' @param passwd what password
#' @param sys if TRUE execute the bash script
#' @param passfile what file holds the passwords
#' @param gdir location of host Game folder
#' @param pfile name of file to hold the passwords
#' @param add_admin also reset admin password [NOT YET WORKING]
#' @param create overwrite and create new passwd_file [CURRENTLY done with new admin]

#' @return a string to be executed by system()
# @examples
#' 
#' @export

passwd_maker0 <- compiler::cmpfun( function(
    n=20,
    user_append="JA",
    passwd="TrialAuction",
    create=FALSE,
    sys=FALSE,
    passfile="/srv/shiny-server/passwd",
    gdir="/etc/shiny-server/",
    pfile="passwd",
    add_admin=TRUE) {

    
    ## Create File with Admin
    passfile <- paste0(gdir,pfile)
    SetupGameR::sspasswd("admin", passwd,
        create=TRUE, sys=TRUE, passfile=passfile)

    Class <- SetupGameR::create_playergroups(
        n=n, groupsize=1)[,"ID"]
    USERS <- paste0(user_append, Class)
    
    ## Players created in DoubleAuction/PlayerSetup/PlayerSetup.R
    ## "JA" was appended to each ID
    mapply(SetupGameR::sspasswd, USERS, PASSWDS,
        MoreArgs=list(
            create=FALSE,
            passfile=passfile,
            sys=sys))
    
    return(passwd)

})

