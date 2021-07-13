# CLASE 5 - geo

#::install_github("politicaargentina/geoAr")

library(geoAr)

argentina <- get_geo("ARGENTINA")

library(sf)

argentina %>%
  st_write("data/mapasad_arg.geojson")

#IMPORTAR DATOS PESADOS: 
# .gitignore
# zip
# .rds

#VROOM CORRE MAS RAPIDO LOS ARCHIVOS

#HAY GEOMETRÍA?
is.empty()  -> TRUE O FALSE

units () devuelve la unidad de medida 
area()

centroid()

#SF

plot(argentina)

#INTERSECCION AGRANDANDO UN BUFFER
#ggplot() +
#geom_sf(data = st_intersection(schools, st_buffer(subway, 1000)))


show_arg_codes() %>% 
  print(n=Inf)

argentina2 <- get_geo("ARGENTINA", simplified = FALSE) #SIMPLIFICADO

argentina2 %>%
  st_write("data/mapasad_arg2.geojson")

install.packages("mapview")
library(mapview)

#EXCELENTE MAPA CON REPRESENTACION SIMPLIFICADA
mapview::mapview(argentina2)



argentina %>%
  add_geo_codes() %>%
  mapview::mapview()

install.packages("mapedit")
library(mapedit)

#EDICION DE MAPAS
mapedit::editFeatures(argentina)


install.packages("rmapshaper")
library(rmapshaper)

#rmapshaper::ms_simplify()



mapa_arg %>%
  rmapshaper::ms_simplify() %>%
  st_crop(xmin = -78.844299, ymin = -56.918980,
          xmax = -53.531800, ymax = -20.341163) %>%
  st_write("../../mapa2.geojson")



st_crop
