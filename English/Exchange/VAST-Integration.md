##Vungle VAST Integration

### Steps in Integration:
__________________________________________________________________________________________

1. Please send sample VAST endpoint to Vungle 
  * Review supported parameters below for reference
  * Vungle will add supported macros where available

2. Vungle will send demo apps for iOS and Android testing
  * supply a sample VAST URL (VAST tag) that returns 100% of the time
  * ad response should return an ad
  * please check for video display, tracking pixels firing, clicks recorded etc. 

3. If test is successful we’ll move onto Live Testing
  * Vungle will traffic 1,000 non-billable impressions
  * Reconcile delivery


### VAST Request Parameters:
__________________________________________________________________________________________


| Parameter Name     | Macro                          | Value      | Notes                                        | Example                                                                                                                                         |
|--------------------|--------------------------------|------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| Device ID          | {{{device_id}}}                | String     | Clear or Hashed                              | ab4d6cc4-f57f-4309-9d29-b7fb5e35dd74                                                                                                            |
| Application ID     | {{{pub_app_id}}}               | String     | From the iTunes or Play store                | 539920547                                                                                                                                       |
| App Name           | {{{pub_app_name}}}             | String     | From the iTunes or Play store                | Family%20Farm%20Seaside                                                                                                                         |
| IP                 | {{{ip}}}                       | String     | Internet Protocol Address                    | 95.118.153.77                                                                                                                                   |
| User Agent         | {{{browser_user_agent}}}       | String     | UA from headers                              |                                                                                                                                                 |
| Vungle User Agent  | {{{user_agent}}}               | String     | UA from Vungle SDK                           |                                                                                                                                                 |
| Platform           | {{{device_platform}}}          | String     | iOS or Android                               | iOS/Android                                                                                                                                     |
| Device DNT         | {{{ad_tracking_disabled}}}     | String     | True/False                                   | True/False                                                                                                                                      |
| Device DNT         | {{{ad_tracking_enabled}}}      | String     | True/False                                   | True/False                                                                                                                                      |
| Screen Width       | {{{screen_width}}}             | Integer    | screen width (pixels)                        | 1024                                                                                                                                            |
| Screen Height      | {{{screen_height}}}            | Integer    | screen height (pixels)                       | 768                                                                                                                                             |
| Screen Orientation | {{{screen_orientation}}}       | String     | Portrait or Landscape                        | Portrait/Landscape                                                                                                                              |
| Connection Type    | {{{connection_type}}}          | String     | Wifi, wwan, mobile                           | Wifi, wwan, mobile                                                                                                                              |
| Timestamp          | {{{timestamp}}}                | String/Int | Timestamp                                    | 2014-12-05T00%3A44%3A19%2B00%3A00                                                                                                               |
| App Category       | {{{pub_app_store_category}}}   | String     | List of categories                           | Games                                                                                                                                           |
| App Store URL      | {{{pub_app_store_url}}}        | String     | App Store or content URL                     |                                                                                                                                                 |
| Vungle ID          | {{{vungle_id}}}                | String     | Vungle Publisher ID to associate performance |                                                                                                                                                 |
| Market ID          | {{{market_id}}}                | String     | Publisher Store ID to associate performance  |                                                                                                                                                 |
| OS version         | {{{os_version}}}               | String     | OS Version (ie iOS 7.2)                      |                                                                                                                                                 |
| Device Model       | {{{device_model}}}             | String     |                                              |                                                                                                                                                 |
| Device Make        | {{{device_model}}}             | String     |                                              |                                                                                                                                                 |
| Device Type        | {{{device_model}}}             | String     |                                              |                                                                                                                                                 |
| City               | {{{city}}}                     | String     |                                              |                                                                                                                                                 |
| Country            | {{{country}}}                  | String     |                                              |                                                                                                                                                 |
| Connection Type    | {{{language}}}                 | String     | two character Language from headers          | UK                                                                                                                                              |

### Sample VAST Request URL (VAST tag) with unfilled parameters:
__________________________________________________________________________________________


```javascript
http://partner.com/vast2/6524rgww153hifw/?duration=15&app_name={{{pub_app_name}}}&app_id={{{market_id}}}&rtb_type=instream_mobile_vast_inter&user_id={{{device_id}}}&ua={{{browser_user_agent}}}&random={{{timestamp}}}&ip_address={{{ip}}}
```

### Sample VAST Request URL (VAST tag) with filled parameters:
__________________________________________________________________________________________

```javascript
http://partner.com/vast2/124765432/?duration=15&app_name=My%20Talking%20Tom%20Free%20for%20Android&app_id=com.outfit7.mytalkingtomfree&rtb_type=instream_mobile_vast_inter&user_id=6df43c89-9e3d-43fb-a1e9-bacd51932d41&ua=Mozilla%2F5.0%20(Linux%3B%20Android%204.4.2%3B%20SPH-L720%20Build%2FKOT49H)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Version%2F4.0%20Chrome%2F30.0.0.0%20Mobile%20Safari%2F537.36&random=2015-01-27T21%3A30%3A34%2B00%3A00&ip_address=66.87.114.254
```

### No-Ad Response
__________________________________________________________________________________________

 Please Respond with ```No Ad``` or a ```403``` for impressions not wanted


### VAST Response Criteria:
__________________________________________________________________________________________

* 15s or 30s duration video (please specify with Vungle AM)
* > 250 kbps bitrate
* 1 media file in .mp4
* maximum of 1 redirect
* Bid Responses returned within 300ms (for streaming)
* Bid Responses returned within 500ms (for pre-cached)
* Click through event
