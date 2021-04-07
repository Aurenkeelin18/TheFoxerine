![cover_photo](./06_Images/FirstPage.png)
## THE STORY
Since 2008, there is an average of 129 Bad Air Days (BADs) each year in Houston. During BADs, the Air Quality Index (AQI) labels may be “moderate”, “unhealthy”, and a few times a year “very unhealthy”. This project aims at identifying drivers of air pollution to enable the prediction of the outdoor air quality in Houston for decades to come in function of measurable factors. A secondary aspect of the project is to measure the impact of outdoor air quality on indoor air quality.

## THE HYPOTHESIS
Houston’s traffic ranked 8th in the nation in 2020. To this daily pollution are added industrial emissions from refineries, plastic plants and other petro-chemical industries. Houston attracts an increasing number of workers (including the author of this report). According to the Houston-Galveston Area Council the population of Houston Metro will reach 9 millions in 2040.

## THE DATA
The data was collected from different sources:
* [Pollutant Concentrations: TCEQ’s Tamis DB (Texas Commission on Environmental Quality),](https://www.tceq.texas.gov/)
* [Weather Data: NOAA (National Oceanic and Atmospheric Administration),](https://www.noaa.gov/)
* [Pollutant and Weather Data: US EPA (Environmental Protection Agency),](https://www.epa.gov/)
* [Land Use: HGAC (Houston Galveston Area Council),](https://www.h-gac.com/Home)
* [Traffic and Population Data: City of Houston data website,](https://cohgis-mycity.opendata.arcgis.com/)
* [Indoor/Outdoor Data: RIOPA study (Relationship of Indoor, Outdoor, and Personal Air).](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/7UBE7P)
![](./06_Images/HoustonMap.jpg)

## DATA WRANGLING
The idea is to merge the data into a coherent data set by taking into account geographical locations, and by covering as much territory possible from The Woodlands to the North all the way down to Galveston to the Southeast on the coastline, including Baytown and Angleton (plants).
![](./06_Images/Overview.png)
The main issues encountered during the wrangling of the data were matching sampling rates, connect local weather to each air quality station, deal with missing data, and integrate traffic count, land use  and population data to the data set.

## AIR QUALITY INDEX
The AQI describes the impact of pollution on the quality of life and daily activities. When applied to ozone concentrations the effects are as described in the picture below. The AQI is calculated using pollutant concentrations. Check how the AQI is calculated in the US in the [report](./SpringboardCapstone2_HoustonAirQuality_Report_Anne Warren.pdf) or [presentation[(./Springboard_Capstone2_HoustonAirQuality_AnneWarren_2021.pdf) or in [wikipedia](https://en.wikipedia.org/wiki/Air_quality_index#United_States)
![](./06_Images/AQI.png)




