# Ganancias en función de días transcurridos
dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Convertimos las columnas date_ordered y date_end a tipo date
dataset$date_ordered <- as.Date(dataset$date_ordered)
dataset$date_end <- as.Date(dataset$date_end)

# Calculamos los días transcurridos
dataset <- dataset %>%
  mutate(days_elapsed = as.numeric(difftime(date_end, date_ordered, units = "days")))

# Cramos la visualización
ggplot(dataset, aes(x = days_elapsed, y = total, color = as.factor(category))) +
  geom_point(size = 3) +
  labs(title = "Ganancias en función de días transcurridos",
       x = "Días transcurridos",
       y = "Total",
       color = "Categoría") +
  theme_minimal()