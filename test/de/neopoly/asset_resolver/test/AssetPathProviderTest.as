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
    _provider = new AssetPathProvider({
      one: "one-123",
      two: "two-123"
    });
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
