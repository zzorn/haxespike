package haxespike;

import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.geom.Point;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import generated.LibraryClasses;

// Main lopp class.
// Extending Sprite to get double buffering, event and child object support.
class MainLoop extends Sprite
{

   var screen: BitmapData;

   // State for each key
   var keyDown: Array<Bool>;

   var components: Array<Component>;

   // Used to move monsters and the player, etc.  Independent from frame rate.
   var logicUpdatesPerSecond: Float;

   var time: Time;

   public function new(screenW: Int, screenH: Int) {
      trace("Test");
      // Call sprite constructor
      super();
      
      components = [];
      
      // Display ourselves
      flash.Lib.current.addChild(this);

      // Create and show screen bitmap
      screen = new BitmapData(screenW, screenH);
      addChild(new Bitmap(screen));

// DEBUG.  TODO: Install debug player.
     var testTile: Bitmap = new Brown_tile_png();
     var p: Picture = new Picture(testTile.bitmapData, 0, 0, 64, 80, 0, 0);
     p.render(screen, 100, 100);

      // Update key state
      keyDown = [];
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown );
      stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp );

      // TODO: Mouse listening

      logicUpdatesPerSecond = 15;

      // Call render frame on each flash frame
      stage.addEventListener(Event.ENTER_FRAME, onFrame);
 
      time = new Time();

   }

   public function addComponent(component: Component) {
   trace("added comp");
      components.push(component);   
   } 

   public function removeComponent(component: Component) {
      components.remove(component);
   } 

   function onKeyDown(event:KeyboardEvent)
   {
      if (!keyDown[event.keyCode])
      {
         keyDown[event.keyCode] = true;
      }
   }

   function onKeyUp(event:KeyboardEvent)
   {
      keyDown[event.keyCode] = false;
   }

   function onFrame(e:flash.events.Event)
   {
      time.update();

      updateLogic();

      // Lock screen to do a more efficient batched bitmap update.
      screen.lock();
      render();
      screen.unlock();
   }

   // Update the game logic one step.
   function updateLogic()
   {
      for (c in components) {
         c.updateLogic(time);
      }
   }

   // Draw current view of game
   function render()
   {
      // Clear to bg color
      screen.fillRect(new Rectangle(0,0,screen.width, screen.height),0x000000);

     var testTile: Bitmap = new Brown_tile_png();
     var p: Picture = new Picture(testTile.bitmapData, 0, 0, 64, 80, 0, 0);
     p.render(screen, 10, 10);

      // Draw things  
      for (c in components) {
         c.render(screen);
      }
   }

}

