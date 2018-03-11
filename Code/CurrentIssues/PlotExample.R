    
    library(shiny)

    ## ui.R
    ui <- fluidPage(
        shinyjs::useShinyjs(),
        column(12,
        plotOutput("Locations", width=500, height=500,
            click="plot_click"), inline=TRUE ),
        actionButton("stop", "Stop")
    )


    ## server.R
    server <- function( input, output, session){

        x <- reactiveValues(x=runif(10))
        y <- reactiveValues(y=rnorm(10))
        
        ## Click To Generate New Random Points
        observeEvent(input$plot_click, {
            x$x <- runif(10)
            y$y <- rnorm(10)
        })

        ## Disable Clicking
        observeEvent(input$stop, {
            shinyjs::disable("plot_click")
        })
        
        ## RenderPlot 
        output$Locations <- renderPlot({ 
            
            ## Constant
            par(bg=NA)

            plot.new()
            plot.window(
                xlim=c(0,1), ylim=c(0,1),
                yaxs="i", xaxs="i")
            axis(1)
            axis(2)
            grid(10,10, col="black")
            box()

            ## Updating
            points( x$x, y$y, cex=3, pch=16)
            
        })        
    }

    ### Run Application
    shinyApp(ui, server)

