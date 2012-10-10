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

  [Test]
  public function testInit():void {
    var empty:AssetResolver = new AssetResolver();
    assertTrue(empty.initialized);
  }

  [Test]
  public function testAddProvider():void {
    // todo
  }

  [Test]
  public function testAssetPathFor():void {
  }
}
}
