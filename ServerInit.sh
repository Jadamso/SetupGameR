## Shiny configuration files

## General File in $HOME/shiny-server/Shiny.conf 
# see ~/Setup/DesktopInstall/ShinySetup.sh for details

## New Global Configuration
#sudo cp $HOME/shiny-server/Shiny.conf \
#    /etc/shiny-server/shiny-server.conf

## Local Configuration in 
# ~/Desktop/Packages/DoubleAuction/Game/.shiny_app.conf


## Server Restart:  ~/Setup/DesktopInstall/ShinySetup.sh
    ## Restart From Scratch
sudo systemctl restart httpd
    ## Restart Shiny: require new login online
sudo systemctl daemon-reload
    ## Restart Shiny: require new login online
sudo systemctl stop shiny-server
sudo systemctl start shiny-server


## Game Start
#su - shiny
#sudo bash /srv/shiny-server/DoubleAuction/Server/DoubleAuction.sh


