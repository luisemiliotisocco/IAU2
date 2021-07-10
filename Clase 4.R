library(janitor)
library(googlesheets4)
library(tidyverse)
#install.packages("skimr")
library(skimr)
#install.packages("anotator")

googlesheets4::gs4_deauth()
tp_1<- read_sheet("https://docs.google.com/spreadsheets/d/1lOmFtE291lVjy8w8UwramgnIEgcvwz0iIq0VqvjMp5A/edit#gid=0") %>% 
  clean_names()

tp_1 %>% 
  dplyr::filter(!is.na(alumne_apellido_nombre))
tp_1

# + dplyr -> Properati
datos <- vroom::vroom("https://storage.googleapis.com/properati-data-public/ar_properties.csv.gz")
#esta libreria me cuenta el tiempo

muestra <- datos %>% 
  slice(1:1000) #corte el prime 10%
#VARIANTES SLICE: 
  #slice_min(10000) <- me quedo con los 1000 menores
  #BUSCAR otros


skimr::skim(muestra)
#hace rápidamente un gran resumen del objeto


muestra %>%
  select(provincia=l2) %>% #renombro desde el mismo select 
  group_by(provincia) %>% 
  summarise (cantidad=n()) %>% 
  arrange(desc(cantidad)) %>% 
  mutate(provincia2=case_when(
    str_detect(string=provincia, pattern ="Bs.As")~"PBA",  #str_detect
    TRUE~ provincia 
  )) %>% 
  #que complete casos. si cumple la condicion de que es "Bs.As., cambia a PBA
  #sino, toma los valores de provincia
  print(n=Inf) #que los imprima todos


muestra %>% #le cambio la clase a las columnas start_date y end_date
  mutate_at(.vars =c("start_date", "end_date"), .funs = ~as.character(.))

#AHORA FUNCION ACROSS REEMPLAZO ESTO
muestra %>%
  mutate(across(.cols = everything(), .fns = as.character()))
#este no funciona, revisar


rowwise() 


ANTI_JOIN #descarta los que no estan en el dataframe
SET_DIFF() #A-B -> CUALES NO ESTAN LOS 2 CONJUNTOS



trnsmute() # mutate y descarga todas las otras variables


## STRIGR

str_pad(string=columna, width = 3, side = "left", pad = 1) 
#3 lugares, agrega a la izquierda un 1 a cada instancia de la columna



#forcats::
fct_reorder() #modifica el orden
fct_recore() #modificia los valores 
fct_collapse() #colapsar es util para recodificar muchos niveles
fact_lump() #agrupa





















