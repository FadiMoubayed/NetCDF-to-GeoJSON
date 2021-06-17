plotGeneralizedTrackDistance = function(Track, distance){
  generalizedTrack = generalize(Track, distance =distance)
  plot(Track, col = "blue")
  plot(generalizedTrack, col = "red",add=TRUE)
}

# This is an example of the previous function
manipulate(plotGeneralizedTrackDistance(Track = missionTrack, distance = d),
           d = slider(min = 100, max = 50000, step = 100))


manipulate(
plot(generalize(missionTrack, distance = d, tol= tol)),
d = slider(min = 100, max = 50000, step = 100), 
tol = slider(min = 0.001, max = 100, step = 0.0001))


manipulate(
  plot(generalize(missionTrack, distance = d)),
  d = slider(min = 100, max = 50000, step = 100))
