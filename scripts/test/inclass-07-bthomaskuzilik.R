library(googledrive)
library(sf)
library(terra)
library(tidyterra)
library(tidyverse)

source("scripts/utilities/download_utils.R")

file_list <- drive_ls(drive_get(as_id("https://drive.google.com/drive/u/1/folders/1PwfUX2hnJlbnqBe3qvl33tFBImtNFTuR")))

file_list %>% 
  dplyr::select(id, name) %>%
  purrr::pmap(function(id, name) {
    gdrive_folder_download(list(id = id, name = name),
                           dstfldr = "inclass07")
  })

cejst_shp <- read_sf("data/original/inclass07/cejst.shp")
str(cejst_shp)
glimpse(cejst_shp)
all(st_is_valid(cejst_shp))
plot(st_geometry(cejst_shp))

fire_prob <- rast("data/original/inclass07/wildfire.tif")
str(fire_prob)
glimpse(fire_prob)
plot(fire_prob)