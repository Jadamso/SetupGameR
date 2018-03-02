#------------------------------------------------------------------
##################
# Initialize Button
##################
#'
#' @param ...
#'
#' @return 
# @examples
#' @export

InitializeUI <- compiler::cmpfun( function(id) {
    ns <- NS(id)
    
    actionButton( ns("init"),
        h4("Initialize"),
        width="100%" )
})
            

#' @export
#' @rdname InitializeUI
Initialize <- compiler::cmpfun( function(input, output, session,
    GlobClass, userPID ) {
        
    observeEvent( input$init, {
        shinyjs::hide("init")
        GlobClass$Init[userPID] <- TRUE
    }, autoDestroy=TRUE)

})



#' @export
#' @rdname InitializeUI
Initialize2 <- compiler::cmpfun( function(input, output, session,
    GlobClass ) {
    
    observeEvent(GlobClass$Init, {
            removeUI(selector='#init', immediate=TRUE)
        if( all(GlobClass$Init) ){
            shinyjs::show('game_sidepanel')
            shinyjs::show('game_mainpanel')
        }
    }, autoDestroy=TRUE)
})    
  

#------------------------------------------------------------------
##################
# Initialize Button
##################
# @export
# @rdname InitializeUI
InitializeUImm <- compiler::cmpfun( function(id) {   
    actionButton( "init",
        h4("Initialize"),
        width="100%" )
})
     
# @export
# @rdname InitializeUI
Initializemm <- compiler::cmpfun( function(input, output, session,
    GlobClass, userPID ) {
    
    observeEvent( input$init, {
        removeUI(selector='#init', immediate=TRUE)
        GlobClass$Init[userPID] <- TRUE
    }, autoDestroy=TRUE)
})


        
#------------------------------------------------------------------
##################
# Initialize Button
##################
#'
#' @param ... 
#'
#' @return 
# @examples
# @export

InitializeUIm <- compiler::cmpfun( function(id) {
    ns <- NS(id)
    
    shinyjs::hidden( div( id="init_mainpanel",
        actionButton( ns("init"),
            h4("Initialize"),
            width="100%" )
    ))
})


# @export
# @rdname InitializeUI2
Initializem <- compiler::cmpfun( function(input, output, session,
    GlobSurvey, userPID ) {

    observeEvent( input$init, {
        shinyjs::hide('init_mainpanel')
        shinyjs::hide('init')
        GlobClass$Init[userPID] <- TRUE
    })
    #removeUI("init")
})



