# VungleSDK- Android进阶设定

## 请注意

这份参考文件包含更多有关Vungle广告的进阶设定。假如你才刚开始学习，请先参考[这份指南](https://github.com/Vungle/vungle-resources/blob/master/中文/Android/3.1.x/android-dev-guide.md。
                                               
## 进阶设定 

### 初始设置
                                               
在调用`init`后，你可以自由选择使用全局对象`AdConfig`。这个对象允许你设定一些可以控制全部广告的选项。
                                               
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

        //  得到全局對象 AdConfig 
    final AdConfig globalAdConfig = vunglePub.getGlobalAdConfig();

    // 设定你想要的设置
    // 请参考'设置选项'的部份，里面有全部可用选项的说明。
      globalAdConfig.setSoundEnabled(true);
      globalAdConfig.setOrientation(Orientation.portrait);

  }
}
```

### playAd 设置 

通过传递`AdConfig`对象给`playAd`，你可以选择性地客制任意一个你播放的广告。假如你改变一个全局对象的设置（如下），你原有的设定都会被覆盖。
```java
import com.vungle.publisher.VunglePub;
import com.vungle.publisher.AdConfig;

public class GameActivity extends android.app.Activity {
  ...
  
  private void onLevelComplete() {
  	  //创造一个新的 AdConfig 对象
  	  final AdConfig overrideConfig = new AdConfig();

    // 设定你想要的设置
    // 请参考'设置选项'的部份，里面有全部可用选项的说明
  	  overrideConfig.setIncentivized(true);
  	  overrideConfig.setSoundEnabled(false);

    // 这个overrideConfig对象只会影响当前广告播放
    // 为了统一全局设置，请参考初始设置章节。
      vunglePub.playAd(overrideConfig);
  }
}
```

### 设置选项

#### `AdConfig` 对象

一个全局对象`AdConfig` 控制所有广告播放的相关设定，但你可以选择性地覆盖一些实例来改变单个广告播放的设定。以下是`AdConfig`中可改变的设定:

| 方法 | 预设值 | 描述 |
|:------ |:------- |:----------- |
| `setOrientation` | `Orientation.matchVideo` | `Orientation.autoRotate` 广告的播放方向会随着播放设施的方向改变而改变。 `Orientation.matchVideo` 广告的播放方向取决于视频本身最佳的播放方向（一般为横向）。 |
| `setSoundEnabled` | `true` | 设定广告开始音效。假如值是`true`，音效会依据播放设施的状态播放；假如值是`false`，影像一开​​始会静音，但是使用者可以自己更改静音状态。 |
| `setBackButtonImmediatelyEnabled` | `false` | 假如值为`true`，使用者可以通过后退按钮退出广告；假如值为`false`,使​​用者不能后退只能等广告播完退出广告。 |
| `setImmersiveMode` | `false` | 可以启用或者停用KitKat+装置上的[immersive mode](https://developer.android.com/training/system-ui/immersive.html) |
| `setIncentivized` | `false` | 设置奖励机制：假如你要使用服务器回叫来给使用者奖励，你要设置这个`true`。假如值为`true`，当使用者想要跳过这个广告时，会有一个确认视窗提示。假如值为`false`，确认视窗不会出现。 |
| `setIncentivizedUserId` | none | 设定一个特殊的用户ID在回叫时确认用户是否​​有观看广告从而得到奖励。如果广告没有设置为奖励此处值为`N/A`。 |
| `setIncentivizedCancelDialogTitle` | "跳过广告?" | 当用户选择跳过观看奖励广告时，在此处设定确认视窗的标题。如果广告没有设置为奖励此处值为`N/A`。 |
| `setIncentivizedCancelDialogBodyText` | "跳过广告将无法得到奖励，确定退出？" | 此处设定确认视窗的内容。如果广告没有设置为奖励此处值为`N/A`。 |
| `setIncentivizedCancelDialogCloseButtonText` | "关闭广告" | 确认视窗设定按钮“关闭”显示的文字。如果广告没有设置为奖励此处值为`N/A`。 |
| `setIncentivizedCancelDialogKeepWatchingButtonText` | "继续观看" | 确认视窗设定按钮“继续观看”显示的文字。如果广告没有设置为奖励此处值为`N/A`。 |
| `setExtra1..8` | none | 你可以用这个来记录更多特征值，比如年龄，性别等等. |
| `setPlacement` | none | 设置一个可选的广告放置的名字，这个对在控制板上的反馈有帮助. |

##### 展示关闭按钮

为了控制用户是否能再播放广告的时候退出广告, 请在Vungle的控制后台设置强制预览选项 forced view options [Vungle Dashboard](https://v.vungle.com/).

#### `EventListener` 接口
Publisher SDK提供一些让用户可以控制的事件。你可以实施`com.vungle.publisher.EventListener` 然后再登记/移除：

```java
VunglePub.setEventListener(eventListener)
```

##### UI 线程注意事项

注意服务器间的回叫和用户界面（UI）是两条不同的线程，所以如果你想通过服务器回叫来控制用户界面，你需要一个特殊的技术在你的主线程（用户界面）执行你的服务器回叫。以下有两种比较普遍的方法可以实现：

* [Handler](http://developer.android.com/reference/android/os/Handler.html)

* [Activity.runOnUiThread(Runnable)](http://developer.android.com/reference/android/app/Activity.html#runOnUiThread(java.lang.Runnable))

```java
import com.vungle.publisher.EventListener;
...

public class FirstActivity extends android.app.Activity {
...

private final EventListener vungleListener = new EventListener(){

    @Override
    public void onVideoView(boolean isCompletedView, int watchedMillis, int videoDurationMillis) {
        // 当视频完成时回叫。如果超过80％的视频被播放，isCompletedView值为true，会记为一次完整播放。
        // watchedMills 记录用户最长播放（如果用户重放视频）
    }

    @Override
    public void onAdStart() {
        // 在播放广告前会回叫
    }

    @Override
    public void onAdEnd(boolean wasCallToActionClicked) {
        // 当使用者离开这个广告并且回到你的程序中回叫
    }

    @Override
    public void onCachedAdAvailable() {
        // 当广告缓冲好并且可以开始播放时回叫
    }

    @Override
    public void onAdUnavailable() {
        // 当VunglePub.playAd() 被调用但没有可播放广告视频可以提供时回叫
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

如果你使用Proguard, 请确认以下代码加到你proguard的config 文件中：

`-keep class com.vungle.** { public *; }`

`-keep class javax.inject.*`

`-keepattributes *Annotation*`
