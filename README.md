# Extracting-metadata-from-glider-NetCDF-files

### Description
Extracts metadata from the glider NetCDF files into a GeoJSON file using R.
The extracted metadata will be mapped to O&M

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
