library(sp)
library(trajectories)
library(manipulate)


# To populate the manipulate slider
manipulate(plot(1:x), x = slider(1, 100))

# Setting the margins so I don't get the error figure margins too large
par(mar=c(2,2,2,2))

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
manipulate(plotGeneralizedTrack(Track = missionTrack, distance = distance, tol = tol),
           distance = slider(min = 100, max = 5000, step = 100), 
           tol = slider(min = 0.01, max = 100, step = 0.01))



# Testing with values
# Based only on distance
# The original track

gen0 = generalize(missionTrack, distance = 500)
gen1 = generalize(missionTrack, distance = 1000)
gen2 = generalize(missionTrack, distance = 1500)
gen3 = generalize(missionTrack, distance = 2000)
gen4 = generalize(missionTrack, distance = 2500)
gen5 = generalize(missionTrack, distance = 3000)
gen6 = generalize(missionTrack, distance = 3500)

# Getting the number of coordinates
length(coordinates(gen0)[,1])
length(coordinates(gen1)[,1])
length(coordinates(gen2)[,1])
length(coordinates(gen3)[,1])
length(coordinates(gen4)[,1])
length(coordinates(gen5)[,1])
length(coordinates(gen6)[,1])

# Getting the number of lines
length(gen0@sp@lines)
length(gen1@sp@lines)
length(gen2@sp@lines)
length(gen3@sp@lines)
length(gen4@sp@lines)
length(gen5@sp@lines)
length(gen6@sp@lines)

# Based on distance and tolerance
# After the optimal distance for generalization is determined, the tolerance is
# explored
distanceTol = 500
genTol1 = generalize(missionTrack, distance = distanceTol, tol = 0.0001)
genTol2 = generalize(missionTrack, distance = distanceTol, tol = 0.001)
genTol3 = generalize(missionTrack, distance = distanceTol, tol = 0.01)
genTol4 = generalize(missionTrack, distance = distanceTol, tol = 0.1)
genTol5 = generalize(missionTrack, distance = distanceTol, tol = 1)
genTol6 = generalize(missionTrack, distance = distanceTol, tol = 10)

# Getting the number of coordinates
length(coordinates(genTol1)[,1])
length(coordinates(genTol2)[,1])
length(coordinates(genTol3)[,1])
length(coordinates(genTol4)[,1])
length(coordinates(genTol5)[,1])
length(coordinates(genTol6)[,1])

# Getting the number of lines
length(genTol1@sp@lines)
length(genTol2@sp@lines)
length(genTol3@sp@lines)
length(genTol4@sp@lines)
length(genTol5@sp@lines)
length(genTol6@sp@lines)


# Comparing the first line
# Using only the distance, the line has significantly a higher number of points representing it
# while using the tolerance vlaue, the number of points is significantly less
coordinates(gen1@sp@lines[[1]])
coordinates(genTol1@sp@lines[[1]])