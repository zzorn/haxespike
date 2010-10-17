import flash.display.MovieClip;
import LibraryClasses;
import Blob;

import flash.display.Bitmap;
import flash.display.BitmapData;

class Test {
    static function main() {
        trace("Hello World !");

        var mc: MovieClip = flash.Lib.current;
        mc.graphics.beginFill(0x336611);
        mc.graphics.moveTo(50,50);
        mc.graphics.lineTo(100,50);
        mc.graphics.lineTo(100,100);
        mc.graphics.lineTo(50,100);
        mc.graphics.endFill();

        var x = 100;
        var y = 100;

        var bitmap: Bitmap = new Brown_tile_png();
        var bd: BitmapData = bitmap.bitmapData;
        mc.graphics.beginBitmapFill(bd);
        mc.graphics.drawRect(bd.rect.x, bd.rect.y, bd.rect.width, bd.rect.height);
        mc.graphics.endFill();
    }
}

