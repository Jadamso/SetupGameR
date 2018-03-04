# SetupGameR
Function and Libraries for Shiny Experiments

## To install latest release from Github: 

    devtools::install_github("Jadamso/SetupGameR",subdir="SetupGameR")
    citation("SetupGameR")

## Pre-reqs

    devtools::install_github("Jadamso/MiscUtils",subdir="MiscUtils")
    devtools::install_github("Jadamso/GeoCleanR",subdir="GeoCleanR")






# Linux Setup On Amazon instance: 
---

## First Time Amazon setup
    
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

