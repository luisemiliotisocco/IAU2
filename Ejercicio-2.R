#----------------------------------------
#SCRAPPING

library(tidyverse)
library(rvest)
library(stringr)

url <- "https://www.cronista.com/MercadosOnline/dolar.html"

moneda <- read_html(url) %>% 
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "name", " " )) and contains(concat( " ", @class, " " ), concat( " ", "col", " " ))]
') %>%
  html_text2()

variacion <- read_html(url) %>% 
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "percentage", " " )) and contains(concat( " ", @class, " " ), concat( " ", "col", " " ))]
') %>%
  html_text()

compra <- read_html(url) %>% 
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "buy", " " )) and contains(concat( " ", @class, " " ), concat( " ", "col", " " ))]') %>%
  html_text()

venta <- read_html(url) %>% 
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "sell", " " )) and contains(concat( " ", @class, " " ), concat( " ", "col", " " ))]') %>%
  html_text() 

tabla <- tibble(
  moneda = moneda, 
  variacion = variacion, 
  compra = compra,
  venta= venta
)

tabla<- tabla %>% slice(2:nrow(tabla)) #elimino primera fila que viene repetida 


tabla_completa <- read_html (url) %>% 
  html_elements(xpath="//*[(@id = 'market-scrll-2')]") %>% 
  html_text2()