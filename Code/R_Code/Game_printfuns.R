#------------------------------------------------------------------
##################
#' Prints Objects to Main Screen
################## 
#' @param session session from server.R
#' @return Nothing
# @examples
#' @export

print_exists <-  compiler::cmpfun( function( objname, fill=NA){
   if ( exists(objname) ) {
        fill
    } else {
        objname
    }
})


#' @rdname print_exists
#' @export
print_message <-  compiler::cmpfun( function(session){
   if ( exists("Message") ) {
        Message
    } else {
        ""
    }
})

#' @rdname print_exists
#' @export
print_proposals <-  compiler::cmpfun( function(){
    if ( exists("ActiveProposals") ) {
        ActiveProposals
    } else {
        data.frame(Proposals="None Yet")
    }
})

#' @rdname print_exists
#' @export
print_accepts <-  compiler::cmpfun( function(){
   if ( exists("BlockChain") ) {
        BlockChain
    } else {
        data.frame(Transactions="None Yet")
    }
})

#------------------------------------------------------------------
##################
#' HTML formatting finance style
################## 
# @examples
#' @seealso sign_formatter
#' @export
sign_formatter2 <- formattable::formatter("span", 
  style = x ~ style(color = ifelse(x > 0, "green", 
    ifelse(x < 0, "red", "blue"))))

#' @rdname sign_formatter2
#' @seealso sign_formatter2
#' @export
sign_formatter <- formattable::formatter("span",
    style = x ~ style(color = ifelse(x < 0, "red", "black")) )


