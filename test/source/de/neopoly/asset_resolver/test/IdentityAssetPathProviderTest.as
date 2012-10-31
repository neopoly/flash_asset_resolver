/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 31.10.12
 * Time: 12:37
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.test {
import de.neopoly.asset_resolver.provider.IAssetPathProvider;
import de.neopoly.asset_resolver.provider.IdentityAssetPathProvider;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertTrue;

public class IdentityAssetPathProviderTest {
  [Test]
  public function testHasAssetPathForAnyKey():void {
    var o:IAssetPathProvider = new IdentityAssetPathProvider("test").init(null, null);
    assertTrue(o.hasAssetPathFor("doesn't exists, but still ok"));
  }

  [Test]
  public function testAssetPathForEmptyPrefix():void {
    var o:IAssetPathProvider = new IdentityAssetPathProvider("").init(null, null);
    assertEquals(o.assetPathFor("img/test.jpg"), "img/test.jpg");
  }

  [Test]
  public function testAssetPathForSlashPrefix():void {
    var o:IAssetPathProvider = new IdentityAssetPathProvider("/").init(null, null);
    assertEquals(o.assetPathFor("img/test.jpg"), "/img/test.jpg");
  }

  [Test]
  public function testAssetPathForPrefix():void {
    var o:IAssetPathProvider = new IdentityAssetPathProvider("http://bla").init(null, null);
    assertEquals(o.assetPathFor("img/test.jpg"), "http://bla/img/test.jpg");
  }
}
}
