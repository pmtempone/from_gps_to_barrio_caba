# from_gps_to_barrio_caba

Como saber si una coordenada entra dentro del territorio de un barrio en CABA.

El objetivo es buscar una dirección en google maps, obtener las coordenadas y generar información de a que barrio corresponde.

## Datos de los barrios

Se obtienen del siguiente link: https://data.buenosaires.gob.ar/dataset/barrios

## Datos del shapefile de barrios

Las coordenadas de los  polígonos tienen otro tipo de numeración, por lo que dentro del loop se agrega un paso para la conversión a la misma escala y que permita ubicarlos en el mapa.


