#-------------------------------------------------------------------
##################
# Libraries
##################

## Imported Packages: (.packages())
rfiles <- c("MiscUtils")
for( i in rfiles) { devtools::use_package( i, pkg=packg) }

sfiles <- c("shinyjs", "formattable")
for( i in sfiles) { devtools::use_package( i, "Suggests", pkg=packg) }


#-------------------------------------------------------------------
##################
# Add Codes
################## 

# Which Codes
rfile <- c(
    "Game_periodtiming.R",
    "Game_printfuns.R",
    "Game_userURLdata.R",
    "Game_payouts.R",
    #"Game_proposeoffer.R",
    #"Game_acceptoffer.R",
    #"Game_exchange.R",
    "Module_Initialize.R",
    "Module_Survey.R",
    #"Player_marketmaker.R",
    #"Player_profilefunctions.R",
    #"Player_profilefunctions2.R",
    #"Server_utilityfunctions.R"
    "Server_groupmaker.R",
    "Server_createclass.R",
    "Server_passwd.R",
    "Server_playermaker.R",
    "Server_expdesign.R",
    "Server_startgame.R",
    "Server_stopgame.R")

rfiles <- paste0(pdir,"Code/R_Code/",rfile)

# Move Code
file.copy(rfiles, rdir, overwrite=T )
devtools::load_all( rdir )

# Create Code Documentation
devtools::document( pkg=packg)


