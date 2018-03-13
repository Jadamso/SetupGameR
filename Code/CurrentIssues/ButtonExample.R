    
    library(shiny)
    utf_pch <- sapply(c(9632, 9679, 9650), intToUtf8)
    utf_col <- c("blue", "red", "green")
    utf_list <- mapply( function(mycol, mypch) {
        span(style=paste0("color:",mycol,";"),mypch)
    }, utf_col, utf_pch, SIMPLIFY=FALSE, USE.NAMES=FALSE)
    
    ## ui.R
    ui <- fluidPage(
        shinyjs::useShinyjs(),
        radioButtons("GoodChoice", "Change Your Endowment To",
            choiceNames=utf_list,
            choiceValues=1:3)
    )

    ## server.R
    server <- function( input, output, session){

    }

    ### Run Application
    shinyApp(ui, server)

