#Frecuencia de clientes repetidos por Categoría
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Paso 1: Calcular la suma total de "total" para cada categoría
total_por_categoria <- dataset %>%
  group_by(category) %>%
  summarise(total_sum = sum(total))

# Paso 2: Calcular el porcentaje acumulado para cada categoría
total_por_categoria <- total_por_categoria %>%
  mutate(percentage = total_sum / sum(total_sum) * 100,
         cumulative_percentage = cumsum(percentage))

# Paso 3: Crear un gráfico de pastel para visualizar los porcentajes acumulados
ggplot(total_por_categoria, aes(x = "", y = percentage, fill = factor(category))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Ganancias por Categoría",
       fill = "Categoría",
       x = NULL,
       y = NULL) +
  theme_void() +
  theme(legend.position = "right")