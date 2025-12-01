server <- function(input, output) {
  updatedata <- eventReactive(input$update,{
    apikey <- "260a5a65ceb58aae70101ff17815bc70"
    city <- "Riyadh"
    url <- paste0("https://api.openweathermap.org/data/2.5/weather?q=", city,
                  "&appid=", apikey, "&units=metric")
    weatherRiyadh <- fromJSON(content(GET(url),"text"))
    print(weatherRiyadh)
  })
  output$temp <- renderValueBox(valueBox("Temperature",paste0(updatedata()$main$temp," °C")))
  output$humidity <- renderValueBox(valueBox("Humidity", paste0(updatedata()$main$humidity," %")))
  output$wind <- renderValueBox(valueBox("Wind Speed", paste0(updatedata()$wind$speed," m/s")))
  output$weather <- renderValueBox(valueBox("Weather", updatedata()$weather$description))
}