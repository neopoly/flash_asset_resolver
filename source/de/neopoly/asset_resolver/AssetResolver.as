package de.neopoly.asset_resolver {
import de.neopoly.asset_resolver.provider.AssetPathProvider;

import flash.events.EventDispatcher;

public class AssetResolver extends EventDispatcher {
  public static const VERSION:String = "0.0.1";
  private var _provider:Array;

  public function AssetResolver(...provider) {
    if (provider && provider.length > 0) {
      _provider = provider;
    }
  }

  public function addProvider(provider:AssetPathProvider):AssetResolver {
    (_provider || (_provider = [])).push(provider);
    return this;
  }

  /**
   * Initializes all added AssetPathProvider
   * @param complete_callback       Provider-init can be async, so there is a callback, but you don't need, because also "complete-event" is fired
   * @param error_callback          Called for each single provider that causes an error. If given: overrides previous callback set by "onError"
   */
  public function initAllProvider(complete_callback:Function = null, error_callback:Function = null):AssetResolver {
    // todo
    return this;
  }

  public function onError(callback:Function):AssetResolver {
    // todo
    return this;
  }
}
}