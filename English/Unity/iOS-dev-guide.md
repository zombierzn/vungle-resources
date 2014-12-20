## Unity Plugin

Once you have setup your application on the Vungle website you will want to retrieve the application ID and pass it to the startWithAppId method. Vungle's SDK will automatically load up some videos. You can use the isAdAvailable method to determine if an ad is available to display. Once you are ready to show the ad just call playAd. The playAd method takes several options that can be used to customize the way it is displayed. Optionally you can use the playModalAd or playIncentivizedAd to display non-incentivized or incentivized ads respectively.


### VungleBinding.cs exposes the following methods:
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
```

### VungleManager.cs fires the following events:
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
```
