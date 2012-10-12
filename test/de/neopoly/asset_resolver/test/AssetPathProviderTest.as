/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 09.10.12
 * Time: 15:25
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.test {
import de.neopoly.asset_resolver.provider.AssetPathProvider;

import flash.events.TimerEvent;

import flash.utils.Timer;

import org.flexunit.Assert;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertFalse;

import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;

public class AssetPathProviderTest {
  private var _provider:AssetPathProvider;

  public function AssetPathProviderTest() {
  }

  [Before]
  public function setUp():void {
    _provider = new AssetPathProvider().setMap({
      one: "one-123",
      two: "two-123"
    });
  }

  [Test]
  public function testInit():void {
    var p:AssetPathProvider = new AssetPathProvider();
    assertFalse(p.initialized);

    var errors:int = 0;
    var oks:int = 0;

    var on_error:Function = function (...ignore):void {
      errors++;
    };

    var on_ok:Function = function():void {
      oks++;
    };

    assertEquals(errors, 0);
    assertEquals(oks, 0);

    // error callback called when not initiated
    p.init(on_ok, on_error);
    assertEquals(errors, 0);
    assertEquals(oks, 0);

    // ok callback called when initiated
    p.setMap({});
    assertEquals(errors, 0);
    assertEquals(oks, 1);
  }

  [Test(async)]
  public function testAsyncInit():void {
    // setup
    var p:AssetPathProvider = new AssetPathProvider();
    var ok_count:int = 0;
    var error_count:int = 0;

    var on_init_ok_with_async_handler:Function = Async.asyncHandler(this, null, 100, function (...ignore):void {
      assertTrue(p.initialized);
    }, function (...ignore):void { Assert.fail("callback timeout");});

    assertFalse(p.initialized);
    assertFalse("not yet initialized", p.initialized);
    p.init(function (...ignore):void {
      on_init_ok_with_async_handler();
    }, null);
    assertFalse("still not initialized, because called async", p.initialized);

    var t:Timer = new Timer(50);
    var on_timer:Function = function (...ignore):void {
      t.removeEventListener(TimerEvent.TIMER, on_timer);
      t.stop();
      p.setMap({}); // should init p and call init-callback
    };
    t.addEventListener(TimerEvent.TIMER, on_timer);
    t.start();
  }

  [Test]
  public function testHasAssetPathFor():void {
    assertTrue(_provider.hasAssetPathFor("one"));
    assertFalse(_provider.hasAssetPathFor("onex"));
  }

  [Test]
  public function testAssetPathFor():void {
    assertEquals(_provider.assetPathFor("one"), "one-123");
    assertEquals(_provider.assetPathFor("two"), "two-123");
    assertEquals(_provider.assetPathFor("three"), null);
  }
}
}
