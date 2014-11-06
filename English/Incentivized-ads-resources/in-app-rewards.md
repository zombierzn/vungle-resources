## Overview

This is an alternative to using server-to-server callbacks. When a user successfully completes an ad view, you can reward them directly in your app.

## Implementation- iOS

You'll want to implement the VungleSDK Delegate, which can be found under Delegate Methods, in the [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-advanced-settings.md). 

This callback `(void)vungleSDKwillCloseAdWithViewInfo:` will pass you a `viewInfo` dictionary.

If the key `completedView` returns `YES`, go ahead and reward the user for their view.

## Implementation- Android

You'll want to implement the EventListener interface, found in the [advanced settings](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-advanced-settings.md). 

If `isCompletedView` (in `onVideoView`) returns `true`, the user has earned the reward.
