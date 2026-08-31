# filtrado inicial de paises y exportacion a csv
paises <- read.csv("./encuesta_aspiraciones_2026 3.csv")

paises_filtrados <- subset(paises, paises$continente == "India" | paises$continente == "Suecia")

write.csv(paises_filtrados, file = "./paises_filtrados.csv", row.names = FALSE)