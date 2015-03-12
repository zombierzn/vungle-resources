##Upgrading Android SDK from 3.2.2 to 3.3.0

The Vungle SDK 3.3.0 for Android introduces new features such as support for multiple EventListeners and the ability to integrate the SDK without Google Play Services (if desired). A breakdown of all the new features are detailed in the [change log](https://github.com/Vungle/vungle-resources/blob/master/English/Android/README.md#changelog). This document will describe the necessary changes when upgrading.

###Updating AndroidManifest.xml & Google Play Services
Unlike previous versions, Google Play Services is not required in this release. However, including Google Play Services with your project will allow Vungle to provide a more customized ad experience to the end-user. This therefore reduces the changes needed to be made to the Manifest.xml file to the following:
```xml
<manifest>

  ...
  
  <!-- permissions to download and cache video ads for playback -->
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
  
  <application>
  
    ...
    
    <!--
      Required Activity for playback of Vungle video ads
    -->
    <activity
      android:name="com.vungle.publisher.FullScreenAdActivity"
      android:configChanges="keyboardHidden|orientation|screenSize"
      android:theme="@android:style/Theme.NoTitleBar.Fullscreen"/>
    
  </application>
  
</manifest>
```
###Support for Multiple EventListeners 

The publisher SDK now has the ability to support multiple EventListeners. To reflect this change the method has been changed from setEventListener() to setEventListeners(). Furthermore, the following methods have been added:

<table style="height: 60px; margin-left: auto; margin-right: auto;" width="516">
<tbody>
<tr>
<td class="wysiwyg-text-align-center"><strong>Method</strong></td>
<td class="wysiwyg-text-align-center"><strong>Description</strong></td>
</tr>
<tr>
<td class="wysiwyg-text-align-center">&nbsp;addEventListeners()</td>
<td class="wysiwyg-text-align-left">Clears registered EventListeners and then adds the input eventListeners.&nbsp;</td>
</tr>
<tr>
<td class="wysiwyg-text-align-center">&nbsp;clearEventListeners()</td>
<td class="wysiwyg-text-align-left">Clears EventListeners</td>
</tr>
<tr>
<td class="wysiwyg-text-align-center">&nbsp;removeEventListeners()</td>
<td class="wysiwyg-text-align-left">Removes the input EventListeners.</td>
</tr>
</tbody>
</table>
###Renamed Methods
The following is a list of methods who have been renamed.
<table style="height: 45px;" width="521">
<tbody>
<tr>
<td class="wysiwyg-text-align-center"><strong>Old</strong></td>
<td class="wysiwyg-text-align-center"><strong>New</strong></td>
</tr>
<tr>
<td class="wysiwyg-text-align-center">setEventListener()</td>
<td class="wysiwyg-text-align-center">setEventListeners()</td>
</tr>
<tr>
<td class="wysiwyg-text-align-center">isCachedAdAvailable()</td>
<td class="wysiwyg-text-align-center">isAdPlayable()</td>
</tr>
<tr>
<td class="wysiwyg-text-align-center">EventListener.onCachedAdAvailable()</td>
<td class="wysiwyg-text-align-center">EventListener.onAdPlayableChanged()</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>


### Proguard

If you are using Proguard,  the following lines need to be added to the proguard file:

`-keepattributes Signature`

`-keep class dagger.* `

All lines required to use Proguard with the Vungle Android SDK are now :

`-keep class com.vungle.** { public *; }`

`-keep class javax.inject.*`

`-keepattributes *Annotation*`

`-keepattributes Signature`

`-keep class dagger.*`

### Java

To suppport the latest versions of Android, our SDK now requires JDK 7 to be installed on the development system