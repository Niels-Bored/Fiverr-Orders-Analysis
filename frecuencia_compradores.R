#Frecuencia de clientes repetidos por Categoría
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Calcular la frecuencia de cada comprador
buyer_frequencies <- dataset %>%
  group_by(buyer) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# Crear el gráfico de barras ordenado
ggplot(buyer_frequencies, aes(x = reorder(buyer, -count), y = count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Frecuencia de Aparición de Cada Comprador", 
       x = "Comprador", 
       y = "Frecuencia de Aparición") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))