## Version 1.1.1
**(Oct 12, 2022)**

**Changes:**

In tvOS 16, Apple requires an App entitlement for accessing the user-assigned device name instead of the generic device name. Exhibit does not yet have this entitlement and therefore the name of the device will always show as "Apple TV". As a work-around, a new App Config Preference has been added to allow the setting of device name from MDM. Jamf Pro and Jamf School both support variables in App Config so you can pass the name of the device to the Apple TV. You may need to check with your MDM provider to see if they support passing variables through App Config.

Jamf Pro: `$DEVICENAME`
Jamf School: `%Name%`

**New Managed App Config Preferences**

* `edu.nebraska.ImageViewer.deviceName` - Set the device name display value of the Apple TV.

***

## Version 1.1.0
**(Oct 8, 2021)**

**Changes:**

* **New Loading Screen:**
    * Exhibit now features a loading view status and error messages on startup.
    * Full media preheat now occurs before the first content item is displayed. This ensures that all content is loaded into cache and certain items aren’t skipped.
    * App Config updates are now processed as soon as the Apple TV receives an update from MDM.
    * In the event of a content load failure, Exhibit will attempt to load content every 60 seconds while the content player is empty. This is advantageous if the Apple TV experiences a delay in obtaining a network connection.

* **Support for Google Drive content:**
    * Shared public URLs from Google Drive can now be used in Exhibit. This includes either uploaded CSV files or Google Sheets documents following the standard CSV playlist format. The “dataType” key must be set to “csv” for this functionality. See https://exhibit.readthedocs.io for more information.

**New Managed App Config Preferences**

* `edu.nebraska.ImageViewer.dataType` - Can be set to "csv" for Google Drive support or for situations where a CSV file does not include the .csv extension in the url.

***

## Version 1.0.5
**(Dec 17, 2019)**

**Changes**
* Added support for video playback for `.mp4` videos.
* Current image types supported: `.jpg` `.jpeg` `.png`.
* Added several video related Managed App Config options (see below).

**New Managed App Config Preferences**

* `edu.nebraska.ImageViewer.airplayViewHideOnVideo` - Set to `true` to hide the AirPlay box only on videos.
* `edu.nebraska.ImageViewer.playVideosInFull` - Set to `true` to ignore the playlist instructions and play videos in their entirety.
* `edu.nebraska.ImageViewer.playVideosWithAudio` - Set to `true` to allow audio playback.

***

## Version 1.0.4
**(Dec 4, 2019)**

**New Managed App Config Preferences**

* `Airplay View Movement` - Change the behavior of the Airplay box movement around the screen.
* `Airplay View Position` - Set the starting X/Y coordinates of the Airplay box on the screen.
* `Airplay Description Text` - Change the text shown under the Airplay logo.
* `Airplay Subtitle Text` - Change the text shown under the Airplay Description.
