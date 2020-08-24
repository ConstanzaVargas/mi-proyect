# https://code.earthengine.google.com/fa94ca9713774f9cd9834de89d53d98d buffer

#Initialize Earth Engine
library(rgee)
ee_check()
ee_Initialize()

#Colores
colores <- list(palette = c("#d73027", "#f46d43", "#fdae61","#fee08b", "#d9ef8b", "#a6d96a","#66bd63", "#1a9850"))

#Importar poligonos
la_paciencia = ee$FeatureCollection("users/practico1/la-paciencia")
drenaje_paciencia = ee$FeatureCollection("users/practico1/drenajelapaciencia")

paciencia = Map$addLayer(la_paciencia, colores, name="La Paciencia")
drenaje = Map$addLayer(drenaje_paciencia, name="Cursos de agua en La Paciencia")
drenaje+paciencia

Map$centerObject(la_paciencia, 9)  # cual es la diferencia con Map$setCenter(la_paciencia,12)  ?
                                   # punto la paciencia(-68.97310412129922,-54.33102639556196)
                                   # Map$setCenter(c(-68.97310412129922,-54.33102639556196)) #NOTE: Center obtained from the first element.
#Importar hansen
hansen2019 = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")
hansen2017 = ee$Image("UMD/hansen/global_forest_change_2017_v1_5")
hansen2016 = ee$Image("UMD/hansen/global_forest_change_2016_v1_4")
hansen2015 = ee$Image("UMD/hansen/global_forest_change_2015_v1_3")

Map$addLayer(hansen$clip(la_paciencia), name="Capa Hansen en La Paciencia 2019")+drenaje

lossyear = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")$select("lossyear")
lossyear1 = Map$addLayer(lossyear$clip(la_paciencia),colores,name="Pérdida forestal en La Paciencia")

#Calculo del NDVI inicial y final
NDVI2000 = (hansen2019$clip(la_paciencia))$normalizedDifference (c("first_b40","first_b30"))
NDVI2019 = (hansen2019$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2017 = (hansen2017$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2016 = (hansen2016$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2015 = (hansen2015$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))

m2019 = Map$addLayer(NDVI2019, colores, "NDVI 2019")
m2017 = Map$addLayer(NDVI2017, colores, "NDVI 2017")
m2016 = Map$addLayer(NDVI2016, colores, "NDVI 2016")
m2015 = Map$addLayer(NDVI2015, colores, "NDVI 2015")
m2000 = Map$addLayer(NDVI2000, colores, "NDVI 2000")

m2019+m2017+m2016+m2015+m2000+drenaje+lossyear1

#o Map$addLayer(NDVI2019, colores, "NDVI 2019")+Map$addLayer(NDVI2017, colores, "NDVI 2017")+Map$addLayer(NDVI2016, colores, "NDVI 2016")+Map$addLayer(NDVI2015, colores, "NDVI 2015")+Map$addLayer(NDVI2000, colores, "NDVI 2000")


# https://code.earthengine.google.com/fa94ca9713774f9cd9834de89d53d98d buffer

#Initialize Earth Engine
library(rgee)
ee_check()
ee_Initialize()

#Colores
colores <- list(palette = c("#d73027", "#f46d43", "#fdae61","#fee08b", "#d9ef8b", "#a6d96a","#66bd63", "#1a9850"))

#Importar poligonos
la_paciencia = ee$FeatureCollection("users/practico1/la-paciencia")
drenaje_paciencia = ee$FeatureCollection("users/practico1/drenajelapaciencia")

paciencia = Map$addLayer(la_paciencia, colores, name="La Paciencia")
drenaje = Map$addLayer(drenaje_paciencia, name="Cursos de agua en La Paciencia")
drenaje+paciencia

DEM=ee$Image("USGS/SRTMGL1_003")     #duda, preguntar cómo hacer que salga con los colores de elevación, min= -10 max=6500
vis_params <- list(
  min = 0,
  max = 3000, 
  palette = c(
    "141414", "383838", "808080", "EBEB8F", "F7D311", "AA0000", "D89382",
    "DDC9C9", "DCCDCE", "1C6330", "68AA63", "B5C98E", "E1F0E5", "a975ba",
    "6f198c"
  )
)

Map$addLayer(DEM$clip(la_paciencia), vis_params, "DEM")


Map$centerObject(la_paciencia, 9)  # cual es la diferencia con Map$setCenter(la_paciencia,12)  ?
# punto la paciencia(-68.97310412129922,-54.33102639556196)
# Map$setCenter(c(-68.97310412129922,-54.33102639556196)) #NOTE: Center obtained from the first element.

#Importar hansen
hansen2019 = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")
hansen2017 = ee$Image("UMD/hansen/global_forest_change_2017_v1_5")
hansen2016 = ee$Image("UMD/hansen/global_forest_change_2016_v1_4")
hansen2015 = ee$Image("UMD/hansen/global_forest_change_2015_v1_3")

Map$addLayer(hansen$clip(la_paciencia), name="Capa Hansen en La Paciencia 2019")+drenaje

lossyear = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")$select("lossyear")
lossyear1 = Map$addLayer(lossyear$clip(la_paciencia),colores,name="Pérdida forestal en La Paciencia")

#Calculo del NDVI inicial y final
NDVI2000 = (hansen2019$clip(la_paciencia))$normalizedDifference (c("first_b40","first_b30"))
NDVI2019 = (hansen2019$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2017 = (hansen2017$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2016 = (hansen2016$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2015 = (hansen2015$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))

m2019 = Map$addLayer(NDVI2019, colores, "NDVI 2019")
m2017 = Map$addLayer(NDVI2017, colores, "NDVI 2017")
m2016 = Map$addLayer(NDVI2016, colores, "NDVI 2016")
m2015 = Map$addLayer(NDVI2015, colores, "NDVI 2015")
m2000 = Map$addLayer(NDVI2000, colores, "NDVI 2000")

m2019+m2017+m2016+m2015+m2000+drenaje+lossyear1

# https://code.earthengine.google.com/fa94ca9713774f9cd9834de89d53d98d buffer

#Initialize Earth Engine
library(rgee)
ee_check()
ee_Initialize()

#Colores
colores <- list(palette = c("#d73027", "#f46d43", "#fdae61","#fee08b", "#d9ef8b", "#a6d96a","#66bd63", "#1a9850"))

#Importar poligonos
la_paciencia = ee$FeatureCollection("users/practico1/la-paciencia")
drenaje_paciencia = ee$FeatureCollection("users/practico1/drenajelapaciencia")

paciencia = Map$addLayer(la_paciencia, colores, name="La Paciencia")
drenaje = Map$addLayer(drenaje_paciencia, name="Cursos de agua en La Paciencia")
drenaje+paciencia

Map$centerObject(la_paciencia, 9)  # cual es la diferencia con Map$setCenter(la_paciencia,12)  ?
# punto la paciencia(-68.97310412129922,-54.33102639556196)
# Map$setCenter(c(-68.97310412129922,-54.33102639556196)) #NOTE: Center obtained from the first element.
#Importar hansen
hansen2019 = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")
hansen2017 = ee$Image("UMD/hansen/global_forest_change_2017_v1_5")
hansen2016 = ee$Image("UMD/hansen/global_forest_change_2016_v1_4")
hansen2015 = ee$Image("UMD/hansen/global_forest_change_2015_v1_3")

Map$addLayer(hansen$clip(la_paciencia), name="Capa Hansen en La Paciencia 2019")+drenaje

lossyear = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")$select("lossyear")
lossyear1 = Map$addLayer(lossyear$clip(la_paciencia),colores,name="Pérdida forestal en La Paciencia")

#Calculo del NDVI inicial y final
NDVI2000 = (hansen2019$clip(la_paciencia))$normalizedDifference (c("first_b40","first_b30"))
NDVI2019 = (hansen2019$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2017 = (hansen2017$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2016 = (hansen2016$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))
NDVI2015 = (hansen2015$clip(la_paciencia))$normalizedDifference (c("last_b40","last_b30"))

m2019 = Map$addLayer(NDVI2019, colores, "NDVI 2019")
m2017 = Map$addLayer(NDVI2017, colores, "NDVI 2017")
m2016 = Map$addLayer(NDVI2016, colores, "NDVI 2016")
m2015 = Map$addLayer(NDVI2015, colores, "NDVI 2015")
m2000 = Map$addLayer(NDVI2000, colores, "NDVI 2000")

m2019+m2017+m2016+m2015+m2000+drenaje+lossyear1



getNDVI <- function(image) {
  (image$clip(la_paciencia))$normalizedDifference(c("last_b40","last_b30"))$rename('NDVI')
}



hansen_ndvi= (hansen$clip(la_paciencia))$map(getNDVI)





#Buffer drenaje en loss year
buffered = drenaje_paciencia$map(function(f) f$buffer(1000)) #Muestra loss year en la paciencia dentro de 1 km de un drenaje
Map$addLayer(buffered, list(color = 'b0b0b0'), "drenaje_paciencia")+lossyear1+Map$addLayer(drenaje_paciencia, name="Cursos de agua en La Paciencia")

join_filter = ee$Filter$withinDistance(1000, '.geo', NULL, '.geo')

close_lossyear = ee$Join$simple()$apply(lossyear, drenaje_paciencia, join_filter)


Map$addLayer(close_lossyear, list(color = '008000'), "lossyear")














#Parametrizamos el timelapse con proyección, resolución, AOI, valores de pixel y frames/seg
Timelapse = {
  crs: 'EPSG:4326',
  dimensions: '600',
  region: ZonaAOI,
  min: 0,
  max: 3000,
  palette: 'ffffff, fcd163, 99b718, 66a000, 3e8601, 207401, 056201, 004c00, 011301',
  framesPerSecond: 5,}

#Creamos la animación con la colección de imagenes y parámetros del timelapses
Animacion = ui.Thumbnail({
  image: IndiceEVI 
  params: Timelapse,
  style: {
    position: 'bottom-right', 
    width: '300px'}})
Map.add(Animacion)

##Adicionalmente visualizamos una imagen compuesta del timelapse sobre el visor
MODIS_Composicion = ee.Image(IndiceEVI .median());
Map.addLayer (MODIS_Composicion, {
  min: 0,
  max: 3000,
  palette: 'ffffff, fcd163, 99b718, 66a000, 3e8601, 207401, 056201, 004c00, 011301',
  bands: ['EVI']}, 
  'Indice EVI');




getNDVI <- function(image) {
  (image$clip(la_paciencia))$normalizedDifference(c("last_b40","last_b30"))$rename('NDVI')
}



hansen_ndvi= (hansen$clip(la_paciencia))$map(getNDVI)





#Buffer drenaje en loss year
buffered = drenaje_paciencia$map(function(f) f$buffer(1000)) #Muestra loss year en la paciencia dentro de 1 km de un drenaje
Map$addLayer(buffered, list(color = 'b0b0b0'), "drenaje_paciencia")+lossyear1+Map$addLayer(drenaje_paciencia, name="Cursos de agua en La Paciencia")

join_filter = ee$Filter$withinDistance(1000, '.geo', NULL, '.geo')

close_lossyear = ee$Join$simple()$apply(lossyear, drenaje_paciencia, join_filter)


Map$addLayer(close_lossyear, list(color = '008000'), "lossyear")














#Parametrizamos el timelapse con proyección, resolución, AOI, valores de pixel y frames/seg
Timelapse = {
  crs: 'EPSG:4326',
  dimensions: '600',
  region: ZonaAOI,
  min: 0,
  max: 3000,
  palette: 'ffffff, fcd163, 99b718, 66a000, 3e8601, 207401, 056201, 004c00, 011301',
  framesPerSecond: 5,}

#Creamos la animación con la colección de imagenes y parámetros del timelapses
Animacion = ui.Thumbnail({
  image: IndiceEVI 
  params: Timelapse,
  style: {
    position: 'bottom-right', 
    width: '300px'}})
Map.add(Animacion)

##Adicionalmente visualizamos una imagen compuesta del timelapse sobre el visor
MODIS_Composicion = ee.Image(IndiceEVI .median());
Map.addLayer (MODIS_Composicion, {
  min: 0,
  max: 3000,
  palette: 'ffffff, fcd163, 99b718, 66a000, 3e8601, 207401, 056201, 004c00, 011301',
  bands: ['EVI']}, 
  'Indice EVI');




getNDVI <- function(image) {
  (image$clip(la_paciencia))$normalizedDifference(c("last_b40","last_b30"))$rename('NDVI')
}



hansen_ndvi= (hansen$clip(la_paciencia))$map(getNDVI)





#Buffer drenaje en loss year
buffered = drenaje_paciencia$map(function(f) f$buffer(1000)) #Muestra loss year en la paciencia dentro de 1 km de un drenaje
Map$addLayer(buffered, list(color = 'b0b0b0'), "drenaje_paciencia")+lossyear1+Map$addLayer(drenaje_paciencia, name="Cursos de agua en La Paciencia")

join_filter = ee$Filter$withinDistance(1000, '.geo', NULL, '.geo')

close_lossyear = ee$Join$simple()$apply(lossyear, drenaje_paciencia, join_filter)


Map$addLayer(close_lossyear, list(color = '008000'), "lossyear")














#Parametrizamos el timelapse con proyección, resolución, AOI, valores de pixel y frames/seg
Timelapse = {
  crs: 'EPSG:4326',
  dimensions: '600',
  region: ZonaAOI,
  min: 0,
  max: 3000,
  palette: 'ffffff, fcd163, 99b718, 66a000, 3e8601, 207401, 056201, 004c00, 011301',
  framesPerSecond: 5,}

#Creamos la animación con la colección de imagenes y parámetros del timelapses
Animacion = ui.Thumbnail({
  image: IndiceEVI 
  params: Timelapse,
  style: {
    position: 'bottom-right', 
    width: '300px'}})
Map.add(Animacion)

##Adicionalmente visualizamos una imagen compuesta del timelapse sobre el visor
MODIS_Composicion = ee.Image(IndiceEVI .median());
Map.addLayer (MODIS_Composicion, {
  min: 0,
  max: 3000,
  palette: 'ffffff, fcd163, 99b718, 66a000, 3e8601, 207401, 056201, 004c00, 011301',
  bands: ['EVI']}, 
  'Indice EVI');

