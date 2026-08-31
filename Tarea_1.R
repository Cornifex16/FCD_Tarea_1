# filtrado inicial de paises y exportacion a csv
datos_originales <- read.csv("./encuesta_aspiraciones_2026 3.csv")

paises_filtrados <- subset(datos_originales, pais %in% c("India", "Suecia"))

cat("Filas originales:", nrow(datos_originales), "\n")
cat("Filas filtradas:", nrow(paises_filtrados), "\n")

write.csv(paises_filtrados, file = "./paises_filtrados.csv", row.names = FALSE)

# Seccion 2: Datos Faltantes

# Cargar datos filtrados
datos <- read.csv("./paises_filtrados.csv")

# 1. Resumen general de valores faltantes
cat("=== RESUMEN DE VALORES FALTANTES ===\n")
total_faltantes <- sum(is.na(datos))
cat("Total de valores NA en el dataset:", total_faltantes, "\n")

obs_con_faltantes <- sum(rowSums(is.na(datos)) > 0)
cat("Observaciones con al menos un NA:", obs_con_faltantes, "de", nrow(datos), "(", round(obs_con_faltantes/nrow(datos)*100, 2), "%)\n\n")

# 2. Faltantes por columna
faltantes_por_col <- sapply(datos, function(x) sum(is.na(x)))
faltantes_por_col <- faltantes_por_col[faltantes_por_col > 0]
faltantes_por_col <- sort(faltantes_por_col, decreasing = TRUE)

cat("=== FALTANTES POR COLUMNA ===\n")
for (col in names(faltantes_por_col)) {
  pct <- round(faltantes_por_col[col] / nrow(datos) * 100, 2)
  cat(sprintf("%-35s: %6d (%.2f%%)\n", col, faltantes_por_col[col], pct))
}

# 3. Variable con mayor proporción de faltantes
if (length(faltantes_por_col) > 0) {
  var_max <- names(faltantes_por_col)[1]
  cat("\n=== VARIABLE CON MÁS FALTANTES ===\n")
  cat("Variable:", var_max, "\n")
  cat("Faltantes:", faltantes_por_col[1], "(", round(faltantes_por_col[1]/nrow(datos)*100, 2), "%)\n")
}

# 4. Patrones de faltantes (combinaciones)
library(naniar)
if (requireNamespace("naniar", quietly = TRUE)) {
  cat("\n=== PATRONES DE FALTANTES (naniar) ===\n")
  print(miss_var_summary(datos))
  
  # Matriz de patrones
  patrones <- miss_case_table(datos)
  cat("\nTabla de patrones de faltantes por observación:\n")
  print(patrones)
}

# 5. Análisis de faltantes en variables de expectativa (posibles faltantes estructurales)
# Las variables expectativa_* y sentimiento_si_no_* solo aplican si ocurrio_* == "No"
vars_expectativa <- grep("^expectativa_", names(datos), value = TRUE)
vars_ocurrio <- grep("^ocurrio_", names(datos), value = TRUE)

cat("\n=== ANÁLISIS ESTRUCTURAL: EXPECTATIVAS ===\n")
for (var_exp in vars_expectativa) {
  hito <- gsub("expectativa_", "", var_exp)
  var_oc <- paste0("ocurrio_", hito)
  
  if (var_oc %in% names(datos)) {
    # Casos donde ocurrió = Sí pero expectativa tiene valor (debería ser NA estructural)
    casos_inconsistentes <- sum(!is.na(datos[[var_exp]]) & datos[[var_oc]] == "Sí", na.rm = TRUE)
    # Casos donde ocurrió = No pero expectativa es NA (faltante real)
    casos_faltantes_reales <- sum(is.na(datos[[var_exp]]) & datos[[var_oc]] == "No", na.rm = TRUE)
    
    if (casos_inconsistentes > 0 || casos_faltantes_reales > 0) {
      cat(sprintf("%s: %d inconsistentes (ocurrió=Sí con expectativa), %d faltantes reales (ocurrió=No sin expectativa)\n", 
                  hito, casos_inconsistentes, casos_faltantes_reales))
    }
  }
}

# 6. Faltantes por país
cat("\n=== FALTANTES POR PAÍS ==\n")
faltantes_pais <- aggregate(rowSums(is.na(datos)), by = list(datos$pais), FUN = mean)
names(faltantes_pais) <- c("pais", "promedio_faltantes_por_obs")
print(faltantes_pais)

# 7. Faltantes por generación
cat("\n=== FALTANTES POR GENERACIÓN ==\n")
faltantes_gen <- aggregate(rowSums(is.na(datos)), by = list(datos$generacion), FUN = mean)
names(faltantes_gen) <- c("generacion", "promedio_faltantes_por_obs")
print(faltantes_gen)

# 8. Visualización de patrones (requiere naniar y ggplot2)
if (requireNamespace("naniar", quietly = TRUE) && requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
  
  # Heatmap de faltantes
  p1 <- gg_miss_var(datos) + 
    labs(title = "Valores faltantes por variable") +
    theme_minimal()
  ggsave("faltantes_por_variable.png", p1, width = 10, height = 6)
  
  # Mapa de calor de patrones
  p2 <- gg_miss_upset(datos) + 
    labs(title = "Combinaciones de variables con faltantes")
  ggsave("patrones_faltantes_upset.png", p2, width = 10, height = 6)
  
  cat("\nGráficos guardados: faltantes_por_variable.png, patrones_faltantes_upset.png\n")
}

