#!/bin/sh

mkdir -p build

echo "### Generating resource descriptions"
bash swfml_gen.sh images > build/resources.xml

echo "### Building resource library"
cat build/resources.xml | swfmill simple stdin build/resources.swf

#swfmill simple resources.swfml  resources.swf

echo "### Compiling"
haxe compile.hxml

echo "### Running test page"
firefox src/test.html &

