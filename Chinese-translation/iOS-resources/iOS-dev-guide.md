# VungleSDK- iOS開發指南

## 在你開始之前。。。

這份指南能幫助你輕易地安裝SDK到你的APP，讓你開始賺錢。

假如你已經安裝了Vungle SDK以前的版本，那你需要看[這份指南](https://github.com/Vungle/vungle-resources/blob/master/Chinese-translation/iOS-resources/iOS-migration-guide.md)。

應用于版本3.0以上。


### 幾點重要的建議:

* 假如你從未安裝過，請先到我們的系統頁面（[儀表板](https://v.vungle.com/dashboard/login)）把你的app加到你的帳戶。使用我們的SDK需要一個App ID, 你可以通過在我們的系統註冊得到一個App (在你的App頁面顯示為**紅色**)

* 假如你想直接跳到範例app中，請參考 [這個鏈接](https://github.com/Vungle/vungle-resources/tree/master/iOS-resources/iOS-sample-app). 

* •	假如你正在使用以下的開發平台，請參考我們的第三方插件（**Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**和**Marmalade**）。**注意：我們的合作夥伴正在更新這些插件，我們會在他們完成之後將鏈接更新**。

除此之外，請讀以下內容。

## 1. 下載SDK

請到[這](https://v.vungle.com/dev/ios)下載SDK，下載完後解壓縮。  

## 2. 把VungleSDK加到你的项目中

### 加入我們的框架

我們的SDK是一種框架(Framework)模式發佈的，所以請先將*VungleSDK.embeddedframework/*複製到你的项目地址中，之後把他們拖拽到Xcode(*Frameworks*) 打开，讓它能連到你的项目中。

注意：當添加.embeddedframework資料夾時，请添加资料夹内全部内容（不仅是VungleSDK.framework）,添加成功之后显示为一個群組（图标為黃色）， 不是參考(reference)(图标为蓝色)

### 加入其他需要的框架

Vungle SDK需要以下的幾種框架連結到項目，所以點擊你的項目之後跳轉到：

*General > Linked Frameworks and Libraries*

请将以下未連結的框架添加你的项目中：

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

完成以上動作請檢查下在框架(framework)下有沒有VungleSDK，假如之前的拖拽沒有產生自動連結，請點擊’+’然後’Add Other’進行手動連結。

## 3. 移除iOS狀態條

我們建議移除在播放我們廣告的同時移除iOS狀態條出於以下兩點原因。第一點，這會讓使用者更容易關閉我們的廣告體驗。第二點，這樣比較好看。要關閉iOS狀態條，打開你的Info.pList然後加入 *"View controller-based status bar appearance"* 然後設置為 *"No"*。

## 4. 初始化SDK

我們強烈建議你在運行App的初期就初始我們的SDK ，因為我們需要播放前提前緩存我們的廣告到app裡面，所以請在相應位置加入以下代碼：

### AppDelegate.h:

`#import <VungleSDK/VungleSDK.h>`

### AppDelegate.m/didFinishLaunchingWithOptions:

```objc
NSString* appID = @"Your AppID Here";
VungleSDK* sdk = [VungleSDK sharedSDK];
// start vungle publisher library
[sdk startWithAppId:appID];
```

## 5. 播放廣告！

我們還有最後一步，就是在播video的時候添加一個提示！請記得在每一個頭文件都import我們的SDK，並且在源文件中加入以下代碼：

```objc
VungleSDK* sdk = [VungleSDK sharedSDK];
[sdk playAd:self];
```

基本步驟就完成了！你可以再繼續看我們的進階設定來定製服務，或者你也可以直接發佈你的App開始賺錢！


## 進階設定

查看我們的[進階設定](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-advanced-settings.md)，裡面有廣告定製、程序調試、事件回調。


