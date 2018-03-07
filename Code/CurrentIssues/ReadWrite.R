    library(shiny)
        
    UserList <- list(NewE=c(NA,NA)) 

    GlobalTriggers <- reactiveValues(
        Submit=c(FALSE,FALSE),
        Show=c(FALSE,FALSE) )

    ## Server Input
    server <- function( input, output, session){

        user <- sample( 1:2,1)
        cat( file=stderr(), "User: ", user, "\n")
        
        ## 
        o0 <- observeEvent( input$init,{
            GlobalTriggers$Submit[[user]] <<- TRUE
            cat( file=stderr(), "Click \n")
        })
        
        ## Write Data
        o1 <- observeEvent( GlobalTriggers$Submit,{
            if( all(GlobalTriggers$Submit) ){
                newInput <- isolate( input[["e1"]] )
                UserList$NewE[[user]] <<- newInput
                cat( file=stderr(), "Write \n")
                if(user==1){
                    GlobalTriggers$Show <<- c(TRUE,TRUE)
                }
            }
        })

        ## Read Data
        o2 <- observeEvent( GlobalTriggers$Show, {
            if( GlobalTriggers$Show ){
                showModal( modalDialog( h4(UserList$NewE[[user]]) ) )
                cat( file=stderr(), "Show \n")
            }
        })

    }
    
    ## Server Input
    server_alt <- function( input, output, session){

        user <- sample( 1:2,1)
        cat( file=stderr(), "User: ", user, "\n")
        
        ## 
        o0 <- observeEvent( input$init,{
            GlobalTriggers$Submit[[user]] <<- TRUE
            cat( file=stderr(), "Click \n")
        })
        
        ## Write Data
        o1 <- observeEvent( GlobalTriggers$Submit,{
            if( all(GlobalTriggers$Submit) ){
                newInput <- isolate( input[["e1"]] )
                UserList$NewE[[user]] <<- newInput
                cat( file=stderr(), "Write \n")
                GlobalTriggers$Show[[user]] <<- TRUE
            }
        })

        ## Read Data
        o2 <- observeEvent( GlobalTriggers$Show, {
            if( GlobalTriggers$Show[[user]] ){
                showModal( modalDialog( h4(UserList$NewE[[user]]) ) )
                cat( file=stderr(), "Show \n")
            }
        })

    }


    ### User Input
    ui <- fluidPage(
        sliderInput( "e1", label=NULL, min=0, max=100, value=0),
        actionButton( "init", h4("Initialize") )
        )



    ### Run Application
    shinyApp(ui, server)

