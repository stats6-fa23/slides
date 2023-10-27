library(rvest)
library(tidyverse)

robotstxt::paths_allowed("http://www.criterion.com")

page <- read_html("https://www.criterion.com/shop/browse/list?sort=spine_number")

spine <- page  |>  
  html_nodes(".g-spine") |> 
  html_text() |> 
  str_remove_all("\n") 


title <- page |> 
  html_nodes(".g-title") |> 
  html_text() |> 
  str_remove_all("\n")

director <- page |> 
  html_nodes(".g-director") |> 
  html_text() |> 
  str_remove_all("\n")

year <- page |> 
  html_nodes(".g-year") |> 
  html_text() |> 
  str_remove_all("\n")

criterion <- tibble(spine = spine,
                    title = title,
                    director = director,
                    year = year) |> 
  slice(-1) |> 
  mutate(spine = as.numeric(spine),
         year = as.numeric(year)) 

readr::write_csv(criterion, "data/criterion.csv")

