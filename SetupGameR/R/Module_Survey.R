#-------------------------------------------------------------------
##################
#' Enter Survey Information
##################
#'
#' @param ...
#'
#' @return 
# @examples
#' @export


StartSurveyUI <- compiler::cmpfun( function(id) {

    # Create a namespace function using the provided id
    ns <- NS(id)

    #---------------------------------------------------
    # Survey Panels
    tagList(
        shinyjs::hidden( div( id="survey_sidepanel",
        h2("Post Game Survey"),
        fluidRow(
            column(12, textInput(ns("Name"), "Name", value=NA) ),
            column(12, selectInput(ns("Gender"), "Gender",
                choices=c("Male", "Female", NA) ), selected=NA ),
            column(12, textAreaInput(ns("Comments"),
                "Please Describe How You Made Decisions", value=NA) )
        ),
        actionButton(ns("surveyenter"),
            h4("Submit"),
            width="100%" )
        ))
    )
})
            

#' @rdname StartSurveyUI
#' @export    
StartSurvey <- compiler::cmpfun( function(input, output, session,
    GlobSurvey, SaveSurveyFile=getwd(), userPID ) {

    #---------------------------------------------------
    # Survey Server
    #source('server_survey.R', local=TRUE)

    observeEvent( input$surveyenter, {
        
        ## Enter Results
        GlobSurvey$SurveyReady[userPID] <- TRUE
        GlobSurvey$Names[userPID] <- input$Name
        GlobSurvey$Gender[userPID] <- input$Gender
        GlobSurvey$Comments[userPID] <- input$Comments
       
        ## Show Payoffs
        showNotification(
            h1("Game Over"),
            duration=Inf, closeButton=FALSE,
            type="error")
        showNotification(
            "Please Wait Quietly",
            duration=Inf, closeButton=FALSE,
            type="default")
            
        shinyjs::hide('surveyenter')
        shinyjs::disable('surveyenter')
        shinyjs::disable('Name')
        shinyjs::disable('Gender')
        shinyjs::disable('Comments')   
                    
    })#


    observeEvent( GlobSurvey$SurveyReady, {
        if( all(GlobSurvey$SurveyReady) ){
        
            if(userPID==1) {
                SURVEY <<- list(
                    Names=GlobSurvey$Names,
                    Earnings=GlobSurvey$Earnings,
                    Gender=GlobSurvey$Gender,
                    Payments=GlobSurvey$Payments,
                    Comments=GlobSurvey$Comments,
                    RandomHistory=GlobSurvey$RandomHistory)
                    
                #SetupGameR::post_global(SURVEY)
                    
                saveRDS(SURVEY, file=SaveSurveyFile)
                
            }
        }
    })
    
  
})




#-------------------------------------------------------------------
##################
#' View Payment Information
##################
#'
#' @param ...
#'
#' @return 
# @examples
#' @export

ViewPaymentUI <- compiler::cmpfun( function(id) {
    ns <- NS(id)
    
    shinyjs::hidden( div( id="survey_mainpanel",
        uiOutput(ns("Payment"))
    ))
})


#' @export
#' @rdname ViewPaymentUI
ViewPayment <- compiler::cmpfun( function(input, output, session,
    GlobSurvey, userPID ) {

    output$Payment <- renderUI({
        fluidRow(
            column(12, h4( paste0("User ID: JA", userPID) )),
            column(12, h2( paste0("Earnings: $", GlobSurvey$Payments[userPID])),
                h4(" (including showup fee)" ) ),
            column(12, h4( paste0("Random History: ", GlobSurvey$RandomHistory)))
        )
    })

})


