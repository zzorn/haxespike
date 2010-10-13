#!/bin/sh

bash swfml_gen.sh images > resources.xml
cat resources.xml | swfmill simple stdin resources.swf

#swfmill simple resources.swfml  resources.swf

haxe compile.hxml

firefox test.html &

