/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 10.10.12
 * Time: 17:24
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.test {
import de.neopoly.asset_resolver.AssetResolver;
import de.neopoly.asset_resolver.provider.AssetPathProvider;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;

import org.flexunit.asserts.assertTrue;

public class AssetResolverTest {
  private var _a:AssetResolver;

  private function noop(...ignore):void {}

  [Before]
  public function setUp():void {
    _a = new AssetResolver(
      new AssetPathProvider().setMap({one: "one-xxx"}),
      new AssetPathProvider().setMap({two: "two-xxx"}),
      new AssetPathProvider().setMap({two: "two2-xxx"})
    ).init(noop, noop) as AssetResolver;
  }

  public function AssetResolverTest() {
  }

  [After]
  public function tearDown():void {
    _a = null;
  }

  [Test]
  public function testInit():void {
    var empty:AssetResolver = new AssetResolver();
    assertTrue(empty.initialized);
  }

  [Test]
  public function testAddProvider():void {
    assertTrue("starting initialized", _a.initialized);
    assertFalse(_a.hasAssetPathFor("newly_added_key"));

    var p:AssetPathProvider;

    _a.addProvider(
      p = new AssetPathProvider()
    );

    assertFalse("no longer initialized", _a.initialized);
    p.setMap({newly_added_key: "test"});

    assertTrue("initialized again", _a.initialized);
    assertTrue("has new key", _a.hasAssetPathFor("newly_added_key"));
  }

  [Test]
  public function testAssetPathFor():void {
    assertEquals(_a.assetPathFor("one"), "one-xxx");
  }

  [Test]
  public function testAssertPathTakenFromFirstMatchingProvider():void {
    assertEquals(_a.assetPathFor("two"), "two-xxx");
  }

  [Test]
  public function testHasAssetPathFor():void {
    assertTrue(_a.hasAssetPathFor("one"));
    assertFalse(_a.hasAssetPathFor("voihdsoigfhaskjghjdsaihjbvlkdaf:)"));
  }
}
}
