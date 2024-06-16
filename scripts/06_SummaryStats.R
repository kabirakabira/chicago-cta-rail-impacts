#### Creating summary state tables from the cleaned data
library(dplyr)
library(data.table)

#### Dependencies
## Overall Data
overall.data <- fread("data/processed/nongeo/Summarized_Overall.csv")
## Line Data
line.data <- fread("data/processed/nongeo/Summarized_byLine.csv")
## Station Data
station.data <- fread("data/processed/nongeo/Summarized_byStation.csv")

#### Overall Data
overall.data <- overall.data %>%
  mutate(
    White.Percent = (RE.White) / (RE.White + RE.Black + RE.Asian + RE.Native + 
                                    RE.AAPI + RE.Other + RE.TwoPlus + RE.Hispanic),
    Bachelors.Percent = (Edu.Bachelors + Edu.Masters) / (Edu.LessThanHS + Edu.HS + Edu.SomeCollege + 
                                                           Edu.Bachelors + Edu.Masters),
    Drive.Percent = Workers.Drove / Workers.Total,
    Transit.Percent = Workers.PublicTransit / Workers.Total,
    WFH.Percent = Workers.WFH / Workers.Total,
    OtherTransport.Percent = 1 - (Drive.Percent + Transit.Percent + WFH.Percent)
  ) %>%
  select(
    Year,
    Intersected,
    Total.Population,
    MedianAge,
    MHHI,
    MedianRent,
    MedianValue,
    White.Percent,
    Bachelors.Percent,
    Drive.Percent,
    Transit.Percent,
    WFH.Percent,
    OtherTransport.Percent
  ) %>%
  filter(Year %in% c(2010, 2022))

