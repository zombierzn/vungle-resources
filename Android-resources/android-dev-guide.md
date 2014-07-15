# VungleSDK- Android Developer Guide

## Before You Begin...

This guide will show you how you can easily integrate our SDK into your app so you can start monetizing!

If you have already integrated a previous version of the Vungle SDK, you'll want to use [this guide](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-migration-guide.md).

Applicable to Version 3.0+

### Requirements

* Android 2.3 (Gingerbread - API version 9) or later
* If your application is written in C/C++, you'll need to use JNI to interface with the Publisher SDK written in Java

### Here are a few important tips:

* If you haven't already done so, head over to our [dashboard](https://v.vungle.com/dashboard/login) and add your app to your account. You need to do this so that you can get your App ID that you’ll be adding to your app with our SDK. It’s in **red** on your app’s page.

* If you’d rather just jump right in with our sample app, head [here](https://github.com/Vungle/vungle-resources/tree/master/Android-resources/androidSampleApp). 

* If you’re using one of the following development platforms, check out our plugins for **Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**, and **Marmalade**. **Note- our partners are in-process of updating these plugins, we will update these links as they become available.**

Otherwise, read on!

## 1. Download the SDK

Next, head [here](https://v.vungle.com/dev/android) to download our SDK. Unzip it.

## 2. Add VungleSDK To Your Project

Copy `vungle-publisher-[version].jar`, `javax.inject.jar`, and `android-support-v13.jar` to the `/libs` directory of your project. Create the directory if it doesn't already exist. 

If you already include the android-support or javax-inject libraries, you won't need to include them again.

This should automatically add the Publisher SDK to your build path.

## 3. Update `AndroidManifest.xml`

Add the following lines:

```xml
<manifest>

  ...
  
  <!-- permissions to download and cache video ads for playback -->
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
  
  <application>
  
    ...
    
    <!--
      Required Activity for playback of Vungle video ads
    -->
    <activity
      android:name="com.vungle.publisher.FullScreenAdActivity"
      android:configChanges="keyboardHidden|orientation|screenSize"
      android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
    />
    
    
    <service android:name="com.vungle.publisher.VungleService"
      android:exported="false"
    />
    
  </application>
  
</manifest>
```

### Additional Steps for SDK Version 3.1.0 or Higher:

1) Add the following to your Manifest:

```xml
<manifest>

  ...
  
  <application>

    <meta-data android:name="com.google.android.gms.version"
      android:value="@integer/google_play_services_version" />

    ...

  </application>
  
</manifest>
```

2) Add Google Play Services to your project:

http://developer.android.com/google/play-services/setup.html#Setup

3) In your app, ensure that the device has a sufficiently up-to-date version of Google Play Services:

http://developer.android.com/google/play-services/setup.html#ensure

## 4. Initialize & Integrate the SDK

### Application Startup

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

### Each Activity

In addition, override the `onPause` and `onResume` methods in each `Activity` (including the first) to notify the Publisher SDK when your application gains or loses focus:
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

## 5. Play an Ad!

### Default Configuration

Almost done! When you want to actually play the ad in your application, simply call `playAd`
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

**Tip-** If you'd like to check if a cached ad is available, use: `vunglePub.isCachedAdAvailable();`

That's it! Quick start guide complete. Stick around if you'd like to check out some of the ways you can customize the ad experience, but otherwise go forth and monetize!

<a name="advancedStartupConfig"></a>
## Advanced Settings

Check out our [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-advanced-settings.md) for instructions on ad customization, debugging, and event callbacks!
