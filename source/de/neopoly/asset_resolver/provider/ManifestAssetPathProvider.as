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
  public static const DEFAULT_MANIFEST_SUBPATH:String = "assets/manifest.yml";
  private var _host_url:String;
  private var _manifest_url:String;

  public function ManifestAssetPathProvider(asset_host_url:String = "", manifest_file_url:String = null) {
    _host_url = asset_host_url;
    _manifest_url = manifest_file_url;
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
      trace("done loading");
      l.removeEventListener(IOErrorEvent.IO_ERROR, onerror);
      l.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onerror);
      setMap({});
    });

    l.load(new URLRequest(manifest_file_url));
    trace("start loading");
  }

  public function get host_url():String {
    return _host_url;
  }

  private function concatPaths(pre:String, post:String):String {
    trace("was:", pre, post);
    if(!post || post === "" || post === "/") return pre;
    if(!pre || pre === "") return post;
    if(pre.indexOf("/") === pre.length -1) {
      trace("pre was '" + pre + "'");
      pre = pre.substring(0, pre.length -1);
      trace("pre is '" + pre + "'");
    }
    if(post.indexOf("/") === 0) post = post.substring(1);
    trace("is:", pre, post);
    return pre + "/" + post;
  }
}
}
