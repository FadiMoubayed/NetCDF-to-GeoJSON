# Extracting-metadata-from-glider-NetCDF-files
Extracts metadata from the glider NetCDF files into a GeoJSON file using R.
The extracted metadata will be mapped to O&M


### Extracted metadata
+ The minimum bounding box
+ The temporal extent
+ The mission track
+ The names of the variables
+ The dimensions names


The track of the mission is generalized using Douglas-Peucker Algorithm


### Result
The metadata is saved in a GeoJSON file.
