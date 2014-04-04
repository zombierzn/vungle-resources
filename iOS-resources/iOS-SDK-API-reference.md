# iOS Publisher SDK API Reference

## VungleSDK

### Properties

* `userData` (`NSDictionary`): holds user data that will be sent to our servers when playing an incentivized ad.
* `delegate` (`id<VungleSDKDelegate>`): any object that implements Vungle's delegate protocol.
* `assetLoader` (`id<VungleAssetLoader>`): used mostly for 3rd party plugins (corona, adobe), but you can use it if you want for your own projects: should provide the required assets for vungle's view controller.
* `incentivizedAlertText` (`NSString`): The string displayed when the user tries to skip an incentivized ad.
* `muted` (`BOOL`): whether or not to start the ad muted.

### Class methods

* `+ (VungleSDK*)sharedSDK;`
  This method returns the shared instance. This is the only way to get access to the shared instance.

### Instance methods

* `- (void)startWithAppId:(NSString*)appId;`
  Starts Vungle's SDK with the specified appId. The `appId` is the one you obtain from Vungle's dashboard when you create a new app. 

* `- (void)playAd:(UIViewController*)viewController;`
  Plays an ad with the default settings. The ad view will be presented over the passed view controller. It can't be `nil`.

* `- (void)playAd:(UIViewController *)viewController withOptions:(id)options;`
  Same as the other play method, but you can configure how the ad is presented. `options` is an NSDictionary that can contain the following keys:
  * `orientations`: an NSNumber representing a bitmask with orientations. The default value is `UIInterfaceOrientationMaskAll`.
  * `incentivized`: an NSNumber representing a bool value. `YES` means this ad will be incentivized. Default is `NO`.
  * `userInfo`: an NSDictionary with user info that will be passed if the ad is incentivized. The key `user` is the one passed as `user` in the S2S call if there's any.
  * `showClose`: an NSNumber representing a bool value. `YES` means a close button will be displayed. Default is `YES`.

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
  Detacches a logger object.

### Protocols

```obj-c
@protocol VungleSDKLogger <NSObject>
- (void)vungleSDKLog:(NSString*)message;
@end
```

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

```obj-c
@protocol VungleSDKDelegate <NSObject>
/**
 * if implemented, this will get called when the SDK is about to show an ad. This point
 * might be a good time to pause your game, and turn off any sound you might be playing.
 */
- (void)vungleSDKwillShowAd;
   
/**
 * if implemented, this will get called when the SDK closes the ad view, but there might be
 * a product sheet that will be presented. This point might be a good place to resume your game
 * if there's no product sheet being presented. The viewInfo dictionary will contain the
 * following keys:
 * - "completed": NSNumber representing a BOOL whether or not the video can be considered a
 *                full view.
 * - "playTime": NSNumber representing the time in seconds that the user watched the video.
 * - "didDownlaod": NSNumber representing a BOOL whether or not the user clicked the download
 *                  button.
 */
- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary*)viewInfo willPrensetProductSheet:(BOOL)willPresentProductSheet;

/**
 * if implemented, this will get called when the product sheet is about to be closed.
 */
- (void)vungleSDKwillCloseProductSheet:(id)productSheet;
@end			   
```
