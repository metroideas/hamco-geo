#!/bin/sh
# Shell script converts src/**/*.shp to dist/*.geo.json
#
# Usage:
#
# $ chmod 755 shp2json.sh
# $ ./shp2json.sh
# 
#
# Assumes that shapefiles are located in a single input directory:
#
# src/census-blockgroups/tl_2010_47065_bg10.dbf
# src/census-blockgroups/tl_2010_47065_bg10.prj
# src/census-blockgroups/tl_2010_47065_bg10.shp
# src/census-blockgroups/tl_2010_47065_bg10.shp.xml
# src/census-blockgroups/tl_2010_47065_bg10.shx
#  
# Input dirname will become the output filename:
# src/census-blockgroups/tl_2010_47065_bg10.* -> dist/census-blockgroups.geo.json

# Clean dist/
rm -rf dist
mkdir dist


# ogr2ogr conversion function. To use:
# shp2json $OUTPUT_PATH $INPUT_PATH
#
shp2json() {
  echo "Converting $2 to $1"
  ogr2ogr -f GeoJSON -t_srs EPSG:4326 $1 $2
}

# Loop through src/ directories
for PRE in src/*
do
  INPUT_PATH=$PRE/*.shp
  OUTPUT_PATH=${PRE/#src/dist}.geo.json
  
  shp2json $OUTPUT_PATH $INPUT_PATH
done

exit

