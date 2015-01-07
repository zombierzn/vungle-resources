# VungleSDK - Android 开发指南

这份指南能帮助你轻易地安装SDK到你的APP，让你开始赚钱。

### 要求

* Android 2.3 (Gingerbread - API version 9) 或是之后的版本
* 假如你的程式是用C/C++写的，你会需要JNI作为Publisher SDK(Java)的接口

### 几点重要的建议:

* 假如你从未安装过，请先到我们的系统页面（[仪表板](https://v.vungle.com/dashboard/login) ）把你的app加到你的帐户。使用我们的SDK需要一个App ID, 你可以通过在我们的系统注册得到一个App (在你的App页面显示为**红色**)。

* 假如你想直接跳到范例app中，请参考[这个链接](https://github.com/Vungle/publisher-sample-android)。

* 假如你正在使用以下第三方插件（**Adobe Air**, **Unity-iOS**, **Unity-Android**, **Corona**),请参考[这个链接](https:/ /v.vungle.com/dev/plugins)。

除此之外，请读以下内容。

## 1. 下载SDK

请到 [这个链接](https://v.vungle.com/dev/android) 下载SDK，下载完后解压缩。

## 2. 把VungleSDK加到你的项目中

复制解压缩`/libs`目录下所有的库拷贝到你的`/libs`下。假如没有`/libs`文件夹，请新建一个。这个会自动把库加到项目的构建路径。

应该包含以下库:
* `javax.inject-[version].jar`
* `support-v4-[version].jar`
* `vungle-publisher-[version].jar`

假如你的项目已经包含以上同样版本的库，你不需要再次添加他们。如果你用的版本不同，请测试哪个版本和你的app兼容。


## 3.  更新`AndroidManifest.xml` ＆ 添加Google Play服务

1) 加入以下程式码：

```xml
<manifest>

...

<!-- 允许下载和缓存视频广告  -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<application>

    ...

    <!--
    需要添加的活动以便Vungle广告视频顺利播放
    -->
    <activity
        android:name="com.vungle.publisher.FullScreenAdActivity"
        android:configChanges="keyboardHidden|orientation|screenSize"
        android:theme="@android:style/Theme.NoTitleBar.Fullscreen"/>


    <service android:name="com.vungle.publisher.VungleService"
        android:exported="false"/>

    <meta-data android:name="com.google.android.gms.version"
        android:value="@integer/google_play_services_version" />

</application>

</manifest>
```

2) 将Google Play服务添加到你的项目中（建议使用版本4.0.30）。在这个SDK版本当中，我们支持Google Play :

http://developer.android.com/google/play-services/setup.html#Setup

3) 在你的app中，确认你的用户端有更新的Google Play服务：

http://developer.android.com/google/play-services/setup.html#ensure

[Vungle's Google Play Services FAQs](http://www.vungle.com/google-advertising-id-faqs/)

## 4. 初始化及整合 SDK

### 应用起步

在你应用的第一个活动（`Activity`）初始化Publisher SDK。以此让SDK开始视频缓存及准备播放广告。

```java
import com.vungle.publisher.VunglePub;

public class FirstActivity extends android.app.Activity {

    //  得到 VunglePub的实例
    final VunglePub vunglePub = VunglePub.getInstance();

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // 在仪表盘添加并设定好app后，将App ID添加到下面
        final String app_id = "your Vungle App ID";

        // 初始化 Publisher SDK
        vunglePub.init(this, app_id);
    }
}
```

### 每个活动（Activity）

除此之外，请在每一个`Activity`(包括第一个)都覆盖`onPause` 和`onResume`方法以便在你的应用得到或失去焦点时可以及时通知Publisher SDK。

```java
import com.vungle.publisher.VunglePub;

public class EachActivity extends android.app.Activity {

    //得到 VunglePub 实例
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

## 5. 播放广告!

### 默认设置

快完成了！只要调用`playAd`就能在你的应用中拨放广告啦。
```java
import com.vungle.publisher.VunglePub;

public class GameActivity extends android.app.Activity {

    // get the VunglePub instance
    final VunglePub vunglePub = VunglePub.getInstance();

    ...

    private void onLevelComplete() {
        vunglePub.playAd();
    }
}
```

**小贴士-** 假如你在播放之前想确认缓存的广告是否可用，请调用: `vunglePub.isCachedAdAvailable();`
```java
// 假如你在播放之前想确认缓存的广告是否可用 （但是忽略频率上限）
vunglePub.isCachedAdAvailable()
```

基本步骤就完成了！你可以再继续看我们的进阶设定来定制服务，或者你也可以直接发布你的App开始赚钱！
<a name="advancedStartupConfig"></a>

## 进阶设定

查看我们的[进阶设定](https://github.com/Vungle/vungle-resources/blob/master/%E4%B8%AD%E6%96%87/Android-resources/3.1.x/android-advanced-settings.md)，里面有广告定制、程序调试、事件回叫。
