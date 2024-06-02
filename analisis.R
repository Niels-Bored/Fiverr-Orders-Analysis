dataset <- read.csv("completed_orders.csv")

# Calculo de frecuencias de los datos de cada columna

frecuencias <- list()

for (columna in names(dataset)) {
  frecuencia <- table(dataset[[columna]])
  frecuencias[[columna]] <- frecuencia
}

for (columna in names(frecuencias)) {
  if(columna != "order_link" & columna != "includes"){
    cat("Column:", columna, "\n")
    print(frecuencias[[columna]])
    cat("\n")    
  }
}

library(dplyr)

# Contar los NA por columna
nas_por_columna <- dataset %>%
summarise_all(~ sum(is.na(.)))

print(nas_por_columna)

# Verificar si alguna columna contiene cadenas vacías
columnas_con_cadenas_vacias <- sapply(dataset, function(col) any(col == "", na.rm = TRUE))

columnas_con_cadenas_vacias <- names(columnas_con_cadenas_vacias[columnas_con_cadenas_vacias])

print(columnas_con_cadenas_vacias)

# Verificar los tipos de datos de cada columna

unique_classes <- function(column) {
  unique(sapply(column, class))
}

tipos_de_datos_por_columna <- lapply(dataset, unique_classes)

print(tipos_de_datos_por_columna)