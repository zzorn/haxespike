package haxespike;

class Entity {

    private var components: Array<Component> = [];

    function updateLogic() {
        for (c in components) {
            c.updateLogic();
        }
    }

    function render(screen: BitmapData) {
        for (c in components) {
            c.render(screen);
        }
    } 
}

