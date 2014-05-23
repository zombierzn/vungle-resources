# VungleSDK- Android Advanced Settings

## Please note:

This reference covers the more advanced settings and customizeable aspects of Vungle ads. If you're just getting started, you'll want to check out this [guide](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-dev-guide.md). 

Applicable to Version 3.0+

## Advanced Configuration 

### Startup Configuration 

After calling `init` you can optionally get access to the global `AdConfig` object. This object allows you to set options that will be automatically applied to every ad you play.
```java
import com.vungle.publisher.VunglePub;
import com.vungle.publisher.AdConfig;
import com.vungle.publisher.Orientation;

public class FirstActivity extends android.app.Activity {

  ...

  @Override
  public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      
      ...

      vunglePub.init(this, app_id);

      // get a handle on the global AdConfig object
      final AdConfig globalAdConfig = vunglePub.getGlobalAdConfig();

      // set any configuration options you like. 
      // For a full description of available options, see the 'Configuration Options' section.
      globalAdConfig.setSoundEnabled(true);
      globalAdConfig.setOrientation(Orientation.portrait);

  }
}
```

### playAd Configuration 

You can optionally customize each individual ad you play by providing an `AdConfig` object to `playAd`. If you set any options in the [global ad configuration](#advancedStartupConfig), those options will be overriden by the provided options.
```java
import com.vungle.publisher.VunglePub;
import com.vungle.publisher.AdConfig;

public class GameActivity extends android.app.Activity {
  ...
  
  private void onLevelComplete() {
  	  // create a new AdConfig object
  	  final AdConfig overrideConfig = new AdConfig();

  	  // set any configuration options you like. 
  	  // For a full description of available options, see the 'Configuration Options' section.
  	  overrideConfig.setIncentivized(true);
  	  overrideConfig.setSoundEnabled(false);

  	  // the overrideConfig object will only affect this ad play. 
  	  // See the Application Startup section for how to set persistent global configurations.
      vunglePub.playAd(overrideConfig);
  }
}
```

### Configuration Options

#### The `AdConfig` Object

One global `AdConfig` object controls settings for all ad plays, and you can optionally pass override instances to each individual ad play. These are the available setters in `AdConfig`:

| Method | Default | Description |
|:------ |:------- |:----------- |
| `setOrientation` | `Orientation.autoRotate` | Sets the orientation of the ad. Orientation.matchVideo is the alternate option. This means the ad will play in its ideal orientation (usually landscape). |
| `setSoundEnabled` | `true` | Sets the starting sound state for the ad. If true, audio respects device volume and sound settings. If false, video begins muted but user may modify |
| `setBackButtonImmediatelyEnabled` | `false` | Enables or disables the back button. If true the user can back out of the ad, otherwise they cannot |
| `setShowClose` | `true` | Enables or disables the close button on the video ad. If false, the close button will never appear <br> *Note- this method was deprecated in v3.0.2. You can use the forced view options in your app's advanced settings, on the dashboard |
| `setIncentivized` | `false` | Sets the incentivized mode. If true, user will be prompted with a confirmation dialog when attempting to skip the ad. If false, no confirmation is shown |
| `setIncentivizedUserId` | none | Set the unique user id to be passed to your application to verify that this user should rewarded for watching an incentivized ad. N/A if ad is not incentivized. |
| `setIncentivizedCancelDialogTitle` | "Close video?" | Sets the title of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. |
| `setIncentivizedCancelDialogBodyText` | "Closing this video early will prevent you from earning your reward. Are you sure?" | Sets the body of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. | 
| `setIncentivizedCancelDialogCloseButtonText` | "Close video" | Sets the 'cancel button' text of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. | 
| `setIncentivizedCancelDialogKeepWatchingButtonText` | "Keep watching" | Sets the 'keep watching button' text of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. |

#### The `EventListener` Interface
The Publisher SDK raises several events that you can handle programmatically by implementing `com.vungle.publisher.EventListener` and setting it in your `VunglePub` instance using `setEventListener`
```java
import com.vungle.publisher.EventListener;
...

public class FirstActivity extends android.app.Activity {
  ...

  private final EventListener vungleListener = new EventListener(){

    @Override
    public void onVideoView(boolean isCompletedView, int watchedMillis, int videoDurationMillis) {
        // Called each time a video completes. isCompletedView is true if the video was not skipped.     
    }

    @Override
    public void onAdStart() {
        // Called before playing an ad
    }

    @Override
    public void onAdEnd() {
        // Called when the user leaves the ad and control is returned to your application
    }

    @Override
    public void onCachedAdAvailable() {
        // Called when ad is downloaded and ready to be played
    }
    
  };

  @Override
  public void onCreate(Bundle savedInstanceState) {
      ...

      vunglePub.init(this, app_id);
      vunglePub.setEventListener(vungleListener);

  }
}
```
