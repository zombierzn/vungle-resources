# Adobe Air Extension Instructions

### Before you begin:

* **The Vungle Extension Requires Adobe AIR SDK 3.5 or higher.** For instructions on updating the AIR SDK in Flash Builder or Flash Professional, refer to “How do I update the AIR SDK?” at the end of this guide.

* You can view the ActionScript 3 Class Documentation [here](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/index.html).

* Review 'example/VungleExample.as' for a sample application class. (If you're a Flash Professional user and are not sure how to use a Document Class, see “How do I use the VungleExample Document Class in Flash CS6?” at the end of this guide.)

## 1. Include the Extension Library

Start by creating a new AIR for mobile project and adding the native extension.

### In Flash Professional CS6 or Higher:

1. Create a new AIR for Android or AIR for iOS project
2. Choose *File > Publish Settings...*
3. Select the wrench icon next to 'Script' for 'ActionScript Settings'
4. Select the Library Path tab
5. Click 'Browse for Native Extension (ANE) File' and select the com.vungle.extensions.Vungle.ane file. Press OK
6. Select the wrench icon next to 'Target' for Player Settings
7. If targeting *Android*: Select the 'Permissions' tab and enable 'INTERNET', 'WRITE_EXTERNAL_STORAGE', 'ACCESS_WIFI_STATE', and 'ACCESS_NETWORK_STATE'
8. Check the 'Manually manage permissions and manifest additions for this app' box
9. Press OK

### In Flash Builder 4.6 or Higher:

1. Go to *Project Properties*
2. Select *Native Extensions* under *Actionscript Build Path*
3. Choose *Add ANE...* and navigate to the com.vungle.extensions.Vungle.ane file
4. Select *Actionscript Build Packaging > Google Android*
5. Select the *Native Extensions* tab and click the *'Package'* checkbox next to the extension 
6. If targeting iOS, repeat steps 4 and 5 for the 'Apple iOS' target

## 2. Update Your Application Descriptor

For Vungle to work, changes are required to the application XML file for your app. modify the XML file created by your IDE with the following changes (if you're a Flash Professional user, make sure you've followed the steps above for 'Include the Library in Flash Professional CS6 or Higher', otherwise Flash might undo your changes as you make them):

1. Set your AIR SDK to 3.5 (or later) in the app descriptor file:

`<application xmlns="http://ns.adobe.com/air/application/3.5">`

2. Include a link to the extension in the descriptor:

```as3
<extensions>
<extensionID>com.vungle.extensions.Vungle</extensionID>
</extensions>
```

### For AIR Applications Targeting Android

*If targeting Android*, update your Android Manifest Additions in the <android> XML element, to include the INTERNET, WRITE_EXTERNAL_STORAGE, ACCESS_WIFI_STATE permissions; add the VungleAdvert activity definition; and add the VungleIntentService:

```as3
<android> 
<manifestAdditions><![CDATA[ 
<manifest android:installLocation="auto"> 

  <uses-permission android:name="android.permission.INTERNET"/> 
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" /> 
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" /> 

  <application> 

   <activity
      android:name="com.vungle.publisher.FullScreenAdActivity"
      android:configChanges="keyboardHidden|orientation|screenSize"
      android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
    />
  </application> 

  <service android:name="com.vungle.sdk.VungleIntentService"
    android:exported="false"
  />

</manifest> 
]]></manifestAdditions>
</android>
```

## 3. Integrate the Vungle API

The Vungle API can be added your application in just a few lines of ActionScript.

###  Initialize the Vungle Extension

Initialize the API when your application starts. (If using pure ActionScript, do this in the constructor of your Document Class. If using Flex, call this in initialize() event of the main class. If using timeline code in Flash, do this on Frame 1.)

1. Import the API Classes:

```as3
import com.vungle.extensions.*; 
import com.vungle.extensions.events.*;
```

2. Initialize the API by calling Vungle.create(), and passing in an array containing your application ID from the Vungle Dashboard. If you are targeting both iOS and Android from the same project, include both IDs in the array- with the iOS id first and the Android id second.

You should also check the Vungle.isSupported() method first, to ensure the current platform is supported before initializing (for instance, the extension won't run on the Desktop):

```as3
// check if the current platform supports the extension 
if (Vungle.isSupported()) 
{ 
  // initialize with your app id 
  Vungle.create(["your_vungle_id"]); 

  // -OR- initialize including both ios and android ids for multiplatform apps 
  // Vungle.create(["your_ios_vungle_id","your_android_vungle_id"]); 
}
```

### Display an Interstitial Ad

To display an interstitial ad, call displayAd(). You'll want to first check than ad is available using the isVideoAvailable() method:

```as3
if(Vungle.vungle.isAdAvailable()) 
{ 
// Parameters for displayAd(showCloseButton:Boolean=false, orientationHint:int=0)
Vungle.vungle.displayAd(false, VungleOrientation.IOS_PORTRAIT | VungleOrientation.ANDROID_MATCH_VIDEO); 
}

/** VungleOrientation options:
        public class VungleOrientation
        {
                private static const NUMBER_OF_IOS_BITS:int = 2;
                public static const ANDROID_AUTOROTATE:int = 3 << NUMBER_OF_IOS_BITS;
                public static const ANDROID_MATCH_VIDEO:int = 1 << NUMBER_OF_IOS_BITS;
                public static const IOS_LANDSCAPE:int = 1;
                public static const IOS_PORTRAIT:int = 2;
        } */
```

### Display an Incentivized Ad

To display an incentivized ad, call displayIncentivizedAd(). You'll want to first check than ad is available using the isVideoAvailable() method. The function takes two Optional parameters: whether to display a Close button on the ad, and an optional user-identifying string (which can be used with Vungle's server-side webhooks, to trigger an HTTP GET whenever a user completes a view):

```as3
if(Vungle.vungle.isAdAvailable())
{ 
// Parameters for displayIncentivizedAd(name:String=null, showCloseButton:Boolean=false, orientationHint:int=0)
Vungle.vungle.displayIncentivizedAd("userName123", false, VungleOrientation.IOS_LANDSCAPE | VungleOrientation.ANDROID_AUTOROTATE);
}
```

To reward the player for completing an incentivized view, you'll want to implement the AD_VIEWED event listener as described below.

### Add Event Listeners

The Vungle Extension dispatches three events: VungleEvent.AD_STARTED, VungleEvent.AD_FINISHED, and VungleEvent.AD_VIEWED.

1. The AD_STARTED and AD_FINISHED events are dispatched when an ad is displayed and dismissed, respectively:

```as3
Vungle.vungle.addEventListener(VungleEvent.AD_STARTED, onAdStarted); 
Vungle.vungle.addEventListener(VungleEvent.AD_FINISHED, onAdFinished); 
 
function onAdStarted(e:VungleEvent):void 
{ 
  trace("ad displayed"); 
} 

function onAdFinished(e:VungleEvent):void
{ 
  trace("ad dismissed"); 
}
```

2. The AD_VIEWED event is triggered when the user is no longer in a Vungle ad, and has watched some portion of the video. The 'watched' property is the amount of time, in seconds, of a video that the user watched. The 'property' is the total length of the video. 

(This event may not be called in some cases, such as when there is a pre-roll HTML asset in the advertisement and the user opts out of the ad before seeing the video.) 

For incentivized ads, Vungle considers a viewing where more than 80% of the video was seen as a completed view:

```as3
Vungle.vungle.addEventListener(VungleEvent.AD_VIEWED, onAdViewed); 

function onAdStarted(e:VungleEvent):void 
{ 
  trace("watched"+e.watched+" of "+e.length+" second video."); 
  var percentComplete:Number=e.watched/e.length; 
  if(percentComplete>0.80) 
  { 
    trace("counts a completed view- present reward."); 
  } 
}
```

### Toggle Auto-rotation

You can use the setAutoRotationEnabled() method to toggle whether videos will automatically rotate to the orientation of the user's device:

```as3
Vungle.vungle.setAutoRotation(true);
```

### Toggle Sound

You can use the setSoundEnabled() method to toggle whether ads will play sound, or be muted:

```as3
Vungle.vungle.setSoundEnabled(true);
```

### Toggle Back-Button Enabled (Android Only)

You can use the setBackButtonEnabled() and setIncentivizedBackButtonEnabled() methods to toggle whether the back button will be enable during ads on Android devices. On iOS, these functions will have no effect:

```as3
Vungle.vungle.setBackButtonEnabled(true); 
Vungle.vungle.setIncentivizedBackButtonEnabled(true);
```

## Troubleshooting and FAQ

**“How do I use the VungleExample.as Document Class in Flash Professional CS6?”**

1. First, create the application and add the extension by following this guide, Sections 1-3. 

2. Copy and paste VungleExample.as into the same folder as your .fla. Do not copy and paste its contents on to the timeline. That will not work.

3. Change the app ids on line 51 to be your own Vungle App Ids. 

4. In Flash properties, under 'Document Class', type 'VungleExample' (no quotes) and press OK. 

5. Build and install the application.

**“How do I install a newer version of the AIR SDK (3.5 or higher) in Flash Professional CS6?”**

You can download the latest AIR SDK [here](http://www.adobe.com/devnet/air/air-sdk-download.html). If you have already installed AIR 3.5 or higher, you may skip this step. Otherwise, follow the instructions below:

1. Unzip the AIR 3.5 or later SDK package to a location on your hard drive. 

2. Launch Flash Professional CS6. 

3. Select Help > Manage AIR SDK... 

4. Press the Plus (+) Button and navigate to the location of the unzipped AIR SDK 

5. Press OK 

6. Select File > Publish Settings 

7. Select the latest AIR SDK for iOS from the 'Target' Dropdown menu

**“How do I install a newer version of the AIR SDK (3.5 or higher) in Flash Builder?”**

You can download the latest AIR SDK [here](http://www.adobe.com/devnet/air/air-sdk-download.html). If you have already installed AIR 3.5 or higher, you may skip this step. You can find Adobe's latest instructions for updating Flash Builder AIR SDKs [here](http://helpx.adobe.com/flash-builder/kb/overlay-air-sdk-flash-builder.html).

