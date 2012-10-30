Flash Asset Resolver
====================

Utilise rails manifest.yml to resolve asset paths (and leave room to use other path resolver, too).


Desired usage (how I'd like to use the resolver)
------------------------------------------------

   new AssetResolver(
     new ManifestAssetPathProvider("http://my/asset/host", "http://my/asset/host/manifest-12345.json"),
     new ManifestAssetPathProvider("http://my/other/asset/host", "http://my/other/asset/host/manifest-456987.json")
   ).init(myCompleteCallback, myErrorCallback);


Requires
--------

* for parsing manifest file: Require your favorite parser for manifest file (I use JSON parser from http://www.blooddy.by/en/crypto/)
* for tests: Flexunit 4.*