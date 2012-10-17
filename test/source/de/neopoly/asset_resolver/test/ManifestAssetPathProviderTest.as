/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 12.10.12
 * Time: 11:24
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.test {
import de.neopoly.asset_resolver.provider.ManifestAssetPathProvider;

import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.Security;

import flexunit.framework.Assert;

import org.flexunit.asserts.assertEquals;
import org.flexunit.async.Async;

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

  [Test(async)]
  public function testInitDone():void {
    var handler:Function = Async.asyncHandler(this,null, 300,null, function (...ignore):void { Assert.fail("timeout"); });
    new ManifestAssetPathProvider("", "files/test_manifest.yml").init(function (...ignore):void {handler();}, function (err:*):void { Assert.fail("init shows error, should not! " + err);});
  }

  [Test(async)]
  public function testInitError():void {
    var handler:Function = Async.asyncHandler(this,null, 300,null, function (...ignore):void { Assert.fail("timeout"); });
    new ManifestAssetPathProvider("", "files/this/does/not/exists.yml").init(function ():void { Assert.fail("should not init, but did");}, function (...ignore):void {handler();});
  }
}
}
