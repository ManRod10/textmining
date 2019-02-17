---
title: "Text Mining"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Descripcion

Esta aplicacion esta diseñada para realizar Scraping a las paginas web de varios medios de comunicacion en Colombia, con un objetivos fundamentales:

* Extraer informacion que permita conocer de manera rapida, de que hablan los medios de comunicacion en Colombia

## Medios de Comunicacion

Se toma informacion de las secciones de economia de los siguientes diarios:

* El Espectador 
* El Tiempo
* Semana
* Caracol
* La Republica
* El Pais

## Algoritmo 

Los pasos necesarios para realizar el analisis de las noticias, se pueden resumir en cuatro grandes bloques 

1. Realizar Scraping a cada una las paginas web de los distintos medios y consolidacion de la base de datos.
2. Preprocesamiento de los datos, generalmente el texto queda descargado con simbolos del lenguaje HTML y estos deben ser removidos
3. Se cuentan las palabras mas frecuentes y se realiza una *WordCloud* con los terminos mas significativos
4. Luego se analizan bi-gramas (secuencias de dos palabras), con estos se construye un grafo dirigido que muestra las frases mas relevantes.

