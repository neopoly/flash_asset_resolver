/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 10.10.12
 * Time: 12:04
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.event.test {
import de.neopoly.asset_resolver.event.AssetResolverEvent;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;

import org.flexunit.asserts.assertTrue;

public class AssetResolverEventTest {
  [Test]
  public function testInitErrorEvent():void {
    var evt:AssetResolverEvent = AssetResolverEvent.initErrorEvent("causer", "message", {test: true});
    assertEquals(evt.type, AssetResolverEvent.INIT_ERROR);
    assertTrue(evt.is_error);
    assertEquals(evt.error_causer, "causer");
    assertEquals(evt.error_message, "message");
    assertTrue(evt.error_args.test);
  }

  [Test]
  public function testSetErrorInfo():void {
    // handled through testInitErrorEvent
  }

  [Test]
  public function testInitCompleteEvent():void {
    var evt:AssetResolverEvent = AssetResolverEvent.initCompleteEvent();
    assertFalse(evt.is_error);
    assertEquals(evt.type, AssetResolverEvent.INIT_COMPLETE);
  }
}
}
