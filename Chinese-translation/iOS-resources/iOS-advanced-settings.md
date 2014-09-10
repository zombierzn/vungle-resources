# Vungle SDK- iOS 進階設定

## 請注意:

這份參考文件包含更多有關Vungle廣告的進階還有定製服務。假如你才剛開始學習，請先參考[這份指南](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-dev-guide.md)。

能應用在版本3.0以上。

## playAd 選項

想要改變廣告體驗的預設行為的話，你可以設定自己的dictionary傳入playAd中。辭典裡面每一個選值可以任意選擇是否改變，假如不改變會默認預設值。你每次撥放廣告前都需要傳入辭典到playAd中，不然的話系統會使用預設值。你可以在樣本app的[第70行](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-sample-app/Vungle%20Sample%20App/FirstViewController.m)找到一個辭典選項的例子。



* 如果你在更新3.0.8之前的版本，請注意下面這些選值是定值.

| Key          | 初始值/類型 | 描述 | 
| :----------- | :------------------- |:----------- |
| `VunglePlayAdOptionKeyIncentivized` | `NO` <br> NSNumber 代表一個布爾代數值 | 你可以選擇是否收到用戶有沒有看完廣告的提示。一個典型的案例是當你提提供一些獎勵給用戶的時候（比如：看完這個影片你可以得到100顆寶石）。假如你希望以此來激勵用戶，我們會將用戶ID的訊息及時傳送到你的伺服器。YES 代表啟用該選項。 |
| `VunglePlayAdOptionKeyShowClose` | `NO` <br> NSNumber 代表一個布爾代數值 | 決定是否讓用戶在播放途中選擇跳出這個影片。YES 代表啟用能關閉視窗的按鈕。注意在儀錶盤(dashboard)裡可以選擇覆蓋這個選項，(移除關閉按鈕會對你在我們平台的表現大有幫助)。 |
| `VunglePlayAdOptionKeyOrientations` | `UIInterfaceOrientationMaskAll` <br>  NSNumber 代表包括方向的位元屏蔽 | 設定廣告的播放方向。| 
| `VunglePlayAdOptionKeyUser` | `nil` <br> NSString 用來在獎勵用戶的時候識別用戶| 主要用戶（key user）的數值在S2S call中被傳遞（任選項） | 
| `VunglePlayAdOptionKeyPlacement` | `nil` <br> NSString 會在之後上線的報告功能中用到 | 你可能會想知道哪個廣告在用戶端播放，比如說，“level2”。| 
| `VunglePlayAdOptionKeyExtraInfoDictionary` | `nil` <br> NSDictionary 可以有更多的選項來保存在辭典中（定義如下一條所示） | 你可以通過這個來記錄用戶不同的測度，比如年齡，性別，等等。| 
| `VunglePlayAdOptionKeyExtra1..8` | `nil` <br> NSString 代表你追蹤的不同的用戶測度 | 我們內置了8個鍵可以保存用戶信息，比如： `VunglePlayAdOptionKeyExtra1`, `VunglePlayAdOptionKeyExtra2`, 以此類推。 | 


## SDK 實例

### 實例性質

* `muted` (`BOOL`): 廣告靜音選項
* `incentivizedAlertText` (`NSString`): 當使用者嘗試跳過一個有獎勵機制的廣告時，設定提示信息。
* `delegate` (`id<VungleSDKDelegate>`): 任何實施Vungle委派協議的對象。
* `assetLoader` (`id<VungleAssetLoader>`): 主要用於第三方插件（corona, adobe），你也可以在自己的項目中調用它。但是使用時需要遵守Vungle視頻控制器的協定，提供所需要的信息（如下所示）。

### assetLoader 協定

```obj-c
@protocol VungleAssetLoader<NSObject>
/**
 * 此處回傳有效的包含圖像的(原始)資料的路徑（數值格式為NSData） 或 nil。
 */
- (NSData*)vungleLoadAsset:(NSString*)path;
   
/**
 * 此處回傳有效路徑的 UIImage 或 nil.
 */
- (UIImage*)vungleLoadImage:(NSString*)path;
@end
```

### 實例方法 (用於程序調試)

* `- (BOOL)isCachedAdAvailable;`
  返回值為 `YES`表示有一個緩存的影片可以播放。即使發行者允許流式傳遞，此設定也不會檢查是否有廣告進行流式傳遞;
* `- (NSDictionary*)debugInfo;`
  返回值為 NSDictionary 包括程序調試的信息（包含緩存狀態還有其他一些有用的資訊）;
* `- (void)setLoggingEnabled:(BOOL)enable;`
  是否保存運行記錄，預設值為不能;
* `- (void)log:(NSString*)message, ... NS_FORMAT_FUNCTION(1,2);`
  記錄每一條新的信息，跟 `NSLog` 有一樣的格式;
* `- (void)attachLogger:(id<VungleSDKLogger>)logger`
  A附加一個登記器，能用`Log`記錄所有發送到內部或外部的記錄。開發者可以決定是否拆開登記器（登記器內部）。
* `- (void)detachLogger:(id<VungleSDKLogger>)logger;`
  將登記器拆除。

* `NSString* VungleSDKVersion`
  這個不是實例的方法，是一個表示現在所使用Vungle SDK版本的定值。你可以用這個定值來調試程序。

### SDKLogger Protocol

```obj-c
@protocol VungleSDKLogger <NSObject>
- (void)vungleSDKLog:(NSString*)message;
@end
```

## 偵聽器（Delegate）

### 偵聽器方法說明（Delegate Methods）

你可以在程序中實施VungleSDK 偵聽功能，可以及時收到關於廣告體驗相關事件發生的通知。 

| 方法       | 描述 | 
| :----------- | :---------- |
| `(void)vungleSDKhasCachedAdAvailable` | (在3.0.7以後的版本可用) 在廣告緩存完成，可以播放的時候回叫。 |
| `(void)vungleSDKwillShowAd` | 當SDK要播放廣告時會回叫。可以在此設定遊戲暫停、禁聲。 |
| `(void)vungleSDKwillCloseAdWithViewInfo: willPresentProductSheet:` | 在廣告完成播放的時候，有兩個方法能退出我們的廣告，直接關閉廣告或者下載新應用。下載應用時，我們能利用iOS提供的程式在app中打開app商店 （在此使用StoreKit框架）。 <br> 以上兩種情況下，這個回傳都會被激發，同時播放控制器（ViewController）會關閉。有一個布林值會提示你產品介紹單（Product Sheet）會不會出現。假如值是0,用戶會返回使用 app的界面。假如值是1，你需要等到下一個回傳事件發生。 <br> 同時有一個viewInfo的辭典（dictionary)可以被回傳, 裡面包括用戶廣告體驗的相關信息。開發者可能需要這些信息來獎勵用戶。 |
| `(void)vungleSDKwillCloseProductSheet:` | 最後這個回傳發生在用戶選擇下載程序跳轉到app商店，然後要退出下載app頁面的時候。此時你可能需要恢復用戶使用app的頁面。 |

### 偵聽器協議（Delegate Protocol）

```obj-c
@protocol VungleSDKDelegate <NSObject>
/**
 * 實施之後,當廣告被緩存之後調用. 現在可以播放廣告了！
 */
- (void)vungleSDKhasCachedAdAvailable;
/**
 * 實施之後, 當SDK要播廣告時被調用. 可以在此設定遊戲暫停還有禁聲。
 */
- (void)vungleSDKwillShowAd;
   
/**
 * 實施之後, 當SDK 關廣告時被調用, 但這並不表示廣告體驗已經完成，可能會跳轉到產品介紹（Product Sheet）。
 * 如果廣告之後不會跳轉到產品介紹（Product Sheet)，可以在這裡回到你的app。
 * 如果有產品介紹(Product Sheet)，我們建議你在等它關閉之後再回到app。
 * 向用戶確認獎勵信息，比如：在viewInfo辭典中會包含以下值：
 * - "completedView": NSNumber 一個布林值，代表video有沒有完整播放。
 * - "playTime": NSNumber 記錄用戶收看的秒數。
 * - "didDownlaod": NSNumber 一個布林值，表示用戶有沒有按”下載” 鍵。
 */
- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary*)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet;

/**
 * 實施之後, 在產品說明（Product Sheet） 被關閉時調用 
 * 只有在產品說明（Product Sheet） 顯示的情況下可能被調用
 */
- (void)vungleSDKwillCloseProductSheet:(id)productSheet;
@end			   
```

### 註冊偵聽器（Delegate）

你需要在你使用偵聽器的時候顯示聲明Vungle SDK，在你要應用偵聽器的類加入以下代碼：

```obj-c
[[VungleSDK sharedSDK] setDelegate:self];
```

注意：在移除偵聽器之前，請在VungleSDK取消註冊 。因為Vungle SDK會保留偵聽器的信息，所以Vungle會一直向偵聽器發佈信息，這會造成內存洩露。

你也可以在任何時間取消該偵聽器，取消之後你將不會收到任何SDK發佈的信息 。

```obj-c
[[VungleSDK sharedSDK] setDelegate:nil];
```
