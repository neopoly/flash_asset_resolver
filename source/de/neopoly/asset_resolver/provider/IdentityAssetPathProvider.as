package de.neopoly.asset_resolver.provider {

public class IdentityAssetPathProvider implements IAssetPathProvider {
  private var _asset_prefix:String;

  public function IdentityAssetPathProvider(asset_prefix:String = "") {
    _asset_prefix = asset_prefix;
  }

  public function assetPathFor(key:String):String {
    return concatPaths(_asset_prefix, key);
  }

  public function hasAssetPathFor(key:String):Boolean {
    return true;
  }

  public function get initialized():Boolean {
    return true;
  }

  public function init(on_complete:Function, on_error:Function):IAssetPathProvider {
    if(on_complete) on_complete();
    return this;
  }

  private function concatPaths(pre:String, post:String):String {
    if(!post || post === "" || post === "/") return pre;
    if(!pre || pre === "") return post;
    if(pre.indexOf("/") === pre.length -1) {
      pre = pre.substring(0, pre.length -1);
    }
    if(post.indexOf("/") === 0) post = post.substring(1);
    return pre + "/" + post;
  }
}
}
