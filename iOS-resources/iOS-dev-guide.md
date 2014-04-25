# VungleSDK- iOS Developer Guide

## Before You Begin...

This guide will show you how you can easily integrate our SDK into your app so you can start monetizing!

If you have already integrated a previous version of the Vungle SDK, you'll want to use [this guide](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-migration-guide.md).

Applicable to Version 3.0+

### Here are a few important tips:

* If you haven't already done so, head over to our dashboard and add your app to your account. You need to do this so that you can get your App ID that you’ll be adding to your app with our SDK. It’s in red on your app’s page.

* If you’d rather just jump right in with our sample app, head [here](https://github.com/Vungle/vungle-resources/tree/master/iOS-resources/iOS-sample-app). 

* If you’re using one of the following development platforms, check out our plugins for **Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**, and **Marmalade**. **Note- our partners are in-process of updating these plugins, we will update these links as they become available.**

Otherwise, read on!

## 1. Download the SDK

Next, head [here](https://v.vungle.com/dev/ios) to download our SDK. Unzip it.

## 2. Add Our SDk to Your Project

### Add Our Framework

Our SDK is released as a framework, so copy *VungleSDK.embeddedframework/* into your project directory, then drag and drop it into Xcode (*Frameworks*) to have it linked to your project.

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

## 3. Remove the iOS Status Bar

We recommend that our ads play without the iOS status bar at the top of the screen for two reasons. Firstly, it makes it easier for the user to close out of our ad experiences. Secondly, they look waaay better. To do this, open up your Info.pList and add the key *"View controller-based status bar appearance"* and set it to *"No"*.

## 4. Initialize the Vungle SDK

We strongly recommend that you initialize our SDK as early as possible within your app. We need to pre-cache the first ad before we can play it, so the earlier the better. Add the following:

### AppDelegate.h:

`#import <VungleSDK/VungleSDK.h>`

### AppDelegate.m/didFinishLaunchingWithOptions:

```objc
NSString* appID = @"Your AppID Here";
VungleSDK* sdk = [VungleSDK sharedSDK];
// start vungle publisher library
[sdk startWithAppId:appID];
```

## 5. Play an Ad!

Nearly there! Now we just need to play an advert. Remember to add the import statement to any header files. Then:

```objc
VungleSDK* sdk = [VungleSDK sharedSDK];
[sdk playAd:self];
```

That's it! Quick start guide complete. Stick around if you'd like to check out some of the ways you can customize the ad experience, but otherwise go forth and monetize!


## Advanced Settings

Check out our [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-advanced-settings.md) for instructions on ad customization, debugging, and event callbacks!

