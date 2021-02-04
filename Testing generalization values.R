library(sp)
library(trajectories)
library(manipulate)

# The script Extracting metadata from NetCDF needs to run first before this
# script is run

# This function uses the gSimplify function to generalze the geomentry of the
# This function plots the generalized track using distance and the gSimplify functions
plotGeneralizedTrack = function(Track, distance, tol){
  generalizedTrack = generalize(Track, distance = distance, tol= tol)
  plot(Track, col = "blue")
  plot(generalizedTrack, col = "red",add=TRUE)
}

# This is an example of the previous function
manipulate(plotGeneralizedTrack(missionTrack, distance = d, tol = t),
           d = slider(min = 100, max = 100000, step = 100), 
           tol = slider(min = 0.001, max = 100, step = 0.001))


# Testing with values
# Based only on distance
# The original track

gen1 = generalize(missionTrack, distance = 1000)
gen2 = generalize(missionTrack, distance = 1500)
gen3 = generalize(missionTrack, distance = 2000)


length(coordinates(gen1)[,1])
length(coordinates(gen2)[,1])
length(coordinates(gen3)[,1])

# Based on distance and tolerance
# After the optimal distance for generalization is determined, the tolerance is
# explored
genTol1 = generalize(missionTrack_File1, distance = 1000, tol = 0.006)
genTol2 = generalize(missionTrack_File1, distance = 1000, tol = 0.008)
genTol3 = generalize(missionTrack_File1, distance = 1000, tol = 0.009)

# Comparing the first line
coordinates(gen1@sp@lines[[1]])
coordinates(genTol1@sp@lines[[1]])