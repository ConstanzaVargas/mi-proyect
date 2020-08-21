remotes::install_github("r-spatial/rgee")
library(rgee)
install.packages(rgee)
#Solo es necesario una vez
ee_install()
Y

Y


#Initialize Earth Engine
library(rgee)
ee_Initialize()

#Definir centro de la imagen
point = ee$Geometry$Point(c(-69.14696311910278,-54.18051554071887))

Map$addLayer(point)
Map$centerObject(point,12)

geometry = ee$Geometry$Polygon(
  coords = list(
    c(-69.19331169088012, -54.168458345642335),
    c(-69.19331169088012, -54.21746902624868),
    c(-69.13220024068481, -54.21746902624868),
    c(-69.13220024068481, -54.168458345642335)))

Map$addLayer(geometry)
Map$addLayer(geometry, name="Poligono")
Map$addLayer(point, name="Poligono")

S2_collection = ee$ImageCollection('COPERNICUS/S2_SR')$filterBounds(geometry)$sort('system:time_start', FALSE)
S2_img = S2_collection$first()

Map$addLayer(S2_img$clip(geometry), list(bands = c("B8","B3","B2"), min = 0, max = 3000), "imagen S2")

S2_collection = ee$ImageCollection('COPERNICUS/S2_SR')$filterBounds(geometry)$sort('system:time_start',FALSE)

S2_collection_cloudfilt10 = S2_collection$filter(ee$Filter$lt('CLOUDY_PIXEL_PERCENTAGE',10))
S2_img_filter = S2_collection_cloudfilt10$first()
Map$addLayer(S2_img_filter, list(bands = c("B4","B3","B2"), min = 0, max = 3000), "imagen S2")

#funciones
olaketal = function(x) {
  suma = x+1
  return(suma)
}
olaketal(7)

mascara_S2 = function (image) {
  cloud_mask = image$select("MSK_CLDPRB")
  cloud_mask_bin=cloud_mask$lte(1) #mascaras con 1% de probabilidad de nubes o más
  apply_mask = image$updateMask(cloud_mask_bin)
}


S2_collection_cloudfilt10_mask = S2_collection_cloudfilt10$map(mascara_S2)
S2_img_masked = S2_collection_cloudfilt10_mask$first()
Map$addLayer(S2_img_masked, list(bands = c("B4","B3","B2"), min = 0, max = 3000), "imagen S2")

S2_mosaic_masked = S2_collection_cloudfilt10_mask$mosaic()
Map$addLayer(S2_mosaic_masked, list(bands = c("B4","B3","B2"), min = 0, max = 3000), "imagen S2")



#Calcular NDVI para la imagen mosaico
#(B8-B4)/(B8+B4)

Map$addLayer(S2_mosaic_masked, list(bands = c("B4","B3","B2"), min = 0, max = 3000), "imagen S2")
NDVI = S2_mosaic_masked$normalizedDifference(c("B8", "B4"))

ndviParams <- list(palette = c(
  "#d73027", "#f46d43", "#fdae61",
  "#fee08b", "#d9ef8b", "#a6d96a",
  "#66bd63", "#1a9850"
))

Map$addLayer(NDVI, ndviParams, "NDVI")


#imagen enmascarada antes del mosaico, la de la mascara de nubes
getNDVI <- function(image) {
  image$normalizedDifference(c("B8", "B4"))$rename('NDVI')
}

S2_collection_cloudfilt10_mask_ndvi = S2_collection_cloudfilt10_mask$map(getNDVI)
S2_img_masked = S2_collection_cloudfilt10_mask_ndvi$first()
Map$addLayer(S2_img_masked$select('NDVI'), ndviParams, "NDVI de coleccion")

#le pongo sort para que sea la mas nueva, no funciono, error, 
S2_collection_cloudfilt10_mask_ndvi = S2_collection_cloudfilt10_mask$map(getNDVI)


