package haxespike;
import flash.display.BitmapData;

interface Entity implements Component {

    public function onMap(): Bool;
    public function xPos(): Float;
    public function yPos(): Float;
    public function zPos(): Float;

    
}


