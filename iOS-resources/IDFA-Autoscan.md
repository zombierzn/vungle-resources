# IDFA- Autoscan

### What is Autoscan?

In April 2014, Apple released a new feature called [Autoscan](http://techcrunch.com/2014/04/11/apple-developers-must-now-agree-to-ad-identifier-rules-or-risk-app-store-rejection/). Upon submission to the app store, this scanner will verify that your app complies with the guidelines outlined in the [iOS Developer Library](https://developer.apple.com/library/ios/documentation/AdSupport/Reference/ASIdentifierManager_Ref/ASIdentifierManager.html).

### Why does it concern you?

Many publishers had their app rejected by Apple due to an error titled "Improper Advertiser Identifier Usage".

### How is Vungle handling this?

Autoscan is rejecting apps that do not respect the Limit Ad Tracking setting on iOS. The catch here, is that advertising SDKs can still be compliant with Apple's guidelines, even if they do not check this setting.

"**advertisingTrackingEnabled:** ...If the value is NO, use the advertising identifier only for the following purposes: frequency capping, **conversion events**, estimating the number of unique users, security and fraud detection, and debugging." -iOS Developer Library

Vungle uses the identifier for conversion events only, so we do not check the Ad Tracking settings (which is okay!).

### What should Vungle publishers do?

As long as publishers check the correct boxes on the app submission form, under "Advertising Identifier", they should pass Autoscan (as far as Vungle is concerned). The first 2 checkboxes and the last 1 should be checked.

### Example:

**This app uses the Advertising Identifier to (select all that apply):**

[X] Serve advertisements within the app<br>
[X] Attribute this app installation to a previously served advertisement<br>
[ ] Attribute an action taken within this app to a previously served advertisement

...

**Limit Ad Tracking setting in iOS**

[X] I, (name), confirm that this app, and any third party that interfaces with this app, uses the Advertising Identifier checks and honors a user's Limit Ad Tracking setting in iOS and, when it is enabled by a user, this app does not use Advertising Identifier, and any information obtained through the use of the Advertizing Identifier, in any way other than for "Limited Advertising Purposes" as defined in the iOS Developer Program License Agreement.
