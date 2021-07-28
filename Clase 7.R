library(tidyverse)

df <- tibble::tibble(direccion = "ALVEAR, MARCELO T DE 1558")

df %>% separate(col = direccion, sep =  ",", # tidy
                into = c("dir2", "dir")) %>%
  mutate(numero = str_extract(dir, pattern = "\\d{1,}"), # MAS DE 1 DIGITO,
         dir = str_remove_all(dir, pattern = "\\d"),
         dir = str_squish(dir)) %>%  # ELIMIO ESPACIO EN BLANCO) %>% # ELIMINO NUMERO
  transmute(direccion = glue::glue("{dir} {dir2} {numero}"))


--------------------------
  
  
## SCRAPEO

library(rvest)

tuq <- read_html("https://tuqmano.ar/")

#HAY QUE COPIAR EL XPATH CON EL SLECTOR GADGET (EXTENSION DE CHROME) / CHROME DEVELOPER

#TENGO QUE IDENTIFICAR EL ELEMENTO QUE CONTIENE LA CLASE

#USO FUNCIONES como html_table o date para ir scrapeando los distintos atributos que quiero extraer






url2 <- "https://www.cronista.com/MercadosOnline/dolar.html"


dolar <- read_html(url2) %>% 
  html_nodes(xpath = '//*[@id="market-scrll-2"]') %>% # Selector Gadget Copy Xpath
  html_table(fill = T)


#RESULTADO DEBERIA SER DF CON 4 VARIABLES



