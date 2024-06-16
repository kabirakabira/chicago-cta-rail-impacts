#### Pulling Tract-level Census Data from the earliest available years for Chicago.

#### Setup
library(tidycensus)
library(dplyr)
library(tidyr)
library(sf)
library(data.table)
census_api_key(readLines('data/reference/censuskey.txt'))

#### Dependencies
## Chicago Tracts in 2011
chicago.tracts.2011 <- read.csv('data/processed/nongeo/chicago_tracts_2011.csv') %>%
  select(GEOID)
## Chicago Tracts in 2021
chicago.tracts.2021 <- read.csv('data/processed/nongeo/chicago_tracts_2021.csv') %>%
  select(GEOID)

#### Defining the variable list
variable.codes.list <- c(
  "B01001_001E", ## Total Population
  
  "B01002_001E", ## Median Age
  
  "B03002_003E", ## Race: White
  "B03002_004E", ## Race: Black
  "B03002_005E", ## Race: Native
  "B03002_006E", ## Race: Asian
  "B03002_007E", ## Race: AAPI
  "B03002_008E", ## Race: Other
  "B03002_009E", ## Race: TwoPlus
  "B03002_012E", ## Ethnicity: Hispanic
  
  "B06009_002E", ## Education: Less than HS
  "B06009_003E", ## Education: HS
  "B06009_004E", ## Education: Some College
  "B06009_005E", ## Education: Bachelors
  "B06009_006E", ## Education: Masters
  
  "B08006_001E", ## Total Workers
  "B08006_002E", ## Drove
  "B08006_008E", ## Public Transit
  "B08006_014E", ## Bike
  "B08006_015E", ## Walk
  "B08006_016E", ## Other
  "B08006_017E", ## WFH Workers
  
  "B19013_001E", ## Median HH Income
  
  "B25064_001E", ## Median Gross Rent
  "B25077_001E", ## Median Value
  
  "C24050_002E", ## Industry: Agriculture
  "C24050_003E", ## Industry: Construction
  "C24050_004E", ## Industry: Manufacturing
  "C24050_005E", ## Industry: Wholesale Trade
  "C24050_006E", ## Industry: Retail Trade
  "C24050_007E", ## Industry: Transportation and Warehousing
  "C24050_008E", ## Industry: Information
  "C24050_009E", ## Industry: Finance and Insurance
  "C24050_010E", ## Industry: Professional Services
  "C24050_011E", ## Industry: Education and Healthcare
  "C24050_012E", ## Industry: Arts, Entertainment, Accommodations, Food
  "C24050_013E", ## Industry: Other Services
  "C24050_014E"  ## Industry: Public Administration
)

variable.names.list <- c(
  
  "Total.Population",
  "MedianAge",
  
  "RE.White",
  "RE.Black",
  "RE.Native",
  "RE.Asian",
  "RE.AAPI",
  "RE.Other",
  "RE.TwoPlus",
  "RE.Hispanic",
  
  "Edu.LessThanHS",
  "Edu.HS",
  "Edu.SomeCollege",
  "Edu.Bachelors",
  "Edu.Masters",
  
  "Workers.Total",
  "Workers.Drove",
  "Workers.PublicTransit",
  "Workers.Bike",
  "Workers.Walk",
  "Workers.Other",
  "Workers.WFH",
  
  "MHHI",
  "MedianRent",
  "MedianValue",
  
  "Emp.Agriculture",
  "Emp.Construction",
  "Emp.Manufacturing",
  "Emp.Wholesale",
  "Emp.Retail",
  "Emp.Warehousing",
  "Emp.IT",
  "Emp.Finance",
  "Emp.Professional",
  "Emp.EduHealth",
  "Emp.Arts",
  "Emp.Other",
  "Emp.Public"
)

#### Data Pulls for each year
## 2010
census.2010 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2010
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2010)

## 2011
census.2011 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2011
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2011)

## 2012
census.2012 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2012
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2012)

## 2013
census.2013 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2013
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2013)

## 2014
census.2014 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2014
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2014)

## 2015
census.2015 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2015
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2015)

## 2016
census.2016 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2016
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2016)

## 2017
census.2017 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2017
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2017)

## 2018
census.2018 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2018
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2018)

## 2019
census.2019 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2019
) %>%
  filter(GEOID %in% chicago.tracts.2011$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2019)

## 2020
census.2020 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2020
) %>%
  filter(GEOID %in% chicago.tracts.2021$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2020)

## 2021
census.2021 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2021
) %>%
  filter(GEOID %in% chicago.tracts.2021$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2021)

## 2022
census.2022 <- get_acs(
  geography = 'tract',
  state = 'IL',
  variables = variable.codes.list,
  survey = 'acs5',
  year = 2022
) %>%
  filter(GEOID %in% chicago.tracts.2021$GEOID) %>%
  select(-moe) %>%
  pivot_wider(names_from = variable,
              values_from = estimate) %>%
  `colnames<-`(c('GEOID','NAME', variable.names.list)) %>%
  mutate(Year = 2022)

## Write Out .CSVs
write.csv(census.2010,
          'data/processed/nongeo/CensusData_2010.csv',
          row.names = F)
write.csv(census.2011,
          'data/processed/nongeo/CensusData_2011.csv',
          row.names = F)
write.csv(census.2012,
          'data/processed/nongeo/CensusData_2012.csv',
          row.names = F)
write.csv(census.2012,
          'data/processed/nongeo/CensusData_2012.csv',
          row.names = F)
write.csv(census.2013,
          'data/processed/nongeo/CensusData_2013.csv',
          row.names = F)
write.csv(census.2014,
          'data/processed/nongeo/CensusData_2014.csv',
          row.names = F)
write.csv(census.2015,
          'data/processed/nongeo/CensusData_2015.csv',
          row.names = F)
write.csv(census.2016,
          'data/processed/nongeo/CensusData_2016.csv',
          row.names = F)
write.csv(census.2017,
          'data/processed/nongeo/CensusData_2017.csv',
          row.names = F)
write.csv(census.2018,
          'data/processed/nongeo/CensusData_2018.csv',
          row.names = F)
write.csv(census.2019,
          'data/processed/nongeo/CensusData_2019.csv',
          row.names = F)
write.csv(census.2020,
          'data/processed/nongeo/CensusData_2020.csv',
          row.names = F)
write.csv(census.2021,
          'data/processed/nongeo/CensusData_2021.csv',
          row.names = F)
write.csv(census.2022,
          'data/processed/nongeo/CensusData_2022.csv',
          row.names = F)
