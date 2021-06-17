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
A well formatted GeoJSON file that has the extracted metadata.


### Extracted metadata
+ The minimum bounding box
+ The temporal extent
+ The mission track
+ The names of the variables
+ The dimensions names


The track of the mission is generalized using Douglas-Peucker Algorithm

### How to use
+ Place the downloaded NetCDF files in a directory on your hard drive. Provide that directory to the variable files_Directory.
+ Provide the file name whose metadata you want to get extracted in the variable
file_Name.
+ Provide the directory of the Gepjson output folder in the variable geoJSONOutput.
+ To explore with the dinamic generalization values:
    + Run the rmd script
Extracting metadata from NetCDF files in R.
    + Run the script Testing generalization values.R
