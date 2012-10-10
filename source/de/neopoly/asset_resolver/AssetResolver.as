package de.neopoly.asset_resolver {
import de.neopoly.asset_resolver.provider.IAssetPathProvider;

public class AssetResolver implements IAssetPathProvider {
  public static const VERSION:String = "0.0.1";
  private var _provider:Array;

  private var _on_complete:Function;

  public function AssetResolver(...provider) {
    if (provider && provider.length > 0) {
      _provider = provider;
    }
  }

  public function addProvider(provider:IAssetPathProvider):AssetResolver {
    (_provider || (_provider = [])).push(provider);
    return this;
  }

  public function hasAssetPathFor(key:String):Boolean {
    return false;
  }

  public function init(on_complete:Function, on_error:Function):IAssetPathProvider {
    if(initiated) {

    } else {

    }
    return this;
  }

  public function assetPathFor(key:String):String {
    return "";
  }

  public function get initiated():Boolean {
    return _provider.every(function(p:IAssetPathProvider,...ignore):Boolean {
      return p.initiated;
    });
  }
}
}