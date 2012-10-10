Flash Asset Resolver
====================

Utilise rails manifest.yml to resolve asset paths (and leave room to use other path resolver, too).


Desired usage (how I'd like to use the resolver)
------------------------------------------------

   new AssetResolver(
     new ManifestAssetPathProvider("http://my/asset/host"),
     new ManifestAssetPathProvider("http://my/other/asset/host")
   ).init(myCompleteCallback, myErrorCallback);


Requires
--------

* asYAML: Actionscrip YAML parser from git://github.com/yaml/as3YAML.git
* for tests: Flexunit 4.*