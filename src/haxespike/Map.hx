package haxespike;
import flash.Vector;
import flash.display.Bitmap;
import flash.display.BitmapData;

class Map implements Component {

    var w: Int;
    var h: Int;

    var tiles: Vector<TileType>;
    var entities: Array<Entity>;

    public function new(width: Int, height: Int, tile: TileType) {
        w = width;
        h = height;
        tiles = new Vector<TileType>(w * h, true);
        for (i in 0 ... w * h) tiles[i] = (tile);
    } 

    public function set(x: Int, y: Int, tile: TileType) {
        tiles[y * w + x] = tile;        
    }

    public function fill(x1: Int, y1: Int, x2: Int, y2: Int, tile: TileType) {
        for (j in y1 ... y2) {
            for (i in x1 ... x2) {
                tiles[j * w + i] = tile;        
            }
        }
    }

    public function get(x: Int, y: Int): TileType {
        return tiles[y * w + x];
    }
    
    public function updateLogic(time: Time) {
        for (e in entities) {
            e.updateLogic(time);
        }
    }

    public function render(screen: BitmapData) {
        // Render map
    
      trace("render map");
    
        for (e in entities) {
            e.render(screen);
        }
    } 
}

