dataset <- read.csv("clean_data.csv")

if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(ggplot2)
library(dplyr)

# Example dataframe
# dataset <- data.frame(date_ordered = as.Date(c('2023-01-01', '2023-02-01', '2023-03-01')),
#                       date_end = as.Date(c('2023-01-10', '2023-02-20', '2023-03-15')),
#                       total = c(100, 200, 150),
#                       category = c(1, 2, 3))

# Convertimos las columnas date_ordered y date_end a tipo date
dataset$date_ordered <- as.Date(dataset$date_ordered, format = "%d/%m/%Y")
dataset$date_end <- as.Date(dataset$date_end, format = "%d/%m/%Y")

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