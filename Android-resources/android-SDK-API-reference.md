# Android Publisher SDK API Reference

## VungleSDK

### Overview

The Publisher SDK allows you to integrate Vungle full screen video ads into your Android application. Please note the following requirements:
* Android 2.2 (Froyo - API version 8) or later
* If your application is written in C/C++, you'll need to use JNI to interface with the Publisher SDK written in Java
* If you are interested in advertising your application on the Vungle network, but not in showing Vungle ads in your application, please see the [Advertiser SDK](http://bd.vungle.com/dev/downloads).

### Integration

You can integrate the Publisher SDK by following these 4 easy steps:

#### 1. Add Vungle SDK To Your Project

[Download](http://bd.vungle.com/dev/android#download) the latest Android Publisher SDK zip file. Unzip it and copy `vungle-publisher-[version].jar` to the `/libs` directory of your project. (Create the directory if it doesn't already exist.)

This should automatically add the Publisher SDK to your build path.

#### 2. Update `AndroidManifest.xml`

Add the following lines:

```xml
<manifest>

  ...
  
  <!-- permissions to download and cache video ads for playback -->
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
  
  <application>
  
    ...
    
    <!--
      Required Activity for playback of Vungle video ads
      
      NOTE:  The 'configChanges' value 'screenSize' was introduced in Android 3.2 (API level 13).
      If your 'targetSdKVersion' is less than 13, you can either:
      * increase your 'targetSdkVersion' to 13 or greater (recommended)
      * omit the 'screenSize' value
    -->
    <activity
      android:name="com.vungle.publisher.FullScreenAdActivity"
      android:configChanges="keyboardHidden|orientation|screenSize"
      android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
    />
    
    
    <service android:name="com.vungle.publisher.VungleService" android:exported="false"/>
    
  </application>
  
</manifest>
```

#### 3. Integrate the SDK

##### Application Startup

Initialize the Publisher SDK in your application's first `Activity`. This starts video caching and prepares the SDK to display ads.
```java
import com.vungle.publisher.VunglePub;

public class FirstActivity extends android.app.Activity {

  // get the VunglePub instance
  final VunglePub vunglePub = VunglePub.getInstance();

  @Override
  public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      
      // get your App ID from the app's main page on the Vungle Dashboard after setting up your app
      final String app_id = "your Vungle App ID";
      
      // initialize the Publisher SDK
      vunglePub.init(this, app_id);
  }
}
```

##### Each Activity

In addition, override the onPause() and onResume() methods in each `Activity` (including the first) to notify the Publisher SDK when your application gains or loses focus:
```java
import com.vungle.publisher.VunglePub;

public class EachActivity extends android.app.Activity {

  // get the VunglePub instance
  final VunglePub vunglePub = VunglePub.getInstance();

  ...
  
  @Override
  protected void onPause() {
      super.onPause();
      vunglePub.onPause();
  }
  
  @Override
  protected void onResume() {
      super.onResume();
      vunglePub.onResume();
  }
}
```

<a name="advancedStartupConfig"></a>
##### Advanced Startup Configuration

After calling `init()` you can optionally get access to the global `AdConfig` object. This object allows you to set options that will be automatically applied to every ad you play.
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

      // get a handle on the global ad config object
      final AdConfig globalAdConfig = vunglePub.getGlobalAdConfig();

      // set any configuration options you like. 
      // For a full description of available options, see the end of this document
      globalAdConfig.setSoundEnabled(true);
      globalAdConfig.setOrientation(Orientation.portrait);

  }
}
```

#### 4. Play Video Ad

##### Default Configuration

When you want to actually play the ad in your application, simply call `playAd`
```java
import com.vungle.publisher.VunglePub;

public class GameActivity extends android.app.Activity {

  // get the VunglePub instance
  final VunglePub vunglePub = VunglePub.getInstance();

  ...
  
  private void onLevelComplete() {
      vunglePub.playAd();
  }
}
```

##### Advanced Play Configuration

You can optionally customize each individual ad you play by providing an `AdConfig` object to `playAd`. If you [set any options in the global ad configuration](#advancedStartupConfig), those options will be overriden by the provided options.
```java
import com.vungle.publisher.VunglePub;
import com.vungle.publisher.AdConfig;

public class GameActivity extends android.app.Activity {

  ...
  
  private void onLevelComplete() {
  	  // create a new AdConfig object
  	  final AdConfig overrideConfig = new AdConfig();

  	  // set any configuration options you like. 
  	  // For a full description of available options, see the end of this document
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

One global `AdConfig` option controls settings for all ad plays, and you can optionally pass override instances to each ad play. These are the available setters in `AdConfig`:
| Method        | Default | Description|
| ------------- |--------------| 
| setOrientation | Orientation.autoRotate | Sets the orientation of the ad. Orientation options include portrait, landscape, or auto|
| setSoundEnabled | true | Sets the starting sound state for the ad. If true, audio respects device volume and sound settings. If false, video begins muted but user may modify|
| setIncentivized | false | Sets the incentivized mode. If true, user will be prompted with a confirmation dialog when attempting to skip the ad. If false, no confirmation is shown.|
| setIncentivizedCancelDialogTitle | "Close video?" | Sets the title of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized.| 
| setIncentivizedCancelDialogBodyText | "Closing this video early will prevent you from earning your reward. Are you sure?" | Sets the body of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized.| 
| setIncentivizedCancelDialogCloseButtonText | "Close video" | Sets the 'cancel button' text of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized.| 
| setIncentivizedCancelDialogKeepWatchingButtonText | "Keep watching" | Sets the 'keep watching button' text of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized.| 