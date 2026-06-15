dashboardPage(
  dashboardHeader(title = "🌦️ Weather Dashboard"),
  dashboardSidebar(
    
    conditionalPanel(
      condition = "input.tabs == 'Other Cities'",
      
      selectInput("city",
                  "City Name",
                  c("London","Jeddah","New York","Paris","Tokyo","Sydney")),
      
      # textInput(
      #   "city",
      #   "City Name",
      #   value = Jeddah
      # ),
      
      sliderInput(
        "days",
        "Forecast Days",
        min = 1,
        max = 5,
        value = 5
      ),
      
      radioButtons(
        "units",
        "Temperature Unit",
        choices = c(
          "Celsius" = "metric",
          "Fahrenheit" = "imperial"
        )
      ),
      
      checkboxInput(
        "show_avg",
        "Show Average Line",
        TRUE
      ),
      
      selectInput(
        "chart_type",
        "Chart Type",
        choices = c(
          "Line",
          "Line + Points"
        )
      )
    )
  ),
  
  dashboardBody(
    # set background to white
    setBackgroundColor(color = "#FFFFFF", shinydashboard = TRUE),
    tags$head(
      tags$link(rel = "shortcut icon", href = "Good-logo.ico")
    ),
               theme = shinytheme("paper"),
               windowTitle = "Weather Dashboard",
    
    tabsetPanel(
      id = "tabs",
      
      tabPanel(
        "Riyadh",
        # عنوان المدينة
        fluidRow(
          column(width = 12, align = "center",
                 h2(strong("Weather in Riyadh City 🏙️"), 
                    style = "color: #2c3e50; margin-top: 20px; margin-bottom: 20px;")
          )
        ),
        
        fluidRow(
          column(width = 3, align = "center", uiOutput("weathericon"),
                 h3(textOutput("weather_desc"))),
          valueBoxOutput("temp",3),
          valueBoxOutput("humidity",3),
          valueBoxOutput("wind",3),
        ),
        
        hr(),
        
        fluidRow(
          plotlyOutput("tempPlot")
        ),
      ),
      
      tabPanel(
        "Other Cities",
        # h2("Other Cities"),
        
        fluidRow(
          column(width = 12, align = "center",
                 h2(strong("Weather in Selected City 🏙️"), 
                    style = "color: #2c3e50; margin-top: 20px; margin-bottom: 20px;")
          )
        ),
        
        fluidRow(
          column(width = 3, align = "center", uiOutput("weathericon_City"),
                 h3(textOutput("weather_desc_City"))),
          valueBoxOutput("temp_City",3),
          valueBoxOutput("humidity_City",3),
          valueBoxOutput("wind_City",3),
        ),
        
        hr(),
        
        fluidRow(
          plotlyOutput("tempPlot_City")
        )
        
      )),
    hr(),
    
    fluidRow(
      column(width = 1,align = "right", offset = 4,
             tags$a(img(src = "GitHub.png",style = "width:30%;height:30%;"),href = "https://github.com/0abdullah0sami0", target="_blank")),
      column(width = 1,align = "center", offset = 0,
             tags$a(img(src = "LinkedIn.png",style = "width:30%;height:30%;"),href = "https://www.linkedin.com/in/abdullahalshalaan/", target="_blank")),
      column(width = 1,align = "left", offset = 0,
             tags$a(img(src = "twittter.jpeg",style = "width:30%;height:30%;"),href = "https://twitter.com/HR02030", target="_blank"))
    )
  )
)