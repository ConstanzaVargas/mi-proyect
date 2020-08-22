#remotes::install_github("r-spatial/rgee")

#Solo es necesario una vez
#ee_install()
# install.packages(rgee)
# CÓDIGOS PARA INSTALACIÓN
# ee_clean_pyenv()  en caso de error   Remember that you can remove EARTHENGINE_PYTHON and EARTHENGINE_ENV using rgee::ee_clean_pyenv().
# To activate this environment, use $ conda activate rgee o To deactivate an active environment, use $ conda desactivate
# we recommend run ee_check() to perform a full check of all non-R dependencies.


#Initialize Earth Engine
library(rgee)
ee_check()
ee_Initialize()

#Importar poligonos
parrillar = ee$FeatureCollection("users/queenb/Parrillar_bonito") #Parillar_bonito$getInfo()
la_paciencia = ee$FeatureCollection("users/practico1/la-paciencia")


Map$addLayer(Parrillar_bonito, name="Parrillar")
Map$centerObject(Parrillar_bonito,12)

Map$addLayer(la_paciencia, name="La Paciencia")
Map$centerObject(la_paciencia,9)

#Importar hansen
hansen = ee$Image("UMD/hansen/global_forest_change_2019_v1_7")
Map$addLayer(Hansen$clip(la_paciencia), name="Capa Hansen en La Paciencia")
Map$addLayer(Hansen$clip(la_paciencia), list(bands = c("lossyear","gain", "treecover2000"), min = 0, max = 19, name="Capa Hansen en La Paciencia"))
bands: ['treecover2000'],



min: 0,
max: 100,
palette: ['black', 'green']



hansen$getInfo()

hansen$bands[[1]]$id
$bands[[4]]$id
[1] "lossyear"




treeCoverVisParam = {
  bands: ['treecover2000'],
  min: 0,
  max: 100,
  palette: ['black', 'green']
}

Map.addLayer(hansen, treeCoverVisParam, 'tree cover');

var treeLossVisParam = {
  bands: ['lossyear'],
  min: 0,
  max: 19,
  palette: ['yellow', 'red']
};
Map.addLayer(hansen, treeLossVisParam, 'tree loss year');
  

# The eeObject argument must be an instance of one of ee$Image, ee$Geometry, ee$Feature, or ee$FeatureCollection.

#list(bands = c("lossyear"), min = 0, max = 3000))


#Available band names: [treecover2000, loss, gain, lossyear, 
#first_b30, first_b40, first_b50, first_b70, last_b30, last_b40, last_b50, last_b70, datamask]




Map$addLayer(S2_img$clip(geometry), list(bands = c("B8","B3","B2"), min = 0, max = 3000), "imagen S2")


#funciones
olaketal = function(x) {
  suma = x+1
  return(suma)
}
olaketal(7)


