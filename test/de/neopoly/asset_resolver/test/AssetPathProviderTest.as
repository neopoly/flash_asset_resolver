/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 09.10.12
 * Time: 15:25
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.test {
import de.neopoly.asset_resolver.provider.AssetPathProvider;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertFalse;

import org.flexunit.asserts.assertTrue;

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
    assertFalse(p.initiated);

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
    assertEquals(errors, 1);
    assertEquals(oks, 0);

    // ok callback called when initiated
    p.setMap({}).init(on_ok, on_error);
    assertEquals(errors, 1);
    assertEquals(oks, 1);
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
