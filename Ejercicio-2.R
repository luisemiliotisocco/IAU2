library(tidyverse) # Easily Install and Load the 'Tidyverse', CRAN v1.3.0
library(sf) # Simple Features for R, CRAN v1.0-0
options(scipen = 999) # Eliminar notación cientifica

barrios<- st_read("data/barrios/barrios_badata.shp")
barrios <- select(barrios, BARRIO, COMUNA)

terrenos2020 <- st_read("data/terrenos-2020/210517_Terrenos_Vta_Anual2020.shp")

sum(is.na(terrenos2020))  #hay 6 instancias nulas, las elimino

terrenos2020 <- drop_na(terrenos2020)

terrenos2020 <- terrenos2020 %>% 
  select(DOLARM2) %>% 
  st_join(barrios)
  
head(terrenos2020)
names(terrenos2020)


terrenos2020_barrio<- terrenos2020 %>% 
  as.data.frame() %>% 
  group_by(BARRIO) %>% 
  summarise(PROMEDIOUSD_2020=mean(DOLARM2))

print(terrenos2020_barrio)


ggplot()+
  geom_bar(data=terrenos2020_barrio, aes(y=reorder(BARRIO, -PROMEDIOUSD_2020), weight=PROMEDIOUSD_2020, fill=BARRIO), show.legend = FALSE)+
  scale_fill_viridis_d()+
  labs(x="USD", 
       y="Barrio",
       title="Promedio m2 en 2020", 
       caption="Fuente: GCBA")+
  theme_minimal()



terrenos2019 <- st_read("data/terrenos-2019/Terrenos_venta_2019.shp")
head(terrenos2019)
names(terrenos2019)
terrenos2019 <- select(terrenos2019, OPERACION, PRECIOUSDM)

sum(is.na(terrenos2019))  #no hay instancias nulas
terrenos2019 <- filter(terrenos2019, OPERACION=="VTA")

terrenos2019 <- st_join(barrios, terrenos2019)

terrenos2019_barrio<- terrenos2019 %>% 
  as.data.frame() %>% 
  group_by(BARRIO) %>% 
  summarise(PROMEDIOUSD_2019=mean(PRECIOUSDM))

print(terrenos2020_barrio)


ggplot()+
  geom_bar(data=terrenos2019_barrio, aes(y=reorder(BARRIO, -PROMEDIOUSD_2019), weight=PROMEDIOUSD_2019, fill=BARRIO), show.legend = FALSE)+
  scale_fill_viridis_d()+
  labs(x="USD", 
       y="Barrio",
       title="Promedio m2 en 2019", 
       caption="Fuente: GCBA")+
  theme_minimal()


terrenos <- left_join(terrenos2019_barrio, terrenos2020_barrio, by="BARRIO")
terrenos <- terrenos %>%  mutate(VARIACION=((PROMEDIOUSD_2020/PROMEDIOUSD_2019)-1)*100)
print(terrenos[order(terrenos$VARIACION, decreasing= T),])


ggplot()+
  geom_bar(data=terrenos, aes(y=reorder(BARRIO, -VARIACION), weight=VARIACION, fill=BARRIO), show.legend = FALSE)+
  scale_fill_viridis_d()+
  labs(x="USD", 
       y="Barrio",
       title="Variación 2019-2020", 
       caption="Fuente: GCBA")+
  theme_minimal()


terrenos_barrios <- left_join(barrios, terrenos, by="BARRIO")

ggplot()+
  geom_sf(data=terrenos_barrios, aes(fill=VARIACION), alpha=.75)+
  geom_sf(data=terrenos_barrios %>% filter(VARIACION>=0), fill=NA, size=2, color="chartreuse3")+
  geom_sf(data=terrenos_barrios %>% filter(VARIACION<0), fill=NA, size=1, color="brown1")+
  scale_fill_continuous(limits=c(-100, 100), breaks=c(-100, -75, -50, -25, 0, 25, 50, 75, 100))+
  geom_sf_text(data=terrenos_barrios, aes(label=round(VARIACION),0), size=4, fontface = "bold")+
  scale_fill_viridis_c(alpha=.75)+
  labs(title="Variación porcentual por Barrio", 
       subtitle = "Período 2019-2020",
       caption="Fuente: GCBA")+
  theme_void()









