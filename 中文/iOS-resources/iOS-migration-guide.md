# VungleSDK- iOS 迁移指南

## 在你开始之前...

这个指南会告诉你如何升级我们的SDK到最新版本- version 3.0!

如果你是新加入Vungle的, 你可能想使用[这份指南](https://github.com/Vungle/vungle-resources/blob/master/中文/iOS-resources/iOS-dev-guide.md).

### 以下是很重要的贴士:

* **这是一个全新的SDK!** 当你阅读这份指南的时候, 你需要检查 **全部** Vungle有关的程序码. 我们的方法的名称改变了, 但是功能上大致相同. 

* 我们新的SDK有范例app, 可以参考 [这里](https://github.com/Vungle/vungle-resources/tree/master/iOS-docs/iOS-sample-app). 这个 Github 版本没有加入我们的 SDK, 你可以从源码中添加.

* 如果你用以下的开发平台, 可以检查更新: **Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**, 和 **Marmalade**. 看[这里](https://v.vungle.com/dev/plugins)

我们开始升级之旅吧!

## 1. 把旧的SDK移除

从你的目标文件夹还有Xcode的框架表中移除 vunglepub.embeddedframework 。

之后，去 [这里](https://v.vungle.com/dev/ios) 下载并解压缩新的SDK.

## 2. 框架

### 加入我们的框架

在新的下载的SDK中, 拷贝 *VungleSDK.embeddedframework/* 到目标文件夹中，之后拖到XCode当中 (*Frameworks*) 和你的项目建立连接.

注意-  .embeddedframework 文件夹应该以一个组添加 (黄色文件夹) 而不是一个参考 (蓝色文件夹).

### 加入其他文件夹

新的SDK需要添加一些别的框架, 所以点击你的项目并选择:

*General > Linked Frameworks and Libraries*

如果不存在以下的文件夹请添加:

* libsqlite3.dylib

完成以上动作请检查下在框架(framework)下有没有VungleSDK的框架，假如之前的拖拽没有产生自动连结，请点击'+'然后'添加其他'进行手动连结。
'.

## 3. 初始化SDK

定位在你之前初始化SDK的地方并替换成下面的程序码:

### AppDelegate.h:

`#import <VungleSDK/VungleSDK.h>`

### AppDelegate.m/didFinishLaunchingWithOptions:

```objc
NSString* appID = @"Your AppID Here";
VungleSDK* sdk = [VungleSDK sharedSDK];
// 初始化Vungle SDK
[sdk startWithAppId:appID];
```

## 4. 播放广告!

快完成了！这里请注意，确认你在标准库头文件中的调用库是正确的. 

之后, 在播放广告的位置替换如下:

```objc
VungleSDK* sdk = [VungleSDK sharedSDK];
[sdk playAd:self];
```

### 想改变广告的默认设置?

* **Options object:** 要改变广告的静音设置, 方位, 还有其他客制化选项, 你可能要传入一个字典. 请看范例程序 [第70行](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-sample-app/Vungle%20Sample%20App/FirstViewController.m) . 在 [进阶设定](https://github.com/Vungle/vungle-resources/blob/master/中文/iOS/iOS-advanced-settings.md)会有详细的介绍.

* **激励性广告** 这个也可以是你字典的一个选项. 没有独立的方法去播放激励性还有非激励性的广告。
  
到这里迁移计划完成了！ 你可以继续浏览其他客制化SDK的方法!


## 进阶化设定

看我们的 [进阶设定](https://github.com/Vungle/vungle-resources/blob/master/中文/iOS/iOS-advanced-settings.md),里面有客制化，程序调试，还有事件回调！
