# VungleSDK Unity- Combo Developer Guide (Android and iOS)

## Setup

* If you haven't already done so, head over to our [dashboard](https://v.vungle.com/dashboard/login) and add your apps to your account. You need to do this in order to get your App ID. It’s in **red** on your app’s page. You'll need to make separate apps for Android and iOS.

* To initialize Vungle, pass both App IDs to the `init` method. The SDK will automatically begin caching a video. 

* You can use the `isAdvertAvailable` method to determine if an ad is available to display. 

* Once you are ready to show the ad, just call `playAd`. The `playAd` method takes several options that can be used to customize the way it is displayed.

## API Documentation

#### Vungle.cs exposes the following methods:
```
// Initializes the Vungle SDK optionally with an age and gender
public static void init( string androidAppId, string iosAppId )

public static void init( string androidAppId, string iosAppId, int age, VungleGender gender )

// Sets if sound should be enabled or not
public static void setSoundEnabled( bool isEnabled )

// Checks to see if a video is available
public static bool isAdvertAvailable()

// Plays an ad with the given options. The user option is only supported for incentivized ads.
public static void playAd( bool incentivized = false, string user = "" )
```

#### Vungle.cs fires the following events:
```
// Fired when a Vungle ad starts
public static event Action onAdStartedEvent;

// Fired when a Vungle ad finishes
public static event Action onAdEndedEvent;

// Fired when a Vungle ad is cached and ready to be displayed
public static event Action onCachedAdAvailableEvent;

// Fired when a Vungle video is dismissed and provides the time watched and total duration in that order.
public static event Action<double,double> onAdViewedEvent;
```
