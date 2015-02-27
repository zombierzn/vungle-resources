##Advertiser API

###Overview
In order to provide robust reporting and attribution for your advertising campaigns, Vungle needs to track installs of your app. This way, we can make sure your campaigns are performing well, and driving quality traffic and users to your app. The most common way to send Vungle install information is through a 3rd party tracking solution

###Advertiser API
___
***TAKE NOTE*** : *As of August 1, 2014, all apps being uploaded to the Google Play Store should use the Play Services Advertising ID in lieu of any other identifiers, or else risk ejection from the Play Store. See the [Google Play Services Documentation](https://developer.android.com/google/play-services/id.html) for more details.*
___

#####API Version 3
We have the same API end point for both the iOS and Android platforms, but each requires different parameters. The base endpoint is:      
**`http://api.vungle.com/api/v3/new`**  
At a minimum, the request must contain your Vungle App ID, and a device ID of some kind. See below for the list of accepted parameters:
<div class="page-header"></div><table class="table table-striped"> <tr> <th colspan="2" align="left">GET Query Parameters <tr><td>app_id</td><td>The App ID listed in red on your application's page on the Vungle Dashboard. If your app isn't on the Dashboard yet, then be sure to <a href="http://v.vungle.com/dashboard/apps/new" target="_blank">add it.</a></td></tr><tr><td>ifa</td><td>The identifierForAdvertising, a UUID provided by Apple for iOS devices since iOS 6. This is the preferred device identifier for iOS.</td></tr><tr><td>aaid</td><td>The <a href="https://developer.android.com/google/play-services/id.html">Advertising ID</a>, a UUID provided by Google Play Services 4.0+, compatible with Android 2.3+. This is the preferred device identifier for Android.</td></tr><tr><td>isu</td><td>A parameter for when preferred device identifiers cannot be used. <br /> <br />
When the iOS IFA cannot be used (such as devices < iOS 6), you may pass a <a href="https://github.com/ylechelle/OpenUDID" target="_blank">OpenUDID </a>here. <br /> <br />
When the Play Services Advertising ID cannot be used (such as devices without Google Play Services 4.0+), you may pass an <a href="http://developer.android.com/reference/android/provider/Settings.Secure.html#ANDROID_ID" target-"_blank="target-"_blank">Android ID </a> here.</td></tr><tr><td>conversion <b>*required</b></td><td>Required parameter used for attribution. Setting <span class="code-text">conversion=1 </span><span>means that Vungle will attempt to attribute the install. Setting </span><span class="code-text">conversion=0 </span><span>means that Vungle will not attempt to attribute it. <br /><br /></span>The benefit of passing all installs to Vungle is that we then know not to target your campaigns at those devices if they
are on our network. This improves your conversion rates and thus improves your campaign performance in our network, which 
may give you access to more inventory.</td></tr><tr><td>trk</td><td>Optional parameter for tracking. If <span class="code-text">trk=mat </span><span>(MobileApp Tracking), the </span><span class="code-text">conversion </span><span>parameter is required.</span></td></tr><tr><td>event_id</td><td>Parameter used for attribution. This is used across events such as clicks, installs and views, to help Vungle attribute installs.</td></tr> </table></div></div>

Thus, in a typical case, for each install which your app registers, you will send a GET request to our endpoint of the form:

`http://api.vungle.com/api/v3/new?app_id=[Vungle_App_Id]&aaid=[Google_Advertising_ID]&conversion=[1|0]&event_id=[Event_ID]`

or

`http://api.vungle.com/api/v3/new?app_id=[Vungle_App_Id]&ifa=[iOS_Identifier_For_Advertisers]&conversion=[1|0]&event_id=[Event_ID]`

#####API Versions 1 & 2
___
***DEPRECATED*** : 
The Mobile API Versions 1 & 2 (for both Android and iOS) are no longer supported, along with MAC-based attribution.
___
