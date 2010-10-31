package haxespike;


class SimpleMapGenerator implements MapGenerator {

  public function new() {
  }

  public function generateMap(params: Dynamic): Map {
  
    var map = new Map(30, 30, Config.grassTile);

    return map;   
  }

}
