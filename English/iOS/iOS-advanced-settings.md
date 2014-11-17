# VungleSDK- iOS Advanced Settings

## Please note:

This reference covers the more advanced settings and customizeable aspects of Vungle ads. If you're just getting started, you'll want to check out this [guide](https://github.com/Vungle/vungle-resources/blob/master/English/iOS/iOS-dev-guide.md). 

Applicable to Version 3.0+

## playAd Options

You can pass a dictionary into playAd which changes the default behaviour of the experience. Each key is optional to add to the dictionary, and if omitted they will take a default value. You need to pass in the dictionary each time you show an ad, else the default settings will be used. You can find an example of an options dictionary on [line 70](https://github.com/Vungle/publisher-sample-ios/blob/master/Vungle%20Sample%20App/FirstViewController.m) of the sample app.

* If you are updating from a version prior to 3.0.8, please note that the keys (below) are now constants.

| Key          | Default Value / Type | Description | 
| :----------- | :------------------- |:----------- |
| `VunglePlayAdOptionKeyIncentivized` | `NO` <br> NSNumber representing a bool value. | You can choose to be notified whenever a user has completed an ad. A typical use case of this is when you are offering some sort of value exchange (‘watch this video and receive 100 gems!’). If you choose to make your ads incentivized, we’ll immediately send a message to your server along with a user id (that you provide) so that you can reward your users. YES means this ad will be incentivized. |
| `VunglePlayAdOptionKeyShowClose` | `NO` <br> NSNumber representing a bool value. | Determines whether you would like to give the user the option to skip out of the video. YES means a close button will be displayed. Note that this can be overridden by an option on our dashboard that will remove all skip buttons in your app (which will likely boost your performance). Note- this method will be deprecated in version 3.1.0. The close button will be controlled by the dashboard settings 'Forced View' and 'Forced View Incentivized'. |
| `VunglePlayAdOptionKeyOrientations` | `UIInterfaceOrientationMaskAll` <br> An NSNumber representing a bitmask with orientations (defaults to autorotate). | Sets the orientation of the ad. We recommend allowing ads to autorotate, even if your app is in portrait. This way, the user has the option to watch full-size videos, resulting in a better user experience. You can acheive this by setting the orientation on a view controller level (rather than a project level). | 
| `VunglePlayAdOptionKeyUser` | `nil` <br> NSString with user identifier that will be passed if the ad is incentivized. | The key user is the one passed as user in the S2S call (if there are any). | 
| `VunglePlayAdOptionKeyPlacement` | `nil` <br> NSString that will eventually be used for reporting (coming soon!). | You'll want to pass an indicator of which ad was played, for example, 'Level2'. | 
| `VunglePlayAdOptionKeyExtraInfoDictionary` | `nil` <br> NSDictionary containing the extra keys (defined below). | You can use this to keep track of metrics such as age group, gender, etc. | 
| `VunglePlayAdOptionKeyExtra1..8` | `nil` <br> NSString representing each user metric you are tracking. | We have 8 keys built in here, for example, `VunglePlayAdOptionKeyExtra1`, `VunglePlayAdOptionKeyExtra2`, and so on. | 


## SDK Instances

### Instance Properties

* `muted` (`BOOL`): whether or not to start the ad muted.
* `incentivizedAlertText` (`NSString`): The string displayed when the user tries to skip an incentivized ad.
* `delegate` (`id<VungleSDKDelegate>`): any object that implements Vungle's delegate protocol.
* `assetLoader` (`id<VungleAssetLoader>`): used mostly for 3rd party plugins (corona, adobe), but you can use it if you want for your own projects: should provide the required assets for vungle's view controller.

### assetLoader Protocol

```obj-c
@protocol VungleAssetLoader<NSObject>
/**
 * should return a valid NSData containing the (raw) data of an image for the specified
 * path or nil.
 */
- (NSData*)vungleLoadAsset:(NSString*)path;
   
/**
 * should return a valid UIImage for the specified path, or nil.
 */
- (UIImage*)vungleLoadImage:(NSString*)path;
@end
```

### Instance Methods (Debugging)

* `- (BOOL)isCachedAdAvailable;`
  Returns `YES` if there's a cached ad ready to be displayed. This doesn't check whether there might be a streaming ad available, even if the publisher is opted in for streaming.
* `- (NSDictionary*)debugInfo;`
  Returns an NSDictionary with debug information (cache status and some other useful information).
* `- (void)setLoggingEnabled:(BOOL)enable;`
  Whether or not to enable logging. By default is disabled.
* `- (void)log:(NSString*)message, ... NS_FORMAT_FUNCTION(1,2);`
  Logs a new message. It follows the same format than `NSLog`.
* `- (void)attachLogger:(id<VungleSDKLogger>)logger`
  Attaches a logger, that will receive every log sent internally and externally using `log:`. It's up to the developer to properly detach the logger (internally, the logger is retained).
* `- (void)detachLogger:(id<VungleSDKLogger>)logger;`
  Detaches a logger object.

* `NSString* VungleSDKVersion`
  This is not an instance method, it's a constant who's value is the current version of the SDK. You can use this for debugging purposes.

### SDKLogger Protocol

```obj-c
@protocol VungleSDKLogger <NSObject>
- (void)vungleSDKLog:(NSString*)message;
@end
```

## Delegates

### Delegate Methods

You can implement the VungleSDK Delegate which can alert you to some useful events with regards to the ad experience. 

| Method       | Description | 
| :----------- | :---------- |
| `(void)vungleSDKhasCachedAdAvailable` | (Available in 3.0.7 and later) This callback will fire when we have an ad cached and it's ready to play. |
| `(void)vungleSDKwillShowAd` | This callback will be fired when the SDK is about to play an ad, so this is a useful place to have your game pause, mute, etc. |
| `(void)vungleSDKwillCloseAdWithViewInfo: willPresentProductSheet:` | At the end of our ad, there are two ways for the user to dismiss our unit: either by pressing the close button, or by clicking on the download button, in which case we will open the in-app app-store that iOS provides (using the StoreKit framework). <br> In both of these cases, this callback will get fired, as our ViewController exits. There is a boolean to alert you whether the ProductSheet will show. If the boolean is false, then this is the time to resume your app’s state. If it’s true, you’ll want to wait until the next callback fires. <br> There is also a viewInfo dictionary passed which contains some information about the user’s ad experience, which is useful if you’d like to provide client-side rewards. |
| `(void)vungleSDKwillCloseProductSheet:` | This final callback will fire in the case when a user had opted to download the advertised app, and is now closing out of the in-app app store. This is when you’ll want to resume the state of your app. |

* Note- the product sheet is the in-app app-store. If your user clicks to download an advertised app, this will be shown. They can then download without leaving your app.

### Delegate Protocol

```obj-c
@protocol VungleSDKDelegate <NSObject>
/**
 * If implemented, this will get called when ad ad has cached. It's now ready to play!
 */
- (void)vungleSDKhasCachedAdAvailable;
/**
 * If implemented, this will get called when the SDK is about to show an ad. This point
 * might be a good time to pause your game, and turn off any sound you might be playing.
 */
- (void)vungleSDKwillShowAd;
   
/**
 * If implemented, this will get called when the SDK closes the ad view, but that doesn't always mean 
 * the ad experience is complete. There might be a product sheet that will be presented. 
 * This point might be a good place to resume your game if there's no product sheet being presented. 
 * If the product sheet will be shown, we recommend waiting for it to close before you resume, 
 * show a reward confirmation to the user, etc. The viewInfo dictionary will contain the following keys:
 * - "completedView": NSNumber representing a BOOL whether or not the video can be considered a
 *                full view.
 * - "playTime": NSNumber representing the time in seconds that the user watched the video.
 * - "didDownlaod": NSNumber representing a BOOL whether or not the user clicked the download
 *                  button.
 */
- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary*)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet;

/**
 * If implemented, this will get called when the product sheet is about to be closed. 
 * It will only be called if the product sheet was shown.
 */
- (void)vungleSDKwillCloseProductSheet:(id)productSheet;
@end			   
```

### Registering The Delegate

You need to explicitly register your delegate with the Vungle SDK. In the class where you implement the delegate methods:

```obj-c
[[VungleSDK sharedSDK] setDelegate:self];
```

IMPORTANT: do not forget to unregister the delegate before it disappears! The Vungle SDK retains a copy of your delegate, so it will continue to send messages as long as the delegate is set, which can cause memory leaks. 

You can also do this any time you no longer want to receive messages from the SDK.

```obj-c
[[VungleSDK sharedSDK] setDelegate:nil];
```
