
# Reading forecast data
get_weather <- function(city,apikey) {
  url <- paste0(
    "https://api.openweathermap.org/data/2.5/forecast?q=",city,"&appid=",
    apikey,
    "&units=metric"
  )

  res <- GET(url)
  data <- fromJSON(content(res, "text"), flatten = TRUE)
  
  df <- data$list %>%
    select(dt_txt, main.temp) %>%
    mutate(
      dt_txt = as.POSIXct(dt_txt)
    )
  
  return(df)
}

# Reading weather data
Weather_today <- function(city,apikey,metric) {
  url <- paste0("https://api.openweathermap.org/data/2.5/weather?q=", city,
                       "&appid=", apikey, "&units=",metric)
  
  weather_data <- fromJSON(content(GET(url),"text"), flatten = TRUE)
  
  print(weather_data)
  
  return(weather_data)
}




