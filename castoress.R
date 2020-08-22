# https://code.earthengine.google.com/fa94ca9713774f9cd9834de89d53d98d buffer

#Initialize Earth Engine
library(rgee)
ee_check()
ee_Initialize()

#Importar poligonos
la_paciencia = ee$FeatureCollection("users/practico1/la-paciencia")
Map$addLayer(la_paciencia, name="La Paciencia")
Map$centerObject(la_paciencia, 11)

drenaje_paciencia = ee$FeatureCollection("users/practico1/drenajelapaciencia")
Map$addLayer(drenaje_paciencia, name="Drenaje en La Paciencia")
Map$centerObject(drenaje_paciencia, 11)

Map$addLayers(la_paciencia,drenaje_paciencia)

#colores
colores <- list(palette = c(
  "#d73027", "#f46d43", "#fdae61",
  "#fee08b", "#d9ef8b", "#a6d96a",
  "#66bd63", "#1a9850"
))


#Importar hansen
hansen = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")
Map$addLayer(hansen$clip(la_paciencia), name="Capa Hansen en La Paciencia")

lossyear = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")$select("lossyear")
Map$addLayer(lossyear$clip(la_paciencia),colores,name="Pérdida forestal en La Paciencia")


treecover2000 = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")$sel("treecover2000")
Map$addLayer(treecover2000$clip(la_paciencia), colores, name="Cobertura forestal en La Paciencia") 


#buffer
var stations = [
  ee.Feature(
    ee.Geometry.Point(-122.42, 37.77), {'name': '16th St. Mission (16TH)'}),
  ee.Feature(
    ee.Geometry.Point(-122.42, 37.75), {'name': '24th St. Mission (24TH)'}),
  ee.Feature(
    ee.Geometry.Point(-122.41, 37.78),
    {'name': 'Civic Center/UN Plaza (CIVC)'})
];
var bartStations = ee.FeatureCollection(stations);

// Map a function over the collection to buffer each feature.
var buffered = bartStations.map(function(f) {
  return f.buffer(2000, 100); // Note that the errorMargin is set to 100.
});

Map.addLayer(buffered, {color: '800080'});

Map.setCenter(-122.4, 37.7, 11);




#first_b30, first_b40, first_b50, first_b70, last_b30, last_b40, last_b50, last_b70]



#funciones
olaketal = function(x) {
  suma = x+1
  return(suma)
}
olaketal(7)


