/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 12.10.12
 * Time: 11:24
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.test {
import de.neopoly.asset_resolver.provider.ManifestAssetPathProvider;

import org.flexunit.asserts.assertEquals;

public class ManifestAssetPathProviderTest {
  public function ManifestAssetPathProviderTest() {
  }


  [Test]
  public function testPaths():void {
    var m:ManifestAssetPathProvider = new ManifestAssetPathProvider();
    assertEquals(m.host_url, "");
    assertEquals(m.manifest_file_url, ManifestAssetPathProvider.DEFAULT_MANIFEST_SUBPATH);

    m = new ManifestAssetPathProvider("/");
    assertEquals(m.host_url, "/");
    assertEquals(m.manifest_file_url, "/" + ManifestAssetPathProvider.DEFAULT_MANIFEST_SUBPATH);

    m = new ManifestAssetPathProvider("ASSET/HOST/PATH", "ASSET/HOST/MANIFEST/FILE/PATH");
    assertEquals(m.host_url, "ASSET/HOST/PATH");
    assertEquals(m.manifest_file_url, "ASSET/HOST/MANIFEST/FILE/PATH");

    m = new ManifestAssetPathProvider("host/");
    assertEquals(m.host_url, "host/");
    assertEquals(m.manifest_file_url, "host/" + ManifestAssetPathProvider.DEFAULT_MANIFEST_SUBPATH);

    m = new ManifestAssetPathProvider("host");
    assertEquals(m.host_url, "host");
    assertEquals(m.manifest_file_url, "host/" + ManifestAssetPathProvider.DEFAULT_MANIFEST_SUBPATH);
  }
}
}
