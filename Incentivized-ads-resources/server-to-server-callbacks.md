### Overview

Server-to-server callbacks allow you to reward users for ad views with in-game currency or other rewards. When a user successfully completes an ad view, you can configure a callback from Vungle's servers to your own to notify you of the user's completed action.

### Implementation

When a user watches 80% or more of an incentivized ad, it is considered a completed view. Vungle will then ping your servers with a callback URL, which looks something like this:

`http://acme.com/bugzBunny/reward?uid=%user%`

or

`http://acme.com/bugzBunny/reward?amount=1&uid=%user%&openudid=%udid%&mac=%mac%`

Configure the callback URL in your app's Advanced Settings, on the dashboard. Most publishers only use `%user%`, plus `%txid%` and `%digest%` for security, but all of the following are available:

| Variables  | Description | 
| :--------- |:----------- |
| `%user%`   | the username provided to the Vungle SDK via: <br>**iOS-** the `user` key of the [options dict](https://github.com/Vungle/vungle-resources/blob/master/iOS-resources/iOS-advanced-settings.md) passed to `playAd()` <br>**Android-** the `setIncentivizedUserId` setter of the [global ad config object](https://github.com/Vungle/vungle-resources/blob/master/Android-resources/android-advanced-settings.md) passed to `playAd()` |
| `%udid%`   | a unique identifier for the device | 
| `%ifa%`    | Apple's unique identifier for the device (iOS only) |
| `%mac%`    | the device's MAC address, if available | 
| `%txid%`   | a unique transaction ID for the completed view |
| `%digest%` | security token to verify that the callback came from Vungle - see **Security** section for details | 

Note that `%user%` is the only variable you need to pass in- the rest will come back from Vungle's servers if you include them in the callback URL.

### Security

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

### Sample Code

#### Node.js

```javascript
var crypto = require('crypto');

function isTransactionValid(secret, transaction_id, provided_hash) {
  return isTransactionRecent(transaction_id) &&
         isTransactionNew(transaction_id)    &&
         createSecurityDigest(secret, transaction_id) === provided_hash;
}

function getTransactionTimestamp(transaction_id) {
  return parseInt(transaction_id.split(":")[1], 10) || null;
}

function isTransactionRecent(transaction_id) {
  // Does the transaction have a reasonable format?
  var tx_timestamp = getTransactionTimestamp(transaction_id);
  if (tx_timestamp === null) { return false; }
  
  // Is the transaction within a reasonable time range?
  var now = new Date().getTime();
  var time_diff = now - tx_timestamp;
  var hour_in_future = -1000 * 60 * 60, three_days_ago = 1000 * 60 * 60 * 24 * 3;
  return (time_diff < three_days_ago && time_diff > hour_in_future);
}

// Have we seen this transaction before?
// NOTE: To scale beyond just this one node process, you'll need to put this in some
// sort of centralized datastore. Any one that supports atomic insertions into a set
// should do. The Redis database, with its SADD command, would be a good place to start.
var known_transactions = {};
function isTransactionNew(transaction_id) {
  if (known_transactions[transaction_id]) { return false; }
  
  known_transactions[transaction_id] = true;
  return true;
}

function createSecurityDigest(secret, transaction_id) {
  var firsthash = crypto.createHash("sha256").update(secret + ":" + transaction_id).digest("binary");
  return crypto.createHash("sha256").update(firsthash).digest("hex");
}
```

#### Java

```java
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;

public class ServerCallbackSecurityExample {
  private static final long MAX_CALLBACK_AGE_MILLIS = 7 * 24 * 60 * 60 * 1000;  // 7 days
  
  /**
   * Checks that a transaction is recent enough, signed with the secretKey, and not a duplicate.
   * 
   * @param transactionId the transaction ID.
   * @param secretKey a shared secret.
   * @param verificationDigest the verification digest sent in the callback querystring.
   */
  public boolean isValidTransaction(String transactionId, String secretKey, String verificationDigest) throws NoSuchAlgorithmException {
    return isRecentTransaction(transactionId)
      && isDigestValid(transactionId, secretKey, verificationDigest)
      && isNewTransaction(transactionId);
  }
  
  protected boolean isRecentTransaction(String transactionId) {
    boolean isRecent = false;
    try {
      final long minCallbackAgeMillis = System.currentTimeMillis() - MAX_CALLBACK_AGE_MILLIS;
      final long transactionMillis = getTransactionMillis(transactionId);
      isRecent = (transactionMillis > minCallbackAgeMillis);
    }
    catch (ParseException exception) {
      // invalid transaction ID format
    }
    return isRecent;
  }
  
  protected boolean isDigestValid(String transactionId, String secretKey, String verificationDigest) throws NoSuchAlgorithmException {
    return createSecurityDigest(transactionId, secretKey)
      .equals(verificationDigest);
  }
  
  protected boolean isNewTransaction(String transactionId) {
    // TODO if transactionId is new, store the transactionId with its associated transactionMillis
    return true;
  }
  
  protected long getTransactionMillis(String transactionId) throws ParseException {
    final int transactionMillisIndex = transactionId.lastIndexOf(":") + 1;
    try {
      if (transactionMillisIndex > 0 && transactionMillisIndex < transactionId.length()) {
        return Long.parseLong(
          transactionId.substring(transactionMillisIndex));
      }
      else {
        throw new ParseException("No timestamp in transaction ID", transactionMillisIndex);
      }
    }
    catch (NumberFormatException exception) {
      throw new ParseException("Invalid transaction ID timestamp", transactionMillisIndex);
      // invalid timestamp
    }
  }
  
  protected String createSecurityDigest(String transactionId, String secretKey) throws NoSuchAlgorithmException {
    final String verificationString = secretKey + ":" + transactionId;
    final MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
    return toHexString(
      messageDigest.digest(
        messageDigest.digest(
          verificationString.getBytes(Charset.forName("US-ASCII")))));
  }
  
  protected String toHexString(byte[] bytes) {
    final StringBuffer hexStringBuffer = new StringBuffer();
    for (final byte byt : bytes) {
      hexStringBuffer.append(
        Integer.toString((byt & 0xff) + 0x100, 16)
          .substring(1));
    }
    return hexStringBuffer.toString();
  }
}
```

#### Python

```python
import hashlib, time

def isTransactionValid(secret, transaction_id, input_hash):
  """Returns whether this transaction id / hash should be considered valid"""
  return isTransactionIDRecent(transaction_id) and \
         isTransactionIDNew(transaction_id)    and \
         createSecurityDigest(secret, transaction_id) == input_hash
         
def getTransactionTimestamp(transaction_id):
  """Will return the unix time (in milliseconds) of this transaction, or None if invalid"""
  parsed = transaction_id.split(":")
  try:
    return int(parsed[1]) if len(parsed) == 2 else None
  except ValueError as e:
    return None
    
def isTransactionIDRecent(transaction_id):
  """Is this transaction within a reasonable time range?"""
  tx_time = getTransactionTimestamp(transaction_id)
  
  # Handle bad transaction:
  if tx_time is None:
    return False
    
  # Handle bad transaction times:
  now = int(time.time() * 1000)
  three_days_ago = now - (1000 * 60 * 60 * 24 * 3)
  one_hour_from_now = now + (1000 * 60 * 60)
  return ( three_days_ago < tx_time < one_hour_from_now )
  
def isTransactionIDNew(transaction_id, known_transaction_ids=set()):
  """Is this a duplicate transaction?
     NOTE: We only use the Python set for simplicity. For better / more centralized solutions,
     you can use any datastore that supports atomic insertion into a set. For starters, try
     Redis with its "SADD" command."""
  if transaction_id in known_transaction_ids:
    return False
    
  # Else, valid:
  known_transaction_ids.add(transaction_id)
  return True
  
  
def createSecurityDigest(secret, transaction_id):
  """Will return the string that the security hash should have been"""
  firsthash = hashlib.sha256()
  firsthash.update(secret + ":" + transaction_id)
  
  secondhash = hashlib.sha256()
  secondhash.update(firsthash.digest())
  
  return secondhash.hexdigest()
```
  
#### Ruby

```ruby
require "openssl"
require "digest/sha2"
require "base64"
require "time"

# just some helper methods, ignore if using Rails
class Fixnum
  SECONDS_IN_DAY = 24 * 60 * 60
  HOURS_IN_DAY = 24 * 60
  
  def days
    self * SECONDS_IN_DAY
  end
  
  def hour
    self * 60 * 60
  end
  
  def ago
    (Time.now - self)
  end
  
  def from_now
    (Time.now + self)
  end
end

def transaction_valid?(secret, txid, input_hash)
  transaction_id_recent?(txid) && transaction_id_new?(txid) && create_security_digest(secret, txid) == input_hash
end

def transaction_timestamp(txid)
  arr = txid.split(":")
  return arr[1].to_i if arr.size == 2
end

def transaction_id_recent?(txid)
  tx_time = transaction_timestamp(txid)
  return false if tx_time.nil?
  
  now = Time.now.to_i
  three_days_ago = 3.days.ago
  one_hour_from_now = 1.hour.from_now
  three_days_ago.to_i < tx_time && tx_time < one_hour_from_now.to_i
end

def transaction_id_new?(txid, transactions = [])
  return false if transactions.include?(txid)
  transactions << txid
  return true
end

def create_security_digest(secret, txid)
  verification_string = "#{secret}:#{txid}"
  first_digest = Digest::SHA2.new(256).update(verification_string)
  Digest::SHA2.new(256).hexdigest(first_digest.digest)
end
```
