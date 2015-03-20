# VungleSDK- Swift Developer Guide

## Before You Begin...

* If you haven't already done so, head over to our [dashboard](https://v.vungle.com/dashboard/login) and add your app to your account. You need to do this so that you can get your App ID that you’ll be adding to your app with our SDK. It’s in **red** on your app’s page.

## 1. Download the SDK

Next, head [here](https://v.vungle.com/dev/ios) to download our SDK. Unzip it.

## 2. Add VungleSDK to Your Project

### Update Build Settings

In your project's build settings -> Enable Modules (C and Objective-C) should be set to YES

### Add Our Framework

Our SDK is released as a framework, so copy *VungleSDK.embeddedframework/* into your project directory, then drag and drop it into Xcode (*Frameworks*) to have it linked to your project.

Note- the .embeddedframework directory should be added as a group (yellow folder) and not as a reference (blue folder).

### Add Required Frameworks

The Vungle SDK requires the following frameworks to be linked to your project, so click on your project and head to:

*General > Linked Frameworks and Libraries*

Add any of the following that are not included:

* AdSupport.framework
* AudioToolbox.framework
* AVFoundation.framework
* CFNetwork.framework
* CoreGraphics.framework
* CoreMedia.framework
* Foundation.framework
* libz.dylib
* libsqlite3.dylib
* MediaPlayer.framework
* QuartzCore.framework
* StoreKit.framework
* SystemConfiguration.framework
* UIKit.framework

It's also a good idea to check that the VungleSDK framework appears in there. If the drag-n-drop didn't link it automatically, then manually add it by clicking the '+' and then 'Add Other'.

## 3. Create a Bridging Header File

* Create a new Objective C file in your project (File->New->File [Objective C for iOS]).

* Xcode will ask if you'd like to create a bridging header file between Objective C and Swift. Go ahead and accept this prompt.

* Delete the new Objective C file but retain the bridging header file ${YOURPROJ}-Bridging-Header.h.

* In the Bridging header file, import Vungle by adding `#import <VungleSDK/VungleSDK.h>`.

## 4. Initialize the SDK

We strongly recommend that you initialize our SDK as early as possible within your app. We need to pre-cache the first ad before we can play it, so the earlier the better. Add the following:

### AppDelegate.swift/didFinishLaunchingWithOptions:

```swift
var appID = "Your AppID Here"
		var sdk = VungleSDK.sharedSDK()
		// start vungle publisher library
		sdk.startWithAppId(appID)
```

## 5. Play an Ad!

Nearly there! Now we just need to play an advert. Add the following:

### ViewController.swift

```swift
  var sdk = VungleSDK.sharedSDK()
  sdk.playAd(self)
```

* Note for testing ads- until your app is live in the app store, you will not be able to download any of the advertised apps directly. You can click 'download' to view the product sheet, though.

That's it! Quick start guide complete. Stick around if you'd like to check out some of the ways you can customize the ad experience, but otherwise go forth and monetize!


## Advanced Settings

You can find our playAd options in our [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/English/iOS/iOS-advanced-settings.md). Here's an example of how they should look in Swift:

```swift
  var sdk = VungleSDK.sharedSDK()
  sdk.playAd(self, withOptions: [VunglePlayAdOptionKeyIncentivized: true,
			VunglePlayAdOptionKeyOrientations: UIInterfaceOrientationMask.Portrait.rawValue,
			VunglePlayAdOptionKeyUser: "username123",
			VunglePlayAdOptionKeyPlacement: "Level3",
			VunglePlayAdOptionKeyExtraInfoDictionary: [VunglePlayAdOptionKeyExtra1: "female", VunglePlayAdOptionKeyExtra2: "21"]])
```
