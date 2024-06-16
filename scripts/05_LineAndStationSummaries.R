#### Summarizing by Station and Line

#### Setup
library(dplyr)
library(data.table)

#### Dependencies
## Census Data
census.data <- fread("data/processed/nongeo/CensusData_AllYears_Intersected.csv")

#### Summarizing

## By Intersected
overall.data <- census.data %>%
  group_by(Year, Intersected) %>%
  summarize(
    Total.Population = sum(Total.Population),
    
    MedianAge = mean(MedianAge, na.rm = T),
    
    RE.White = sum(RE.White),
    RE.Black = sum(RE.Black),
    RE.Native = sum(RE.Native),
    RE.Asian = sum(RE.Asian),
    RE.AAPI = sum(RE.AAPI),
    RE.Other = sum(RE.Other),
    RE.TwoPlus = sum(RE.TwoPlus),
    RE.Hispanic = sum(RE.Hispanic),
    
    Edu.LessThanHS = sum(Edu.LessThanHS),
    Edu.HS = sum(Edu.HS),
    Edu.SomeCollege = sum(Edu.SomeCollege),
    Edu.Bachelors = sum(Edu.Bachelors),
    Edu.Masters = sum(Edu.Masters),
    
    Workers.Total = sum(Workers.Total),
    Workers.Drove = sum(Workers.Drove),
    Workers.PublicTransit = sum(Workers.PublicTransit),
    Workers.Bike = sum(Workers.Bike),
    Workers.Walk = sum(Workers.Walk),
    Workers.Other = sum(Workers.Other),
    Workers.WFH = sum(Workers.WFH),
    
    MHHI = mean(MHHI, na.rm = T),
    MedianRent = mean(MedianRent, na.rm = T),
    MedianValue = mean(MedianValue, na.rm = T),
    
    Emp.Agriculture = sum(Emp.Agriculture),
    Emp.Construction = sum(Emp.Construction),
    Emp.Manufacturing = sum(Emp.Manufacturing),
    Emp.Wholesale = sum(Emp.Wholesale),
    Emp.Retail = sum(Emp.Retail),
    Emp.Warehousing = sum(Emp.Warehousing),
    Emp.IT = sum(Emp.IT),
    Emp.Finance = sum(Emp.Finance),
    Emp.Professional = sum(Emp.Professional),
    Emp.EduHealth = sum(Emp.EduHealth),
    Emp.Arts = sum(Emp.Arts),
    Emp.Other = sum(Emp.Other),
    Emp.Public = sum(Emp.Public)
  )

## By Line
line.data <- census.data %>%
  group_by(Year, Line) %>%
  summarize(
    Total.Population = sum(Total.Population),
    
    MedianAge = mean(MedianAge, na.rm = T),
    
    RE.White = sum(RE.White),
    RE.Black = sum(RE.Black),
    RE.Native = sum(RE.Native),
    RE.Asian = sum(RE.Asian),
    RE.AAPI = sum(RE.AAPI),
    RE.Other = sum(RE.Other),
    RE.TwoPlus = sum(RE.TwoPlus),
    RE.Hispanic = sum(RE.Hispanic),
    
    Edu.LessThanHS = sum(Edu.LessThanHS),
    Edu.HS = sum(Edu.HS),
    Edu.SomeCollege = sum(Edu.SomeCollege),
    Edu.Bachelors = sum(Edu.Bachelors),
    Edu.Masters = sum(Edu.Masters),
    
    Workers.Total = sum(Workers.Total),
    Workers.Drove = sum(Workers.Drove),
    Workers.PublicTransit = sum(Workers.PublicTransit),
    Workers.Bike = sum(Workers.Bike),
    Workers.Walk = sum(Workers.Walk),
    Workers.Other = sum(Workers.Other),
    Workers.WFH = sum(Workers.WFH),
    
    MHHI = mean(MHHI, na.rm = T),
    MedianRent = mean(MedianRent, na.rm = T),
    MedianValue = mean(MedianValue, na.rm = T),
    
    Emp.Agriculture = sum(Emp.Agriculture),
    Emp.Construction = sum(Emp.Construction),
    Emp.Manufacturing = sum(Emp.Manufacturing),
    Emp.Wholesale = sum(Emp.Wholesale),
    Emp.Retail = sum(Emp.Retail),
    Emp.Warehousing = sum(Emp.Warehousing),
    Emp.IT = sum(Emp.IT),
    Emp.Finance = sum(Emp.Finance),
    Emp.Professional = sum(Emp.Professional),
    Emp.EduHealth = sum(Emp.EduHealth),
    Emp.Arts = sum(Emp.Arts),
    Emp.Other = sum(Emp.Other),
    Emp.Public = sum(Emp.Public)
  )

## By Station
station.data <- census.data %>%
  group_by(Year, LONGNAME) %>%
  summarize(
    Total.Population = sum(Total.Population),
    
    MedianAge = mean(MedianAge, na.rm = T),
    
    RE.White = sum(RE.White),
    RE.Black = sum(RE.Black),
    RE.Native = sum(RE.Native),
    RE.Asian = sum(RE.Asian),
    RE.AAPI = sum(RE.AAPI),
    RE.Other = sum(RE.Other),
    RE.TwoPlus = sum(RE.TwoPlus),
    RE.Hispanic = sum(RE.Hispanic),
    
    Edu.LessThanHS = sum(Edu.LessThanHS),
    Edu.HS = sum(Edu.HS),
    Edu.SomeCollege = sum(Edu.SomeCollege),
    Edu.Bachelors = sum(Edu.Bachelors),
    Edu.Masters = sum(Edu.Masters),
    
    Workers.Total = sum(Workers.Total),
    Workers.Drove = sum(Workers.Drove),
    Workers.PublicTransit = sum(Workers.PublicTransit),
    Workers.Bike = sum(Workers.Bike),
    Workers.Walk = sum(Workers.Walk),
    Workers.Other = sum(Workers.Other),
    Workers.WFH = sum(Workers.WFH),
    
    MHHI = mean(MHHI, na.rm = T),
    MedianRent = mean(MedianRent, na.rm = T),
    MedianValue = mean(MedianValue, na.rm = T),
    
    Emp.Agriculture = sum(Emp.Agriculture),
    Emp.Construction = sum(Emp.Construction),
    Emp.Manufacturing = sum(Emp.Manufacturing),
    Emp.Wholesale = sum(Emp.Wholesale),
    Emp.Retail = sum(Emp.Retail),
    Emp.Warehousing = sum(Emp.Warehousing),
    Emp.IT = sum(Emp.IT),
    Emp.Finance = sum(Emp.Finance),
    Emp.Professional = sum(Emp.Professional),
    Emp.EduHealth = sum(Emp.EduHealth),
    Emp.Arts = sum(Emp.Arts),
    Emp.Other = sum(Emp.Other),
    Emp.Public = sum(Emp.Public)
  )

#### Write out
fwrite(overall.data, "data/processed/nongeo/Summarized_Overall.csv", row.names = F)
fwrite(line.data, "data/processed/nongeo/Summarized_byLine.csv", row.names = F)
fwrite(station.data, "data/processed/nongeo/Summarized_byStation.csv", row.names = F)