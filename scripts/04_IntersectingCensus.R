#### Joining Tract Data to Quarter-mile Buffers and Summarizing

#### Setup
library(dplyr)
library(data.table)
library(sf)

#### Dependencies
## Census Data
census.2010 <- fread('data/processed/nongeo/CensusData_2010.csv')
census.2011 <- fread('data/processed/nongeo/CensusData_2011.csv')
census.2012 <- fread('data/processed/nongeo/CensusData_2012.csv')
census.2013 <- fread('data/processed/nongeo/CensusData_2013.csv')
census.2014 <- fread('data/processed/nongeo/CensusData_2014.csv')
census.2015 <- fread('data/processed/nongeo/CensusData_2015.csv')
census.2016 <- fread('data/processed/nongeo/CensusData_2016.csv')
census.2017 <- fread('data/processed/nongeo/CensusData_2017.csv')
census.2018 <- fread('data/processed/nongeo/CensusData_2018.csv')
census.2019 <- fread('data/processed/nongeo/CensusData_2019.csv')
census.2020 <- fread('data/processed/nongeo/CensusData_2020.csv')
census.2021 <- fread('data/processed/nongeo/CensusData_2021.csv')
census.2022 <- fread('data/processed/nongeo/CensusData_2022.csv')
## Intersect Crosswalks
intersections.2010 <- fread('data/processed/nongeo/tracts_2011_intersected.csv')
intersections.2020 <- fread('data/processed/nongeo/tracts_2021_intersected.csv')
## CTA Ridership Data
cta.ridership <- fread('data/raw/nongeo/CTA_Ridership_byStation.csv')

#### Joining Intersect Info to Tract Data
df.list <- c("census.2010",
             "census.2011",
             "census.2012",
             "census.2013",
             "census.2014",
             "census.2015",
             "census.2016",
             "census.2017",
             "census.2018",
             "census.2019",
             "census.2020",
             "census.2021",
             "census.2022")

census.joined <- census.2010 %>%
  left_join(intersections.2010) %>%
  mutate(LONGNAME = ifelse(is.na(LONGNAME), "None", LONGNAME),
         Number.of.Stations = ifelse(is.na(Number.of.Stations), 0, Number.of.Stations),
         Daily.Rides = ifelse(is.na(Daily.Rides), 0, Daily.Rides),
         Line = ifelse(is.na(Line), "None", Line)) %>%
  mutate(Intersected = ifelse(Number.of.Stations > 0, 1, 0))

for (i in 2:length(df.list)) {
  temp <- get(df.list[i])
  
  if (i <= 10) {
  temp <- temp %>%
    left_join(intersections.2010) %>%
    mutate(LONGNAME = ifelse(is.na(LONGNAME), "None", LONGNAME),
           Number.of.Stations = ifelse(is.na(Number.of.Stations), 0, Number.of.Stations),
           Daily.Rides = ifelse(is.na(Daily.Rides), 0, Daily.Rides),
           Line = ifelse(is.na(Line), "None", Line)) %>%
    mutate(Intersected = ifelse(Number.of.Stations > 0, 1, 0))
  }
  else {
    temp <- temp %>%
      left_join(intersections.2020) %>%
      mutate(LONGNAME = ifelse(is.na(LONGNAME), "None", LONGNAME),
             Number.of.Stations = ifelse(is.na(Number.of.Stations), 0, Number.of.Stations),
             Daily.Rides = ifelse(is.na(Daily.Rides), 0, Daily.Rides),
             Line = ifelse(is.na(Line), "None", Line)) %>%
      mutate(Intersected = ifelse(Number.of.Stations > 0, 1, 0))
  }
  
  census.joined <- rbind(census.joined, temp)
  
}

#### Write out
fwrite(census.joined,
       "data/processed/nongeo/CensusData_AllYears_Intersected.csv",
       row.names = F)