#!/bin/sh

swfmill simple resources.swfml  resources.swf

haxe compile.hxml

firefox test.html &

