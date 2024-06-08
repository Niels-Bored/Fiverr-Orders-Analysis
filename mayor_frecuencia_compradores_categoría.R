#Frecuencia de clientes repetidos por Categoría
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Calcular la frecuencia de cada comprador dentro de cada categoría
buyer_frequencies <- dataset %>%
  group_by(category, buyer) %>%
  summarise(count = n(), .groups = 'drop')

# Encontrar la mayor frecuencia de aparición dentro de cada categoría
max_buyer_frequencies <- buyer_frequencies %>%
  group_by(category) %>%
  summarise(max_count = max(count), .groups = 'drop')

# Crear el gráfico de barras con las mayores frecuencias
ggplot(max_buyer_frequencies, aes(x = factor(category), y = max_count, fill = factor(category))) +
  geom_bar(stat = "identity") +
  labs(title = "Mayor Frecuencia de Compradores por Categoría", 
       x = "Categoría", 
       y = "Mayor Frecuencia de Aparición",
       fill = "Categoría") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5))
