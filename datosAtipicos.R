library(tidyverse)
datos <- read.csv("paises_filtrados.csv")

boxplot(datos$ingreso_anual, 
        main = "Diagrama de Caja - Ingreso Anual", 
        ylab = "Ingreso Anual", 
        col = "lightblue",
        border = "darkblue")

Q1 <- quantile(datos$ingreso_anual, 0.25, na.rm = TRUE)
Q3 <- quantile(datos$ingreso_anual, 0.75, na.rm = TRUE)
IQR_val <- Q3 - Q1

limite_inferior <- Q1 - 1.5 * IQR_val
limite_superior <- Q3 + 1.5 * IQR_val

outliers_iqr <- datos[which(datos$ingreso_anual < limite_inferior | datos$ingreso_anual > limite_superior), 
                       c("id_encuestado", "pais", "generacion", "ingreso_anual")]
 
# outliers_iqr <- datos[datos$ingreso_anual < limite_inferior | datos$ingreso_anual > limite_superior, 
#                   c("id_encuestado","pais","generacion","ingreso_anual")]
# AHI REVISO  ( PERO ATIPIVO LITO)

cat("Límite Superior: ", limite_superior)
cat("Límite Inferior: ", limite_inferior)
cat("ATÍPICOS IDENTIFICADOS")
print(outliers_iqr)