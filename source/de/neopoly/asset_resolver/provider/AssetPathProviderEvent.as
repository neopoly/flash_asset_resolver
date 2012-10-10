/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 10.10.12
 * Time: 11:52
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.provider {
import flash.events.Event;

public class AssetPathProviderEvent extends Event {
  public static const INIT_COMPLETE:String = "asset_path_provider_init_complete";
  public static const INIT_ERROR:String = "asset_path_provider_init_error";
  private var _error_causer:*;
  private var _error_message:String;
  private var _error_args:Object; // to be more flexible

  public function AssetPathProviderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
    super(type, bubbles, cancelable);
  }

  public function setErrorInfo(error_causer:Object, error_message:String, error_args:Object = null):AssetPathProviderEvent {
    _error_causer = error_causer;
    _error_message = error_message;
    _error_args = error_args;
    return this;
  }

  public function get is_error():Boolean { return type === INIT_ERROR; }
  public function get error_causer():* { return _error_causer; }
  public function get error_message():String { return _error_message; }
  public function get error_args():Object { return _error_args; }

  // ------------------------ statics -----------------------

  /**
   * Create and return INIT_ERROR event
   */
  public static function initErrorEvent(error_causer:Object, error_message:String, error_args:Object = null):AssetPathProviderEvent {
    return new AssetPathProviderEvent(INIT_ERROR).setErrorInfo(error_causer, error_message, error_args);
  }

  /**
   * Create and return INIT_COMPLETE event
   */
  public static function initCompleteEvent():AssetPathProviderEvent {
    return new AssetPathProviderEvent(INIT_COMPLETE);
  }

}
}
