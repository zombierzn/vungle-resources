## Android 资源

根据SDK的不同版本选择不同的文件夹, 可以帮你整合并且播放广告. 一旦你完成之后, 我们的高级设定会帮你客制化你的应用.

你可以在这边看我们的范例app [这里](https://github.com/Vungle/publisher-sample-android). 可以看程序或者实际操作一下!

## 更新版本

### VERSION 3.2.2

* 新的 'adaptiveId' 会用 [Android Advertising ID](https://developer.android.com/google/play-services/id.html) 做移动归因, 如果失败的话就会用 [Android ID](http://developer.android.com/reference/android/provider/Settings.Secure.html#ANDROID_ID) 和 wifi MAC address (if available)
* 支持非Google Play Services的环境 (e.g. Kindle 设备)
* 修补了关于 `EventListener.onAdEnd()` 提醒的bug

### VERSION 3.2.1

* 修补了给Vungle服务器提交请求时 `User-Agent`的信息
* 用浏览器向non-Vungle服务器提交申请时 `User-Agent`的信息
* 多次点击的时候防止视频退出按钮
* 修补在 `singleTask` `Activity` 启动模式下广告不播放的bug

### VERSION 3.2.0 

* 加入服务器决定播放广告的次序
* 加入 `AdConfig.setImmersiveMode()` 增加 KitKat+设备中 immersive 模式 (default is `false`, which is a change from versions 3.1.1 and prior)
* 再回传中加入 `EventListener.onAdEnd(boolean wasCallToActionClicked)` 来判定用户是否点击下载按钮
* 修改 `VunglePub.init()` 来返回一个布林值，由此判定是否初始化成功`void`
* 在某些特定情况下加入遗失的 `EventListener.onAdUnavailable()` 
* 独立的未绑定的库, 要加入以下jar file: `dagger-[version].jar` and `nineoldandroids-[version].jar`
* 加入 Javadoc 给 `AdConfig`

### VERSION 3.1.1

* 在应用中加入 geolocation 对`ACCESS_COARSE_LOCATION` 和 `ACCESS_FINE_LOCATION` 的支持
* 修补重启应用广告才播放的漏洞
* 修改在反馈流媒体广告的漏洞
* fixed bug where some ad progress messages were not being sent
* fixed bug where the ad report of the currently playing ad could be deleted
* reduced delay between `VunglePub.init()` and initial ad request from 3 seconds to 2 seconds
* delete old version 1.x.x cache directory if it exists
* hid some debug logging messages that were being shown in production mode 

### VERSION 3.1.0 

* added support for [Android Advertising ID](https://developer.android.com/google/play-services/id.html)
* removed references to `android.provider.Settings.Secure.ANDROID_ID`
* added `AdConfig.setPlacement()` for tracking ad performance by placement location
* added `AdConfig.setExtra1-8()` for passing developer-defined key-value pairs
* added 3 second delay between `VunglePub.init()` and initial ad request to allow for global `AdConfig` configuration
* removed deprecated methods `AdConfig.setShowClose()` and `AdConfig.isShowClose()` (please confugre these from the [Vungle Dashboard](https://v.vungle.com))
* fixed `Activity` and `Fragment` recreation if they are destroyed while in the background
* fixed sound bug with ads starting muted
* fixed bugs affecting session length calculation 
* added `logcat` warning messages for missing `AndroidManifest.xml` permissions and config
