#INSTALAR ANNOTATER

install.packages("remotes")
remotes::install_github("luisDVA/annotater")

library(annotater) # Annotate Package Load Calls

#install.packages("devtools")
devtools::install_github ("politicaargentina/geoAr")
library(geoAr)     # [github::politicaargentina/geoAr] v0.0.1.1


devtools::install_github ("electorArg/polAr")
library(polAr)     # [github::electorArg/polAr] v0.2.0.1

devtools::install_github ("politicaargentina/electorAr")
library(electorAr) # [github::politicaargentina/electorAr] v0.0.1.0


eleccion <- get_election_results(district = "tucuman", category = "gober", round = "gral", year = 1991)
get_geo(geo = "TUCUMAN")

library(tidyverse)

### LIBRERIA GLUE


library(glue)      # CRAN v1.4.2
nombre <- "Luis"
ocupacion <- "Analista de Datos"
aniversario <- as.Date("1993-02-04")

glue("Mi nombre es {nombre}.
     Trabajo de {ocupacion}.
     Naci el {format(aniversario, '%A, %d de %B de %Y')}")

paste("Mi nombhre es ", nombre, ".\n Trabajo de ", ocupacion)



--------------------------------------
  
mutate(case_when(
  moneda=="USD" ~ "precio"180,
  moneda=="peso" ~ precio
)) 
  

ALTERNATIVAMENTE (TODAS LAS OTRAS)


mutate(case_when(
  moneda=="USD" ~ "precio"180,
  TRUE ~ precio
)) 

-------------------------------------

  mutate(case_when(
    moneda=="USD" ~ "precio"180,
    moneda=="peso" ~ precio
  )) 

----------------------------------

  
GENERO UN DATASET ALEATORIO  
  
df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)


#REESCALADO ENTRE 0 y 1

df$a <- (df$a - min(df$a)) /(max(df$a) - min(df$a))
df$b <- (df$b - min(df$b)) /  (max(df$b) - min(df$b))
df$c <- (df$c - min(df$c)) /  (max(df$c) - min(df$c))
df$d <- (df$d - min(df$d)) /  (max(df$d) - min(df$d))

#EN ESTE CASO DEBERIA CREAR UNA FUNCION EN VEZ DE COPIAR Y PEGAR EL BLOQUE DE CODIGO

x <- df$a #en este caso lo hago para a, pero podría ser para cualquier valor
(x - min(x)) / (max(x) - min(x))

#ALTERNATIVAMENTE:

rng <- range(x)
(x - rng[1]) / (rng[2] - rng[1])

#ALTERNATIVAMENTE:

rescale01 <- function(x) { #a la funcion la generalizo para cualquier X
  rng <- range(x, na.rm = TRUE) 
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale01(x=c(1005, 205,25))



----------------------
  
  
tucuman_dip_gral_2017 %>% 
  get_names()


CALCULAR PORCENTAJE


tucuman_dip_gral_2017 %>% 
  get_names() %>% 
    transmute(nombre_lista, votos, 
            pct = round(votos/sum(votos)*100,1)) #calculo porcentaje


calcular_pct <- function(data){
  round(data/sum(data)*100,1)
}

datos <- electorAr::tucuman_dip_gral_2017
datos %>% 
  electorAr::get_names() %>% 
  dplyr::transmute(nombre_lista,
                   pct = calcular_pct(data = votos))


#PODRIA ARMAR UNA FUNCION EN OTRO ARCHIVO Y LEVANTARLA ASI:

source("calcular_pct.R")




--------------------------
  
#ITERACION CON PURR:

library(geoAr)
geo <- get_geo("ARGENTINA") %>% 
  add_geo_codes()

geo
  
  