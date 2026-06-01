server <- function(input, output, session) {
  
  updatedata <- reactive({
    url <- paste0("https://api.openweathermap.org/data/2.5/weather?q=", city,
                  "&appid=", apikey, "&units=metric")
    weatherRiyadh <- fromJSON(content(GET(url),"text"), flatten = TRUE)
    print(weatherRiyadh)
  })
  
  weather_data <- reactive({
    invalidateLater(600000, session)  # تحديث كل 10 دقائق
    get_weather(city,apikey)
  })
  
  output$temp <- renderValueBox(valueBox(paste0(updatedata()$main$temp," °C"),"Temperature",icon = icon("temperature-half"),color="yellow" ))
  
  output$humidity <- renderValueBox(valueBox(paste0(updatedata()$main$humidity," %"),"Humidity",icon = icon("droplet"),color="blue" ))
  
  output$wind <- renderValueBox(valueBox(paste0(updatedata()$wind$speed," m/s"),"Wind Speed",icon = icon("wind"),color="green" ))

  output$weathericon <- renderUI({
    tags$img(src = paste0("https://openweathermap.org/img/wn/",updatedata()$weather$icon,"@2x.png"),
             width = "65px")
  })
  
  output$weather_desc <- renderText({
    tools::toTitleCase(updatedata()$weather$description)
  })
  
  output$tempPlot <- renderPlotly({
    df <- weather_data()
  
   p <- ggplot(df, aes(x = dt_txt, y = main.temp, color = main.temp, group = 1,
                       text = paste(
                         "📅 Date:", format(dt_txt, "%Y-%m-%d"),
                         "<br>⏰ Time:", format(dt_txt, "%H:%M"),
                         "<br>🌡Temperature:", round(main.temp,1), "°C"
                       )
                       )) +
     geom_line(color = "#0072B2", linewidth = .5) +
      geom_point(size = 2) +
      
      scale_color_gradient(low = "#00BFFF", high = "#FF4500") +
      
      geom_hline(yintercept = mean(df$main.temp, na.rm = TRUE),
                 linetype = "dashed",
                 color = "darkgreen",
                 size = 1) +
      
      scale_x_datetime(date_labels = "%a %H:%M") +
      
      labs(
        title = "🌤️ Temperature forecast in Riyadh",
        x = "Time",
        y = "Temperature (°C)",
        color = "Temperature"
      ) +
      
      theme_minimal(base_size = 14) +
      theme(
        plot.title = element_text(face = "bold", size = 18),
        axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.minor = element_blank()
      )  
   ggplotly(p, tooltip = "text") %>%
     layout(
       title = list(
         text = "🌤️ Temperature in Riyadh<br><sub>Updated every 10 minutes</sub>"       )
     )
  
  })
}
