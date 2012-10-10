package de.neopoly.asset_resolver.provider {
import de.neopoly.asset_resolver.event.AssetResolverEvent;

public class AssetPathProvider implements IAssetPathProvider {
  private var _map:Object; // maps key to path
  private var _initiated:Boolean;

  public function AssetPathProvider() {
    _initiated = false;
  }

  /**
   * Set key -> pathname mapping
   */
  public function setMap(map:Object):AssetPathProvider {
    _map = map;
    _initiated = true;
    return this;
  }

  public function get initiated():Boolean {
    return _initiated;
  }

  public function init(on_complete:Function, on_error:Function):void {
    // in basic implementation the on_compete_callback
    on_complete(AssetResolverEvent.initCompleteEvent());
  }

  public function assetPathFor(key:String):String {
    return (map && map.hasOwnProperty(key) && map[key]) || null;
  }

  public function hasAssetPathFor(key:String):Boolean {
    return assetPathFor(key) !== null;
  }

  protected function get map():Object { return _map; }
  protected function set map(val:Object):void { _map = val; }
}
}