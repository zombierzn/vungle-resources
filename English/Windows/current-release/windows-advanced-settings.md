# VungleSDK- Windows Developer Guide

This guide will show you how you can easily integrate our SDK into your app so you can start monetizing!

### Requirements

* Windows 10 operating system
* XAML enabled environment (sdk currently does not support js applications)

### Here are a few important tips:

* If you haven't already done so, head over to our [dashboard](https://v.vungle.com/dashboard/login) and add your app to your account. You need to do this so that you can get your App ID that you’ll be adding to your app with our SDK. It’s in **red** on your app’s page.

* If you’d rather just jump right in with our sample app, head [here](https://github.com/Vungle/publisher-sample-windows). 

Otherwise, read on!

## 1. Download the SDK

Next, head [here](https://v.vungle.com/dev/windows) to download our SDK. Unzip it.

## 2. Add VungleSDK To Your Project

1) In Solution Explorer, select the project.
2) On the Project menu, click Add Reference.
3) Click Browse button and find downloaded sdk library.
4) Click OK when you have selected all the components you need.

## 3. Update `package.appxmanifest`

1) In Solution Explorer double click `package.appxmanifest`.
2) Go to Capabilities tab.
3) Enable the `Internet (client)` capability.

## 4. Initialize & Integrate the SDK

Initialize the SDK in your application's first `Page`. This starts video caching and prepares the SDK to display ads.
```cs
using VungleSDK;
public sealed partial class MainPage : Page
{
	VungleAd sdkInstance;
	public MainPage()
	{
		InitializeComponent();
		
		// get your App ID from the app's main page on the Vungle Dashboard after setting up your app
		var appId = "your Vungle App ID";
		
		// initialize the VungleAd instance
		sdkInstance = AdFactory.GetInstance(appId);
	}
}
```


## 5. Play an Ad!

### Default Configuration

Almost done! When you want to actually play the ad in your application, simply call `PlayAdAsync` method
```cs
using VungleSDK;
public sealed partial class SecondPage : Page
{
	VungleAd sdkInstance;
	public MainPage()
	{
		InitializeComponent();
		
		// get the VungleAd instance
		sdkInstance = AdFactory.GetInstance("your Vungle App ID");
	}
	...
	async void PlayVungleAdAsync()
	{
		await sdkInstance.PlayAdAsync(new AdConfig());
	}
}
```

**Tip-** If you'd like to check if an ad is available before playing, use:
```cs
// indicates if an ad is ready to play
sdkInstance.AdPlayable()
```

That's it! Quick start guide complete. Stick around if you'd like to check out some of the ways you can customize the ad experience, but otherwise go forth and monetize!

<a name="advancedStartupConfig"></a>
## Advanced Settings

Check out our [advanced settings](./windows-advanced-settings.md) for instructions on ad customization, debugging, and event callbacks!