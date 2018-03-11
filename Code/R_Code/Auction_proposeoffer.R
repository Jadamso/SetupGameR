#########################
# Offer Functions
#########################

#------------------------------------------------------------------
##################
#' Update Transactions
################## 
# @param 
# @return
# @examples
#' @export

update_transaction <-  compiler::cmpfun( function(){
    if ( exists("TransactionID") ) {
        TransactionID <<- TransactionID + as.integer(1)
    } else {
        TransactionID <<- as.integer(1)
    }
})

#------------------------------------------------------------------
##################
#' Update Active Proposals
################## 
#' @param proposal New Proposal
#' @return Nothing
# @examples
#' @export

update_proposals <-  compiler::cmpfun(function(proposal){
    if ( exists("ActiveProposals") ) {
        ActiveProposals <<- rbind(
            proposal,
            ActiveProposals)
    } else {
        ActiveProposals <<- proposal
    }
    Message <<- c("New Proposal Created", "default")
})


#------------------------------------------------------------------
##################
#' Make A Proposal
################## 
#' @param unitoffer what type of unit "i.e. Q1"
#' @param priceoffer what price "i.e. 2.04"
#' @param buysell Buying or Selling
#' @param trans_id id of transaction 
#' @param trans_id id of player
#' @return Nothing
# @examples
#' @export

propose_offer <- compiler::cmpfun( function(
    unitoffer,
    priceoffer,
    buysell,
    trans_id,
    player_id){

    proposal <- data.frame(
        "Unit"=unitoffer,
        "Price"=priceoffer,
        "Action"=buysell,
        "TransactionID"=trans_id,
        "PlayerID"=player_id)

    update_proposals(proposal)

})

