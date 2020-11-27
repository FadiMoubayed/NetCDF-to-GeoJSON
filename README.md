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
nc.get.proj4.string did not return anything!µ

### Extracting the mission track
This step extracts the mission track using the library trajectories and spacetime.

The sequence followed:

1. Formatiing time and combining lat lon with time:
+ Open the netcdf file (using ncdf4)
+ Get the lattitude and longitude variables (using netcdf4)
+ Get the time dimension and format it to POSIXct. This step also includes gettig
the time stamp and the date. The result is a dataframe that has the time formatted
in addition to the date and timestamp.
+ Combine the lat lon with the time. This step results in on dataframe that has
the lat, lon, time, timeStamp and date. The NA data is deleted from the dataframe.

2. Get the mission track object
+ Create a track object
+ Get the first value of the track mission of each day
+ Generalize the mission tracks

3. Plot the tracks in order to check the results

4. Get the minimum bounding box

#### Issues
+ I am not sure how to deal with the NA data. So far my approach deals with NA data
assuming that the NA in the lat and long match the NA in the time dimension. The
question that remains is what if the time dimension has NA that is not available in lat and lon? This is going to shift the measurement and mess up the dataframe.

+ With big files the processing is taking some time.
+ The code still needs to be organized
+ Pay attention to the order of lat, lon, time, date, timestamp
+ I need to have 2 general parts one for getting metadata and one for plotting and testing
+ Generalizing tracks is throwing an error due to the reference system
"CRS object has comment, which is lost in output"
+ Some labels (the first measurement of the day) are given at 2:00 a.m.
+ When I type the track object in the console, I get information such as the minimum bounding box and the time span of the mission. The problem is I don't know how to get that information into a variable.

#### Next steps
+ Add a function to genralize the mission track
+ The plotting functions do not work in R markdown. I need to fix This
+ Add getting the name of the variables to the metadata
+ Organize the section testing the functions
+ I need to decide on the form in which metadata extracted using the written functions is saved. Some libraries for writing GeoJson in R require objects to be saved in lists (S3 objects)
+ Add a function to get the number of NA in the netcdf file if any
