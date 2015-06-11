# VungleSDK Unity- iOS Developer Guide

## Setup

* If you haven't already done so, head over to our [dashboard](https://v.vungle.com/dashboard/login) and add your app to your account. You need to do this in order to get your App ID. It’s in **red** on your app’s page.

* To initialize Vungle, pass your App ID to the `startWithAppId` method. The SDK will automatically begin caching a video. 

* You can use the `isAdAvailable` method to determine if an ad is available to display. 

* Once you are ready to show the ad, just call `playAd`. The `playAd` method takes several options that can be used to customize the way it is displayed.

## API Documentation

#### VungleBinding.cs exposes the following methods:
```
// Starts up the SDK with the given appId
public static void startWithAppId( string appId )

// Enables/disables sound
public static void setSoundEnabled( bool enabled )

// Enables/disables verbose logging
public static void enableLogging( bool shouldEnable )

// Checks to see if a video ad is available
public static bool isAdAvailable()

// Plays an ad with the given options. The user option is only supported for incentivized ads.
public static void playAd( bool incentivized = false, string user = "" )

// Plays an ad with more options. Use Dictionary<string,object> to set options.
public static void playAdEx( Dictionary<string,object> options )

// Clear cache
public static void clearCache()

// Clear sleep
public static void clearSleep()
```

#### Options
| Key          | Description |
| :----------- |:----------- |
| `incentivized` | You can choose to be notified whenever a user has completed an ad. A typical use case of this is when you are offering some sort of value exchange (‘watch this video and receive 100gems!’). If you choose to make your ads incentivized, we’ll immediately send a message to your server along with a user id (that you provide) so that you can reward your users. YES means this ad will be incentivized. Instructions for setting up incentivized ads are [here](https://github.com/Vungle/vungle-resources/tree/master/English/Incentivized-Ads). |
| `orientation` | Sets the orientation of the ad. See VungleAdOrientation |
| `large` | Large buttons mode |
| `userTag` | The key user is the one passed as user in the S2S call (if there are any). |
| `placement` | You'll want to pass an indicator of which ad was played, for example, 'Level2'. |
| `alertTitle` | String that is used as the title of the alert dialog presented when a user closes an incentivized ad experience prematurely. |
| `alertText` | String that is used as the body text of the alert dialog presented when a user closes an incentivized ad experience prematurely. |
| `closeText` | String title for the close button text of the alert dialog presented when a user closes an incentivized ad experience prematurely. |
| `continueText` | String title for the close button text of the alert dialog presented when a user closes an incentivized ad experience prematurely. |
| `key1..8` | We have 8 keys built in here |


#### VungleManager.cs fires the following events:
```
// Fired when a video has finished playing. Includes the following keys: completedView (bool), playTime (double),
// didDownload (bool) and willPresentProductSheet (bool).
public static event Action<Dictionary<string,object>> vungleSDKwillCloseAdEvent;

// Fired when the product sheet is dismissed
public static event Action vungleSDKwillCloseProductSheetEvent;

// Fired when the video is shown
public static event Action vungleSDKwillShowAdEvent;

// Fired when a Vungle ad is cached and ready to be displayed
public static event Action vungleSDKhasCachedAdAvailableEvent;

// Fired when the SDK sends a log event.
public static event Action<string> vungleSDKlogEvent;
```
