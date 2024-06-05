# Ganancias totales en función de la categoría
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Cálculo de ganancias totaltes por categoría
result <- dataset %>%
  group_by(category) %>%
  summarise(sum_total = sum(total, na.rm = TRUE))

# Creamos la visualización
ggplot(result, aes(x = factor(category), y = sum_total)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Ganancias totales en función de la categoría", x = "Categoría", y = "Ganancias") +
  theme_minimal()