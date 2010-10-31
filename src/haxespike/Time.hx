package haxespike

class Time {

  private var startTime_ms : Int;
  public var currentTime_ms : Int;
  public var deltaTime_ms : Int;

  public function new() {
    startTime_ms = flash.Lib.getTimer();
    currentTime_ms = startTime_ms;
    deltaTime_ms = 0;
  }

  

}
