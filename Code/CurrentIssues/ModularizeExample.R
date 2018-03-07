
    ## Pass URL parameters to shiny (not yet available for shiny-server-pro)
    ## https://github.com/daattali/advanced-shiny/tree/master/url-inputs
    
    library(shiny)

    ### Modularized Code
    #' UserSide Function to Create Button
    InitializeUI <- compiler::cmpfun( function(id) {
        ns <- NS(id)    
        actionButton( ns("init"), h4("Initialize") )
    })         
    #' ServerSide Function to Update reactive Vector and Delete Button
    Initialize <- compiler::cmpfun( function(input, output, session,
        GlobClass, userPID ) {

        observeEvent( input$init, {
            cat("click\n")
            shinyjs::hide("init")
            #removeUI(selector='#init', immediate=TRUE)
            GlobClass$Init[userPID] <- TRUE
        }, autoDestroy=TRUE)
    })

    ### User.R
    ui <- fluidPage( InitializeUI("init") )

    ### Server.R
    GlobClass <- reactiveValues(Init=c(FALSE, FALSE))

    server <- function(input,output) {
        userPID <-  sample( 1:2,1)
        cat(userPID, "\n")
        callModule( Initialize, "init", GlobClass, userPID )        
    }

    ### Run Application
    shinyApp(ui, server)

