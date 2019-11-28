install.packages("readr")
install.packages("tidyr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("gganimate")
install.packages("ggsci")
install.packages("gifski")
library(tidyr)
library(dplyr)
library(ggplot2)
library(gganimate)
library(ggsci)
library(gifski)
install.packages("curl")
empleo_genero <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-10-16/empleo_genero.csv")
save(empleo_genero,file = "Empleo.Rdata")
load("Empleo.Rdata")
#Seleccion de datos
Datos <- empleo_genero %>%
  #Seleccion de las variables para cambiar a formato largo
  pivot_longer(-c(variable,codigo_pais_region,pais_region),
               names_to ="a?o",
               values_to = "porcentaje") %>% 
  #Renombrando el codigo del pais
  rename(codigo== codigo_pais_region) %>% 
  #Cambiando la variable a?o de caracter a numerico y codigo a factor
  mutate(a?o = as.numeric(a?o),
         codigo =as.factor(codigo) ) %>% 
  #Selecionando variable de interes "Desempleo"
  filter(variable=="desempleo_mujeres" |  variable =="desempleo_hombres") %>% 
  #Eliminando valores faltantes
  #quitando la variable pais region
  empleo_genero %>%
  select(- pais_region) %>%  
  #Filtrando paises en frontera con colobia
  filter(codigo == "COL" | codigo =="ECU" | codigo =="PER" | codigo =="VEN" | codigo  =="BRA" | codigo  =="PAN")
#Figura
gplot <- ggplot(empleo_genero,aes(x=a?o,y=porcentaje,color=variable)) + 
  geom_line()+
  facet_wrap(~codigo,scales = "free")+
  scale_color_jco(name="Desempleo",
                  breaks = c("desempleo_hombres","desempleo_mujeres"),
                  labels=c("Hombres","Mujeres"))+
  theme_dark()+
  geom_tile(color="orange")+
  theme(text = element_text(size=10),
        legend.text = element_text( size = 12),
        legend.title = element_text(size=14),
        legend.position = "top",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = 'black'),
        legend.background = element_rect(fill = "white", color = NA),
        legend.key = element_rect(fill = "white"))+
  labs(x="A?o",y="Porcentaje")+
  transition_reveal(a?o)

animate(gplot, renderer = gifski_renderer())
install.packages("png")
library(png)
