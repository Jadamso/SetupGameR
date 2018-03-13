#! /bin/bash
###################################################################
# Jordan Adamson 
###################################################################
shopt -s expand_aliases
source $HOME"/.bashrc"
#---------------------------------------------------------
###################
# Input Password Parameters
###################

## Default Create Players
PassWordFlag="FALSE"
PASSWD="MakeBelieve"

## Default Players
PlayerFlag="TRUE"
N=6
   
host=""
#BLOG=/dev/null
 
## Override Default Parameters
while getopts 'G:N:pwP:' opt
do
    case "${opt}" in
        ## Paths for All Files
        G) GPath="${OPTARG}";;
        ## Number of Participants
        N) N="${OPTARG}";;
        ## Passwords
        p) PlayerFlag="TRUE";;
        w) PassWordFlag="TRUE";;
        P) PASSWD=${OPTARG};;
        ## GPath defines Locations for logging
        ## B) BLOG="${OPTARG}";;
        ## S) ServerLogDir="${OPTARG}";;
    esac
done



## GPath defines
    ## ServerLogDir
    ## BLOG
    
source $GPath



#---------------------------------------------------------
##################
# Setup PassWords
################## 

if [[ $PassWordFlag == "TRUE" ]] 
then 

    R_in="$ServerLogDir/PassWord_$DATE.R"
    R_out="$ServerLogDir/PassWord_$DATE.Rout"
    
    echo "
        SetupGameR::passwd_maker0( $N, passwd=\"$PASSWD\", sys=TRUE)
        " &>> $R_in
    
    R CMD BATCH --quiet --no-save $R_in $R_out

fi

#---------------------------------------------------------
###################
# Setup Tasks Performed
###################

echo -e "##-- PassWordFlag: $PassWordFlag" | tee -a $BLOG
echo -e "##-- PlayerFlag: $PlayerFlag" | tee -a $BLOG

cat $ServerLogDir/*$DATE*.Rout &>> $BLOG
rm $ServerLogDir/*$DATE*.Rout $ServerLogDir/*$DATE*.R

echo -e "$BLOG"

