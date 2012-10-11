package de.neopoly.asset_resolver {
import de.neopoly.asset_resolver.provider.IAssetPathProvider;

public class AssetResolver implements IAssetPathProvider {
  public static const VERSION:String = "0.0.1";
  private var _provider:Array;

  public function AssetResolver(...provider) {
    if (provider && provider.length > 0) {
      _provider = provider;
    } else {
      _provider = [];
    }
  }

  /**
   * Note: if AssetResolver is already initialized, a newly added provider still needs to be initialized itself! Just recall AssetResolver.init(...)
   */
  public function addProvider(provider:IAssetPathProvider):AssetResolver {
    _provider.push(provider);
    return this;
  }

  public function hasAssetPathFor(key:String):Boolean {
    return false;
  }

  public function init(on_complete:Function, on_error:Function):IAssetPathProvider {
    if(initialized && on_complete) {
      on_complete();
    } else {
      _provider.forEach(function(p:IAssetPathProvider,...ignore):void {
        if(!p.initialized) {
          p.init(function():void {
            if(initialized && on_complete) on_complete();
          }, on_error);
        }
      });
    }
    return this;
  }

  public function assetPathFor(key:String):String {
    return "";
  }

  public function get initialized():Boolean {
    return _provider.every(function(p:IAssetPathProvider,...ignore):Boolean {
      return p.initialized;
    });
  }
}
}