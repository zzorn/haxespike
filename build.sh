#!/bin/sh

mkdir -p build

echo "### Generating resource descriptions"
bash swfml_gen.sh images > build/resources.xml

echo "### Building resource library"
cat build/resources.xml | swfmill simple stdin build/resources.swf

#swfmill simple resources.swfml  resources.swf

echo "### Compiling"
haxe compile.hxml

echo "### Copying to output"
mkdir -p out
rm out/*.swf
rm out/*.html
cp src/*html out/
cp build/test.swf out/

echo "### Running test page"
firefox out/test.html &

