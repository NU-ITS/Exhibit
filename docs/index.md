<h1>Exhibit</h1>

<p align="center">
  <img width="400" height="261" src="https://github.com/NU-ITS/mdm-image-viewer/blob/master/Assets/logo.png?raw=true">
</p>

Exhibit, previously known as "MDM Image Viewer", is a managed screensaver App for tvOS and a great alternative for conference rooms and public spaces where managed Apple TVs are locked to Conference Room Display mode. With Exhibit, you can customize the Apple TVs in your collaborative spaces by displaying curated images and videos to your users. The App also displays an AirPlay box similar to Conference Room Display mode so users can easily identify the device.

Exhibit is available for download from the [tvOS App Store](https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1439027089&mt=8).

[<h5>Watch the Demo Video</h5>](https://www.youtube.com/watch?v=jdt0uAyO-28)

<h3>Features:</h3>

* Run the App in single App mode and automate your processes for a zero-touch deployment.
* Give content curators access to managing the background content playlist.
* Allow your Apple TV to double as digital signage and an AirPlay device.

<h3>Requirements:</h3>

* Apple TV with tvOS 12 or higher
* A Mobile Device Management (MDM) solution such as Jamf.
* App Deployment through an MDM with required Managed App Config.

<h3>Video Support (Beta):</h3>
Video support for .mp4 videos has been added in version 1.0.5. There are several limitations when using this feature.

- Offline caching is not available for videos. Exhibit currently uses Nuke for image caching but the ability to cache video does not exist in this framework nor does it exist in other frameworks due to limitations in tvOS.
- High speed internet connection is recommended as loading video files is more network intensive than loading images. We do not suggest relying on Wi-Fi for video playback unless tested thoroughly.
- If playback issues arise, try limiting the size of your individual video files.

<h3>Sample Screenshot:<h3>
<img src="https://github.com/qharouff/mdm-image-viewer/blob/master/Assets/screenshot_example.png?raw=true" width="650">
