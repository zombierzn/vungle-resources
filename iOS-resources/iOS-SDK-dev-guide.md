# VungleSDK 

## iOS Developer Guide

## Before You Begin...

This guide will show you how you can easily integrate our SDK into your app so you can start monetizing!

If you have already integrated a previous version of the Vungle SDK, you'll want to use [this guide](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-migration-guide.md).

### Here are a few important tips:

* If you haven't already done so, head over to our dashboard and add your app to your account. You need to do this so that you can get your App ID that you’ll be adding to your app with our SDK. It’s in red on your app’s page.

* If you’d rather just jump right in with our sample app, head [here](https://github.com/Vungle/vungle-resources/tree/master/iOS-resources/iOS-sample-app). 

* If you’re using one of the following development platforms, check out our plugins for **Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**, and **Marmalade**. Otherwise, read on!

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

### Options

You can choose to pass in a dictionary into playAd which changes the default behaviour of the experience. Each is optional to add to the dictionary, and if omitted they will take a default value. You need to pass in the options each time you show an ad, else the default settings will be used. You can find an example of an options dictionary on [line 70](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-sample-app/Vungle%20Sample%20App/FirstViewController.m) of the sample app.

<table>
	<thead>
		<tr>
			<th>Key</th>
			<th>Default Value</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>orientations</td>
			<td>UIInterfaceOrientationMaskAll</td>
			<td>An NSNumber representing a bitmask with orientations. Sets the orientation of the ad.</td>
		</tr>
		<tr>
			<td>muted (here or in properties?)</td>
			<td>NO</td>
			<td>Sets the starting sound state for the ad. Default is... . Note that the user can toggle sound once the ad unit has started.</td>
		</tr>
	    <tr>
		    <td>showClose</td>
		    <td>YES</td>
		    <td>An NSNumber representing a bool value. Determines whether you would like to give the user the option to skip out of the video. `YES` means a close button will be displayed. Note that this can be overridden by an option on our dashboard that will remove all skip buttons in your app (which will likely boost your performance).</td>
	    </tr>
	    <tr>
	    	<td>incentivized</td>
	    	<td>NO</td>
	    	<td>An NSNumber representing a bool value. You can choose to be notified whenever a user has completed an ad. A typical use case of this is when you are offering some sort of value exchange (‘watch this video and receive 100 gems!’). If you choose to make your ads incentivized, we’ll immediately send a message to your server along with a user id (that you provide) so that you can reward your users. `YES` means this ad will be incentivized.</td>
	    </tr>
		<tr>
			<td>userInfo (or userData?)</td>
			<td></td>
			<td>An NSDictionary with user info that will be passed if the ad is incentivized. The key `user` is the one passed as `user` in the S2S call (if there are any).</td>
		</tr>
	</tbody>
</table>

### Other

Check out our [reference](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-SDK-API-reference.md) for specific methods that you call to use these settings.

