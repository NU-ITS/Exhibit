# Exhibit 
#### (Previously known as "MDM Image Viewer")


<p align="center">
  <img width="400" height="261" src="https://github.com/NU-ITS/mdm-image-viewer/blob/master/Assets/logo.png?raw=true">
</p>

MDM Image Viewer is a managed screensaver App for tvOS and an alternative to Conference Room Display only mode. 

**With MDM Image Viewer you can:**
* Run the App in single App mode and automate your processes for a zero-touch deployment.
* Give content curators access to managing the background image playlist.
* Allow your Apple TV to double as digital signage and an AirPlay device.

It is currently tested and working with Jamf Pro but should also work with other MDM providers.

**New Managed App Config Preferences in version 1.0.4 (Dec 4, 2019):**
* Airplay View Movement: Change the behavior of the Airplay box movement around the screen.
* Airplay View Position: Set the starting X/Y coordinates of the Airplay box on the screen.
* Airplay Description Text - Change the text shown under the Airplay logo.
* Airplay Subtitle Text - Change the text shown under the Airplay Descritpion.


##### Sample Screenshot:
<img src="https://github.com/qharouff/mdm-image-viewer/blob/master/Assets/screenshot_example.png?raw=true" width="650">


### Installation

A build of MDM Image Viewer is available for download from the [tvOS App Store](https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1439027089&mt=8). The current version should be deployed with App Configuration Preferences from Jamf Pro.



### Managed App Configuration Preferences <br />
App configuration Preferences are currently required to load the CSV file location through the "edu.nebraska.ImageViewer.dataURL" preferences key. All available keys are shown here: <br />

**edu.nebraska.ImageViewer.dataURL** (required) <br />
URL of the CSV file containing image information. There is no default option for this key and the App will not function as built without this value loaded. <br />
<br />
**edu.nebraska.ImageViewer.imageTimer** (optional) <br />
Time (in seconds) of the image timer default. Image display time length is specified in the CSV file but will default to this option if nothing is entered in the file. <br />
<br />
**edu.nebraska.ImageViewer.airplayViewHide** (optional) <br />
Boolean value set to false be default, override with a "true" value to hide the floating AirPlay box. <br />
<br />
**edu.nebraska.ImageViewer.airplayViewTimer** (optional) <br />
Time (in seconds) between movements of the AirPlay box. The default time is set to 33 seconds. <br />
<br />
**edu.nebraska.ImageViewer.dataCheckTimer** (optional) <br />
Time (in seconds) between checks for updates in the CSV file. The default time is set to 180 seconds. <br />
<br />
**edu.nebraska.ImageViewer.defaultBackground** (optional) <br />
This value can be set to "DefaultBackgroundNoLogo" in order to remove the MDM Image Viewer logo from the default background image. <br />
<br />
**New in version 1.0.4:** <br />
<br />
**edu.nebraska.ImageViewer.airplayDescription** (optional) <br />
Change the value of the description within the Airplay box. The default value is: "Wirelessly send what's on your iOS device or computer to this display using AirPlay. Learn more at help.apple.com/appletv."  <br />
<br />
**edu.nebraska.ImageViewer.airplaySubtitle** (optional) <br />
Change the value of the subtitle within the Airplay box. The default value is: "CHOOSE THIS APPLE TV"  <br />
<br />
**edu.nebraska.ImageViewer.airplayViewPositionX** (optional) <br />
Set the default position of the Airplay box on the 'X' axis. This should be a value between 0 and 1920. The default value is 1354.  <br />
<br />
**edu.nebraska.ImageViewer.airplayViewPositionY** (optional) <br />
Set the default position of the Airplay box on the 'Y' axis. This should be a value between 0 and 1080. The default value is 638.  <br />
<br />
**edu.nebraska.ImageViewer.airplayViewMovement** (optional) <br />
The the movement behavior of the Airplay box. The following options are applicable:  <br />
* Fade (Default) - Airiplay box fades out of one location on the screen and into another location.
* Slide - Airplay box slides from one location on the screen to another.
* Inactive - Airplay box has no movement and is left in the default position. Use with airplayViewPositionX and airplayViewPositionY to set the inactive locaiton on the screen.
<br />


*Sample configuration preferences:*
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

### CSV Image Playlist Settings Example
The CSV file liked in the managed preferences should show values including a header and in the order listed below. The "UpdateInterval" and "Cache" values are not currently used but should still be included within the CSV file.

| Name | URL | Duration | UpdateInterval | StartOn | EndBy | Cache |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Test Image | https://example.com/image.png | 0:00:10 | 1:00:00 | 1/1/18 0:00 | 12/31/99 23:59 | yes |

**Name** - Name of the image. This value is strictly for reference. <br />
**URL** - Web location of the image file. <br />
**Duration** - Length of time to display the particular image in **H:MM:SS** format. <br />
**UpdateInterval** - *Currently Unused* <br />
**StartOn** - Date and time to begin showing the specified image in the playlist in **M/d/yy H:mm** format. <br />
**EndBy** - Date and time to stop showing the specified image in the playlist in **M/d/yy H:mm** format. <br />
**Cache** - *Currently Unused* <br />

## Suggested Configuration
It is reccomended that you lock your Apple TV into single app mode with MDM Image Viewer. Images should not be larger than 3840px × 2160px. Loading unessisarily large images may cause the App to crash.

## Contact

Feel free to reach out to Quentin Harouff at qharouff@nebraska.edu with any questions. Or https://github.com/NU-ITS/mdm-image-viewer/issues with any bugs or issues.

## Errors and bugs

If something is not behaving intuitively, it is a bug and should be reported.
Report it here by creating an issue: https://github.com/qharouff/mdm-image-viewer/issues

Help us fix the problem as quickly as possible by following [Mozilla's guidelines for reporting bugs.](https://developer.mozilla.org/en-US/docs/Mozilla/QA/Bug_writing_guidelines#General_Outline_of_a_Bug_Report)

## Patches and pull requests

Your patches are welcome. Here's our suggested workflow:
 
* Fork the project.
* Make your feature addition or bug fix.
* Send us a pull request with a description of your work. Bonus points for topic branches!

## Copyright and attribution

Copyright (c) 2018 University of Nebraska. Released under the [MIT License](https://github.com/datamade/your-repo-here/blob/master/LICENSE).
