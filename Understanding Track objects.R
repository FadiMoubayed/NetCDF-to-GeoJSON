library("manipulate")
library("spacetime")
library("sp")

set.seed(10)

t0 = as.POSIXct(as.Date("2013-09-30",tz="CET"))
x = c(7,6,5,5,4,3,3)
y = c(7,7,6,5,5,6,7)

n = length(x)
t = t0 + cumsum(runif(n) * 60)
crs = CRS("+proj=longlat +datum=WGS84") # longlat
stidf = STIDF(SpatialPoints(cbind(x,y),crs), t, + data.frame(co2 = rnorm(n,mean = 10)))
A1 = Track(stidf)
A1

plot(A1)


attributes(A1)

A2 = generalize(A1, distance = 100)



for(i in seq_along(A1@data)){
  l = Lines(list(Line(A1@sp)), paste("L", i, sep = ""))
  sp = SpatialLines(list(l), proj4string = A1@sp@proj4string)
  sp = rgeos::gSimplify(spgeom = sp, tol = 0.5, topologyPreserve = TRUE)
}


plottrack <- function(Track, tol){
  
  for(i in seq_along(Track@data)){
    l = Lines(list(Line(Track@sp)), paste("L", i, sep = ""))
    sp = SpatialLines(list(l), proj4string = Track@sp@proj4string)
    sp = rgeos::gSimplify(spgeom = sp, tol = tol, topologyPreserve = TRUE)
    #plot = manipulate(plot(sp), tol=slider(0.2,0.5))
    return(sp)
  }
}


manipulate(plot(plottrack(A1,tol = n)), n=slider(0.2,0.5))

manipulate(plot(plottrack(A1,tol = n), axes = axes,ann = label)
           , n=slider(0.2,0.5),axes = checkbox(TRUE, "Axes"),
           label = checkbox(TRUE, "Labels"))


manipulate(plot(plottrack(A1,tol = n), type = plot_type ,axes = axes,ann = label),
           n=slider(0.2,0.5),
           axes = checkbox(TRUE, "Axes"),
           plot_type = picker("p", "l", "b"),
           label = checkbox(TRUE, "Labels"))


manipulate(plot(plottrack(A1,tol = n), axes = axes,ann = label)
           , n=slider(0.2,0.5),axes = checkbox(TRUE, "Axes"),
           label = checkbox(TRUE, "Labels"))
par(new=TRUE)


points = A1@data
plot(plottrack(A1,tol = 0.05))
points(points) #to add points to the same plot

#keeping the original points
plottrack2 <- function(Track, tol){
  
  for(i in seq_along(Track@data)){
    l = Lines(list(Line(Track@sp)), paste("L", i, sep = ""))
    sp = SpatialLines(list(l), proj4string = Track@sp@proj4string)
    sp = rgeos::gSimplify(spgeom = sp, tol = tol, topologyPreserve = TRUE)
  }
  plot(Track, col = "blue")
  plot(sp, col = "red",add=TRUE)
}

manipulate(plottrack2(A1, tol = n),n=slider(0.01,0.2))
manipulate(plottrack2(A1, tol = n),n=slider(min = 0.001, max = 0.2, step = 0.005))

plotGeneralize = function(Track, distance, tol){
  generalizedTrack = generalize(Track, distance = distance, tol= tol)
  plot(Track, col = "blue")
  plot(generalizedTrack, col = "red",add=TRUE)
}

#the slider does not appear here
manipulate(plotGeneralize(missionTrack_File1, distance = d, tol = t),d = slider(1000,100000), tol = slider(0.001,5))

manipulate(plot(generalize(missionTrack_File1, distance = d)),d = slider(1000,1100))

manipulate(plot(generalize(missionTrack_File1, distance = d)),d = slider(1000,5000))
