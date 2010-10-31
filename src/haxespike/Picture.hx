package haxespike;

import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.geom.Point;

// Sprite class, gets picture from a spritesheet.
class Picture
{
   var sheet: BitmapData;
   var area: Rectangle;
   var location: Point;
   var hotSpotX: Int;
   var hotSpotY: Int;
 
   public function new(source:BitmapData, sourceX: Int, sourceY:Int, sourceW:Int, sourceH:Int, sourceHotSpotX: Int, sourceHotSpotY: Int)
   {
      sheet = source;
      area = new Rectangle(sourceX,sourceY,sourceW,sourceH);
      hotSpotX = sourceHotSpotX;
      hotSpotY = sourceHotSpotY;
      location = new Point(0, 0); // Cache point object
   }

   public function render(target: BitmapData, x: Int, y: Int)
   {
      location.x = x - hotSpotX;
      location.y = y - hotSpotY;
      target.copyPixels(sheet,area,location);
   }
}
 

