
# News & Text Mining

## Descripcion

Esta aplicacion esta diseñada para realizar Scraping a varios medios de comunicacion en Colombia, el objetivo de esto es:

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

1. Realizar Scraping a cada uno de los medios y se consolida una base de datos.
2. Preprocesamiento de la base de datos, generalmente el texto queda descargado con simbolos del lenguaje HTML y estos deben ser removidos
3. Se cuentan las palabras mas frecuentes y se realiza una *WordCloud* con los terminos mas significativos
4. Luego se analizan bi-gramas (secuencias de dos palabras), con estos se construye un grafo dirigido que muestra las frases mas relevantes.

