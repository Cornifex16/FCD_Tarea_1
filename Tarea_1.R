# filtrado inicial de paises y exportacion a csv
datos_originales <- read.csv("./encuesta_aspiraciones_2026 3.csv")

paises_filtrados <- subset(datos_originales, pais %in% c("India", "Suecia"))

cat("Filas originales:", nrow(datos_originales), "\n")
cat("Filas filtradas:", nrow(paises_filtrados), "\n")

write.csv(paises_filtrados, file = "./paises_filtrados.csv", row.names = FALSE)

# Seccion 2: Datos Faltantes

# Cargar datos filtrados
datos <- read.csv("./paises_filtrados.csv")

# Vision general: total y observaciones afectadas
total_na <- sum(is.na(datos))
obs_con_na <- sum(rowSums(is.na(datos)) > 0)
cat("Total NA:", total_na, "| Obs con NA:", obs_con_na, "/", nrow(datos), "\n")

# Vision general: tabla de faltantes por variable
na_col <- sort(colSums(is.na(datos)), decreasing = TRUE)
na_col <- na_col[na_col > 0]
print(data.frame(Variable = names(na_col), Faltantes = na_col, Porcentaje = round(na_col/nrow(datos)*100, 2)))

# Vision general: variable con mas faltantes
cat("\n--- Variable con mas faltantes ---\n")
cat(names(na_col)[1], ":", na_col[1], "(", round(na_col[1]/nrow(datos)*100, 2), "%)\n")

# Vision general: faltantes estructurales en expectativa_* (solo aplica si ocurrio == "No")
cat("\n--- Faltantes estructurales vs reales (expectativa) ---\n")
for (v in grep("^expectativa_", names(datos), value = TRUE)) {
  hito <- sub("expectativa_", "", v)
  oc <- paste0("ocurrio_", hito)
  if (oc %in% names(datos)) {
    estructural <- sum(!is.na(datos[[v]]) & datos[[oc]] == "Sí", na.rm = TRUE)
    reales <- sum(is.na(datos[[v]]) & datos[[oc]] == "No", na.rm = TRUE)
    if (estructural > 0 || reales > 0) {
      cat(hito, ": estructurales=", estructural, " reales=", reales, "\n")
    }
  }
}

# Vision general: por pais
cat("\n--- Faltantes por pais (promedio NA/obs) ---\n")
print(aggregate(rowSums(is.na(datos)), list(datos$pais), mean))

# Vision general: por generacion
cat("\n--- Faltantes por generacion (promedio NA/obs) ---\n")
print(aggregate(rowSums(is.na(datos)), list(datos$generacion), mean))

