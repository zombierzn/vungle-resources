# VungleSDK- Windows Advanced Settings 

## Please note:

This reference covers the more advanced settings and customizeable aspects of Vungle ads. If you're just getting started, you'll want to check out this [guide](windows-dev-guide.md). 

## Advanced Configuration 

### PlayAdAsync Configuration 

You can optionally customize ad that you play by providing an `AdConfig` object to `PlayAdAsync`.

```cs
using VungleSDK;

public sealed partial class SecondPage : Page
{
	...
	async void PlayVungleAdAsync()
	{
		// the AdConfig object will only affect this ad play.
		await sdkInstance.PlayAdAsync(new AdConfig(){ 
			// set any configuration options you like. 
			// For a full description of available options, see the 'Configuration Options' section.
			Incentivized = true,
			SoundEnabled = false
		});
	}
}
```

### Configuration Options

#### The `AdConfig` Object

These are the available properties in the `AdConfig` object instance:

| Method | Default | Description |
|:------ |:------- |:----------- |
| `Orientation` | `DisplayOrientations.AutoRotate` | `Orientation.autoRotate` indicates that the ad will autorotate with the device orientation. `Orientation.Portrait` indicates that that the ad will play only in the portrait orientation. `Orientation.Landscape` indicates that that the ad will play only in the portrait orientation.|
| `SoundEnabled` | `true` | Sets the starting sound state for the ad. If `true`, the audio respects device volume and sound settings. If `false`, video begins muted but user may modify. |
| `BackButtonImmediatelyEnabled` | `false` | If `true`, allows the user to immediately exit an ad using the back button.  If `false`, the user cannot use the back button to exit the ad until the on-screen close button is shown.
| `Incentivized` | `false` | Sets the incentivized mode - you must set this to true if you're using server-to-server callbacks for your rewarded ads. If true, user will be prompted with a confirmation dialog when attempting to skip the ad. If false, no confirmation is shown. Further instructions for setting up incentivized ads are [here](../../Incentivized-Ads). |
| `UserId` | null | Sets the unique user id to be passed to your application to verify that this user should rewarded for watching an incentivized ad. N/A if ad is not incentivized. |
| `IncentivizedDialogTitle` | null | Sets the title of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. |
| `IncentivizedDialogBody` | "Are you sure you want to skip this ad? If you do, you might not get your reward" | Sets the body of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. | 
| `IncentivizedDialogCloseButton` | "Close" | Sets the 'cancel button' text of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. | 
| `IncentivizedDialogContinueButton` | "Continue" | Sets the 'keep watching button' text of the confirmation dialog when skipping an incentivized ad. N/A if ad is not incentivized. |
| `Extra[0..7]` | null | You can use this to keep track of metrics such as age group, gender, etc. |
| `Placement` | null | Sets an optional ad placement name for enhanced reporting on the dashboard. |

##### Showing the Close Button

To control whether a user has the option to close out of an ad, use the forced view options in your app's advanced settings on the [Vungle Dashboard](https://v.vungle.com/).

#### Subscribing to events
The Publisher SDK raises several events that you can handle programmatically.

##### UI Thread Note

The evnt listeners are executed on a background thread, so any UI interaction/updates resulting from an event listener need to be passed to the main UI thread before executing. The way to do it may be like this: 
```cs
await CoreApplication.MainView.Dispatcher.RunAsync(CoreDispatcherPriority.Normal,
                new DispatchedHandler(() => 
                {
					// this block will be executed in the UI thread
				}
));
```
##### VungleAd events
```cs
using VungleSDK;

public sealed partial class MainPage : Page
{
	VungleAd sdkInstance;
	public MainPage()
	{
		InitializeComponent();
		
		var appId = "your Vungle App ID";
		sdkInstance = AdFactory.GetInstance(appId);
		
		sdkInstance.OnAdPlayableChanged += Sdk_OnAdPlayableChanged;
		sdkInstance.OnAdStart += VungleAd_OnAdStart;
		sdkInstance.OnAdEnd += VungleAd_OnAdEnd;
		sdkInstance.OnVideoView += VungleAd_OnVideoView;
		sdkInstance.Diagnostic += VungleAd_Diagnostic;
	}
	
	private void Sdk_OnAdPlayableChanged(object sender, AdPlayableEventArgs e)
	{
		// This will get called with an parameter e.AdPlayable is true
		// when the SDK has an ad ready to be displayed.
		// Also it will get called with an parameter e.AdPlayable is false
		// when for some reason, there's no ad available.
	}
	
	private void VungleAd_OnAdStart(object sender, AdEventArgs e)
	{
		// Called before playing an ad
	}

	private void VungleAd_OnAdEnd(object sender, AdEndEventArgs e)
	{
		// Called when the user leaves the ad and control is returned to your application.
		// e.CallToActionClicked is true when the user clicked a Download button 
	}
	
	private void VungleAd_OnVideoView(object sender, AdViewEventArgs e)
	{
		// Called each time an ad completes. e.IsCompletedView is true if at least  
        // 80% of the video was watched, which constitutes a completed view.  
        // e.WatchedDuration is a longest video view time (if the user replayed the video).
        // e.VideoDuration is a total video time.
	}
	
	private void VungleAd_Diagnostic(object sender, DiagnosticLogEvent e)
	{
		// Called when sdk want to send some logs.
		// e.Message contains log message
		// e.Level indicates log Level (Trace, Debug, Info, Warn, Error, Fatal)
	}	
}
```