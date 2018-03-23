
    library(magrittr)    
    library(shiny)

    ## ui.R
    ui <- fluidPage(
        shinyjs::useShinyjs(),
        column(12,
            plotOutput("Locations", width=500, height=500,
                click="plot_click") )
    )


    ## server.R
    server <- function( input, output, session){


        ## Source Locations (Home Base)
        source_coords <- reactiveValues(xy=c(x=1, y=2) )
        dest_coords <- reactiveValues(xy=c(x=1,y=3))
            
        ## Dest Coords
        observeEvent( source_coords$xy,{ 
            dest_coords$xy <- source_coords$xy
        })
        
        observeEvent(input$plot_click, {
            dest_coords$xy <- floor(c(input$plot_click$x, input$plot_click$y))
        })


        
        ## Calculate Manhattan Distance from Source to Destination
        DistCost <- reactive({
            list( Lost=sum( abs( dest_coords$xy - source_coords$xy ) ) )
        })

        
        ## RenderPlot 
        output$Locations <- renderPlot({ 
            
            par(bg=NA)
            plot.new()
            plot.window(
                xlim=c(0,10), ylim=c(0,10),
                yaxs="i", xaxs="i")
            axis(1)
            axis(2)
            grid(10,10, col="black")
            box()

            ## Source
            points( source_coords$xy[1]+.5, source_coords$xy[2]+.5,
                cex=3, pch=intToUtf8(8962)) 
            
            ## Destination
            text(dest_coords$xy[1]+.5, dest_coords$xy[2] +.5,
                paste0("Distance=", DistCost()$Lost ))
        })        
    }

    
    

    ### Run Application
    shinyApp(ui, server)

