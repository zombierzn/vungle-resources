# Vungle SDK- iOS 进阶设定

## 请注意:

这份参考文件包含更多有关Vungle广告的进阶还有定制服务。假如你才刚开始学习，请先参考[这份指南](https://github.com/Vungle/vungle-resources/blob/master/中文/iOS/iOS-dev-guide.md)。
能应用在版本3.0以上。

## playAd 选项

想要改变广告体验的预设行为的话，你可以设定自己的dictionary传入playAd中。辞典里面每一个选值可以任意选择是否改变，假如不改变会默认预设值。你每次拨放广告前都需要传入辞典到playAd中，不然的话系统会使用预设值。你可以在样本app的[第70行](https://github.com/Vungle/publisher-sample-ios/blob/master/Vungle%20Sample%20App/FirstViewController.m)找到一个辞典选项的例子。


* 如果你在更新3.0.8之前的版本，请注意下面这些选值是定值.

| Key | 初始值/类型 | 描述 |
| :----------- | :------------------- |:----------- |
| `VunglePlayAdOptionKeyIncentivized` | `NO` <br> NSNumber 代表一个布尔代数值| 你可以选择是否收到用户有没有看完广告的提示。一个典型的案例是当你提提供一些奖励给用户的时候（比如：看完这个影片你可以得到100颗宝石）。假如你希望以此来激励用户，我们会将用户ID的讯息及时传送到你的伺服器。 YES 代表启用该选项。 |
| `VunglePlayAdOptionKeyShowClose` | `NO` <br> NSNumber 代表一个布尔代数值| 决定是否让用户在播放途中选择跳出这个影片。 YES 代表启用能关闭视窗的按钮。注意在仪表盘(dashboard)里可以选择覆盖这个选项，(移除关闭按钮会对你在我们平台的表现大有帮助)。 |
| `VunglePlayAdOptionKeyOrientations` | `UIInterfaceOrientationMaskAll` <br> NSNumber 代表包括方向的位元屏蔽| 设定广告的播放方向。 |
| `VunglePlayAdOptionKeyUser` | `nil` <br> NSString 用来在奖励用户的时候识别用户| 主要用户（key user）的数值在S2S call中被传递（任选项） |
| `VunglePlayAdOptionKeyPlacement` | `nil` <br> NSString 会在之后上线的报告功能中用到| 你可能会想知道哪个广告在用户端播放，比如说，“level2”。 |
| `VunglePlayAdOptionKeyExtraInfoDictionary` | `nil` <br> NSDictionary 可以有更多的选项来保存在辞典中（定义如下一条所示） | 你可以通过这个来记录用户不同的测度，比如年龄，性别，等等。 |
| `VunglePlayAdOptionKeyExtra1..8` | `nil` <br> NSString 代表你追踪的不同的用户测度| 我们内置了8个键可以保存用户信息，比如： `VunglePlayAdOptionKeyExtra1`, `VunglePlayAdOptionKeyExtra2`, 以此类推。 |


## SDK 实例

### 实例性质

* `muted` (`BOOL`): 广告静音选项
* `incentivizedAlertText` (`NSString`): 当使用者尝试跳过一个有奖励机制的广告时，设定提示信息。
* `delegate` (`id<VungleSDKDelegate>`): 任何实施Vungle委派协议的对象。
* `assetLoader` (`id<VungleAssetLoader>`): 主要用于第三方插件（corona, adobe），你也可以在自己的项目中调用它。但是使用时需要遵守Vungle视频控制器的协定，提供所需要的信息（如下所示）。

### assetLoader 协定

```obj-c
@protocol VungleAssetLoader<NSObject>
/**
* 此处回传有效的包含图像的(原始)资料的路径（数值格式为NSData） 或nil。
*/
- (NSData*)vungleLoadAsset:(NSString*)path;

/**
* 此处回传有效路径的 UIImage 或 nil.
*/
- (UIImage*)vungleLoadImage:(NSString*)path;
@end
```
### 实例方法 &程序调试

* `- (BOOL)isCachedAdAvailable;`
返回值为`YES`表示有一个缓存的影片可以播放。即使发行者允许流式传递，此设定也不会检查是否有广告进行流式传递;
* `- (NSDictionary*)debugInfo;`
返回值为NSDictionary 包括程序调试的信息（包含缓存状态还有其他一些有用的资讯）;
* `- (void)setLoggingEnabled:(BOOL)enable;`
是否保存运行记录，预设值为不能;
* `- (void)log:(NSString*)message, ... NS_FORMAT_FUNCTION(1,2);`
记录每一条新的信息，跟`NSLog` 有一样的格式;
* `- (void)attachLogger:(id<VungleSDKLogger>)logger`
A附加一个登记器，能用`Log`记录所有发送到内部或外部的记录。开发者可以决定是否拆开登记器（登记器内部）。
* `- (void)detachLogger:(id<VungleSDKLogger>)logger;`
将登记器拆除。
* `NSString* VungleSDKVersion`
这个不是实例的方法，是一个表示现在所使用Vungle SDK版本的定值。你可以用这个定值来调试程序。

#### 调试睡眠状态

当你的app发送requestAd之后, 我们的服务器可能会发回睡眠. 比较常见的几种是:

| 睡眠时间 | 描述     | 小提示        | 
| :---------- | :---------- |:----------- |
| **59** | 服务器很忙 | 你应该等一段时间重新尝试 |
| **305** | app不可用 / app未知 | 这个表示你现在用的是错误的AppID. 请确认你们使用的是仪表盘红色的AppID的部分. |
| **1800** | 过滤掉所有可用选项 | 这个可能和我们的广告填充有关系, 或者你已经看到每天可以观看视频的上限. 你在调试过程可以把app放到测试的一栏，这样你就不会看到这些限制。 |


### SDKLogger 协议（Protocol)

```obj-c
@protocol VungleSDKLogger <NSObject>
- (void)vungleSDKLog:(NSString*)message;
@end
```

## 侦听器（Delegate）

### 侦听器方法说明（Delegate Methods）

你可以在程序中实施VungleSDK 侦听功能，可以及时收到关于广告体验相关事件发生的通知。

| 方法       | 描述 | 
| :----------- | :---------- |
| `(void)vungleSDKhasCachedAdAvailable` | (在3.0.7以后的版本可用) 在广告缓存完成，可以播放的时候回叫。 |
| `(void)vungleSDKwillShowAd` | 当SDK要播放广告时会回叫。可以在此设定游戏暂停、禁声。 |
| `(void)vungleSDKwillCloseAdWithViewInfo: willPresentProductSheet:` | 在广告完成播放的时候，有两个方法能退出我们的广告，直接关闭广告或者下载新应用。下载应用时，我们能利用iOS提供的程式在app中打开app商店（在此使用StoreKit框架）。 <br> 以上两种情况下，这个回传都会被激发，同时播放控制器（ViewController）会关闭。有一个布林值会提示你产品介绍单（Product Sheet）会不会出现。假如值是0,用户会返回使用app的界面。假如值是1，你需要等到下一个回传事件发生。 <br> 同时有一个viewInfo的辞典（dictionary)可以被回传, 里面包括用户广告体验的相关信息。开发者可能需要这些信息来奖励用户。 |
| `(void)vungleSDKwillCloseProductSheet:` | 最后这个回传发生在用户选择下载程序然后app商店的页面开启，在退出下载app页面的时候。此时你可能需要恢复用户使用app的页面。 |
* 注意- Product Sheet是应用内置的app商店下载页面，当用户点击广告中的下载按钮时会激活，下载的同时不会离开应用页面。

### 侦听器协议（Delegate Protocol）

```obj-c
@protocol VungleSDKDelegate <NSObject>
/**
* 实施之后,当广告被缓存之后调用. 现在可以播放广告了！
*/
- (void)vungleSDKhasCachedAdAvailable;
/**
* 实施之后, 当SDK要播广告时被调用. 可以在此设定游戏暂停还有禁声。
*/
- (void)vungleSDKwillShowAd;

/**
* 实施之后, 当SDK 关广告时被调用, 但这并不表示广告体验已经完成，可能会跳转到产品介绍（Product Sheet）。
* 如果广告之后不会跳转到产品介绍（Product Sheet)，可以在这里回到你的app。
* 如果有产品介绍(Product Sheet)，我们建议你在等它关闭之后再回到app。
* 向用户确认奖励信息，比如：在viewInfo辞典中会包含以下值：
* - "completedView": NSNumber 一个布林值，代表video有没有完整播放。
* - "playTime": NSNumber 记录用户收看的秒数。
* - "didDownlaod": NSNumber 一个布林值，表示用户有没有按”下载” 键。
*/
- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary*)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet;

/**
* 实施之后, 在产品说明（Product Sheet） 被关闭时调用
* 只有在产品说明（Product Sheet） 显示的情况下可能被调用
*/
- (void)vungleSDKwillCloseProductSheet:(id)productSheet;
@end			   
```

### 注册侦听器（Delegate）

你需要在你使用侦听器的时候显示声明Vungle SDK，在你要应用侦听器的类加入以下代码：

```obj-c
[[VungleSDK sharedSDK] setDelegate:self];
```

注意：在移除侦听器之前，请在VungleSDK取消注册。因为Vungle SDK会保留侦听器的信息，所以Vungle会一直向侦听器发布信息，这会引起内存问题。

你也可以在任何时间取消该侦听器，取消之后你将不会收到任何SDK发布的信息。

```obj-c
[[VungleSDK sharedSDK] setDelegate:nil];
```
