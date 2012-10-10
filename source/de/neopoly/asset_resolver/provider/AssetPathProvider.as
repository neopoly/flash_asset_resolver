/**
 * AssetPathProvider
 *
 * Use it as baseclass for more complicated path provider.
 * - Override init(...)
 * - Calling 'setMap' will set 'initiated'
 */
package de.neopoly.asset_resolver.provider {

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

  public function get initialized():Boolean {
    return _initiated;
  }

  public function init(on_complete:Function, on_error:Function):IAssetPathProvider {
    // That's just for the basic implementation! The use of "setMap" will set _initiated, so if setMap was already called, the complete callback will fire, otherwise the error fallback.
    if(_initiated) {
      on_complete();
    } else {
      on_error(new Error("'key -> pathname' map not initiated. Call 'setMap' before."));
    }
    return this;
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