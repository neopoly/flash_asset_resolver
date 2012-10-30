/**
 * Defaults for
 */
package de.neopoly.asset_resolver.provider {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ManifestAssetPathProvider extends AssetPathProvider {
  public static const DEFAULT_MANIFEST_SUBPATH:String = "assets/manifest.json";
  private static var __DATA_PARSER:Function = null;

  private var _host_url:String;
  private var _manifest_url:String;
  private var _asset_prefix:String;
  private var _parser:Function;

  public function ManifestAssetPathProvider(asset_host_url:String = "", manifest_file_url:String = null, asset_prefix:String = null, parser:Function = null) {
    _host_url = asset_host_url;
    _manifest_url = manifest_file_url;
    _asset_prefix = !asset_prefix ? host_url : asset_prefix;
    _parser = parser;
  }

  override public function assetPathFor(key:String):String {
    return concatPaths(_asset_prefix, super.assetPathFor(key));
  }

  public static function setGlobalParser(parse:Function):void {
    __DATA_PARSER = parse;
  }

  public function get manifest_file_url():String {
    if(_manifest_url && _manifest_url !== "") return _manifest_url;
    return concatPaths(host_url, DEFAULT_MANIFEST_SUBPATH);
  }

  override protected function executeInit():void {
    var l:URLLoader = new URLLoader();
    var onerror:Function = function(evt:Event):void {
      tellInitError(evt);
    };

    l.addEventListener(IOErrorEvent.IO_ERROR, onerror);
    l.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onerror);
    l.addEventListener(Event.COMPLETE, function (...ignore):void {
      l.removeEventListener(IOErrorEvent.IO_ERROR, onerror);
      l.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onerror);
      try {
        if(!_parser && !__DATA_PARSER) throw new Error("No Parser set.");

        var parsed:Object = (_parser || __DATA_PARSER)(l.data);
        setMap(parsed);
      } catch(err:Error) {
        tellInitError(err);
      }
    });

    l.load(new URLRequest(manifest_file_url));
  }

  public function get host_url():String {
    return _host_url;
  }

  private function concatPaths(pre:String, post:String):String {
    if(!post || post === "" || post === "/") return pre;
    if(!pre || pre === "") return post;
    if(pre.indexOf("/") === pre.length -1) {
      pre = pre.substring(0, pre.length -1);
    }
    if(post.indexOf("/") === 0) post = post.substring(1);
    trace("is:", pre, post);
    return pre + "/" + post;
  }
}
}
