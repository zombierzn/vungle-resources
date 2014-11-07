# IDFA- Autoscan

### What is Autoscan (and IDFA)?

In April 2014, Apple released a new feature called [Autoscan](http://techcrunch.com/2014/04/11/apple-developers-must-now-agree-to-ad-identifier-rules-or-risk-app-store-rejection/). Upon submission to the App Store, this scanner will verify that your app complies with the guidelines outlined in the [iOS Developer Library](https://developer.apple.com/library/ios/documentation/AdSupport/Reference/ASIdentifierManager_Ref/ASIdentifierManager.html).

In case you're unfamiliar, IDFA is "a temporary device identifier used by Apple devices. It provides device identification while giving end users the ability to limit the device/consumer information accessed by advertisers or apps." -[Techopedia](http://www.techopedia.com/definition/29032/identifier-for-advertisers-ifa-ifda)

### Why does it concern you?


Apple's submission process now uses Autoscan, as well as a section on the submission form, to check apps for proper IDFA usage. Following the recommendations in this document will ensure that your implementation of the Vungle SDK is compliant with Apple's guidelines. If you don't follow these tips, your app could get rejected due to an error titled "Improper Advertiser Identifier Usage".

### How is Vungle handling this?

In general, Autoscan is rejecting apps that don't check the `advertisingTrackingEnabled` value before using IDFAs. However, advertising SDKs can still be compliant with Apple's guidelines, even if they don't check that value. From the [iOS Developer Library](https://developer.apple.com/library/ios/documentation/AdSupport/Reference/ASIdentifierManager_Ref/ASIdentifierManager.html#//apple_ref/occ/instp/ASIdentifierManager/advertisingTrackingEnabled):

`advertisingTrackingEnabled`: ...If the value is `NO`, use the advertising identifier only for the following purposes: frequency capping, **conversion events**, estimating the number of unique users, security and fraud detection, and debugging.

Vungle only uses the identifier for conversion events, so we do not check the `advertisingTrackingEnabled` value (which is okay!).

### What should Vungle publishers do?

As long as publishers check the correct boxes on the app submission form, under "Advertising Identifier", they should pass Autoscan (at least, as far as Vungle is concerned). The first 2 checkboxes and the last 1 should be checked:

**This app uses the Advertising Identifier to (select all that apply):**

[X] Serve advertisements within the app<br>
[X] Attribute this app installation to a previously served advertisement<br>
[&nbsp;&nbsp;] Attribute an action taken within this app to a previously served advertisement

...

**Limit Ad Tracking setting in iOS**

[X] I, (name), confirm that this app, and any third party that interfaces with this app, uses the Advertising Identifier checks and honors a user's Limit Ad Tracking setting in iOS and, when it is enabled by a user, this app does not use Advertising Identifier, and any information obtained through the use of the Advertizing Identifier, in any way other than for "Limited Advertising Purposes" as defined in the iOS Developer Program License Agreement.
