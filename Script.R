library(leaflet)
library(geojsonio)
library(viridis)
library(dplyr)
library(readr)

Areas <- geojsonio::geojson_read("ServiceAreas_simple.json", what = "sp")
TestData <- read_csv("TestData.csv")


Areas@data <- left_join(Areas@data,TestData, by = "ServiceAreaID")


pal <- colorNumeric("viridis", NULL)

leaflet(Areas) %>%
  addTiles() %>%
  addPolygons(stroke = TRUE, 
              weight = 1, 
              color = "white",
              smoothFactor = 0.8, fillOpacity = .5,
              fillColor = ~pal(Value),
              label = ~paste0(ServiceArea, ": ", formatC(Value, big.mark = ","))
              ) %>%
  addLegend(pal = pal, values = ~Value, opacity = 1.0,
                         labFormat = labelFormat(transform = function(x) round(x)))

