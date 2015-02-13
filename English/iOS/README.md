## iOS Resources

If you're new to Vungle, get started with the [dev guide](https://github.com/Vungle/vungle-resources/blob/master/English/iOS/iOS-dev-guide.md).

Switching from an older version of the SDK ( < v3.0 )? Check out our [migration guide](https://github.com/Vungle/vungle-resources/blob/master/English/iOS/iOS-migration-guide.md).

Once you've gotten an ad to play, our [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/English/iOS/iOS-advanced-settings.md) will help you customize the experience.

## Changelog

## Version 3.0.12
* Fixes crash that happened on rare occasions when sending the app to the background
* Improves re-queuing of network requests. It should improve the ability to re-send requests even after they failed.
* Move saved /reportAds from cache directory to app support directory
* Option to modify incentivized alert text (title, body, close button, and continue button)

## VERSION 3.0.11
* Deprecated VunglePlayAdOptionKeyShowClose
* Deprecated VungleSDK#playAd: & VungleSDK#playAd:withOptions:
* Fixed some minor memory leaks
* Fixed orientations issues on iOS 8
* Fixed some random crashes on very limited edge cases
* Moved internal database from Documents to App Support

## VERSION 3.0.10
* Fixed crash that killed the app when sent to the background (in rare conditions)
* Fixed postroll and corrupted video bugs
* Improved support for iOS 8

### VERSION 3.0.9

* improved iOS 5 support
* fixed TPAT bugs

### VERSION 3.0.8

* added global playAd options
* added placements for each play, as well as dev-defined extra keys
* Fix a few mem leaks
* Send post params instead of query params for /sessionEnd
* miniz symbols no longer exposed
* Delegate methods are optional now

### VERSION 3.0.7
* Automatically remake our database when there's a schema change
* Compatibility fix for pre-iOS7
* Minor bugs fixed
