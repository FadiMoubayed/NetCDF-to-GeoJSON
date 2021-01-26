


# This function converts coordinates from a martix to a numeric list
# The coordinates are assumed to be in the first 2 columns of the matrix
# There is no control on having only having a matrix with 2 colomns
# The coordinates are converted to a numeric list so they can be added
# in the form of [x,y] to the Json file and the converted to Geojson
# If I use the coordinates saved to a matrix they will be added as
# {x:4, y:5}
# The function geojosn_list from the library geojson did not work well

coordsToNumericList = function(matrix){
  list = list()
  for(i in 1:length(matrix[,1])){
    list[[i]]= c(matrix[[i,1]], matrix[[i,2]])
  }
  return(list)
}
