# In this file I am demonstrating how to create a GeoJOSN file in R
# Using the library geojson

# Providing the path where the fils will be saved
geojsonpath = "/home/fadi/DataX1/University/WWU/WWU 5/Task 2/GeoJson/Experimenting writing GeoJSON files/geojson/"

# This function converts coordinates from a martix to a numeric list
# The coordinates are assumed to be in the first 2 columns

coordsToNumericList = function(matrix){
  list = list()
  for(i in 1:length(matrix[,1])){
    list[[i]]= c(matrix[[i,1]], matrix[[i,2]])
  }
  return(list)
}

# converting the coordinates from a martix to a list
TrackPoints = coordsToNumericList(coordsA1)
# creating a list that contains the necessary information to create a linestring
# Json object which will be used to create the linestring
lineStringInfo = list(type = "LineString",coordinates = TrackPoints)
# Converting the linestring info to JSON
lineStringInfoJSON = rjson::toJSON(lineStringInfo)
# creating a linestring objet out of the lineStringInfoJSON
trackLineString = linestring(lineStringInfoJSON)
# creating the gosJSON file
AllFeatureTest2 = trackLineString %>% feature()  %>%  properties_add( .list = featureProperties)
# creating a list of the properties
featureProperties = list(id = "1", bbox = c(1,2,3,4), timespan = "1/1/2019 - 31-10-2020")


# writing the goeJSON file to disk
geo_write(AllFeatureTest2, file = paste(geojsonpath,"allfeaturetes2.geojson"))

################################################################################
# If I were to use writeOGR
################################################################################

# 1. I need to have create a SpatialLinesDataFrame object
#   
#   The properties have to be in a dataframe
#       - How would for example the names of the variables be saved in a dataframe
#       - considering that the length of the dataframe has to be the same as the 
#         coordinated
# 2. To create a SpatialLinesDataFrame, I need to create a SpatialLines object 
#     To create a SpatialLines I need to create a LinesList which is a list with objects of class Lines-class
#     To create a LinesList I need to create an object of class Lines
#     Should I manually loop through the coordinates saved in a matrix and
#     convert them to Line objects and then create a list?

#   When creating a Lines(slinelist, ID) is each couple of coordinates considered
#   a line (only one pari of x,y) or is it possible to create a Lines object out
#   of a set of coordinates

# creating a line object out of the coordinates
lineA1 = Line(coordsA1)
# creating a Lines object
lineA1List = Lines(list(lineA1), ID = "a")
# creating a SpatialLines object
lineA1ListSpatialLines = SpatialLines(list(lineA1List)) # in this case a list of one element

####!!!!!!!!!!!!Question!!!!!!!#####
# How to save the properties in a way that it matches the length of the SpatialLInes?
featuresDataFrame = data.frame(featureProperties) # this is not the solution

################################################################################
# An example of creating a SpatialLinesDataFrame
################################################################################

## from the sp vignette:
l1 <- cbind(c(1, 2, 3), c(3, 2, 2))
l2 <- cbind(c(1, 2, 3), c(1, 1.5, 1))

Sl1 <- Line(l1)
Sl2 <- Line(l2)

S1 <- Lines(list(Sl1), ID = "a")
S2 <- Lines(list(Sl2), ID = "b")

Sl <- SpatialLines(list(S1, S2))

## sample data: line lengths
library(rgeos)
df <- data.frame(len = sapply(1:length(Sl), function(i) gLength(Sl[i, ])))
rownames(df) <- sapply(1:length(Sl), function(i) Sl@lines[[i]]@ID)


## SpatialLines to SpatialLinesDataFrame
Sldf <- SpatialLinesDataFrame(Sl, data = df)