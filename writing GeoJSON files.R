library(geojsonio)
library(geojson)
library(geojsonlint)
library(geojsonR)
library(wellknown)
library(sf)
library(trajectories)

# Getting the coordinates of the Track object A1
coordsA1 = A1@sp@coords


################################################################################
# Using the library geojsonio
################################################################################

# This is the path to the directory where I am experimenting writing GeoJSON files
pathgeojsonio = "/home/fadi/DataX1/University/WWU/WWU 5/Task 2/GeoJson/Experimenting writing GeoJSON files/geojsonio/A1/"

# I am still experimenting different ways to write a GeoJSON file using differnt
# libraries in R


# Writing a geojson file using the library geojsonio
# In this case the coordinates are repeated twice in the GeoJSON file 
geojsonio::geojson_write(coordsA1, file = paste(pathgeojsonio,"testfile0.geojson"))

# Converting the coordinates to a GoeJson List
# This function converts many input types with spatial data to geojson specified as a list
geoJsonList = geojson_list(coordsA1)
# The GoeJSON file is different in this case
geojsonio::geojson_write(geoJsonList, file = paste(pathgeojsonio,"geoListcoordsA1.geojson"))

# Writing one point to a GeoJSON
p1 = st_point(c(1,2))
geojsonio::geojson_list(p1)
geojsonio::geojson_write(p1, file = paste(pathgeojsonio,"onePoint1.geojson"))

p2 = st_point(c(1,2,3))
geojsonio::geojson_list(p2)
geojsonio::geojson_write(p2, file = paste(pathgeojsonio,"onePoint2.geojson"))

p3 = st_point(c(1,2,3), "XYM")
geojsonio::geojson_list(p3)
geojsonio::geojson_write(p3, file = paste(pathgeojsonio,"onePoint3.geojson"))

# Writing a linestring to GeoJSON
pts = matrix(1:10, , 2)
ls1 = st_linestring(pts)
geojsonio::geojson_list(ls1)
geojsonio::geojson_write(ls1, file = paste(pathgeojsonio,"LineString.geojson"))

# Implementing on real tracks
m1spLineString = st_linestring(missionTrack_File1@sp@coords)
geojsonio::geojson_write(m1spLineString, file = paste(pathgeojsonio,"m1splineString.geojson"))

################################################################################
# Using the library geojson
################################################################################
geojsonpath = "/home/fadi/DataX1/University/WWU/WWU 5/Task 2/GeoJson/Experimenting writing GeoJSON files/geojson/"

# To get help of the linesrting function that belongs to the geojson library
?geojson::linestring # Does not accpet matrix as input
# I am trying here to use the function geojson_list to see if it works here
coordsA1GeoJSONList = geojson_list(coordsA1) # Does not work
# I don't know what kind of input linestring accepts!

# The input the this library accepts is defined in as.geojson
sp = SpatialPoints(A1@sp@coords) # check adding the CRS and BBox
geo = as.geojson(sp) # geojsonio::geojson_write works with this

# Maybe creating a linestring needs an object of class SpatialLines

linestring = geojson::linestring()



# trying creating Json objects using the library jsonlite
coordsA1Json = jsonlite::toJSON(coordsA1)

featureData = list(id = 1, type = "LineString",coordinates = coordsA1 ,properties = list(bbox = c(1,2,3,4), timespan = "1/1/2019 - 31-10-2020"))
featureData2 = list(list(id = 1, type = "LineString",coordinates = coordsA1) ,properties = list(bbox = c(1,2,3,4), timespan = "1/1/2019 - 31-10-2020"))

featureDataJSON = jsonlite::toJSON(featureData)
featureDataJSONCharacter = as.character(featureDataJSON)
linestring(featureDataJSONCharacter) %>% feature()

# This example works but I need to find a way to add '' to the json object
# adding ' ' is done by using as.character
# It looks like I only need to add one json object
# I need to get rid of [] around type. Otherwise it throws an error
x = '{"type":"LineString","coordinates":[[7,7],[6,7],[5,6],[5,5],[4,5],[3,6],[3,7]],"properties":{}} '
linestring(x) %>% feature()

# Trying to play around with creating the JSON object using a different library
featureData = list(id = "1", type = "LineString",coordinates = list ,properties = list(bbox = c(1,2,3,4), timespan = "1/1/2019 - 31-10-2020"))
featureDataRJSONIO = RJSONIO::toJSON(featureData)
linestring(featureDataRJSONIO) %>% feature()

# Using the library rjson
# This might be promising!!!!
# I am saving the coordingates in a list instead of a martix using the function
# I wrote below
listCoords = coordsToNumericList(coordsA1)
featureData = list(id = "1", type = "LineString",coordinates = listCoords ,properties = list(bbox = c(1,2,3,4), timespan = "1/1/2019 - 31-10-2020"))
featureDatarjson = rjson::toJSON(featureData)
trackLineString = linestring(featureDatarjson) %>% feature()
trackLineString1 = linestring(featureDatarjson)
geo_write(trackLineString, file = paste(geojsonpath,"A1lineString.geojson"))
geo_write(trackLineString1, file = paste(geojsonpath,"A1lineString1.geojson"))

# I am trying here to organise the GeoJSON file
# I am trying to put the geometry in one JSON file and the properties the fearure
# is going to have in an another Json file and in the end I will use the feature
# function from the geojson library to create the geojson file
# I need one json file with 2 main members: geometry and propoerties I don't think
# I need two json files

# converting the coordinates from a martix to a list
TrackPoints = coordsToNumericList(coordsA1)
# creating a list that contains the necessary information to create a linestring
# Json object which will be used to create the linestring
lineStringInfo = list(type = "LineString",coordinates = TrackPoints)
# Converting the linestring info to JSON
lineStringInfoJSON = rjson::toJSON(lineStringInfo)
# creating a linestring objet out of the lineStringInfoJSON
trackLineString = linestring(lineStringInfoJSON)
# writing the results to disk to check what I got
geo_write(trackLineString, file = paste(geojsonpath,"A1lineString.JSON"))
# Above I have a JOSN file that only has the LineString with the coordinates

# Now I need to put the properties in a JSON file
featureProperties = list(id = "1", bbox = c(1,2,3,4), timespan = "1/1/2019 - 31-10-2020")
# converting the feature properties to JSON
featurePropertiesJSON = rjson::toJSON(featureProperties)
# writing the results to disk to check what I got
jsonlite::write_json(featurePropertiesJSON, path = paste(geojsonpath,"featureProperties.JSON"))

#trying to create one JSON file that has the geometry and properties
AllFeatureInfo = list(geometry = lineStringInfo, properties = featureProperties)
AllFeatureInfoJSON = rjson::toJSON(AllFeatureInfo)
jsonlite::write_json(AllFeatureInfoJSON, path = paste(geojsonpath,"AllfeatureProperties.JSON"))

#######
###### THIS IS WHAT I WANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
AllFeatureTest = trackLineString %>% feature()  %>%  properties_add(featureProperties)
geo_write(AllFeatureTest, file = paste(geojsonpath,"allfeaturetes.geojson"))

AllFeatureTest2 = trackLineString %>% feature()  %>%  properties_add( .list = featureProperties)  
geo_write(AllFeatureTest2, file = paste(geojsonpath,"allfeaturetes2.geojson"))




################################################################################
# Using the library wellknown
################################################################################

pathwellknwon = "/home/fadi/DataX1/University/WWU/WWU 5/Task 2/GeoJson/Experimenting writing GeoJSON files/wellknown/"

# Trying to create a linestring object
linestringA1wellknown = wellknown::linestring(coordsA1)

################################################################################
# Using the library geojsonR
################################################################################
# There is no way to save the GoeJSON file to the disk!!! 

pathgeojsonR = "/home/fadi/DataX1/University/WWU/WWU 5/Task 2/GeoJson/Experimenting writing GeoJSON files/geojsonR/"
# Example on dummy points

init = TO_GeoJson$new()
geoJsonList = geojson_list(coordsA1)
linestring_dat = list(c(100, 1.01), c(200, 2.01))
line_string = init$LineString(linestring_dat, stringify = TRUE)
line_string2 = init$LineString(geoJsonList, stringify = TRUE)


# This looks like the right solution
# This function converts coordinates from a martix to a numeric list
# The coordinates are assumed to be in the first 2 columns

coordsToNumericList = function(matrix){
  list = list()
  for(i in 1:length(matrix[,1])){
    list[[i]]= c(matrix[[i,1]], matrix[[i,2]])
  }
  return(list)
}

  
# testing the function
listCoords = coordsToNumericList(coordsA1)
line_string = init$LineString(listCoords, stringify = TRUE) # works well

feature_dat1 = list(id = "1", bbox = c(1,2,3,4), geometry = list(LineString = listCoords),
                    properties = list())

feature_obj = init$Feature(feature_dat1, stringify = TRUE)

