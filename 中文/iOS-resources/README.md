## iOS 资源

如果你是初到Vungle，请看这里[开发指南](https://github.com/Vungle/vungle-resources/blob/master/%E4%B8%AD%E6%96%87/iOS-resources/iOS-dev-guide.md).

如果你用的是一个旧的版本 ( < v3.0 )? 请看这里 [迁移指南](https://github.com/Vungle/vungle-resources/blob/master/%E4%B8%AD%E6%96%87/iOS-resources/iOS-migration-guide.md)。

当你可以开始放广告，可以看这里 [进阶设定](https://github.com/Vungle/vungle-resources/blob/master/%E4%B8%AD%E6%96%87/iOS-resources/iOS-advanced-settings.md) 来客制化用户体验.

## 更新版本

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
