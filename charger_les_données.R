### Charger les données ===================
# .dat = un df
# .shp = un vecteur, sf

# je charge juste sf et dplyr
library(sf)
library(dplyr)

## A. Données de Pop ======================
# sources données ici https://www.insee.fr/fr/information/2114627
# sauver en csv avant pour eviter de charger un package

classif_communes.dat <- read.csv("data/grille_densite_2020.csv")
# on va renomer pour respecter un minimum de régles
names(classif_communes.dat) <- c("COG", "Nom_communes", "degre_dens", "Région","Pop_2017")
# nb je connais pas ces codes regions et ce n'est pas doc dans "documentation"

## verif
#  str(classif_communes.dat)
# on a 34968 communes
## Répartition de ces communes par typo de densité
# table(classif_communes.dat$degre_dens)
# Répartition en pop par type de densité
# aggregate(classif_communes.dat$Pop_2017  ~ classif_communes.dat$degre_dens, 
# data = classif_communes.dat,            
# FUN = sum 
# )

## B. Données cartos ========================
# ici j'ai pris un extract d'OSM car je me perds toujours sur le site de l'insee
# avec les type_co Rural/urbain de l'ancienne classif

communes.shp <- sf::st_read("data/commune.shp") %>% sf::st_transform(2154)

# on a une différence du nombre de communes tps pour celle que je mange (dsl les territoire d'outremer ...)

### Jointure des tables ==============

# le left join gomme les communes manquantes
communes_classif.shp <- dplyr::left_join(communes.shp, classif_communes.dat, by = c("insee" = "COG"))

# un export
#st_write(communes_classif.shp, "data/communes_classif.shp")