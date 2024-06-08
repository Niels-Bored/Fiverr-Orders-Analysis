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

ggplot(repeated_buyers_summary, aes(x = factor(category), y = repeated_count, fill = factor(category))) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("1" = "#240750", "2" = "#344C64", "3" = "red", 
                               "4" = "green", "5" = "#577B8D", "6" = "#57A6A1"),
                    labels = c("1" = "Web Scraping", 
                               "2" = "Web Development", 
                               "3" = "Summary", 
                               "4" = "Email Automation", 
                               "5" = "Flask", 
                               "6" = "Automation"),
                    name = "Categorías") +
  labs(title = "Número de Compradores Repetidos por Categoría", 
       x = "Categoría", 
       y = "Número de Buyers Repetidos") +
  theme_minimal()

