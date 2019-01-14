#Load Libraries

library(leaflet)
library(geojsonio)
library(viridis)
library(dplyr)
library(readr)

#Load GeoJson Data from DHHS Web API 


LGA <- geojsonio::geojson_read("http://data-dhs.opendata.arcgis.com/datasets/1d451fe314e34caa8f563529c242da26_0.geojson", what = "sp")

#Load and join other Data into the Main dataset

 #TestData <- read_csv("TestData.csv")

 #Areas@data <- left_join(Areas@data,TestData, by = "ServiceAreaID")


#create the colour scale
pal <- colorNumeric("viridis", NULL)


#Create the map
#Use % of population who are Aboriginal
leaflet(LGA) %>%
  addTiles() %>%
  addPolygons(stroke = TRUE, 
              weight = 1, 
              color = "white",
              smoothFactor = 0.8, fillOpacity = .5,
              fillColor = ~pal(AboriginalPop),
              label = ~paste0(LGA_NAME15, ": ", formatC(AboriginalPop, big.mark = ","))
              ) %>%
  addLegend(pal = pal, values = ~AboriginalPop, opacity = 1.0,
                         labFormat = labelFormat(transform = function(x) round(x)))

