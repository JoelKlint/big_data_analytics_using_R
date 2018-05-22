library(dplyr)
library(GGally)

# GDP
GDP <- read.table('GDP.csv', header=TRUE, sep=',')
GDP <- GDP %>%
  select(Country.or.Area, Year, Value)
colnames(GDP) <- c("Country", "Year", "GDP")


# SchoolExpectancy
SchoolExpectancy <- read.table('school_life_expectancy.csv', header=TRUE, sep=',')
SchoolExpectancy <- SchoolExpectancy %>%
  filter(Sex == 'All genders') %>%
  select(Reference.Area, Time.Period, Observation.Value)
colnames(SchoolExpectancy) <- c("Country", "Year", "SchoolExpectancy")
un_data <- merge(GDP, SchoolExpectancy)
ggpairs(un_data[c(-1,-2)])

# Youth Literacy rate
YouthLiteracyRate <- read.table('youth_literacy_rate.csv', header=TRUE, sep=',')
YouthLiteracyRate <- YouthLiteracyRate %>%
  filter(Sex == 'All genders') %>%
  select(Reference.Area, Time.Period, Observation.Value)
colnames(YouthLiteracyRate) <- c("Country", "Year", "YouthLiteracyRate")
un_data <- merge(GDP, YouthLiteracyRate)
ggpairs(un_data[c(-1,-2)])

# Industrial Waste Production
IndustrialWasteProduction <- read.table('industrial_waste_production.csv', header=TRUE, sep=',', nrows=763)
IndustrialWasteProduction <- IndustrialWasteProduction %>%
  select(Country.or.Area, Year, Quantity)
colnames(IndustrialWasteProduction) <- c("Country", "Year", "IndustrialWasteProduction")
un_data <- merge(GDP, IndustrialWasteProduction)
ggpairs(un_data[c(-1,-2)])
