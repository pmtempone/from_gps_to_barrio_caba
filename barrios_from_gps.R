# Cargamos librerias

library(ggmap)
library(maptools)
library(rgeos)
library(sp)
library(rgdal)

wa.map <- readOGR("barrios_badata.shp")

# Loop para el listado de domicilios sin barrio

for (i in 1:nrow(base)) {
  
  print(i) # para conocer el intento
  temp <- getGeoCode(paste(base$domicilio[i],',CABA'))
  
  if (complete.cases(temp)==TRUE){
  
  temp <- data.frame(t(temp))
  
  dat <- data.frame(cbind(test$lon,test$lat))
  
  coordinates(dat) <- dat
  #conversión a mismo tipo númerico de coordenada
  proj4string(dat) <- CRS("+init=epsg:4326") # WGS 84
  
  dat <- tryCatch({X =spTransform(dat,CRSobj = wa.map@proj4string)},
           error=function(e) {e='nada'}) #por si devuelve nulo y evitar el corte del loop
  if (typeof(dat)!='character'){
    matcheo <- over(dat, wa.map)
    
    base$BARRIOS[i] <- as.character(matcheo$BARRIO)
    base$COMUNA[i] <- as.character(matcheo$COMUNA)
  }
  #proj4string(dat) <- proj4string(wa.map)
  
  
  }
  
}
