# Vungle iOS Migration Guide

## Before You Begin...

This guide will show you how to upgrade to our newest SDK- version 3.0!

Here are a few important tips:

* This guide is for those of you who already have an older version of our SDK in your app. If you're new to Vungle, you'll want to use [this guide](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-SDK-dev-guide.md).

* This is a brand-new SDK! As you go through this guide, you'll want to check **all** of your existing Vungle-related code. Our public methods have changed, but they will generally have an equivalent. 

* Our new SDK comes with a sample app, which is also available [here](https://github.com/Vungle/vungle-resources/tree/master/iOS-docs/iOS-sample-app). The Github version is missing our SDK, but a full copy is included in your SDK download.

* If you’re using one of the following development platforms, check out our plugins for updates: **Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**, and **Marmalade**. 

Allright, let's upgrade!

## 1. Switch out the SDK

Remove vunglepub.embeddedframework from your project directory and from Xcode Frameworks.

Next, head **here** to download our new SDK. Unzip it.

## 2. Frameworks

### Add Our Framework

From the new SDK download, copy *VungleSDK.embeddedframework/* into your project directory, then drag and drop it into Xcode (*Frameworks*) to have it linked to your project.

### Add Additional Framework

The new SDK requires an additional framework that was not required in previous versions, so click on your project and head to:

*General > Linked Frameworks and Libraries*

Add the following if you haven't already:

* libsqlite3.dylib

It's also a good idea to check that the VungleSDK framework appears in there. If the drag-n-drop didn't link it automatically, then manually add it by clicking the '+' and then 'Add Other'.

## 3. Initialize the Vungle SDK

Find the code you've used to initialize our SDK and replace it with the following:

### AppDelegate.h:

`#import <VungleSDK/VungleSDK.h>`

### AppDelegate.m/didFinishLaunchingWithOptions:

```objc
NSString* appID = @"Your AppID Here";
VungleSDK* sdk = [VungleSDK sharedSDK];
// start vungle publisher library
[sdk startWithAppId:appID];
```

## 4. Play an Ad!

Nearly there! Now we just need to play an advert. Make sure you have the correct import statement in any header files. 

Then, anywhere you play a Vungle ad, you'll want to replace that code with:

```objc
VungleSDK* sdk = [VungleSDK sharedSDK];
[sdk playAd:self];
```

* Please note that you will now be using the above code for **both** incentivized and non-incentivized ads. Incentivized ads are now configured as an option, just like sound and close buttons. See "Advanced Settings" below for instructions. Check out our [sample app](https://github.com/Vungle/vungle-resources/tree/master/iOS-docs/iOS-sample-app) for examples.

That's it! Migration guide complete. Stick around if your app uses some of the more customized options. As mentioned earlier, the methods have changed, but you'll find something comparable.


## Advanced Settings

Check out our [API reference](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-SDK-API-reference.md) for instructions on ad customization, debugging, and event callbacks!
