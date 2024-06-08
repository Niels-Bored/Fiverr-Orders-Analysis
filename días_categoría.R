# Cálculo de días dedicados a una categoría
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

# Agrupar por categoría y sumar los días transcurridos
result <- dataset %>%
  group_by(category) %>%
  summarise(total_days = sum(days_elapsed, na.rm = TRUE))

# Creamos la visualización
ggplot(result, aes(x = factor(category), y = total_days, fill = factor(category))) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("1" = "red", "2" = "green", "3" = "blue", 
                               "4" = "skyblue", "5" = "yellow", "6" = "orange"),
                    labels = c("1" = "Web Scraping", 
                               "2" = "Web Development", 
                               "3" = "Summary", 
                               "4" = "Email Automation", 
                               "5" = "Flask", 
                               "6" = "Automation"),
                    name = "Categoría") +  
  labs(title = "Total de Días Dedicados Por Categoría", x = "Categoría", y = "Días Dedicados") +
  theme_minimal()