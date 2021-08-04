library(tidyverse)
install.packages("datos")
library (datos)

millas

# podria encadenar el grafico con la pipa asi:

millas %>% 
  ggplot()+
  geom_point(mapping = aes(x=cilindrada, 
                           y=autopista,
                           color=clase),
             size=2)+# setting, no mapping como color
  facet_wrap(~clase, nrow = 4, #separo en 4 filas
             scales = "free") #si quiero que cada uno tenga escalas distintas


# Dos geometrías

# grafico izquierda
millas %>% 
  ggplot()+
  geom_point(mapping = aes(x=cilindrada, 
                           y=autopista))
# grafico derecha
millas %>% 
  ggplot()+
  geom_smooth(mapping = aes(x=cilindrada, 
                           y=autopista))

millas %>% 
  ggplot()+
  geom_point(mapping = aes(x=cilindrada, 
                           y=autopista))+
  geom_smooth(mapping = aes(x=cilindrada, 
                            y=autopista), method="loess")



# Para no ser reiterativo: 
ggplot(millas, aes(cilindrada, autopista))+
  geom_point()+
  geom_smooth()


# themes

ggplot(millas, aes(cilindrada, autopista)) +
  geom_point() +
  geom_point(data = millas %>% 
               filter(fabricante == "audi"), color = "blue", size =3) +
  geom_smooth(se = FALSE) +
  labs(title = "Performance de los AUDI",  subtitle = "Un gráfico del TuQmano", 
       y = "Etiqueta Y",  x = "Etiqueta X", 
       caption = "FUENTE: {datos} 'R Para Ciencia de Datos'") +
  ggthemes::theme_wsj()+
  theme()






