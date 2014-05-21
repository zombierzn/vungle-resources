## Rewards Resources

To maximize revenue while maintaining a great UX, Vungle [recommends](http://www.vungle.com/best-practices-video-ad-placements/) using rewarded interstitials. Shown at natural breaks in the app, rewarded interstitials deliver high revenue as ads are shown frequently and are generally non-skippable. This placement also delivers a great UX, because users opt-in to watch a video and are rewarded with something of value -- such as virtual currency, premium content, or in-app goods. The amount and type of reward given to a user for completing a video view is completely up to you. There are two ways of achieving this:

**Server-to-Server Callbacks** (recommended)

When a user successfully completes an ad view, you can configure a callback from Vungle's servers to your own to notify you of the user's completed action.

One benefit here is control. This method allows you to make changes and updates directly on the server side so there's no need to push an update. Another is security to prevent replay attacks. 

**In-App Rewards**

When a user successfully completes an ad view, you can reward them directly in your app.

The main benefit here is that it's fairly simple to implement. If you're looking for something quick, and you're not concerned with replay attacks, this should do it.
