#Frecuencia de clientes repetidos por Categoría
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Contar las repeticiones de cada buyer dentro de cada categoría
buyer_counts <- dataset %>%
  group_by(category, buyer) %>%
  summarise(count = n()) %>%
  ungroup()

# Filtrar para encontrar sólo los buyers que tienen más de una repetición
repeated_buyers <- buyer_counts %>%
  filter(count > 1)

# Contar el número de buyers repetidos por categoría
repeated_buyers_summary <- repeated_buyers %>%
  group_by(category) %>%
  summarise(repeated_count = n())

ggplot(repeated_buyers_summary, aes(x = factor(category), y = repeated_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Número de Buyers Repetidos por Categoría", x = "Categoría", y = "Número de Buyers Repetidos") +
  theme_minimal()