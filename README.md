:skull: DEPRECATED

Flash Asset Resolver
====================

Utilise rails asset manifest file to resolve asset paths (and leave room to use other path resolver, too).


Desired usage (how I'd like to use the resolver)
------------------------------------------------

    ManifestAssetPathProvider.setGlobalParser(JSON.decode);
    
    var p:IAssetPathProvider = new AssetResolver(
      new ManifestAssetPathProvider("http://my/asset/host", "http://my/asset/host/manifest-12345.json"),
      new ManifestAssetPathProvider("http://my/other/asset/host", "http://my/other/asset/host/manifest-456987.json")
    ).init(myCompleteCallback, myErrorCallback);
    
    trace(p.assetPathFor("test/image.jpg"));      // => http://my/asset/host/test/image-4312.jpg

Requires
--------

* for parsing manifest file: Require your favorite parser for manifest file (e.g JSON parser from http://www.blooddy.by/en/crypto/)
* for tests: Flexunit 4.*
