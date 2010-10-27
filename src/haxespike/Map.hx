package haxespike;

class Map {

    private var w: Int;
    private var h: Int;
    private var tiles: Array<Tile> = [];
    private var things: Array<Thing> = [];

    function updateLogic() {
        for (c in things) {
            c.updateLogic();
        }
    }

    function render(screen: BitmapData) {
        for (c in things) {
            c.render(screen);
        }
    } 
}

