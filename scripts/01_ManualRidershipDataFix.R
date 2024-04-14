#### Setup
library(dplyr)
library(sf)
library(tidycensus)
library(data.table)

## CTA Ridership by Station
cta.ridership <- fread('data/raw/nongeo/CTA_Ridership_byStation.csv') %>%
  select(stationname, daytype, rides)

## First, some manual fixes to ensure a proper join between stations and ridership data
## For some reason, the Station IDs don't match.
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Ashland-Orange",
                                    "Ashland-Midway",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Addison-Brown",
                                    "Addison-Ravenswood",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Austin-Forest Park",
                                    "Austin-Congress",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "California-Cermak",
                                    "California-Douglas",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Cicero-Cermak",
                                    "Cicero-Douglas",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Cicero-Forest Park",
                                    "Cicero-Congress",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Clinton-Forest Park",
                                    "Clinton-Congress",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Conservatory",
                                    "Conservatory-Central Park",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "East 63rd-Cottage Grove",
                                    "Cottage Grove",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Damen-Brown",
                                    "Damen-Ravenswood",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Damen-Cermak",
                                    "Damen",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Halsted-Orange",
                                    "Halsted-Midway",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Harlem-Forest Park",
                                    "Harlem-Congress",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Medical Center",
                                    "Illinois Medical District",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Irving Park-Brown",
                                    "Irving Park-Ravenswood",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Kedzie-Cermak",
                                    "Kedzie-Douglas",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Kedzie-Homan-Forest Park",
                                    "Kedzie-Homan",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Kedzie-Brown",
                                    "Kedzie-Ravenswood",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Kedzie-Homan-Forest Park",
                                    "Kedzie-Homan",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Montrose-Brown",
                                    "Montrose-Ravenswood",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Morgan-Lake",
                                    "Morgan",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Oak Park-Forest Park",
                                    "Oak Park-Congress",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Pulaski-Forest Park",
                                    "Pulaski-Congress",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Pulaski-Cermak",
                                    "Pulaski-Douglas",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Pulaski-Orange",
                                    "Pulaski-Midway",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Roosevelt",
                                    "Roosevelt/State",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Western-Brown",
                                    "Western-Ravenswood",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Western-Forest Park",
                                    "Western-Congress",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Western-Cermak",
                                    "Western-Douglas",
                                    cta.ridership$stationname)
cta.ridership$stationname <- ifelse(cta.ridership$stationname == "Western-Orange",
                                    "Western-Midway",
                                    cta.ridership$stationname)

fwrite(cta.ridership,
       'data/raw/nongeo/CTA_Ridership_byStation.csv',
       row.names = F)
