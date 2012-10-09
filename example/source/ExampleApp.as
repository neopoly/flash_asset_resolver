package {
import flash.display.Sprite;
import flash.events.Event;

public class ExampleApp extends Sprite {

  public function ExampleApp() {
    super();
    if(stage) {
      init();
    } else {
      this.addEventListener(Event.ADDED_TO_STAGE, init);
    }
  }

  private function init(...ignore):void {
    this.removeEventListener(Event.ADDED_TO_STAGE, init);
    trace("init");
  }

}
}