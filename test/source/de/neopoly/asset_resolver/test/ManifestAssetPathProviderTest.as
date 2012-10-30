/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 12.10.12
 * Time: 11:24
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.test {
import by.blooddy.crypto.serialization.JSON;

import de.neopoly.asset_resolver.provider.IAssetPathProvider;
import de.neopoly.asset_resolver.provider.ManifestAssetPathProvider;

import flexunit.framework.Assert;
import flexunit.framework.Test;

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
    new ManifestAssetPathProvider("", "files/test_manifest.json").init(function (...ignore):void {handler();}, function (err:*):void { Assert.fail("init shows error, should not! " + err);});
  }

  [Test(async)]
  public function testInitError():void {
    var handler:Function = Async.asyncHandler(this,null, 300,null, function (...ignore):void { Assert.fail("timeout"); });
    new ManifestAssetPathProvider("", "files/this/does/not/exists.json").init(function ():void { Assert.fail("should not init, but did");}, function (...ignore):void {handler();});
  }

  [Before]
  public function setUp():void {
    ManifestAssetPathProvider.setGlobalParser(function (...ignore):Object { return {}; });
  }

  [Test(async)]
  public function testProperResolveWithHostAsPrefix():void {
    var m:IAssetPathProvider;

    var async_handler:Function = Async.asyncHandler(this,null, 300,function (...ignore):void {
    }, function (...ignore):void { Assert.fail("timeout"); });

    ManifestAssetPathProvider.setGlobalParser(by.blooddy.crypto.serialization.JSON.decode);
    m = new ManifestAssetPathProvider("http://nevermind", "files/test_manifest.json").init(function (...ignore):void {

      assertEquals(m.assetPathFor("neo/test.jpg"), "http://nevermind/neo/test-123.jpg");
      async_handler();

    }, function (err:*):void { Assert.fail("init shows error, should not! " + err);});
  }

  [Test(async)]
  public function testProperResolveWithOverriddenPrefix():void {
    var m:IAssetPathProvider;

    var async_handler:Function = Async.asyncHandler(this,null, 300,function (...ignore):void {
    }, function (...ignore):void { Assert.fail("timeout"); });

    ManifestAssetPathProvider.setGlobalParser(by.blooddy.crypto.serialization.JSON.decode);
    m = new ManifestAssetPathProvider("http://nevermind", "files/test_manifest.json", "PREFIX").init(function (...ignore):void {

      assertEquals(m.assetPathFor("neo/test.jpg"), "PREFIX/neo/test-123.jpg");
      async_handler();

    }, function (err:*):void { Assert.fail("init shows error, should not! " + err);});
  }

  [Test(async)]
  public function testSetGlobalParser():void {
    var m:IAssetPathProvider;

    var async_handler:Function = Async.asyncHandler(this,null, 300,function (...ignore):void {
    }, function (...ignore):void { Assert.fail("timeout"); });

    ManifestAssetPathProvider.setGlobalParser(by.blooddy.crypto.serialization.JSON.decode);
    m = new ManifestAssetPathProvider("http://nevermind", "files/test_manifest.json", null, function (...ignore):Object {
      return {
        test: "test-result"
      };
    }).init(function (...ignore):void {

      assertEquals(m.assetPathFor("test"), "http://nevermind/test-result");
      async_handler();

    }, function (err:*):void { Assert.fail("init shows error, should not! " + err);});
  }

}
}
