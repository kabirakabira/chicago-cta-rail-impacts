## List of Census Blocks with centroids in a 1-mile radius 

#### Setup
library(dplyr)
library(sf)
library(tidycensus)
library(data.table)
census_api_key(readLines('data/reference/censuskey.txt'))

#### Dependencies
## CTA Stations
cta <- st_read('data/raw/geo/CTA_RailStations/CTA_RailStations.shp') %>%
  st_transform(crs = 4269) %>%
  select(LONGNAME, geometry) %>%
  filter(LONGNAME != 'Roosevelt/Wabash')
## CTA Ridership by Station
cta.ridership <- fread('data/raw/nongeo/CTA_Ridership_byStation.csv') %>%
  select(stationname, daytype, rides)
## CTA Lines
cta.lines <- fread('data/reference/station_lines.csv')
## Chicago Boundary
chicago_boundary <- st_read('data/raw/geo/Chicago_Boundary/geo_export_90809ac1-94b0-4a4f-aabc-1cee937223f4.shp') %>%
  st_transform(crs = 4269) %>%
  select(name, geometry)

#### Pulling a list of Census Tracts in Chicago for 2011 and 2021 and computing centroids
## 2011
# tracts.2011 <- get_acs(
#   geography = 'tract',
#   state = 'IL',
#   variables = c('B01001_001E'),
#   year = 2011,
#   geometry = TRUE
# ) %>%
#   select(GEOID, geometry) %>%
#   st_intersection(chicago_boundary) %>%
#   st_centroid()

tracts.2011 <- st_read('data/raw/geo/tl_2011_17_tract/tl_2011_17_tract.shp') %>%
  select(GEOID, geometry) %>%
  st_intersection(chicago_boundary)

## 2021
# tracts.2021 <- get_acs(
#   geography = 'tract',
#   state = 'IL',
#   variables = c('B01001_001E'),
#   year = 2021,
#   geometry = TRUE
# ) %>%
#   select(GEOID, geometry) %>%
#   st_intersection(chicago_boundary) %>%
#   st_centroid()

tracts.2021 <- st_read('data/raw/geo/tl_2021_17_tract/tl_2021_17_tract.shp') %>%
  select(GEOID, geometry) %>%
  st_intersection(chicago_boundary)

#### Creating a 0.25 mile / 402 meter buffer zone around each CTA Station
cta_buffer <- st_buffer(cta, 402)

#### Finding the Census Tract Centroids that intersect with the CTA Station Buffer
tracts.2011.intersected <- tracts.2011 %>%
  st_intersection(cta_buffer)

tracts.2021.intersected <- tracts.2021 %>%
  st_intersection(cta_buffer)

#### Calculating average CTA daily weekday ridership by station from 2021-2022
cta.ridership <- cta.ridership %>%
  filter(daytype == "W") %>%
  group_by(stationname) %>%
  summarize(Daily.Rides = mean(rides, na.rm = T)) %>%
  left_join(cta.lines, by = c("stationname" = "Station"))

#### Clean up list of intersected Tracts:
#### Adding column to measure number of intersected stations
#### Adding column for average CTA daily weekday ridership
tracts.2011.intersected <- tracts.2011.intersected %>%
  st_drop_geometry() %>%
  group_by(GEOID) %>%
  mutate(Station.Number = row_number()) %>%
  mutate(Number.of.Stations = max(Station.Number)) %>%
  select(-Station.Number) %>%
  left_join(cta.ridership,
            by = c("LONGNAME" = "stationname")) %>%
  select(-name)
# %>%
#   summarize(Stations = max(Number.of.Stations),
#             Daily.Rides = sum(Daily.Rides))

tracts.2021.intersected <- tracts.2021.intersected %>%
  st_drop_geometry() %>%
  group_by(GEOID) %>%
  mutate(Station.Number = row_number()) %>%
  mutate(Number.of.Stations = max(Station.Number)) %>%
  select(-Station.Number) %>%
  left_join(cta.ridership,
            by = c("LONGNAME" = "stationname")) %>%
  select(-name)

# %>%
#   summarize(Stations = max(Number.of.Stations),
#             Daily.Rides = sum(Daily.Rides))

#### Write out the csvs
write.csv(tracts.2011 %>% st_drop_geometry(),
          'data/processed/nongeo/chicago_tracts_2011.csv',
          row.names = F)

write.csv(tracts.2021 %>% st_drop_geometry(),
          'data/processed/nongeo/chicago_tracts_2021.csv',
          row.names = F)

write.csv(tracts.2011.intersected,
          'data/processed/nongeo/tracts_2011_intersected.csv',
          row.names = F)

write.csv(tracts.2021.intersected,
          'data/processed/nongeo/tracts_2021_intersected.csv',
          row.names = F)