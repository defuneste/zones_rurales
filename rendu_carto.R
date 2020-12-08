# rendu carto =====
# cela va être très laid 

source("charger_les_données.R")

library(tmap)

tm_shape(communes_classif.shp) + tm_fill(col = "degre_dens")