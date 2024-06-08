#Frecuencia de clientes repetidos por Categoría
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Calcular la frecuencia de cada categoría
category_frequencies <- dataset %>%
  group_by(category) %>%
  summarise(count = n(), .groups = 'drop')

# Imprimir las frecuencias
print(category_frequencies)

# Crear el gráfico de barras con las frecuencias de cada categoría
ggplot(category_frequencies, aes(x = factor(category), y = count, fill = factor(category))) +
  geom_bar(stat = "identity") +
  labs(title = "Frecuencia de Compras en cada Categoría", 
       x = "Categoría", 
       y = "Frecuencia de Aparición",
       fill = "Categoría") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5))