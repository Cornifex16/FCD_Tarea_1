# Tarea 1 - FCD

Este repositorio tiene los codigos de R usados para resolver la tarea. Ademas este readme cumple el rol de facilitar la vision de la informacion obtenida.

Asignacion de paises:

- **India**
- **Suecia**

## Secciones

1. [Datos faltantes](#datos-faltantes)
1. [Datos atipicos](#datos-atipicos)
1. [Variables cualitativas](#distribucion-de-variables-cualitativas)
    1. [Distribucion de variables cualitativas](#distribucion-de-variables-cualitativas)
    1. [Distribucion conjunta de variables cualitativas](#distribucion-conjunta-de-variables-cualitativas)
1. [Variables cuantitativas](#distribucion-de-variables-cuantitativas)
    1. [Distribucion de variables cuantitativas](#distribucion-de-variables-cuantitativas)
    1. [Distribucion por grupos de variables cuantitativas](#distribucion-por-grupos-de-variables-cuantitativas)
    1. [Distribucion conjunta de variables cuantitativas](#distribucion-conjunta-de-variables-cuantitativas)
    1. [Correlacion de variables cuantitativas](#correlacion-de-variables-cuantitativas)
1. [Analisis de componentes Principales](#analisis-de-componentes-principales)
1. [Interpretacion de analisis de componentes principales](#interpretacion-de-analisis-de-componentes-principales)

## Datos faltantes

Despues de filtrar los datos por los paises obtenemos que hay un total 4400 de datos en el archivo.

El total de NA fue: 1135.
El total de filas con al menos un NA: 1039

De estos las variables que contienen NA son las siguientes:

| Variable | Faltantes | Porcentaje |
| ---- | ---- | ---- |
| idx_expectativa_global | 860 | 19.55%|
| idx_satisfaccion_vida | 179 | 4.07% |
| ingreso anual | 96 | 2.18% |

Notar que la variable con mas datos faltantes es el indice de expectativa global, esto puede deberse a como esta armada la entrevista. Por enunciado se indica que ese campo es "porcentaje de hitos pendientes e importantes con expectativa alta", por lo que es posible que no se rellene debido a que no hay hitos pendientes o importantes o que tienen expectativa baja. Esto se describe como una falta estructural.

Evaluando todas las expectativas se puede notar que todos los errores son estructurales:

| Hito | estructurales | reales |
| ---- | ---- | ---- |
| trabajo | 1850 | 0 |
| vivienda propia | 1278 | 0 |
| vida independiente | 1865 | 0 |
| ser padre | 1077 | 0 |
| casarse | 1055 | 0 |
| mascota | 1795 | 0 |

El promedio de NA obtenidos por pais es:

| Pais | NA Promedio |
| ---- | ---- |
| India | 0.290 |
| Suecia | 0.226 |

El promedio de NA obtenidos por generacion es:

| Generacion | NA promedio |
| ---- | ---- |
| Baby Boomer | 0.372 |
| Gen X | 0.289 |
| Gen Z | 0.160 |
| Millenial | 0.212 |

## Datos atipicos

*Under Construction*

## Distribucion de variables cualitativas

*Under Construction*

## Distribucion conjunta de variables cualitativas

*Under Construction*

## Distribucion de variables cuantitativas

*Under Construction*

## Distribucion por grupos de variables cuantitativas

*Under Construction*

## Distribucion conjunta de variables cuantitativas

*Under Construction*

## Correlacion de variables cuantitativas

*Under Construction*

## Analisis de componentes principales

*Under Construction*

## Interpretacion de analisis de componentes principales 

*Under Construction*