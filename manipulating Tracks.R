library(sp)
library(trajectories)
library(manipulate)

# This function uses the gSimplify function to generalze the geomentry of the
# glider traks (only the lines of the track are generalized)
simplifyTrack <- function(Track, tol){
  
  for(i in seq_along(Track@data)){
    l = Lines(list(Line(Track@sp)), paste("L", i, sep = ""))
    sp = SpatialLines(list(l), proj4string = Track@sp@proj4string)
    sp = rgeos::gSimplify(spgeom = sp, tol = tol, topologyPreserve = TRUE)
    return(sp)
  }
}
# This is an example of the previous function
manipulate(plot(simplifyTrack(A1,tol = n)), n=slider(0.2,0.5))


# This function simplifies the geometry of tracks
# It plots the original track and the simplified one
plotSimplifiedTrack <- function(Track, tol){
  
  for(i in seq_along(Track@data)){
    l = Lines(list(Line(Track@sp)), paste("L", i, sep = ""))
    sp = SpatialLines(list(l), proj4string = Track@sp@proj4string)
    sp = rgeos::gSimplify(spgeom = sp, tol = tol, topologyPreserve = TRUE)
  }
  plot(Track, col = "blue")
  plot(sp, col = "red",add=TRUE)
}

# This is an example of the previous function
# A1 Track object example
manipulate(plotSimplifiedTrack(A1, tol = n),n=slider(0.01,0.2))
manipulate(plotSimplifiedTrack(A1, tol = n),n=slider(min = 0.001, max = 0.2, step = 0.005))

# First mission example
manipulate(plotSimplifiedTrack(missionTrack_File1, tol = n),n=slider(min = 0.001, max = 0.2, step = 0.005))

# This function plots the generalized track using distance and the gSimplify functions
plotGeneralizedTrack = function(Track, distance, tol){
  generalizedTrack = generalize(Track, distance = distance, tol= tol)
  plot(Track, col = "blue")
  plot(generalizedTrack, col = "red",add=TRUE)
}

# This is an example of the previous function
manipulate(plotGeneralizedTrack(missionTrack_File1, distance = d, tol = t),d = slider(1000,10000), tol = slider(0.001,100))

# This section tries adding a check box to the previous functin to plot the original track
# This function plots the generalized track using distance and the gSimplify functions
plotGeneralizedTrack2 = function(Track, distance, tol, drawSimplified){
  generalizedTrack = generalize(Track, distance = distance, tol= tol)
  if(drawSimplified){
    plot(Track, col = "blue")
  } 
  
    plot(generalizedTrack, col = "red",add=TRUE)
}

# This is an example of the previous function
manipulate(
  plotGeneralizedTrack2(missionTrack_File1, distance = d, tol = t, drawSimplified = label),
  d = slider(1000,100000), tol = slider(0.001,100),
  label = checkbox(initial = TRUE, label = "Draw Original")
  )


# Testing with values
# The original track

gen1 = generalize(missionTrack_File1, distance = 1000)
gen2 = generalize(missionTrack_File1, distance = 1500)
gen3 = generalize(missionTrack_File1, distance = 2000)


length(coordinates(gen1)[,1])
length(coordinates(gen2)[,1])
length(coordinates(gen3)[,1])

genTol = generalize(missionTrack_File1, distance = 1000, tol = 0.006)
# Comparing the first line
coordinates(gen1@sp@lines[[1]])
coordinates(genTol@sp@lines[[1]])