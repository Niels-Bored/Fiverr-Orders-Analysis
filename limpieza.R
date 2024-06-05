dataset <- read.csv("completed_orders.csv")

library(dplyr)

#Eliminamos las columnas innecesarias
dataset <- dataset[, !names(dataset) %in% c("order_link", "includes")]

for (col in names(dataset)) {
  if (is.character(dataset[[col]])) {
    dataset[[col]] <- tolower(dataset[[col]])
  }
}

# Reemplazar los valores "" con NA en la columna 'description' y 'includes'
dataset$description <- ifelse(dataset$description == "", NA, dataset$description)

# Reemplazar los valores 0 por NA en la columna stars
dataset$stars[dataset$stars == 0] <- NA

# Categorizamos las ordenes con base en el gig
gig_to_category <- c("do web automation bot" = 1, 
                     "do a script for web scraping, data mining from website" = 1, 
                     "create your web page  fast, responsive, contact forms, animations, customization" = 2, 
                     "do web scraping, data mining any website" = 1, 
                     "convert design to website with hosting and domain" = 2, 
                     "do web scraping or web automation and save data in excel, csv, json or database" = 1, 
                     "provide a consultation video call and written summary" = 3, 
                     "create your web page, with hosting and domain, fast, responsive, animations" = 2, 
                     "create a script for extract data from any page" = 1, 
                     "do script for email automation" = 4, 
                     "create a python flask api or project" = 5, 
                     "create a react web app with boostrap, sass and online payments paypal or stripe" = 2, 
                     "create your web page" = 2, 
                     "extract tweets and save in csv or excel filtering by name or tags or keywords" = 1, 
                     "create your landing page" = 2, 
                     "create your landing page, with hosting and domain" = 2, 
                     "do script for processing csv and json data files" = 5, 
                     "do desktop program for automation like web scraping, email, json, csv, excel etc" = 1, 
                     "do simple python script" = 6
                     )

# Añadimos la columna category basada en la categoría del gig
dataset$category <- gig_to_category[dataset$gig]

dataset$date_ordered <- as.Date(dataset$date_ordered, format = "%d/%m/%Y")
dataset$date_end <- as.Date(dataset$date_end, format = "%d/%m/%Y")

# Definir la fecha de corte
cutoff_date <- as.Date("2023-05-31")

# Filtrar el dataframe
dataset <- dataset %>%
  filter(date_ordered > cutoff_date)
dataset <- dataset %>%
  filter(date_end > cutoff_date)

write.csv(dataset, "clean_data.csv", row.names = FALSE)
