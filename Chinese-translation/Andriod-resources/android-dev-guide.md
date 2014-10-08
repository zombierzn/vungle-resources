# VungleSDK - Android 開發指南

## 在你開始之前…

這份指南能幫助你輕易地安裝SDK到你的APP，讓你開始賺錢。

假如你已經安裝了Vungle SDK以前的版本，那你需要看[這份指南](https://github.com/Vungle/vungle-resources/blob/master/Chinese-translation/Android-resources/android-migration-guide.md)。

應用于版本3.0以上。

### 系統需求

* Android 2.3 (Gingerbread - API version 9) 或是之後的版本
* 假如你的程式是用C/C++寫的，你會需要JNI作為Publisher SDK(Java)的接口

### 幾點重要的建議：

* 假如你從未安裝過，請先到我們的系統頁面（[儀表板](https://v.vungle.com/dashboard/login) ）把你的app加到你的帳戶。使用我們的SDK需要一個App ID, 你可以通過在我們的系統註冊得到一個App (在你的App頁面顯示為**紅色**)。

* 假如你想直接跳到範例app中，請參考[這個鏈接](https://github.com/Vungle/publisher-sample-android)。

* 假如你正在使用以下第三方插件（**Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**),請參考[這個鏈接](https://v.vungle.com/dev/plugins)。

除此之外，請讀以下內容。

## 1. 下載SDK

請到[這個鏈接](https://v.vungle.com/dev/android)下載SDK，下載完後解壓縮。 

## 2. 把VungleSDK加到你的項目中

複製解壓縮`/libs`目錄下所有的庫拷貝到你的`/libs`下。假如沒有`/libs`文件夾，請新建一個。這個會自動把庫加到項目的構建路徑。

在版本3.2.0 以上，包含以下庫：
* `dagger-[version].jar`
* `javax.inject-[version].jar`
* `nineoldandroids-[version].jar`
* `support-v4-[version].jar`
* `vungle-publisher-[version].jar`

假如你的項目已經包含以上同樣版本的庫，你不需要再次添加他們。如果你用的版本不同，請測試哪個版本和你的app兼容。

## 3. 更新 `AndroidManifest.xml` ＆ 添加Google Play服務

1) 加入以下程式碼：

```xml
<manifest>

  ...
  
  <!-- 允許下載和緩存視頻廣告 -->
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
  
  <application>
  
    ...
    
    <!--
      需要添加的活動以便Vungle廣告視頻順利播放
    -->
    <activity
      android:name="com.vungle.publisher.FullScreenAdActivity"
      android:configChanges="keyboardHidden|orientation|screenSize"
      android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
    />
    
    
    <service android:name="com.vungle.publisher.VungleService"
      android:exported="false"
    />
  
    <meta-data android:name="com.google.android.gms.version"
      android:value="@integer/google_play_services_version" />  


  </application>
  
</manifest>
```


2) 將Google Play服務添加到你的項目中 （建議使用版本4.0.30）：

http://developer.android.com/google/play-services/setup.html#Setup

3) 在你的app中，確認你的設施有更新的Google Play服務：

http://developer.android.com/google/play-services/setup.html#ensure

[Vungle's Google Play Services FAQs](http://www.vungle.com/google-advertising-id-faqs/)

## 4. 初始化及整合 SDK

### 應用起步

在你應用的第一個活動（`Activity`）初始化Publisher SDK。以此讓SDK開始視頻緩存及準備播放廣告。


```java
import com.vungle.publisher.VunglePub;

public class FirstActivity extends android.app.Activity {

  // 得到 VunglePub的實例（instance）
  final VunglePub vunglePub = VunglePub.getInstance();

  @Override
  public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      
      // 在儀錶盤添加并設定好app後，將App ID添加到下面
      final String app_id = "your Vungle App ID";
      
      // 初始化 Publisher SDK
      vunglePub.init(this, app_id);
  }
}
```

### 活動（Activity）

除此之外，請在每一個`Activity`(包括第一個)都覆蓋`onPause` 和 `onResume`方法以便在你的應用得到或失去焦點時可以及時通知Publisher SDK。

```java
import com.vungle.publisher.VunglePub;

public class EachActivity extends android.app.Activity {

  // 得到 VunglePub instance
  final VunglePub vunglePub = VunglePub.getInstance();

  ...
  
  @Override
  protected void onPause() {
      super.onPause();
      vunglePub.onPause();
  }
  
  @Override
  protected void onResume() {
      super.onResume();
      vunglePub.onResume();
  }
}
```

## 5. 播放廣告!

### 默認設置

快完成了！只要調用`playAd`就能在你的應用中撥放廣告啦。
```java
import com.vungle.publisher.VunglePub;

public class GameActivity extends android.app.Activity {

  // 得到 VunglePub 實例
  final VunglePub vunglePub = VunglePub.getInstance();

  ...
  
  private void onLevelComplete() {
      vunglePub.playAd();
  }
}
```

**小貼士-** 假如你想確認緩存的廣告是否可用，請調用 : `vunglePub.isCachedAdAvailable();`

基本步驟就完成了！你可以再繼續看我們的進階設定來定製服務，或者你也可以直接發佈你的App開始賺錢！

<a name="advancedStartupConfig"></a>
## 進階設定

查看我們的[進階設定](https://github.com/Vungle/vungle-resources/blob/master/Chinese-translation/Android-resources/android-advanced-settings.md)，裡面有廣告定製、程序調試、事件回調。

