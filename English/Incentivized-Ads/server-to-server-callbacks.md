## Overview

Server-to-server callbacks allow you to reward users for ad views with in-game currency or other rewards. When a user successfully completes an ad view, you can configure a callback from Vungle's servers to your own to notify you of the user's completed action.

## Implementation

#### Basic Setup

When a user watches 80% or more of an incentivized ad, it is considered a completed view. Vungle will then ping your servers with a callback URL, which looks something like this:

`http://acme.com/bugzBunny/reward?uid=%user%`

or

`http://acme.com/bugzBunny/reward?amount=1&uid=%user%&txid=%txid%&digest=%digest%`

Configure the callback URL in your app's Advanced Settings, on the dashboard. Most publishers only use `%user%`, plus `%txid%` and `%digest%` for security, but all of the following are available:

| Variables  | Description | 
| :--------- |:----------- |
| `%user%`   | the username provided to the Vungle SDK via: <br>**iOS-** the `user` key of the [options dict](https://github.com/Vungle/vungle-resources/blob/master/English/iOS/iOS-advanced-settings.md#playad-options) passed to `playAd()` <br>**Android-** the `setIncentivizedUserId` setter of the [global ad config object](https://github.com/Vungle/vungle-resources/blob/master/English/Android/3.2.x/android-advanced-settings.md#the-adconfig-object) passed to `playAd()` |
| `%udid%`   | a unique identifier for the device | 
| `%ifa%`    | iOS- Apple's unique identifier for the device. Android- this will return the Google Advertiser ID. |
| `%txid%`   | a unique transaction ID for the completed view |
| `%digest%` | security token to verify that the callback came from Vungle - see **Security** section for details | 

Note that `%user%` is the only variable you need to pass in- the rest will come back from Vungle's servers if you include them in the callback URL.

#### Reward Configuration

Now that you can reward a user for watching an ad, what do you give them? If you're giving out gems every time, it's pretty straightforward..  but what if you want to get a bit more advanced? We don't have a built-in option for reward configuration, but here's what we'd recommend:

**Example- Coins vs Lives:**

Let's say your app has incentivized ads in multiple places- both in your shop and at every 3rd 'game-over'. You'd like to reward coins in the shop, and a life at game-over. For each instance of playAd(), you'll want to configure `user` like this:

`userName123:coins` or `userName123:lives`

Then, when your servers receive Vungle's callback, parse `%user%` for the correct reward!

## Security

#### Authenticating Callbacks

In order to verify that callbacks you receive originated from Vungle, under Advanced Settings, select the Secret Key for Secure Callback checkbox for your application. This will generate a secret key like this:

`4YjaiIualvm8/4wkMBRH8pctlqB1NyzhK3qUGUar+Zc=`

which you can use to verify the origin of the callback as follows:

1. Create the raw transaction verification string by concatenating your secret key with the transaction ID separated by a colon:
`transactionString = secretKey + ":" + %txid%`
2. Hash the bytes of the `transactionString` **twice** using the SHA-256 algorithm.
3. Generate the transaction verification token by hex-encoding the output bytes of 2 sequential rounds of SHA-256 hashing, which will look something like this:
`transactionToken = 870a0d13da1f1670b5ba35f27604018aeb804d5e6ac5c48194b2358e6748e2a8`
4. Check that the `transactionToken` you generated equals the one sent in the callback querystring as `%digest%`. 

#### Preventing Replay Attacks

To prevent a single callback from being replayed multiple times against your server, store authenticated transaction IDs and reject future callbacks with duplicate transaction IDs. Because a transaction ID contains a timestamp, you can limit the number of transaction IDs you must store and check for duplicates by enforcing a cutoff for timely callbacks as follows:

1. Extract the timestamp (in milliseconds) from the transaction ID:
`transactionMillis = transactionId.substringAfter(":")`
2. Check that `transactionMillis` is later than your cutoff and that `transactionId` has not been encountered since your cutoff.

#### Sample Code

We have examples to help you implement callbacks security [here](https://github.com/Vungle/vungle-resources/blob/master/English/Incentivized-Ads/security-sample-code.md)!
