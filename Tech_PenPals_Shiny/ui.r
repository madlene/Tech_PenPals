# URL: https://pragyansmita.shinyapps.io/Tech_PenPals_Shiny/

# Load required libraries
if (!require(shiny))
  install.packages("shiny")
if (!require(markdown))
  install.packages("markdown")
if (!require(DT))
  install.packages("DT")
# http://rpackages.ianhowson.com/cran/metricsgraphics/
if (!require(metricsgraphics))
  install.packages("metricsgraphics")


# Customize the header panel
# Reference: http://stackoverflow.com/questions/21996887/embedding-image-in-shiny-app
# customHeaderPanel <- function(title,windowTitle=title){
#   tagList(
#     tags$head(
#       tags$title(windowTitle),
#       tags$link(rel="stylesheet", type="text/css",
#                 href="app.css"),
#       tags$h1(a(href="www.someURLlogoLinksto.com"))
#     )
#   )
# }


################################################################################
# MIDAAS APIs
# [GET] /quantiles?[year=?][state=?][race=?][sex=?][agegroup=?][compare=?]
# [GET] /distribution?[year=?][state=?][race=?][sex=?][agegroup=?][compare=?]
################################################################################

# Input Variables
# api <- "/distribution" # API name, Options: /quantiles, /distribution
# year <- "2014" # Year, Options: 2005-2014 (any one of the 10 years)
# state <- "VA" # US State Code, Options: VA, MD, CA, etc
# race <- "white" # Race, Options: "white", "african american", "hispanic", "asian"
# sex <- "female" # Sex, Options: "male", "female"
# ageGroup <- "35-44" # Age group, Options: "18-24", "25-34", "35-44", "45-54", "55-64", "65+"
# compare <- "state" # Field to compare against, Options: "state", "race", "sex", "agegroup"

# Default URL: 
#   https://api.commerce.gov/midaas/distribution?year=2014&state=VA&race=white&sex=female&ageGroup=35-44&compare=state&api_key=Z69XvTaBEqK7g7VshJ0FGDb4ReDtFjKjeVvpNWMv


# Define UI for BumpAhead application
shinyUI(navbarPage("Tech Pen Pals",
                   tabPanel("Inspire!", 
                            tags$head(tags$style(
                              HTML('
                                #sidebarInfo {
                                    background-color: #d8ddfe; #Light blue for Informational pages
                                }
                                #sidebarImagine {
                                    background-color: #9da9fb; #Dark blue for Imagination pages
                                }
                                #sidebarData {
                                    background-color: #9dfbca; #Light green for Data pages
                                }
                        
                                body, label, input, button, select { 
                                  font-family: "Arial";
                                }
                              
                                table { 
                                  empty-cells: show; 
                                }
                              ')
                            )),
                            # Application title
                            titlePanel("Tech Pen Pal : Facilitating Unlikely Connections Through Real Work"),
                            sidebarLayout(
                              sidebarPanel(width=6,
                                #id="sidebarInfo",
                                img(src='logo_penpal.png'),
                                # Screen 1: "Did you know that there are nearly 1 million women in computing occupations in the United States today?"
                                conditionalPanel(
                                  condition = "input.ChooseStep1 == 0",
                                  id="sidebarInfo",
                                  h1("Did you know that there are nearly", 
                                     strong("1 million women"), "in computing occupations in the", 
                                     strong("United States"), "today?")
                                  ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep1 == 0)",
                                  actionButton("ChooseStep1", strong("Next"))
                                  ),
                                # Screen 2: "Women comprise 34% of web developers; 23% of programmers; 37% of database administrators; 20% of software developers; and 15% of information security analysts."
                                conditionalPanel(
                                  condition = "(input.ChooseStep1 == 1) && (input.ChooseStep2 == 0)",
                                  id="sidebarInfo",
                                  h1("Women comprise 34% of", strong("web developers"),"; 23% of ", strong("programmers"),"; 37% of ", strong("database administrators"),"; 20% of ", strong("software developers"),"; and 15% of ", strong("information security analysts"),".")
                                  ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep1 == 1) && (input.ChooseStep2 == 0)",
                                  actionButton("ChooseStep2", strong("Next"))
                                  ),
                                # Screen 3: "The average female senior software developer earns between $74,660 - $100,591 per year and has at least a bachelor's degree."
                                conditionalPanel(
                                  condition = "(input.ChooseStep2 == 1) && (input.ChooseStep3 == 0)",
                                  id="sidebarInfo",
                                  h1("The average female senior software developer earns between", strong("$74,660 - $100,591"),"per year and has at least a", strong("bachelor's")," degree.")
                                  ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep2 == 1) && (input.ChooseStep3 == 0)",
                                  actionButton("ChooseStep3", strong("Next"))
                                  ),
                                # Screen 4: "The gender pay gap for computer programmers is smaller (women make 7% less than men) than it is for other professional occupations"
                                conditionalPanel(
                                  condition = "(input.ChooseStep3 == 1) && (input.ChooseStep4 == 0)",
                                  id="sidebarInfo",
                                  h1("The", strong("gender pay gap"),"for computer programmers is", strong("smaller"),"(women make 7% less than men) than it is for other professional occupations")
                                  ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep3 == 1) && (input.ChooseStep4 == 0)",
                                  actionButton("ChooseStep4", strong("Next"))
                                  ),
                                # Screen 5: "Just 3% of the U.S. computing workforce is African-American women, 4% is Asian women, and 1% is Latinas."
                                conditionalPanel(
                                  condition = "(input.ChooseStep4 == 1) && (input.ChooseStep5 == 0)",
                                  id="sidebarInfo",
                                  h1("Just", strong("3%")," of the U.S. computing workforce is", 
                                      strong("African-American women"),",", strong("4%"),"is", strong("Asian"),"women, and", 
                                      strong("1%"),"is", strong("Latinas."))
                                  #h1("Just 3% of the U.S. computing workforce is African-American women, 4% is Asian women, and 1% is Latinas.")
                                  ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep4 == 1) && (input.ChooseStep5 == 0)",
                                  actionButton("ChooseStep5", strong("Next"))
                                  ),
                                # Screen 6: "Let's learn more about the different software occupations...Shall we?"
                                conditionalPanel(
                                  condition = "(input.ChooseStep5 == 1) && (input.ChooseStep6 == 0)",
                                  id="sidebarInfo",
                                  h1("Let's learn more about the different software occupations...", strong("Shall we?"))
                                  ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep5 == 1) && (input.ChooseStep6 == 0)",
                                  actionButton("ChooseStep6", strong("Next"))
                                  ),
                                # Screen 7: "Imagine..."
                                conditionalPanel(
                                  condition = "(input.ChooseStep6 == 1) && (input.ChooseStep7 == 0)",
                                  id="sidebarImagine",
                                  h1("Imagine...")
                                ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep6 == 1) && (input.ChooseStep7 == 0)",
                                  actionButton("ChooseStep7", strong("Next"))
                                ),
                                # Screen 8: "You are young and driven and want to make something of your life. You want to work full-time in one of these software occupations"
                                conditionalPanel(
                                  condition = "(input.ChooseStep7 == 1) && (input.ChooseStep8 == 0)",
                                  id="sidebarImagine",
                                  h1("You are young and driven and want to make something of your life. You want to work full-time in one of these software occupations")
                                ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep7 == 1) && (input.ChooseStep8 == 0)",
                                  actionButton("ChooseStep8", strong("Next"))
                                ),
                                # Screen 9: "Play to see how your different interests and talents align with the needs of a given software occupation."
                                conditionalPanel(
                                  condition = "(input.ChooseStep8 == 1) && (input.ChooseStep9 == 0)",
                                  id="sidebarImagine",
                                  h1("Play to see how your different interests and talents align with the needs of a given software occupation")
                                ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep8 == 1) && (input.ChooseStep9 == 0)",
                                  actionButton("ChooseStep9", strong("Play >"))
                                ),
                                # Screen 10: "Where do you live?"
                                # In future, this information can be used to provide location-specific targeted information
                                conditionalPanel(
                                  condition = "(input.ChooseStep9 == 1) && (input.ChooseStep10 == 0)",
                                  id="sidebarData",
                                  h3( helpText(strong("Location:")) ), 
                                  hr(),
                                  h3( selectInput('stateName_BA', "Where do you live?", c(Choose='', state.name), 
                                              selected="Virginia", selectize=FALSE) )
                                  ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep9 == 1) && (input.ChooseStep10 == 0)",
                                  actionButton("ChooseStep10", strong("Next"))
                                  ),
                                # Screen 11: "Which software occupation interests you most?"
                                conditionalPanel(
                                  condition = "(input.ChooseStep10 == 1) && (input.ChooseStep11 == 0)",
                                  id="sidebarData",
                                  h3( helpText(strong("Location:")) ), 
                                  h3( helpText(textOutput("StateSelectedAsLocation")) ),
                                  hr(),
                                  h3( strong("Job:") ),
                                  hr(),
                                  h1("You are college educated and have big plans to succeed."),
                                  h1("Let's see what field inspires you.")
                                ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep10 == 1) && (input.ChooseStep11 == 0)",
                                  actionButton("ChooseStep11", strong("Next"))
                                )
                              ),
                              mainPanel(
                                textOutput("currentTime_BA"),
                                conditionalPanel(
                                  condition = "(input.ChooseStep9 == 1) && (input.ChooseStep10 == 0)",
                                  h1(textOutput("stateRank_PayGapByMedian")),
                                  tags$i( h5("(Based on Difference in 2014 Median Earnings of Male vs. Female Per State Using MIDAAS APIs)") ),
                                  hr(),
                                  #plotOutput("plot_BA"),
                                  metricsgraphicsOutput("mjs_plot_BA"),
                                  hr(),
                                  #   Pencil Map d3.js
#                                   tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
#                                   tags$script(src="https://d3js.org/d3.v3.min.js"),
#                                   tags$script(src="waterColorMap.js"),
#                                   tags$div(id="div_tree"),
#                                   hr(),
                                  # Regular table display - instead use DataTable for more interactivity
                                  # tableOutput("payGapRecords_BA")
                                  dataTableOutput("payGapRecordsDT_BA")
                                ),
                                conditionalPanel(
                                  condition = "(input.ChooseStep10 == 1) && (input.ChooseStep11 == 0)",
                                  br(),br(),
                                  h1(
                                    tags$table(width="100%", border="1",
                                               id="sidebarInfo",
                                               tags$tr( "Your options ..." ),
                                               tags$tr( tags$td("Software Developer"), tags$td(), tags$td("Database Administrator DBA") ),
                                               tags$tr( tags$td("Technical Analyst"), tags$td(" "), tags$td("Functional Analyst") ),
                                               tags$tr( tags$td("Designer"), tags$td(" "), tags$td("User Experience UX / User Interface UI") ),
                                               tags$tr( tags$td("Data Scientist"), tags$td(" "),  tags$td("Cybersecurity Analyst") )
                                    )
                                  )
                                )
                              ) # mainPanel(
                            )
                   ), # tabPanel("Tech Pen Pal",
                   
                   
                   tabPanel("About Us",
                            fluidRow(
                              column(6,
                                     includeMarkdown("About.md")
                              ),
                              column(3,
                                     img(class="img-polaroid",
                                         src="logo_penpal.png", width = "200px", height = "125px"),
                                     tags$strong(
                                       "Logo: Tech Pen Pal App"
                                     #),
                                     # img(class="img-polaroid",
                                     #     src="wordcloud_packages_res600.png", width = "806px", height = "538px"),
                                     # tags$strong(
                                     #   "Wordcloud of 1500 Tweets with Paygap"
                                     )
                              )
                            ) # fluidRow(
                   ) # tabPanel("About Us",
        ) # tabPanel("Inspire!", 
) # shinyUI(navbarPage("Tech Pen Pals",        




                   