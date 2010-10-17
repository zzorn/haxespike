import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.geom.Point;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

// Main lopp class.
// Extending Sprite to get double buffering, event and child object support.
class MainLoop extends Sprite
{
   static public function main()
   {
      // TODO: Load and initialize any needed data  

      // Start      
      new MainLoop(800, 600);
   }


   var screen: BitmapData;

   // State for each key
   var keyDown: Array<Bool>;

   // Used to move monsters and the player, etc.  Independent from frame rate.
   var logicUpdatesPerSecond: Float;

   var lastUpdated: Float;

   function new(screenW: Int, screenH: Int) {
      // Call sprite constructor
      super();
      
      // Display ourselves
      flash.Lib.current.addChild(this);

      // Create and show screen bitmap
      screen = new BitmapData(screenW, screenH);
      addChild(new Bitmap(screen));

      // Update key state
      keyDown = [];
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown );
      stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp );

      // TODO: Mouse listening

      logicUpdatesPerSecond = 15;

      // Call render frame on each flash frame
      stage.addEventListener(Event.ENTER_FRAME, onFrame);
 
      // Init update timestamp  
      lastUpdated = haxe.Timer.stamp();
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
      var now = haxe.Timer.stamp();

      // Number of logic update steps
      var steps = Math.floor( (now - lastUpdated) * logicUpdatesPerSecond );
      lastUpdated += steps * 1 / logicUpdatesPerSecond;

      for(i in 0...steps) updateLogic();

      // Lock screen to do a more efficient batched bitmap update.
      screen.lock();
      render();
      screen.unlock();
   }

   // Update the game logic one step.
   function updateLogic()
   {
       // TODO: Update game logic 
   }

   // Draw current view of game
   function render()
   {
      // Clear to bg color
      screen.fillRect(new Rectangle(0,0,screen.width, screen.height),0x000000);
      // TODO: Maybe only draw updated parts of the screen?

      // TODO: Draw map  

      // TODO: Update UI
   }

}

