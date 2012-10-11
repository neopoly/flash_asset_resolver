/**
 * AssetPathProvider
 *
 * Use it as baseclass for more complicated path provider.
 * - Override init(...)
 * - Calling 'setMap' will set 'initialized'
 */
package de.neopoly.asset_resolver.provider {

public class AssetPathProvider implements IAssetPathProvider {
  private var _map:Object; // maps key to path
  private var _initialized:Boolean;
  private var _on_init_complete:Function;

  public function AssetPathProvider() {
    _initialized = false;
  }

  /**
   * Set key -> pathname mapping
   */
  public function setMap(map:Object):AssetPathProvider {
    _map = map;
    _initialized = true;
    if(_on_init_complete) _on_init_complete();
    _on_init_complete = null;
    return this;
  }

  public function get initialized():Boolean {
    return _initialized;
  }

  public function init(on_complete:Function, on_error:Function):IAssetPathProvider {
    // That's just for the basic implementation! The use of "setMap" will set _initiated, so if setMap was already called, the complete callback will fire, otherwise the error fallback.
    _on_init_complete = null;
    if(initialized) {
      on_complete();
    } else {
      _on_init_complete = on_complete;
      // now somewhen you should init it
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