# Extracting-metadata-from-glider-NetCDF-files
Extracts metadata from the glider NetCDF files into a JSON file using R

### Reading the netCDF files
+ Time is accessed as a dimension not as a variable. I am not sure if this is
correct.
+ I was only able to read the netCDF file using the library ncdf.
+ Using the stars library:  The functions read_stars and read_ncdf did not work for reading the netCDF files

### Extracted metadata
+ The minimum bounding box
+ The temporal extent
+ The mission track (so far as a leaflet map)

The track of the mission should be generalized. It is not efficient to include
all the coordinates of the track.

### Other ideas for metadata
+ If a variable includes NA data in addition to the number of NA the variable has
+ The variables available in the netCDF file
+ The projection of the netCDF file (Not available in the file!)
nc.get.proj4.string did not return anything!

### Extracting the mission track
This step extracts the mission track using the library trajectories and spacetime.

The sequence followed:

+ open the netcdf file (using ncdf4)
+ get the lattitude and longitude variables (using netcdf4)
+ get the time dimension and format it to POSIXct. This step also includes gettig
the time stamp and the date. The result is a dataframe that has the time formatted
in addition to the date and timestamp.
+ combine the lat lon with the time. This step results in on dataframe that has
the lat, lon, time, timeStamp and date. The NA data is deleted from the dataframe.

#### Issues
+ I am not sure how to deal with the NA data. So far my approach deals with NA data
assuming that the NA in the lat and long match the NA in the time dimension. The
question that remains is what if the time dimension has NA that is not available in lat and lon? This is going to shift the measurement and mess up the dataframe.

+ With big files the processing is taking some time.
