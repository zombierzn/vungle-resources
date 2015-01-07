# VungleSDK- iOS开发指南

## 在你开始之前

这份指南能帮助你轻易地安装SDK到你的APP，让你开始赚钱。

假如你已经安装了Vungle SDK以前的版本，那你需要看[这份指南](https://github.com/Vungle/vungle-resources/blob/master/%E4%B8%AD%E6%96%87/iOS-resources/iOS-migration-guide.md)。

应用于版本3.0以上。

我们的SDK支持iOS 6及以上。


### 几点重要的建议:

* 假如你从未安装过，请先到我们的系统页面（[仪表板](https://v.vungle.com/dashboard/login)）把你的app加到你的帐户。使用我们的SDK需要一个App ID, 你可以通过在我们的系统注册得到一个App (在你的App页面显示为**红色**)

* 假如你想直接跳到范例app中，请参考[这个链接](https://github.com/Vungle/publisher-sample-ios/tree/master).

* 假如你正在使用第三方插件（**Adobe Air**, **Unity-iOS**, **Corona**）。请参考[这个链接](https://v.vungle.com/dev/plugins).
* 因为中国区的网速问题，建议在video成功缓存之后再显示播放按钮（检查广告有没有成功缓存，方法是isCachedAdAvailable）。具体设置请看[这份指南](https://github.com/Vungle/vungle-resources/blob/master/%E4%B8%AD%E6%96%87/iOS-resources/iOS-advanced-settings.md)。

除此之外，请读以下内容。

## 1. 下载SDK

请到[这个链接](https://v.vungle.com/dev/ios)下载SDK，下载完后解压缩。

## 2. 把VungleSDK加到你的项目中

### 加入我们的框架

我们的SDK是一种框架(Framework)模式发布的，所以请先将*VungleSDK.embeddedframework/*复制到你的项目地址中，之后把他们拖拽到Xcode(*Frameworks*) 打开，让它能连到你的项目中。

注意：当添加.embeddedframework资料夹时，请添加资料夹内全部内容（不仅是VungleSDK.framework）,添加成功之后显示为一个群组（图标为黄色）， 不是参考(reference)(图标为蓝色)

### 加入其他需要的框架

Vungle SDK需要以下的几种框架连结到项目，所以点击你的项目之后跳转到：

*General > Linked Frameworks and Libraries*

请将以下未连结的框架添加你的项目中：

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

完成以上动作请检查下在框架(framework)下有没有VungleSDK的框架，假如之前的拖拽没有产生自动连结，请点击'+'然后'添加其他'进行手动连结。

## 3. 移除iOS状态条

我们建议移除在播放我们广告的同时移除iOS状态条出于以下两点原因。第一点，这会让使用者更容易关闭我们的广告体验。第二点，这样看起来好很多！要关闭iOS状态条，打开你的Info.pList然后加入*"View controller-based status bar appearance"* 然后设置为*"No"*。

## 4. 初始化SDK

我们强烈建议你在运行App的初期就初始我们的SDK ，因为我们需要播放前提前缓存我们的广告到app里面，所以请在相应位置加入以下代码：

### AppDelegate.h:

`#import <VungleSDK/VungleSDK.h>`

### AppDelegate.m/didFinishLaunchingWithOptions:

```objc
NSString* appID = @"Your AppID Here";
VungleSDK* sdk = [VungleSDK sharedSDK];
// 初始化vungleSDK
[sdk startWithAppId:appID];
```

## 5. 播放广告！

我们还有最后一步，就是在播video的时候添加一个提示！请记得在每一个头文件都import我们的SDK，并且在源文件中加入以下代码：

```objc
VungleSDK* sdk = [VungleSDK sharedSDK];
[sdk playAd:self];
```

注意作为测试的广告，除非你的app在app商店上线，你还没有办法下载那些播放广告的app。

基本步骤就完成了！你可以再继续看我们的进阶设定来定制服务，或者你也可以直接发布你的App开始赚钱！


## 进阶设定

查看我们的[进阶设定](https://github.com/Vungle/vungle-resources/blob/master/%E4%B8%AD%E6%96%87/iOS-resources/iOS-advanced-settings.md)，里面有广告定制、程序调试、事件回调。


