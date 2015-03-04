# VungleSDK Unity- Android Developer Guide

## Setup

* If you haven't already done so, head over to our [dashboard](https://v.vungle.com/dashboard/login) and add your app to your account. You need to do this in order to get your App ID. It’s in **red** on your app’s page.

* To initialize Vungle, pass your App ID to the `init` method. The SDK will automatically begin caching a video. 

* You can use the `isVideoAvailable` method to determine if an ad is available to display. 

* Once you are ready to show the ad, just call `playAd`. The `playAd` method takes several options that can be used to customize the way it is displayed.

## API Documentation

#### VungleAndroid.cs exposes the following methods:
```
// Starts up the SDK with the given appId
public static void init( string appId )

// Call this when your application is sent to the background
public static void onPause()

// Call this when your application resumes
public static void onResume()

// Checks to see if a video is available
public static bool isVideoAvailable()

// Sets if sound should be enabled or not
public static void setSoundEnabled( bool isEnabled )

// Sets the allowed orientations of any ads that are displayed
public static void setAdOrientation( VungleAdOrientation orientation )

// Checks to see if sound is enabled
public static bool isSoundEnabled()

// Plays an ad with the given options. The user option is only supported for incentivized ads.
public static void playAd( bool incentivized = false, string user = "" )
```

#### VungleAndroidManager.cs fires the following events:
```
// Fired when a Vungle ad starts
public static event Action onAdStartEvent;

// Fired when a Vungle ad finishes
public static event Action onAdEndEvent;

// Fired when a Vungle ad is cached and ready to be displayed
public static event Action onCachedAdAvailableEvent;

// Fired when a Vungle video is dismissed. Includes the watched and total duration in milliseconds.
public static event Action<double,double> onVideoViewEvent;
```
