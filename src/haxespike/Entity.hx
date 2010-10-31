package haxespike;

interface Entity {

    function init(host: Entity);

    function updateLogic(currentTimeMs: Long, timeDeltaS: Float);
    
    function render(screen: BitmapData);
    
}


