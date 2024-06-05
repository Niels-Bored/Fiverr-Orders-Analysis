# Extensión de tiempo por categoría
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Contar las ocurrencias de 1 en extend_delivery por categoría
extend_delivery_counts <- dataset %>%
  filter(extend_delivery == 1) %>%
  group_by(category) %>%
  summarise(count_extend_delivery = n())

# Crear el gráfico de barras
ggplot(extend_delivery_counts, aes(x = factor(category), y = count_extend_delivery)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Número de Entregas Extendidas por Categoría", x = "Categoría", y = "Recuento de Entregas Extendidas") +
  theme_minimal()