#-------------------------------------------------------------------
##################
# Setup 
##################
library(devtools)
library(roxygen2)
library(MiscUtils)

 
pmdir <- path.expand("~/Desktop/Packages/")

#-------------------------------------------------------------------
##################
# Make 
##################
pack  <- "SetupGameR"
pdir  <- paste0(pmdir, pack,"/")
packg <- paste0(pdir, pack)

Version <- numeric_version("0.1.2")

# Setup R Package
source(paste0(pdir,"Code/PackageSetup.R") )

# Create R Package Contents
source(paste0(pdir,"Code/CodeSetup.R") )

MiscUtils::pack_up(pdir)

#-------------------------------------------------------------------
##################
# Install 
##################
devtools::install(packg) ## Locally Works

devtools::install_github( paste0("Jadamso/",pack), subdir=pack)

citation(pack)

print("Done")

## source("~/Desktop/Packages/SetupGameR/Code/TerritoryR.R")

## R CMD BATCH --no-save Code/Make.R && rm Make.Rout


