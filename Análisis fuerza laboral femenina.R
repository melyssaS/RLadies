install.packages("readr")
install.packages("tidyr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("gganimate")
install.packages("ggsci")
install.packages("gifski ")
install.packages("tibble")
library(dplyr)
library(tibble)
library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(gganimate)
library(ggsci)
library(gifski)
datos <- read.csv(file="DATOS 1.csv",sep=";")

#Animada de fuerza laboral en cada pais 
pgg <- ggplot(
  datos,
  aes(Año,FL,  color=País)) +   geom_line() +   scale_alpha() +
  labs(x = "Año", y = "Fuerza laboral") +
  theme(legend.position = "top")
pgg+   
  geom_point(aes(group = seq_along(Año))) +
  transition_reveal(Año)

#Cada país aparte
pgg <- ggplot(
  datos,
  aes(Año,FL,  color=País)) +   geom_line() +   scale_alpha() +
  labs(x = "Año", y = "Fuerza laboral") +
  theme(legend.position = "top")
pgg+   
  geom_point(aes(group = seq_along(Año))) +
  facet_wrap(~País)+
  transition_reveal(Año)











