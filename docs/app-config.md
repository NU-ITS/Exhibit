<h1>Preferences</h1>

App configuration Preferences are currently required to load the CSV file location through the `edu.nebraska.ImageViewer.dataURL` preferences key. All available keys are shown here: <br />

**`edu.nebraska.ImageViewer.dataURL`** ***(required)*** <br />
URL of the CSV file containing image information. There is no default option for this key and the App will not function as built without this value loaded. <br />
<br />
**`edu.nebraska.ImageViewer.imageTimer`** (optional) <br />
Time (in seconds) of the image timer default. Image display time length is specified in the CSV file but will default to this option if nothing is entered in the file. <br />
<br />
**`edu.nebraska.ImageViewer.airplayViewHide`** (optional) <br />
Boolean value set to false be default, override with a `true` value to hide the floating AirPlay box. <br />
<br />
**`edu.nebraska.ImageViewer.airplayViewTimer`** (optional) <br />
Time (in seconds) between movements of the AirPlay box. The default time is set to `33` seconds. <br />
<br />
**`edu.nebraska.ImageViewer.dataCheckTimer`** (optional) <br />
Time (in seconds) between checks for updates in the CSV file. The default time is set to `180` seconds. <br />
<br />
**`edu.nebraska.ImageViewer.defaultBackground`** (optional) <br />
This value can be set to `DefaultBackgroundNoLogo` in order to remove the MDM Image Viewer logo from the default background image. <br />
<br />
**`edu.nebraska.ImageViewer.airplayDescription`** (optional) <br />
Change the value of the description within the Airplay box. The default value is: `Wirelessly send what's on your iOS device or computer to this display using AirPlay. Learn more at help.apple.com/appletv.`  <br />
<br />
**`edu.nebraska.ImageViewer.airplaySubtitle`** (optional) <br />
Change the value of the subtitle within the Airplay box. The default value is: `CHOOSE THIS APPLE TV`  <br />
<br />
**`edu.nebraska.ImageViewer.airplayViewPositionX`** (optional) <br />
Set the default position of the Airplay box on the 'X' axis. This should be a value between `0` and `1920`. The default value is `1354`.  <br />
<br />
**`edu.nebraska.ImageViewer.airplayViewPositionY`** (optional) <br />
Set the default position of the Airplay box on the 'Y' axis. This should be a value between `0` and `1080`. The default value is `638`.  <br />
<br />
**`edu.nebraska.ImageViewer.airplayViewMovement`** (optional) <br />
The the movement behavior of the Airplay box. The following options are applicable:  <br />
* `Fade` (Default) - Airiplay box fades out of one location on the screen and into another location.
* `Slide` - Airplay box slides from one location on the screen to another.
* `Inactive` - Airplay box has no movement and is left in the default position. Use with airplayViewPositionX and airplayViewPositionY to set the inactive locaiton on the screen.
<br />


<h3>Sample App Config:</h3>

```xml
<dict>
    <key>edu.nebraska.ImageViewer.dataURL</key>
    <string>https://link.to.preferences.csv</string>
    <key>edu.nebraska.ImageViewer.imageTimer</key>
    <integer>10</integer>
    <key>edu.nebraska.ImageViewer.airplayViewTimer</key>
    <integer>25</integer>
    <key>edu.nebraska.ImageViewer.dataCheckTimer</key>
    <integer>600</integer>
    <key>edu.nebraska.ImageViewer.airplayViewPositionX</key>
    <integer>1354</integer>
    <key>edu.nebraska.ImageViewer.airplayViewPositionY</key>
    <integer>638</integer>
    <key>edu.nebraska.ImageViewer.airplayDescription</key>
    <string>You can cast the content of your iOS, iPadOS or macOS device to this device using Airplay! </string>
    <key>edu.nebraska.ImageViewer.airplaySubtitle</key>
    <string>SELECT THIS DEVICE:</string>
    <key>edu.nebraska.ImageViewer.airplayViewMovement</key>
    <string>Fade</string>
    <key>edu.nebraska.ImageViewer.airplayViewHide</key>
    <false/>
</dict>
```
