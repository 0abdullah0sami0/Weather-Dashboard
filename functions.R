
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

