package haxespike;

interface Component {

    function init(host: Entity);

    function updateLogic();
    
    function render(screen: BitmapData);
    
}

