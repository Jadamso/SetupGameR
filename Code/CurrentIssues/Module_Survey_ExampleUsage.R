library(shiny)

## ui.R

ui <- fluidPage(
    shinyjs::useShinyjs(),
    sidebarLayout(              
        sidebarPanel(
            #---------------------------------------------------
            ## Initial Waiting Screen
            SetupGameR::InitializeUI("init"),
            ## Main Code
            shinyjs::hidden( div( id="game_sidepanel",
                        fluidRow( "A BUNCH OF INPUTS") ) ),
                ## BUNCH OF CODE HERE ))
            ## Post Game Survey Panels
            SetupGameR::StartSurveyUI("survey")
        ),
        mainPanel(
            #---------------------------------------------------
            ## Main Panel
            shinyjs::hidden( div( id="game_mainpanel",
                        fluidRow( "A BUNCH OF OUTPUTS") ) ),
                ## BUNCH OF CODE HERE ))
            # Post Game Survey Panels
            SetupGameR::ViewPaymentUI("payment")
        )
    )       
)



## server.R

Class <- list(Ready=c(FALSE,FALSE))

PIDs <- paste0("JA", 1:2)

GlobClass <- reactiveValues(Init=Class$Ready)

GlobSurvey <- reactiveValues(
    SurveyReady=Class$Ready,
    Gender=Class$Ready*NA,
    Comments=Class$Ready*NA,
    Earnings=Class$Ready*NA,
    Payments=Class$Ready*NA, 
    RandomHistory=NA)

    
GlobalTriggers <- reactiveValues( ShowSurvey=FALSE)

server <- function( input, output, session){

    #---------------------------------------------------
    # User Login
    ## For Debugging
    user <- sample( paste0("JA", 1:2),1)
    ## Would Like to Use
    #user <- parseQueryString(session$clientData$url_search)[['user']]()
    cat( file=stderr(), "User: ", user, "\n")
    userPID  <- which( PIDs == user )
    
    #---------------------------------------------------
    # Initialize Screen
    callModule( SetupGameR::Initialize, "init",
        GlobClass, userPID )
             
    observeEvent( GlobClass$Init,
        ignoreInit=TRUE, {
        
        removeUI(selector='#init', immediate=TRUE)
        if( all(GlobClass$Init) ){        
            shinyjs::show('game_sidepanel')
            shinyjs::show('game_mainpanel')
        }
        
    }, autoDestroy=TRUE)

    #---------------------------------------------------
    # Main Body of CODE
    ## BUNCH OF CODE HERE
    
    ## Start Survey after 10 seconds
    m_2 <- observe({ invalidateLater(10000)
        if( (userPID==1) &  all(GlobClass$Init) ){
            GlobalTriggers$ShowSurvey <<- TRUE
        }
    })
    
    #---------------------------------------------------
    # Begin Survey
    s_2 <- observeEvent(GlobalTriggers$ShowSurvey,
        ignoreNULL=TRUE, ignoreInit=TRUE,{
     
        if(GlobalTriggers$ShowSurvey ){
            
            ## Hide the Game
            shinyjs::hide('game_mainpanel')
            shinyjs::hide('game_sidepanel')            

            ## Show the Survery
            shinyjs::show('survey_mainpanel')
            shinyjs::show('survey_sidepanel')
        }
    })        


    callModule( SetupGameR::StartSurvey, "survey",
        GlobSurvey=GlobSurvey,
        userPID=userPID,
        SaveSurveyFile=paste0(
            path.expand("~/Desktop/Packages/TerritoryR/Results/"),
            "SessionResults/Session_Trial/Survey.Rds")
    )
    
    #---------------------------------------------------
    # Show Student Payouts
    callModule( SetupGameR::ViewPayment, "payment",
        GlobSurvey=GlobSurvey,
        userPID=userPID
    )
}






### Run Application
shinyApp(ui, server)

    
