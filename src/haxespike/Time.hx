package haxespike;

class Time {

  private var startTime_ms : Int;
  public var currentTime_ms : Int;
  public var deltaTime_ms : Int;

  public function deltaTime_s(): Float {
    var d: Float = deltaTime_ms;
    return d / 1000.0;
  }

  public function new() {
    startTime_ms = flash.Lib.getTimer();
    currentTime_ms = startTime_ms;
    deltaTime_ms = 0;
  }

  public function update() {
    var newTime: Int = flash.Lib.getTimer() - startTime_ms;
    deltaTime_ms = newTime - currentTime_ms;
    currentTime_ms = newTime;
  }

}

