/**
 * Defaults for
 */
package de.neopoly.asset_resolver.provider {
public class ManifestAssetPathProvider {
  public static const DEFAULT_MANIFEST_SUBPATH:String = "assets/manifest.yml";
  private var _host_url:String;
  private var _manifest_url:String;

  public function ManifestAssetPathProvider(asset_host_url:String = "", manifest_file_url:String = null) {
    _host_url = asset_host_url;
    _manifest_url = manifest_file_url;
  }

  public function get manifest_file_url():String {
    return ""; // todo
  }

  public function get host_url():String {
    return ""; // todo
  }
}
}
