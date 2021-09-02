#' prueba

#prueba 2

hola<- "hola"

#con CTR+SHITF+K renderizo

#' prueba 3

# rbase <- read.csv()
# tidy <- read_csv  lalala

install.packages("vroom") #para levantar archivos pesados
library (vroom)


install.packages("datapasta") #este paquete sirve para tablas rapidamente de internet
library(datapasta)

install.packages("janitor")

library(janitor)

df %>% 
  janitor::clean_names() #limpia los nombres. saca tildes o caracteres especiales


#tidy data (tidyr)
#PARA QUE ESTE ORDENADO:
#cada variable debe tener su propia columa
#cada observación debe tener su propia fila
#cada valor debe tener su propia celta

#TIDYR PERMITE PIVOTEAR LAS TABLAS 
  #pivot_longer()   <- reduce la cantidad de filas y aumenta la cantidad de columnas
  #pivot_wider()    <- reduce la cantidad de columnas y aumenta la cantidad de filas

df %>% 
  pivot_longer(cols=c(columnainical:columnafinal),
               names_to="listas",  #por ejemplo
               values_to="votos")

df %>% 
  filter(str_detect(string=depto, pattern="Puey"))


eleccion_long %>% 
  mutate(podio=case_when(   #case_when asigna casos. Para cada fila se fija cual tiene maxima cantidad de votos en este caso
    votos==max(votos)~1,#al partido con maximo votos, le asigna 1, a los otros 0
    votos==min(votos)~-1,#al con menos votos, -1
    TRUE~0 
  )) %>%
  select(podio, everything())







