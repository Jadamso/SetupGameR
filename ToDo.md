# To Do
The following 3 tasks

Use `./Code/CurrentIssues/Module_Survey_ExampleUsage.R` as a minimum working example for debugging


## Task 1
---
Improve ease of debugging

#### Task 1A
Declare user from url inside server.R and access outside of `observe`

See https://stackoverflow.com/questions/49212027/how-to-declare-unique-users-in-rshiny 


In Web-Browser: http://127.0.0.1:3329?user=JA1


In server.R

    user <- parseQueryString(session$clientData$url_search)[['user']]

    ## Outside of any function  ->
    cat( file=stderr(), "User: ", user, "\n")


#### Task 1B
Allow initialize button in `SetupGameR::InitializeUI("init")` to execute by either hitting "Enter" on the keyboard or by clicking the button
 
    $(document).keyup(function(event) {
        if ($("#number").is(":focus") && (event.keyCode == 13)) {
            $("#goButton").click();
        }
    });





    
## Task 2
---
Improve App Initialization

#### Task 2A
Optimize init modules

    SetupGameR::InitializeUI("init")
    SetupGameR::InitializeUI2("init")
    
I currently have a latency spike at this points in the code

#### Task 2B

Create module so that `SetupGameR::StartGame` performs

    observeEvent( GlobClass$Init,
        ignoreInit=TRUE, {
        
        removeUI(selector='#init', immediate=TRUE)
        if( all(GlobClass$Init) ){        
            shinyjs::show('game_sidepanel')
            shinyjs::show('game_mainpanel')
        }
        
    }, autoDestroy=TRUE)



#### Task 2C

Put all 2 start-of-game modules together into a module so that `SetupGameR::InitGame` performs 

    SetupGameR::Initialize
    SetupGameR::StartGame









## Task 3
---

Improve Post-Game Survey

#### Task 3A

Optimize current modules

    callModule( SetupGameR::StartSurvey, "survey", ...
    
    callModule( SetupGameR::ViewPayment, "payment", ...


I currently have a latency spike at these points in the code
    
#### Task 3B

Modularize Switch Panels so that `SetupGameR::StopGame` performs

    observeEvent(GlobalTriggers$ShowSurvey,
        ignoreNULL=TRUE, ignoreInit=TRUE,{
     
        if(GlobalTriggers$ShowSurvey ){
            
            ## Hide the Game
            shinyjs::hide('game_mainpanel')
            shinyjs::hide('game_sidepanel')            

            ## Show the Survery
            shinyjs::show('survey_mainpanel')
            shinyjs::show('survey_sidepanel')
        }
    })


#### Task 3C

Put all 3 end-of-game modules together into a module so that `SetupGameR::PostGameSurvey` performs 

    SetupGameR::StopGame
    SetupGameR::StartSurvey
    SetupGameR::ViewPayment






## Task 4: (Low Priority)
---

General Usage

#### Task 4AA

Make PasswordSetup.sh usable for any experiment

 * Make New SetupGameR::passwd_maker0
  - takes ADMIN=TRUE/FALSE as argument

        
#### Task 4A

Assign a button so that students can click and reload page if frozen.

    session$reload()

    
#### Task 4B
Real-time assignment of number of players in a game based on computer ID

<!--
#### Task 4B
The login procedure user *Shiny-Server-Pro* not *Shiny Server*. 
Write a work-around for *Shiny-Server* on local version.
-->

#### Task 4C

Best way to collect user data all at once.


#### Task 4D

Mathjax can be used as a gate into the web. * Mathjax -> about -> mathjax about page -> any webpage *

