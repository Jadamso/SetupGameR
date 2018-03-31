# To Do
The first 3 tasks can use `./Code/CurrentIssues/Module_Survey_ExampleUsage.R` as a minimum working example for debugging


## Task 1
---
Improve ease of debugging

#### Task 1A
Declare user from url inside server.R and access outside of `observe`

See https://stackoverflow.com/questions/49212027/how-to-declare-unique-users-in-rshiny 


In Web-Browser: http://127.0.0.1:3329?username=JA1


In server.R

```r

    user <- parseQueryString(session$clientData$url_search)[['username']]

    ## Outside of any function  ->
    cat( file=stderr(), "User: ", user, "\n")

```


In shiny-server-pro, one can just use `user <- session$user`

#### Task 1B
Allow initialize button in `SetupGameR::InitializeUI("init")` to execute by either hitting "Enter" on the keyboard or by clicking the button

```r
 
    $(document).keyup(function(event) {
        if ($("#number").is(":focus") && (event.keyCode == 13)) {
            $("#goButton").click();
        }
    });

```


See `commandunput` from https://github.com/rstudio/shiny-incubator
    
## Task 2
---
Improve App Initialization

#### Task 2A
Optimize init modules

```

    SetupGameR::InitializeUI("init")
    SetupGameR::InitializeUI2("init")

```
 
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

```r

    SetupGameR::Initialize
    SetupGameR::StartGame

```







## Task 3
---

Improve Post-Game Survey

#### Task 3A

Optimize current modules

```r

    callModule( SetupGameR::StartSurvey, "survey", ...
    
    callModule( SetupGameR::ViewPayment, "payment", ...

```

I currently have a latency spike at these points in the code
    
#### Task 3B

Modularize Switch Panels so that `SetupGameR::StopGame` performs

```r

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

```

#### Task 3C

Put all 3 end-of-game modules together into a module so that `SetupGameR::PostGameSurvey` performs 

    SetupGameR::StopGame
    SetupGameR::StartSurvey
    SetupGameR::ViewPayment


#### Task 3D

Analyze benefits/costs of using `shiny::switch`
instead of `shinyjs::hide + shinyjs::show`
to switch from Inititial Page to Game Page to Survey Page. 




## Task 4: 
---

General Usage

#### Task 4AA 

Make Survey a Standalone Application (hosted on emergency shutdown) read in data files that display earnings to students.


#### Task 4A

Safegaurds against faulty computers ruining the entire session.

A game will get stuck a computer fails. This is because there are observers that trigger updates after data are collected:

```r

observeEvent( recordEvent, 
    record some data 
    GlobClass$Ready[userPID] <<- TRUE ##>
)

if( all(GlobClass$Ready) ) {
    proceed to next step
}

```
But GlobClass will never have all elements ready if a computer is logged out


## Task 4B

Safegaurds against duplicate log ins.

Currently, can log into two computers as the same user.
It does not currently cause problems to simply close the window and login as another user. 
But it would be desireable to prevent dual logins altogether. 

## Task 4C

Handle All SessionNames as strings
```r

SetupGameR::GameInit(
        SessionName=\"$SessionName\",
        
```

SessionName=001 converts to SessionName=1, which can create bugs
SessionName=as.character(001) converts to SessionName="1", which can create bugs


#### Task 4D 

Best way to collect user data all at once.

 * Currently, there are latency spikes at collection points during modal windows the demarcate periods.
 * The Solution: distribute users across cores, write and read data to common drive on commands by user1.
  - i.e. user1 triggers triggers update by writing `TRUE` to `Update.csv`, 
  - everyone reads `Update.csv`. If `TRUE`, showModal and write data and write `TRUE` to `Ready.csv`
  - user1 reading `Ready.csv`. If `all(TRUE)` perform calculations, record history, write `FALSE` to `Update.csv`
  - everyone removeModal and begins new period.
  - N.B. this means moving from Amazon Lightsail to EC2 or Beanstalk
  - N.B. use `reactivePoll` to read/write data like this
  
## Task 5: 
---

General Usage (Low Priority)

#### Task 5AA
implement client-side rendering

 * For Tables: https://rstudio.github.io/DT/
 * For RasterMaps: http://jkunst.com/highcharter/index.html

#### Task 5A 

Make `PasswordSetup.sh` usable for any experiment

 * Make `SetupGameR::passwd_maker0` takes ADMIN=TRUE/FALSE as argument


Make `SessionStop.sh` usable for any experiment
        
#### Task 5B

Assign a button so that students can click and reload page if frozen.

    session$reload()

    
#### Task 5C

Real-time assignment of number of players in a game based on computer ID

<!-- #### 
The login procedure user *Shiny-Server-Pro* not *Shiny Server*. 
Write a work-around for *Shiny-Server* on local version.
-->


#### Task 5D

Mathjax can be used as a gate into the web. * Mathjax -> about -> mathjax about page -> any webpage *


#### Task 5E
Temporary Timeout Game if lag is too high


#### Task 5F

Are there any local hosting options?

My setup is: AWS + shiny-server-pro

is local hosting a viable alternative: local PC + shiny-server ?


