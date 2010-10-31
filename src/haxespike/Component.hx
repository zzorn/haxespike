package haxespike;
import flash.display.BitmapData;

interface Component {

    function updateLogic(time: Time): Void;
    
    function render(screen: BitmapData): Void;
}

