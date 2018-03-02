#------------------------------------------------------------------
##################
#' Url Information About User
################## 
#' @param user_data data from user
#' @return string
# @examples
#' @export

user_urldata_fun <- compiler::cmpfun( function(user_data){
        paste(sep = "",
            "protocol: ", user_data$url_protocol, "\n",
            "hostname: ", user_data$url_hostname, "\n",
            "pathname: ", user_data$url_pathname, "\n",
            "port: ",     user_data$url_port,     "\n",
            "search: ",   user_data$url_search,   "\n",
            "hash: ",     user_data$url_hash,     "\n"
            #"hash: ", user_data$url_hash_initial, "\n"
        )
})



#check_pass <- function(input){
#    req(input$go)
#    isolate(input$password)
#    pass_correct <- input$password==PASS
#    if(pass_correct){
#    } else {
#        stopApp(0)
#    }
#}
#check_pass <- cmpfun(check_pass)

