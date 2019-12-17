### CSV Example
The CSV file liked in the managed preferences should show values including a header and in the order listed below. The "UpdateInterval" and "Cache" values are not currently used but should still be included within the CSV file.

| Name | URL | Duration | UpdateInterval | StartOn | EndBy | Cache |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Test Image | https://example.com/image.png | 0:00:10 | 1:00:00 | 1/1/18 0:00 | 12/31/99 23:59 | yes |

`Name` - Name of the image. This value is strictly for reference. <br />
`URL` - Web location of the image file. <br />
`Duration` - Length of time to display the particular image in `H:MM:SS` format. <br />
`UpdateInterval` - *Currently Unused* <br />
`StartOn` - Date and time to begin showing the specified image in the playlist in `M/d/yy H:mm` format. <br />
`EndBy` - Date and time to stop showing the specified image in the playlist in `M/d/yy H:mm` format. <br />
`Cache` - *Currently Unused* <br />
