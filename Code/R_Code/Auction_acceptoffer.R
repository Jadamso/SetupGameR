#------------------------------------------------------------------
##################
#' Update Active Proposals
################## 
#' @param trans_id id of transaction 
#' @return Nothing
# @examples 
#' @export

update_proposals_active <- compiler::cmpfun( function(trans_id){

    if ( exists("ActiveProposals") ) {
        ap_i <- ActiveProposals$TransactionID==trans_id

        if( any(ap_i) ) {
            ActiveProposals <<- ActiveProposals[!ap_i,]
            Message <<- c("Transaction Processed","default")
        } else {
            Message <<- c("Transaction Not Available","error")
        }
    } else {
        Message <<- c("None Yet", "error")
    }
    #message(Message[1])
})


#------------------------------------------------------------------
##################
#' Update Blockchain
################## 
#' @param buyer_id,seller_id ids of buyers and sellers
#' @param unittype what type of unit "i.e. Q1"
#' @param price price
#' @param trans_id id of transaction 
#' @return Nothing
# @examples
#' @export

blockchain <- compiler::cmpfun( function(
    buyer_id, seller_id,
    unittype, price,
    trans_id) {

    dat <- data.frame(
        "Price"=price,
        "UnitType"=unittype,
        "Buyer"=buyer_id,
        "Seller"=seller_id,
        "TransactionID"=trans_id,
        "SysTime"=as.character(Sys.time()))

    if (exists("BlockChain", envir=.GlobalEnv)) {
        assign("BlockChain", rbind(dat, BlockChain), envir=.GlobalEnv)
    } else {
        assign("BlockChain", dat, envir=.GlobalEnv)
    }
})

#------------------------------------------------------------------
##################
#' Accept an Offer
################## 
#' @param trans_id id of transaction
#' @param player_id id of player
#' @return exchange_list
# @examples
#' @export


accept_offer <- compiler::cmpfun( function( trans_id, player_id){

    # c("Unit", "Price", "Action", "TransactionID", "PlayerID")
    apid <- which(ActiveProposals[["TransactionID"]] == trans_id)

    if( length(apid)==0 ) {
        message("Not Available")
        exchange_list <- list(trans_id=NA)
    } else {

        ## Get Active Proposal
        aProposal <- get("ActiveProposals", envir=.GlobalEnv)[apid,]
         
        ## Who was Buying/Selling
        offer_player_id     <- aProposal$PlayerID
        offer_player_action <- aProposal$Action

        if (offer_player_action == "Buy") {
            buyer_id  <- aProposal$PlayerID
            seller_id <- player_id
        } else if ( offer_player_action=="Sell" ) {
            buyer_id  <- player_id
            seller_id <- aProposal$PlayerID
        } 
        
        unittype <- aProposal$Unit
        price <- aProposal$Price

        ## Pass to Exchange Functions
        exchange_list <- list(
            buyer_id=buyer_id,
            seller_id=seller_id,
            unittype=unittype,
            price=price,
            trans_id=trans_id)

    }

    return(exchange_list)
})
