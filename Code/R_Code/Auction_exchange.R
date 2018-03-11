#########################
# Exchange Functions
#########################

#------------------------------------------------------------------
##################
#' Format current_trade
################## 
#' @param unittype what type of unit "i.e. Q1"
#' @param cur_unit how many have previously been used
#' @param price price
#' @param trans_id id of transaction 
#' @return formatted data.frame
# @examples
#' @export

current_trade <- compiler::cmpfun( function(
    unittype, cur_unit, price, trans_id){
    cur_trade <- data.frame(
        "UnitType"=unittype,
        "Unit"=cur_unit,
        "Price"=price,
        "TransactionID"=trans_id,
        "Time"=Sys.time() )
    return(cur_trade)
})

#------------------------------------------------------------------
##################
#' Update My Inventory
################## 
#' @param person_i a person object
#' @param unittype what type of unit "i.e. Q1"
#' @param price price
#' @param trans_id id of transaction 
#' @return update person_i
# @examples
#' @export

update_trade_sheet <- compiler::cmpfun( function(
    person_i, unittype, price, trans_id){

    ## Which Person
    #person_i <- participants[[ which( PIDs == person_id ) ]]
    #cat(file=stderr(),"   Which Person:", names(person_i$spreadsheet))

    ## Which Unit
    remains <- person_i$spreadsheet[[unittype]]$Remaining

    ## Update
    if( any(remains) ){

        cur <- which( remains )[1]
        cat(file=stderr(), "    Unit:", cur)

        ## Current Record
        cur_unit   <- person_i$spreadsheet[[unittype]][cur,"Quantity"]
        cur_record <- current_trade(unittype,
            cur_unit, price, trans_id)
        #cat(file=stderr(), "    Which Record")

        ## Update Record
        if(class(person_i$record)=="logical"){
            ## If No records, then create one
            person_i$record <- cur_record
        } else {
            person_i$record <- rbind(cur_record, person_i$record)
        }
        #cat(file=stderr(), "    Update Record")

        ## Update Inventory
        person_i$spreadsheet[[unittype]]$Remaining[cur] <- FALSE
        #cat(file=stderr(), "    Update Inventory")

    } else {
        person_i$record <- "FULL"
    }

    return(person_i)
})

#------------------------------------------------------------------
##################
# CHUNK 
##################
#update_proposals_accept <- function(trans_id){
#
#    if ( exists("ActiveProposals") ) {
#       ap_i <- ActiveProposals$TransactionID==trans_id
#
#       if( any(ap_i) ) {
#            ActiveProposals <<- ActiveProposals[!ap_i,]
#            Message <<- c("Transaction Processed","default")
#        } else {
#            Message <<- c("Transaction Not Available","error")
#        }
#    } else {
#        Message <<- c("None Yet", "error")
#    }
#    #message(Message[1])
#}
#update_proposals_accept <- cmpfun(update_proposals_accept)

#------------------------------------------------------------------
##################
# CHUNK D
##################
#

#trade_update <- function( person, unittype, price, trans_id, pids) {
#    new_person  <- update_trade_sheet(person, unittype, price, trans_id)
#    new_userPID <- which( pids == new_person$ID ) 
#    Participants[[ new_userPID ]] <<- new_person
#    cat(new_userPID)
#    #assign("Participants", Participants, envir=.GlobalEnv)
#}
#trade_update <- cmpfun(trade_update)


#------------------------------------------------------------------
##################
# CHUNK 
##################

#exchange <- function(
#    buyer_id, seller_id,
#    unittype, price,
#    trans_id){
#
#    ## Create Updated Player Profiles
#    trade_update(buyer, unittype, price, trans_id)
#    trade_update(seller, unittype, price, trans_id)
#}
#exchange <- cmpfun(exchange)


