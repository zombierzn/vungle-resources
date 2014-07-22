## Android Resources

If you're new to Vungle, get started with the [dev guide](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-dev-guide.md).

Switching from an older version of the SDK ( < v3.0 )? Check out our [migration guide](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-migration-guide.md).

Once you've gotten an ad to play, our [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-advanced-settings.md) will help you customize the experience.

## Changelog

### VERSION 3.1.0

* added support for [Android Advertising ID](https://developer.android.com/google/play-services/id.html)
* removed references to `android.provider.Settings.Secure.ANDROID_ID`
* added `AdConfig.setPlacement()` for tracking ad performance by placement location
* added `AdConfig.setExtra1-8()` for passing developer-defined key-value pairs
* added 3 second delay between `VunglePub.init()` and initial ad request to allow for global `AdConfig` configuration
* removed deprecated methods `AdConfig.setShowClose()` and `AdConfig.isShowClose()` (please confugre these from the [Vungle Dashboard](https://v.vungle.com))
* fixed `Activity` and `Fragment` recreation if they are destroyed while in the background
* fixed sound bug with ads starting muted
* fixed bugs affecting session length calculation 
* added `logcat` warning messages for missing `AndroidManifest.xml` permissions and config
