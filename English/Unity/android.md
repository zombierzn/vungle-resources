## Unity Plugin

### VungleAndroid.cs exposes the following methods:
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

### VungleAndroidManager.cs fires the following events:
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