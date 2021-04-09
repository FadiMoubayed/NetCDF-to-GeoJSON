library(sp)
library(trajectories)
library(manipulate)

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


length(coordinates(gen0)[,1])
length(coordinates(gen1)[,1])
length(coordinates(gen2)[,1])
length(coordinates(gen3)[,1])
length(coordinates(gen4)[,1])
length(coordinates(gen5)[,1])


# Based on distance and tolerance
# After the optimal distance for generalization is determined, the tolerance is
# explored
genTol1 = generalize(missionTrack, distance = 500, tol = 0.0001)
genTol2 = generalize(missionTrack, distance = 500, tol = 0.001)
genTol3 = generalize(missionTrack, distance = 500, tol = 0.01)
genTol4 = generalize(missionTrack, distance = 500, tol = 0.1)
genTol5 = generalize(missionTrack, distance = 500, tol = 1)
genTol6 = generalize(missionTrack, distance = 500, tol = 10)

length(coordinates(genTol1)[,1])
length(coordinates(genTol2)[,1])
length(coordinates(genTol3)[,1])
length(coordinates(genTol4)[,1])
length(coordinates(genTol5)[,1])
length(coordinates(genTol6)[,1])


# Comparing the first line
coordinates(gen1@sp@lines[[1]])
coordinates(genTol1@sp@lines[[1]])