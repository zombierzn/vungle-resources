# VungleSDK- Android進階設定

## 請注意

這份參考文件包含更多有關Vungle廣告的進階設定。假如你才剛開始學習，請先參考[這份指南](https://github.com/Vungle/vungle-resources/blob/master/Chinese-translation/Android-resources/android-dev-guide.md)。

能應用在版本3.0以上。

## 進階設置

### 初始設置

在調用`init`後，你可以使用全局對象`AdConfig`。這個對象允許你設定一些可以控制全部廣告的選項。

```java
import com.vungle.publisher.VunglePub;
import com.vungle.publisher.AdConfig;
import com.vungle.publisher.Orientation;

public class FirstActivity extends android.app.Activity {

  ...

  @Override
  public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      
      ...

      vunglePub.init(this, app_id);

      // 得到全局對象 AdConfig 
      final AdConfig globalAdConfig = vunglePub.getGlobalAdConfig();

      // 設定你想要的設置 
      // 請參考'設置選項'的部份，裡面有全部可用選項的說明。
      globalAdConfig.setSoundEnabled(true);
      globalAdConfig.setOrientation(Orientation.portrait);

  }
}
```

### playAd 設置 

通過傳遞`AdConfig`對象給`playAd`，你可以選擇性地客製任意一個廣告。假如你改變一個全局對象的設置，你原有的設定都會被覆蓋。

```java
import com.vungle.publisher.VunglePub;
import com.vungle.publisher.AdConfig;

public class GameActivity extends android.app.Activity {
  ...
  
  private void onLevelComplete() {
  	  // 創造一個新的 AdConfig 對象
  	  final AdConfig overrideConfig = new AdConfig();

  	  // 設定你想要的設置
  	  // 請參考'設置選項'的部份，裡面有全部可用選項的說明
  	  overrideConfig.setIncentivized(true);
  	  overrideConfig.setSoundEnabled(false);

  	  // 這個 overrideConfig對象只會影響當前廣告播放  
  	  // 為了統一全局設置，請參考初始設置章節。
      vunglePub.playAd(overrideConfig);
  }
}
```

### 設置選項

#### `AdConfig` 對象

一個全局對象`AdConfig` 控制所有廣告撥放的相關設定，但你可以選擇性地覆蓋一些實例來改變單個廣告播放的設定。以下是`AdConfig`中可改變的設定:

| 方法 | 預設值 | 描述 |
|:------ |:------- |:----------- |
| `setOrientation` | `Orientation.matchVideo` | `Orientation.autoRotate` 廣告的播放方向會隨著播放設施的方向改變而改變。 `Orientation.matchVideo` 廣告的播放方向取決于視頻本身最佳的播放方向（一般為橫向）。|
| `setSoundEnabled` | `true` | 設定廣告開始音效。假如值是`true`，音效會依據播放設施的狀態播放；假如值是`false`，影像一開始會靜音，但是使用者可以自己更改靜音狀態。|
| `setBackButtonImmediatelyEnabled` | `false` | 假如值為`true`，使用者可以通過後退按鈕退出廣告；假如值為`false`,使用者不能後退只能等廣告播完退出廣告。|
| `setShowClose` | `true` | 啟用或停用廣告視頻上的關閉按鈕。假如值為`false`，關閉按鈕則不會出現。<br> 
＊注意﹣這個方法在版本3.0.2被棄用，在版本 3.1.0被移除。你可以在使用Vungle儀錶板（[Dashboard](https://v.vungle.com/)）進階設定中強制觀看選項來控制。|
| `setImmersiveMode` | `false` | 可以啟用或者停用KitKat+裝置上的 [immersive mode](https://developer.android.com/training/system-ui/immersive.html)  |
| `setIncentivized` | `false` | 設置獎勵機制：假如你要使用服務器回叫來給使用者獎勵，你要設置這個`true`。假如值為`true`，當使用者想要跳過這個廣告時，會有一個確認視窗提示。假如值為`false`，確認視窗不會出現。 |
| `setIncentivizedUserId` | none | 設定一個特殊的用戶ID來傳回你的應用來確認用戶是否有觀看廣告從而得到獎勵。 如果廣告沒有設置為獎勵此處值為`N/A`。  |
| `setIncentivizedCancelDialogTitle` | "跳過廣告?" | 當用戶選擇跳過觀看獎勵廣告時，在此處設定確認視窗的標題。如果廣告沒有設置為獎勵此處值為`N/A`。 |
| `setIncentivizedCancelDialogBodyText` | "跳過廣告將無法得到獎勵，確定退出？" | 此處設定確認視窗的內容。如果廣告沒有設置為獎勵此處值為`N/A`。 | 
| `setIncentivizedCancelDialogCloseButtonText` | "關閉廣告" | 確認視窗設定按鈕“關閉”顯示的文字。如果廣告沒有設置為獎勵此處值為`N/A`。 | 
| `setIncentivizedCancelDialogKeepWatchingButtonText` | "繼續觀看" | 確認視窗設定按鈕“繼續觀看”顯示的文字。如果廣告沒有設置為獎勵此處值為`N/A`。|

#### The `EventListener` 介面
Publisher SDK提供一些讓用戶可以控制的事件。你可以實施`com.vungle.publisher.EventListener` 然後在你的實例中設定`setEventListener` 。

注意服務器間的叫回和用戶界面（UI）是兩條不同的線程，所以如果你想通過服務器叫回來控制用戶界面，你需要一個特殊的技術在你的主線程（用戶界面）執行你的服務器叫回。以下有兩種比較普遍的方法可以實現：


1.[Handler](http://developer.android.com/reference/android/os/Handler.html)

2.[Activity.runOnUiThread(Runnable)](http://developer.android.com/reference/android/app/Activity.html#runOnUiThread(java.lang.Runnable))

```java
import com.vungle.publisher.EventListener;
...

public class FirstActivity extends android.app.Activity {
  ...

  private final EventListener vungleListener = new EventListener(){

    @Override
    public void onVideoView(boolean isCompletedView, int watchedMillis, int videoDurationMillis) {
        // 當視頻完成時回叫。如果超過80％的視頻被播放，isCompletedView值為true，會記為一次完整播放。
        // watchedMills 記錄用戶最長播放（如果用戶重放視頻）
    }

    @Override
    public void onAdStart() {
        // 在播放廣告前會回叫
    }

    @Override
    public void onAdEnd(boolean wasCallToActionClicked) {
        // 當使用者離開這個廣告並且回到你的程序中回叫
    }

    @Override
    public void onCachedAdAvailable() {
        // 當廣告緩衝好並且可以開始播放時回叫
    }
    
    @Override
    public void onAdUnavailable() {
        // 當 VunglePub.playAd() 被調用但沒有可播放廣告視頻可以提供時回叫
    }
    
  };

  @Override
  public void onCreate(Bundle savedInstanceState) {
      ...

      vunglePub.init(this, app_id);
      vunglePub.setEventListener(vungleListener);

  }
}
```
### Proguard

如果你使用Proguard, 請確認以下代碼加到你proguard的config 文件中：

`-keep class com.vungle.** { public *; }`

`-keep class javax.inject.*`

`-keepattributes *Annotation*`
