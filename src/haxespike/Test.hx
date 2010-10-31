package haxespike;

import flash.display.MovieClip;
import generated.LibraryClasses;
import haxespike.Picture;

import flash.display.Bitmap;
import flash.display.BitmapData;

class Test {
    static function main() {
        //trace("Hello World !");

        var mainLoop = new MainLoop(800, 600);
        trace("Test");
      
        var mapGen = new SimpleMapGenerator();
     
        mainLoop.addComponent(mapGen.generateMap({}));
        
    }
}

