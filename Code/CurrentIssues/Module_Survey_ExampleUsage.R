
## ui.R

shinyUI(fluidPage(
    sidebarLayout(                
        sidebarPanel(
            #---------------------------------------------------
            ## Initial Waiting Screen
            SetupGameR::InitializeUI("init"),
            ## Main Code
            shinyjs::hidden( div( id="game_sidepanel",
                ## BUNCH OF CODE HERE ))
            ## Post Game Survey Panels
            SetupGameR::StartSurveyUI("survey")
        )
        mainPanel(
            #---------------------------------------------------
            ## Main Panel
            shinyjs::hidden( div( id="game_mainpanel",
                ## BUNCH OF CODE HERE ))
            # Post Game Survey Panels
            SetupGameR::ViewPaymentUI("payment")
        )
        




## server.R

GlobSurvey <- reactiveValues(
    SurveyReady=Class$Ready,
    Gender=Class$Ready*NA,
    Comments=Class$Ready*NA,
    Earnings=Class$Ready*NA,
    Payments=Class$Ready*NA, 
    RandomHistory=NA)

    
shinyServer( function( input, output, session){

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
            "SessionResults/Session_",SessionName,"/Survey.Rds")
    )
    
    #---------------------------------------------------
    # Show Student Payouts
    callModule( SetupGameR::ViewPayment, "payment",
        GlobSurvey=GlobSurvey,
        userPID=userPID
    )
    
    
    
