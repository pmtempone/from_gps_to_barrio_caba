# Cargamos librerias

library(ggmap)
library(maptools)
library(rgeos)
library(sp)
library(rgdal)

# Loop para el listado de domicilios sin barrio

for (i in 1:nrow(empresas_caba_sin_barrio)) {
  
  print(i) # para conocer el intento
  test <- getGeoCode(paste(empresas_caba_sin_barrio$Dire_Fiscal[i],',CABA'))
  
  if (complete.cases(test)==TRUE){
  
  test <- data.frame(t(test))
  
  dat <- data.frame(cbind(test$lon,test$lat))
  
  coordinates(dat) <- dat
  #conversión a mismo tipo númerico de coordenada
  proj4string(dat) <- CRS("+init=epsg:4326") # WGS 84
  
  dat <- tryCatch({X =spTransform(dat,CRSobj = wa.map@proj4string)},
           error=function(e) {e='nada'}) #por si devuelve nulo y evitar el corte del loop
  if (typeof(dat)!='character'){
    matcheo <- over(dat, wa.map)
    
    empresas_caba_sin_barrio$BARRIOS[i] <- as.character(matcheo$BARRIO)
    empresas_caba_sin_barrio$COMUNA[i] <- as.character(matcheo$COMUNA)
  }
  #proj4string(dat) <- proj4string(wa.map)
  
  
  }
  
}
