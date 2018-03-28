#---------------------------------------------------
##################
# Game Parameter Information
##################
library(shiny)
library(SetupGameR)

#------------------------------------------------------------------
##################
# Reactives For All Individuals
##################

# Survey Information Recorded
# After Game Completed
GlobSurvey <- reactiveValues(
    SurveyReady=FALSE,
    Names=NA,
    Gender=NA,
    Comments=NA,
    Earnings=NA,
    Payments=NA,
    RandomHistory=NA)


# Triggers to progress through the game
# only triggered if userPID==1
GlobalTriggers <- reactiveValues(ShowSurvey=TRUE )

# Triggers to show different modal screens
# only triggered if userPID==1
#Triggers <- reactiveValues( Survey=FALSE)

#------------------------------------------------------------------
##################
# For Each Individual
##################

shinyServer( function( input, output, session){


#------------------------------------------------------------------
#------------------------------------------------------------------
#------------------------------------------------------------------
#------------------------------------------------------------------
# Pre Game Setup
    
    #------------------------------------------------------------------
    ##################
    # User Login
    ##################
    
    #---------------------------------------------------
    ## Authorized access for ShinyServerPro
    user <- session$user    
    ## For Debugging
    #user <- sample( paste0("JA", 1:2),1)
    #user <- parseQueryString(session$clientData$url_search)[['user']]()
    #cat( file=stderr(), "User: ", user, "\n")
    
    #---------------------------------------------------
    # Identify User and Initial Group ID in `Participants'
    # Return user PID, GID
    userPID  <- as.numeric( gsub( "JA", "", user ) ) 
   

    #------------------------------------------------------------------
    ##################
    # PostGame Survey
    ##################
    observeEvent(GlobSurvey$SurveyReady, once=TRUE, {
        GlobSurvey$SurveyReady[userPID] <<- FALSE
        GlobSurvey$Payments[userPID] <<- "NA: You will be called and told shortly"
    })
    #---------------------------------------------------
    # Select Random History for Payment
    #s_1 <- observeEvent(Triggers$Survey,
    #    ignoreInit=TRUE, {
    #
    #    ## Save Game Results
    #    if(userPID==1 & Triggers$Survey) {
    #    
    #        ## Generate Random Period
    #        ## Exclude first 2 practice periods
    #        in0  <- ceiling(npractice + 1)
    #        out0 <- floor(length(Participants[[1]]$History))
    #        randout <- sample(in0:out0, 1)
    #        
    #        ## Random Earnings
    #        GlobSurvey$Earnings <- read.csv("PAYOUT FILE HERE")
    #        
    #        ## Round Earnings up to nearest quarter
    #        GlobSurvey$Payments <- MiscUtils::ceiling00(
    #            (2000 + GlobSurvey$Earnings)/200 + 7 )
    #        
    #        ## Which Round Was Selected
    #        GlobSurvey$RandomHistory <- randout
    #        
    #        ## Students (Formatted Histories of Participants)
    #        Students <<- TerritoryR::participant.outcomes(Participants,
    #            TreatmentParameters)
    #        
    #        ## Save Game Results
    #        saveRDS(Students, file=paste0(rdir,
    #            "SessionResults/Session_",SessionName,"/Results.Rds") )
    #            
    #        ## Trigger s_2
    #        GlobalTriggers$ShowSurvey <<- TRUE
    #    }#
    #
    #})

    #---------------------------------------------------
    # Begin Survey
    s_2 <- observeEvent(GlobalTriggers$ShowSurvey,
        ignoreInit=FALSE,{
     
        if(GlobalTriggers$ShowSurvey ){
            
            ## Show the Survery
            shinyjs::show('survey_mainpanel')
            shinyjs::show('survey_sidepanel')

        }
    })        


    
    callModule( SetupGameR::StartSurvey, "survey",
        GlobSurvey=GlobSurvey,
        userPID=userPID,
        SaveSurveyFile=paste0("/tmp/Survey_",
            format(Sys.time(),"%d-%m-%y_%H-%M-%S") ,".Rds")
    )
    
    #---------------------------------------------------
    # Show Student Payouts
    callModule( SetupGameR::ViewPayment, "payment",
        GlobSurvey=GlobSurvey,
        userPID=userPID
    )


#------------------------------------------------------------------
#------------------------------------------------------------------
#------------------------------------------------------------------
#------------------------------------------------------------------
# End Game
## Once everyone has completed survey
    observeEvent( GlobSurvey$SurveyReady, {
        if( all(GlobSurvey$SurveyReady) ) {
            stopApp()
        }
    })


})

