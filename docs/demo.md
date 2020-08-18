<h1>Demo Content</h1>

The following content is provided as a known working configuration and sample for users just getting started.

***

**Example App Configuration** <br />
The following configuration will load a sample CSV playlist and images from the Exhibit GitHub repository. This configuration can be tested by adding it to your Exhibit Mobile Device App record under the **App Configuration** tab. <br />

```xml
<dict>
    <key>edu.nebraska.ImageViewer.dataURL</key>
    <string>https://raw.githubusercontent.com/NU-ITS/Exhibit/master/Demo/Playlist.csv</string>
</dict>
```

***

**Example CSV Playlist** <br />**Note: If using this as a template,  [please download the CSV file from GitHub here](https://raw.githubusercontent.com/NU-ITS/Exhibit/master/Demo/Playlist.csv).** The following table shows the content within the App Configuration listed above.<br />

| Name      | URL                                                          | Duration | UpdateInterval | StartOn     | EndBy          | Cache |
| --------- | ------------------------------------------------------------ | -------- | -------------- | ----------- | -------------- | ----- |
| Exhibit01 | https://github.com/NU-ITS/Exhibit/raw/master/Demo/Exhibit01.png | 0:00:10  | 1:00:00        | 1/1/18 0:00 | 12/31/30 23:59 | yes   |
| Exhibit02 | https://github.com/NU-ITS/Exhibit/raw/master/Demo/Exhibit02.png | 0:00:10  | 1:00:00        | 1/1/18 0:00 | 12/31/30 23:59 | yes   |
| Exhibit03 | https://github.com/NU-ITS/Exhibit/raw/master/Demo/Exhibit03.png | 0:00:10  | 1:00:00        | 1/1/18 0:00 | 12/31/30 23:59 | yes   |
| Exhibit04 | https://github.com/NU-ITS/Exhibit/raw/master/Demo/Exhibit04.png | 0:00:10  | 1:00:00        | 1/1/18 0:00 | 12/31/30 23:59 | yes   |

***
