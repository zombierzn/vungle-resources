# VungleSDK- Android Migration Guide

## Before You Begin...

This guide will show you how to upgrade to our newest SDK- version 3.0!

If you're new to Vungle, you'll want to use [this guide](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-dev-guide.md).

### Here are a few important tips:

* **This is a brand-new SDK!** As you go through this guide, you'll want to check **all** of your existing Vungle-related code. Our public methods have changed, but they will generally have an equivalent. 

* Our new SDK comes with a sample app, which is also available [here](https://github.com/Vungle/publisher-sample-android). The Github version is missing our SDK, but you'll be able to check ou the source code. A full copy is included in your SDK download.

* If you’re using **Adobe Air**, **Unity**, or **Corona**, check out our [plugins page](https://v.vungle.com/dev/plugins).

Allright, let's upgrade!

## 1. Switch out the SDK

Remove your current ```VunglePub.jar``` or ```vungle-publisher-[version].jar``` file. 

Next, head [here](https://v.vungle.com/dev/android) to download our new SDK. Unzip it.

## 2. Add VungleSDK To Your Project

Copy all of the libraries from the unzipped `/libs` directory into your project's `/libs` directory.  Create this directory if it doesn't already exist in your project.  This should automatically add the libraries to the build path of your project.

In version 3.2.0+, this should include the following libraries:
* `dagger-[version].jar`
* `javax.inject-[version].jar`
* `nineoldandroids-[version].jar`
* `support-v4-[version].jar`
* `vungle-publisher-[version].jar`

If you already include the same versions of any of the above libraries, you don't need to include them again. If you are using a different version of any of the libraries, please test your app to determine which version works best.

## 3. Update `AndroidManifest.xml` & add Google Play Services

1) Add the following lines:

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
      android:theme="@android:style/Theme.NoTitleBar.Fullscreen"/>
    
    
    <service android:name="com.vungle.publisher.VungleService"
      android:exported="false"/>

    <meta-data android:name="com.google.android.gms.version"
      android:value="@integer/google_play_services_version"/>
    
  </application>
  
</manifest>
```

2) Add Google Play Services to your project (we recommend using version 4.0.30):

http://developer.android.com/google/play-services/setup.html#Setup

3) In your app, ensure that the device has a sufficiently up-to-date version of Google Play Services:

http://developer.android.com/google/play-services/setup.html#ensure

[Vungle's Google Play Services FAQs](http://www.vungle.com/google-advertising-id-faqs/)


## 4. Initialize the Vungle SDK

Find the code you've used to initialize our SDK and replace it with the following:

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

## 5. Play an Ad!

### Default Configuration

Almost done! Anywhere you play a Vungle ad, you'll want to replace that code with:

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

### Want to change the ads' default settings?

* **AdConfig object:** To configure an ad's mute settings, orientation, and other customizeable options, you will now be configuring this global object. The [Advanced Settings](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-advanced-settings.md) will cover the rest.

* **Incentivized ads:** This will also be configured in the AdConfig object. There are no longer separate methods to play incentivized and non-incentivized ads.

That's it! Migration guide complete. Stick around to learn more about customizing your ads!


## Advanced Settings

Check out our [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-advanced-settings.md) for instructions on ad customization, debugging, and event callbacks!
