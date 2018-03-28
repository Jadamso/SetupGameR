#options(shiny.reactlog=TRUE) 
#options(shiny.trace = TRUE)
#options(shiny.fullstacktrace = TRUE)
#options(shiny.error = browser)

#---------------------------------------------------
##################
# Define UI
##################

shinyUI(fluidPage(

    shinyjs::useShinyjs(),
    
    ## Make Lines Black
    tags$head(tags$style(HTML("hr {border-top: 1px solid #000000;}"))),
    
    ## Hide the ``logout'' popup
    tags$head(tags$style(HTML('.shiny-server-account { display: none; }'))),
    ## Hide the ``reload'' option on ``Server Disconnect''
    tags$head(tags$style("#ss-reload-link {display:none !important;}")),
    
    #---------------------------------------------------
    # Side Panel
    sidebarLayout(
                
        sidebarPanel(
        
            #---------------------------------------------------
            # Post Game Survey Panels
            SetupGameR::StartSurveyUI("survey")           
            
            ),

    #---------------------------------------------------
    # Main Panel
    mainPanel(


        #---------------------------------------------------
        # Post Game Survey Panels
        SetupGameR::ViewPaymentUI("payment")
                
    )
  )
))

