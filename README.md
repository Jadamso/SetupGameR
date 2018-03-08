# SetupGameR
Function and Libraries for Shiny Experiments

## To install latest release from Github: 

    devtools::install_github("Jadamso/SetupGameR",subdir="SetupGameR")
    citation("SetupGameR")

## Pre-reqs

    devtools::install_github("Jadamso/MiscUtils",subdir="MiscUtils")
    devtools::install_github("Jadamso/GeoCleanR",subdir="GeoCleanR")






# Host Game on Amazon Web Server: 
---

## First Time Amazon setup
    
Follow the instructions at https://github.com/Jadamso/ClusterInstall/blob/master/README_AWS.md

    git clone https://github.com/Jadamso/ClusterInstall.git
    cat ClusterInstall/README_AWS.md

<!---
** Other big-memory alternatives on EC2 are
    r4.large (15gb, 10cents/hr)
    r4.xlarge (30gb, 25cents/hr)
    r4.2xlarge (60gb, 50cents/hr)
-->

## First Time Shiny-Server Setup

After SSH-ing into Amazon Instance and becoming the dedicated shiny-user (`su - shiny`)

    wget https://s3.amazonaws.com/rstudio-shiny-server-pro-build/centos6.3/x86_64/shiny-server-commercial-1.5.4.872-rh6-x86_64.rpm 

    sudo yum install --nogpgcheck shiny-server-commercial-1.5.4.872-rh6-x86_64.rpm

    sudo /opt/shiny-server/bin/license-manager activate XXXX-XXXX-XXXX-XXXX-XXXX-XXXX-XXXX


For a full game setup, see
 * https://github.com/Jadamso/TerritoryR/blob/master/README_amazon_setup.md
 

<!--CHECK LATENCY: <.5 is good; >1 is bad
 for x in 'seq 60'; do curl -Ik -w "HTTPcode=%{http_code} TotalTile=%{time_total}\n" http://www.example.com/ -so /dev/null; done
-->


<!-- GIT FORCE PULL
 git fetch --all
 git reset --hard origin/master
 git pull origin master
-->
