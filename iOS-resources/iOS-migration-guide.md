# VungleSDK- iOS Migration Guide

## Before You Begin...

This guide will show you how to upgrade to our newest SDK- version 3.0!

If you're new to Vungle, you'll want to use [this guide](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-dev-guide.md).

### Here are a few important tips:

* **This is a brand-new SDK!** As you go through this guide, you'll want to check **all** of your existing Vungle-related code. Our public methods have changed, but they will generally have an equivalent. 

* Our new SDK comes with a sample app, which is also available [here](https://github.com/Vungle/vungle-resources/tree/master/iOS-docs/iOS-sample-app). The Github version is missing our SDK, but you'll be able to check out the source code.

* If you’re using one of the following development platforms, check out our plugins for updates: **Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**, and **Marmalade**. **Note- our partners are in-process of updating these plugins, we will update these links as they become available.**

Allright, let's upgrade!

## 1. Switch out the SDK

Remove vunglepub.embeddedframework from your project directory and from Xcode Frameworks.

Next, head [here](https://v.vungle.com/dev/ios) to download our new SDK. Unzip it.

## 2. Frameworks

### Add Our Framework

From the new SDK download, copy *VungleSDK.embeddedframework/* into your project directory, then drag and drop it into Xcode (*Frameworks*) to have it linked to your project.

Note- the .embeddedframework directory should be added as a group (yellow folder) and not as a reference (blue folder).

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

### Want to change the ads' default settings?

* **Options object:** To configure an ad's mute settings, orientation, and other customizeable options, you will now be creating and passing in a dictionary. See [line 70](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-sample-app/Vungle%20Sample%20App/FirstViewController.m) of the sample app for an example. The [Advanced Settings](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-advanced-settings.md) will cover the rest.

* **Incentivized ads:** This will also be an option in your dictionary. There are no longer separate methods to play incentivized and non-incentivized ads.
  
That's it! Migration guide complete. Stick around to learn more about customizing your ads!


## Advanced Settings

Check out our [Advanced Settings](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-advanced-settings.md) for instructions on ad customization, debugging, and event callbacks!
