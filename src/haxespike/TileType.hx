package haxespike;

import LibraryClasses;
import flash.display.Bitmap;
import flash.display.BitmapData;

class TileType {

    var bitmap: Bitmap;
    var blocking: Bool;
    
    public function new(pic: Bitmap, block: Bool) {
      bitmap  = pic;
      blocking = block;
    }

}

