##    Programme:  R
##
##    Objective: Map the number of housing consents in Wellington 1/1/2013 - 1/6/02019
##
##    Plan of  : 
##    Attack   :  
##
##               1. Setting up map
##               2. Load in housing consents data
##               3. Mapping the data
##
##    Author   :  Bradd Forster
##
##  Clear the decks and load up some functionality
    ##
    rm(list=ls(all=TRUE))

##  Core libraries
    ##
    library(dplyr)
    library(tidyr)
    library(readxl)
    library(writexl)
    library(stringr)
    library(lubridate)
    library(ggplot2)

##  Optional libraries
    ##
    library(sf)         ##  Saving the data as shape format
    
##  Set up paths for working directories
    ##
    userid <- "bradd"
    r <- paste0("C:/Users/", userid, "")
    data <- paste0("C:/Users/", userid, "")
    consents <- paste0("C:/Users/", userid, "")
    
##  Setting the working directory
    ##
    setwd(data)

################################################################################
## 1.                           Setting up map                                ##
################################################################################
    
nz_sa3 <- read_sf("statistical-area-3-higher-geographies-2023-generalised.shp")

wgtn_sa3 <- nz_sa3[nz_sa3$TA2023_V_1 == "Wellington City",]


################################################################################
## 2.                       Load in housing consents data                     ##
################################################################################

setwd(consents)
building_consents <- read.csv("Consents by SA3.csv")

building_consents <- aggregate(House ~ Sa3Code, data = building_consents, FUN = sum)


################################################################################
## 3.                            Mapping the data                             ##
################################################################################

wgtn_sa3 <- merge(wgtn_sa3, building_consents, by.x = "SA32023_V1", by.y = "Sa3Code")

ggplot() +
  geom_sf(data = wgtn_sa3, aes(fill = House), color = "black", linewidth = 0.3) +
  labs(fill = "Residential Housing Consents") +
  theme_void()
