package haxespike;

class Component {

    private var components: Array<Component> = [];

    public function updateLogic() {
        for (c in components) {
            c.updateLogic();
        }
    }

    public function render(screen: BitmapData) {
        for (c in components) {
            c.render(screen);
        }
    } 
}

