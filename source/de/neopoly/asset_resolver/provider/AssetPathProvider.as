package de.neopoly.asset_resolver.provider {
public class AssetPathProvider implements IAssetPathProvider {
  private var _map:Object; // maps key to path

  public function AssetPathProvider(map:Object = null) {
    _map = map;
  }

  public function assetPathFor(key:String):String {
    return (_map && _map[key]) || null;
  }
}
}