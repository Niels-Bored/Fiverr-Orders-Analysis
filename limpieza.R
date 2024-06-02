dataset <- read.csv("completed_orders.csv", sep=";")

dataset <- dataset[, !(names(dataset) %in% c("buyer", "order_link", "includes"))]

for (col in names(dataset)) {
  if (is.character(dataset[[col]])) {
    dataset[[col]] <- tolower(dataset[[col]])
  }
}

# Reemplazar los valores "" con NA en la columna 'description' y 'includes'
dataset$description <- ifelse(dataset$description == "", NA, dataset$description)
dataset$includes <- ifelse(dataset$includes == "", NA, dataset$includes)
# Reemplazar los valores 0 por NA en la columna stars
dataset$stars[dataset$stars == 0] <- NA


write.csv(dataset, "clean_data.csv", row.names = FALSE)
