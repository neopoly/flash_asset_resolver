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
  private var _on_init_error:Function;

  public function AssetPathProvider() {
    _initialized = false;
  }

  /**
   * Set key -> pathname mapping. Also calls on_init_complete callback.
   */
  public function setMap(map:Object):AssetPathProvider {
    _map = map;
    _initialized = true;
    if(_on_init_complete) {
      var init_complete_was:Function = _on_init_complete;
      _on_init_complete = null; // kill reference before call, otherwise a reference-change in callback would be killed directly
      init_complete_was();
    }
    return this;
  }

  public function tellInitError(error_or_error_event:*):void {
    if(_on_init_error) {
      var was:Function = _on_init_error;
      _on_init_error = null;
      was(error_or_error_event);
    }
  }

  public function get initialized():Boolean {
    return _initialized;
  }

  protected function executeInit():void {
    // todo: override this to init!
  }

  public function init(on_complete:Function, on_error:Function):IAssetPathProvider {
    _on_init_complete = null;
    _on_init_error = null;
    if(initialized) {
      on_complete();
    } else {
      _on_init_complete = on_complete;
      _on_init_error = on_error;
      executeInit();
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