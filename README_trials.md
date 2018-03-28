# Survey Trial And Debugging

## RunApp

    profvis::profvis(
        shiny::runApp("~/Desktop/Packages/SetupGameR/Server/Survey_Trial" )
    )



## On Server

    <!-- ## Delete Old Games -->
    find "/srv/shiny-server/HOSTDIR/" -type l -delete
    <!-- ## Link New Games -->
    ln -sf ~/"Desktop/Packages/SetupGameR/Server/Survey/" \
        "/srv/shiny-server/HOSTDIR/GAMEDIR"



    
<!--

~/Desktop/Packages/TerritoryR/GameStart.sh -G $TREATMENT -N $NPLAYER -P $NPERIODS -A $SESSION -f 10

Control All screens with the owl: select-all, control, remote-control

-->
