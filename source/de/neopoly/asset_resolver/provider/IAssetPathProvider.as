/**
 * Created with IntelliJ IDEA.
 * User: dt-apple
 * Date: 09.10.12
 * Time: 13:10
 * To change this template use File | Settings | File Templates.
 */
package de.neopoly.asset_resolver.provider {

public interface IAssetPathProvider {

  function assetPathFor(key:String):String;
  function hasAssetPathFor(key:String):Boolean;

  /**
   * Will cause initialisation
   * @param on_complete     called when init complete, no args
   * @param on_error        called on init error, gets Error as arg
   */
  function init(on_complete:Function, on_error:Function):IAssetPathProvider;
  function get initiated():Boolean;
}
}
