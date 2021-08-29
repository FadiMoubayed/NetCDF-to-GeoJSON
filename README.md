# Extracting-metadata-from-glider-NetCDF-files

### Description
Extracts metadata from the glider NetCDF files into a GeoJSON file using R.
The extracted metadata will be mapped to OGC O&M so the glider data gets
available through a spatial data infrastructure.

The NetCDF files are available through the following FTP server:

http://www.ifremer.fr/co/ego/ego/v2


### Input
The NetCDF glider metadata

### Output
A well formatted GeoJSON file that has the extracted glider metadata.


### Extracted metadata
+ Variable names
+ Number of variables
+ Dimensions names
+ Number of dimensions
+ Minimum bounding box
+ Track’s length
+ Number of coordinates
+ Time span
+ Generalized track
+ Track’s labels

The track of the mission is generalized using Douglas-Peucker Algorithm

## The resulting GeoJSON file has the following structure:

A feature collection that contains two features
+ A LineString representing the generalized track
    + The properties include
    + Variable names
    + Number of variables
    + Dimensions names
    + Bounding box
    + Track length
    + Number of points
    + Time span
    + The geometry includes the coordinates of the generalized track

+ MultiPoint representing the track’s map labels
    + The properties include
        +  The extracted time stamps
    + The geometry includes
        + The labels’ coordinates


## How to use
+ Place the downloaded NetCDF files in a directory on your hard drive. Provide that directory to the variable files_Directory.
+ Provide the file name whose metadata you want to get extracted in the variable
file_Name.
+ Provide the directory of the Gepjson output folder in the variable geoJSONOutput.
+ To explore with the dinamic generalization values:
    + Run the rmd script
Extracting metadata from NetCDF files in R.
    + Run the script Testing generalization values.R
