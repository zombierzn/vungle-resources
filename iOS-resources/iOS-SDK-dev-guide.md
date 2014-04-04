# Vungle iOS Developer Guide

## Before You Begin...

This guide will show you how you can easily integrate our SDK into your app so you can start monetizing!

If you haven't already done so, head over to our dashboard and add your app to your account. You need to do this so that you can get your App ID that you’ll be adding to your app with our SDK. It’s in red on your app’s page.

If you’d rather just jump right in with our sample app, head [here](https://github.com/Vungle/vungle-resources/tree/master/iOS-docs/iOS-sample-app). If you’re using one of the following development platforms, check out our plugins for **Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**, and **Marmalade**. Otherwise, read on!

## 1. Download the SDK

Next, head **here** to download our SDK. Unzip it.

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

Check out our [reference](https://github.com/Vungle/vungle-resources/blob/master/iOS-docs/iOS-SDK-API-reference.md) for specific methods that you call to use these settings.

### Mute

The SDK has a property which you can set which will determine whether ads should start playing with sound. Note that the user can toggle sound once the ad unit has started.

### Incentivized Ads

You can choose to be notified whenever a user has completed an ad. A typical use case of this is when you are offering some sort of value exchange (‘watch this video and receive 100 gems!’). If you choose to make your ads incentivized, we’ll immediately send a message to your server along with a user id (that you provide) so that you can reward your users.

### Options

You can choose to pass in a dictionary into playAd which changes the default behaviour of the experience. We’ll list them here, but see the [reference](https://github.com/Vungle/vungle-resources/blob/master/iOS-docs/iOS-SDK-API-reference.md) for the specific keys and values that they should take. Each is optional to add to the dictionary, and if omitted they will take a default value. You need to pass in the options each time you show an ad, else the default settings will be used.

### Orientations

Determines in which orientation the video will show.

### Incentivized 

As mentioned above, you can determine whether this impression will send you a callback on video completion.

### userInfo

Used to pass us a username for the incentivized callback.

### showClose

A switch to determine whether you would like to give the user the option to skip out of the video. Note that this can be overridden by an option on our dashboard that will remove all skip buttons in your app (which will likely boost your performance).

### Events

You can implement the VungleSDK Delegate which can alert you to some useful events with regards to the ad experience. See the [reference](https://github.com/Vungle/vungle-resources/blob/master/iOS-docs/iOS-SDK-API-reference.md) for specific implementation details.

### willShowAd

This callback will be fired when the SDK is about to play an ad, so this is a useful place to have your game pause, mute, etc.

### willCloseAdWithViewInfo

At the end of our ad, there are two ways for the user to dismiss our unit: either by pressing the close button, or by clicking on the download button, in which case we will open the in-app app-store that iOS provides (using the StoreKit framework).

In both of these cases, this callback will get fired, as our ViewController exits. There is a boolean to alert you whether the ProductSheet will show. If the boolean is false, then this is the time to resume your app’s state. If it’s true, you’ll want to wait until the next callback fires.

There is also a viewInfo dictionary passed which contains some information about the user’s ad experience, which is useful if you’d like to provide client-side rewards.

### willCloseProductSheet

This final callback will fire in the case when a user had opted to download the advertised app, and is now closing out of the in-app app store. This is when you’ll want to resume the state of your app.

