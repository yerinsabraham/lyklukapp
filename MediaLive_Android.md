SDK application management is a prerequisite for SDK integration. When integrating Native SDK and Web Player SDK, you need to configure the Appid for log reporting. At the same time, when integrating Native SDK, you need to configure the license. In the SDK application management module, you can perform the following operations。

* For Web-type applications: Create an application and obtain the App ID that needs to be configured when integrating the SDK.
* For App-type applications:
   * Create an application and bind the License to the application.
   * Download the License file needed to integrate the SDK.
   * Obtain the App ID for integrating the SDK.

<span id="35f1ae91"></span>
## Creating an SDK application
In most cases, creating an SDK application is the first task you must complete before acquiring your SDK license and package. However, if you are integrating both BytePlus VOD and BytePlus MediaLive's SDKs into the same app, and have already created an SDK application in the BytePlus VOD console, then you must bind the existing application to BytePlus MediaLive's SDK application.
<span id="Prerequisite"></span>
### Prerequisite
If you are creating an App-type SDK application, you need to complete the following prerequisites.

* Note down the package names of your Android and iOS apps.
   * For Android apps, the package name is the value of `applicationId` in the `build.gradle` file.
   * For iOS apps, the package name is the value of `bundleId` of the main target in Xcode.
* If you are binding BytePlus VOD's SDK application, go to the BytePlus VOD console and note down the name of the existing application.
* Acquire an SDK license. For a comprehensive list of features supported by each license type, please refer to [Features](/docs/byteplus-media-live/docs-introduction#2a8ebace). For detailed pricing information of each license type, please refer to [SDK licenses](/docs/byteplus-media-live/docs-sdk-licenses).
   * If you want to get a free license by binding it with a live-stream resource pack, you must first purchase a pack of 100 TB or more. For more information about the resource pack, refer to [Resource packs](/docs/byteplus-media-live/docs-resource-packs).
   * If you prefer to purchase a license directly, please visit [the purchase page](https://console.byteplus.com/live/buyResource?tab=license) to purchase a license. You can also apply for a trial license through the purchase page.

<span id="Procedure for creating an SDK application"></span>
### Steps

1. Log in to the [BytePlus MediaLive console](https://console.byteplus.com/live).
2. In the left-side navigation pane, click **SDK management**.
3. Click **Create SDK application** to create an SDK application, or click **Bind existing application** to bind your existing VOD application. 
4. Select the application type to support the following application types.
   1. App: Used to integrate Native Broadcast SDK and Player SDK.
   2. Web: Used to integrate the Web Player SDK.
5. Configure other required parameters.
   * **Application name**: The name of the SDK application. If you are binding an existing application, choose the application you want to bind.
   * **Select project**: Select the project for the SDK application, and after configuring the project, sub-accounts with project permissions can manage the SDK application.
   * **PackageName**: The package name of your Android app.
   * **Bundle ID**: The package name of your iOS app.
   :::tip
   After you create an SDK application, you can no longer modify the package names. Make sure that you enter the correct package names.
   :::
5. If you are selecting an App type application, after configuring the parameters, you need to click **Next** to select a license that you have acquired according to [Prerequisite](/docs/byteplus-media-live/docs-sdk-management#Prerequisite). If you select the basic license type, you can bind a live-stream traffic pack in this step.
6. Click **Confirm** to save the settings.

<span id="Result"></span>
### Result
After you have successfully created an SDK application, you can find the application in the application list. Some fields are described as follows:

* App ID: The unique identifier of an SDK application.
* Status: The status of the SDK license.
   * **Activated**: The SDK license is valid. You can start integrating the SDK into your app.
   * **Expired**: The SDK license is expired. You need to renew the license.

<span id="f7530d71"></span>
## Managing your SDK applications
Once you have created an SDK application, you can perform the following task as needed in the **Actions** column:

* To modify your application name, click **Edit**.
* To delete an SDK application,  click **Delete**. Be careful when you delete an application because an application cannot be recovered once deleted.

App-type applications can also perform the following operations.

* To upgrade your trial license to a basic or premium, click **Upgrade** and follow the instructions on the screen to complete the task.
* To delete an SDK application, click the three dots icon in the **Actions** column and then click **Delete**. Be careful when you delete an application because an application cannot be recovered once deleted.

<span id="ececc6b2"></span>
## Getting your SDK license
Once your SDK application is created and your license is activated, you can access the license through the console. The license is bound to the Android package name and iOS bundle ID that you specify when creating the SDK application, and you can use the license only in the corresponding apps.

1. Log in to the [BytePlus MediaLive console](https://console.byteplus.com/live).
2. In the left-side navigation pane, click **SDK management**.
3. Find the target application and click the ⬇ icon to download the license file.
   ![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/7096efd30a86427d85dadb7a166963f9~tplv-goo7wpa0wc-image.image =864x)

<span id="d4231600"></span>
## What to do next
You can start integrating the SDK after completing the steps described in this topic. Refer to the following to integrate BytePlus MediaLive client SDKs:

* [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android)
* [Integrating the SDK for iOS](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-ios)
* [Integrating the Player SDK for Web](/docs/byteplus-media-live/docs-integrating-the-player-sdk-for-web_1)

<span id="1031beb5"></span>
## FAQ
<span id="64d9f14e"></span>
### After the license renewal, is it necessary to release a new version of the App? 
Yes. After the license renewal, the license file will change, but the license ID remains the same. You need to download the new license file, replace the old license file in the current App version, and then release a new version according to the recent iteration plan. 
The license in the historical version of the App will be updated automatically. When the license is renewed, the live streaming SDK will detect the change in the license file and automatically update the valid duration of the license.
<span id="c4aa450f"></span>
### Is it necessary to update the live streaming SDK after replacing the license file? 
No. 
This page introduces how you can manage live, ended, and disabled streams.
<span id="Prerequisite"></span>
## Prerequisites
The StreamName and AppName you want to query.
<span id="Procedure"></span>
## Procedure

1. Log in to the [BytePlus MediaLive console](https://console.byteplus.com/live).
2. In the left-side navigation pane, click **Live management** > **Streams**.
3. Select the type of stream you want to search by clicking the corresponding tab at the top of the page.
   * **Live streams**: Displays ongoing streams.
   * **Stream history**: Displays ended streams.
   * **Disabled streams**: Displays disabled streams.
4. Fill in the AppName and StreamName, select the query time range and stream source as needed, and then click **Search** to view the stream list.
   * To view streams pulled from third-party CDN, select **Pulled from origin** as the stream configuration.
   * Otherwise, select **Live stream** as the stream configuration.

<span id="Live streams"></span>
### Live streams
Displays the domain names, status, and stream source of ongoing streams. In the **Actions** column, select the operation you want to perform:

* Click **Live address** to view the push streaming address and generate pull streaming addresses.
* Click **Stream data** to view push streaming data. For details, refer to [Stream data query](https://docs.byteplus.com/en/byteplus-media-live/docs/querying-stream-data).
* Click **Views statistic** to see the number of online viewers. For details, refer to [Analytic](https://docs.byteplus.com/en/byteplus-media-live/docs/statistical-analysis).
* Click **Stop streaming** to stop push streaming.
* Click **Disable** to disable push streaming. You can find disabled streams in the **Disabled streams** tab.

<span id="Stream history"></span>
### Stream history
Displays the domain names, stream source, and end time of streams in the last 30 days. In the **Actions** column, select the operation you want to perform:

* Click **Stream data** to view push streaming data. For details, refer to [Stream data query](https://docs.byteplus.com/en/byteplus-media-live/docs/querying-stream-data).
* Click **Views statistic** to see the number of online viewers. For details, refer to [Analytic](https://docs.byteplus.com/en/byteplus-media-live/docs/statistical-analysis).
* Click **Live address** to view the push streaming address and generate pull streaming addresses.
* Click **Disable** to disable push streaming. You can find disabled streams in the **Disabled streams** tab.

<span id="Disabled streams"></span>
### Disabled streams
Displays the domain names and status of live streams. In the **Actions** column, select the operation you want to perform:

* Click **Enable** to enable push streaming. You can find enabled streams in the **Live streams** tab.
* Click **Stream data** to view push streaming data. For details, refer to [Stream data query](https://docs.byteplus.com/en/byteplus-media-live/docs/querying-stream-data).
* Click **Views statistic** to see the number of online viewers. For details, refer to [Analytic](https://docs.byteplus.com/en/byteplus-media-live/docs/statistical-analysis).


BytePlus MediaLive provides the Broadcast SDK and the Player SDK for Android, iOS, React Native, and Flutter.
BytePlus MediaLive presents two editions of the Player SDK:

* **Standard**: Suitable for live streaming scenarios such as sports events, entertainment, e-commerce, and education.
* **Premium**: Besides the features provided by the **Standard** edition, the **Premium** edition supports the ultra-low latency live streaming feature, known as [Real Time Media (RTM)](https://docs.byteplus.com/en/byteplus-media-live/docs/introduction-to-real-time-media), as well as playing CMAF streams.

:::tip
React Native and Flutter only support the **Premium** edition.
:::
<span id="2a8ebace"></span>
## Features
BytePlus MediaLive SDK consists of Broadcast SDK and Player SDK. The features supported by Broadcast SDK and Player SDK are as follows.
<span id="cab58b66"></span>
### Broadcast SDK

| || | | | \
|Feature | |<div style="width: 100px">Description</div> |Android & iOS |React Native |
|---|---|---|---|---|
| | | | | | \
|Push streaming protocol |\
| |RTMP |Supports stream pushing with the RTMP protocol, providing reliable connections. |Supported |\
| | | | |Supported |
|^^| | | | | \
| |RTMPS |Supports stream pushing with the RTMPS protocol, utilizing TLS/SSL encryption technology to protect audio and video content from unauthorized access and data leakage. |Supported |\
| | | | |Supported |
|^^| | | | | \
| |RTMP over QUIC |Supports QUIC-accelerated stream pushing based on the RTMP protocol, offering fast connections and improved network adaptability, making it suitable for scenarios with higher real-time requirements. |Supported |Supported |
|^^| | | | | \
| |Push the stream using multiple URLs |Using multiple URLs to push the stream allows automatic switching to the next URL to continue streaming if the current URL fails, thereby improving the stability and reliability of stream pushing. |Supported |Supported |\
| | | | | |
| | | | | | \
|Video capturing and recording |Video encoding parameter control |Supports configuring information for video capture, such as resolution, encoding format, frame rate, bitrate, and video GOP size. |Supported |Supported |
|^^| | | | | \
| |Orientation |Supports starting streaming in landscape or portrait mode. |Supported |Supported |
|^^| | | | | \
| |Front and rear camera capture |Supports capturing from the phone's front and rear cameras. |Supported |Supported |
|^^| | | | | \
| |Screen capture |Supports capturing the phone screen as a source, suitable for scenarios such as game streaming and mobile app demonstrations. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Flashlight |Supports turning the flashlight on or off. |Supported |Not supported |
|^^| | | | | \
| |Exposure |\
| | |Supports setting the exposure point and exposure compensation for the camera currently in use. |Supported |Not supported |
|^^| | | | | \
| |Camera switch |Supports switching between front and rear cameras. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Camera zoom |Supports camera zoom. |Supported |Not supported |
|^^| | | | | \
| |Auto and manual focus |Supports enabling or disabling autofocus, and setting manual focus points. |Supported |Not supported |
|^^| | | | | \
| |Local camera preview view |Supports setting the local camera preview view. The captured image, after applying effects such as beauty AR and filters, will be displayed in the preview view. |\
| | |Also supports setting the fill mode for the local camera preview view. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Mirroring |\
| | |Supports configuring capture mirroring, local preview mirroring, and streaming mirroring. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Watermark |Supports adding semi-transparent watermarks. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |External video capture |Supports inputting external video sources. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Video mixing |Besides the primary video input source, the live pusher supports adding multiple video input sources. The live pusher automatically merges all input sources into a single view before sending it to the encoding module. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Image streaming |\
| | |Supports using images as video sources, which is suitable when the app enters the background or the network connection is poor. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Last frame or black frame of a video |Push the stream with the last frame or black frame of the video. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Custom video processing |Supports custom processing of video data captured by the SDK. |Supported |Not supported |
|^^| | | | | \
| |Filters, beauty AR, style makeup, and stickers |Supports filters, beauty AR, and stickers, and allows designing makeup based on specific styles. |\
| | |:::tip |\
| | |This is an additional capability requiring a separate purchase of the Effects SDK. Contact BytePlus MediaLive [technical support](https://console.byteplus.com/workorder/create) to get the Effects SDK. |\
| | |::: |\
| | | |Supported |Supported |\
| | | | | |
| | | | | | \
|Audio capturing and recording |Audio encoding parameter control |Supports configuring audio sampling rate and channel count. |Supported |\
| | | |:::tip |\
| | | |* The audio sampling rate for iOS is currently fixed at 44.1 kHz, which is suitable for most audio processing scenarios and is the standard sampling rate for music CDs. |\
| | | |* Currently, iOS only supports stereo channels. |\
| | | |::: |\
| | | | |Supported |\
| | | | |:::tip |\
| | | | |* The audio sampling rate for iOS is currently fixed at 44.1 kHz, which is suitable for most audio processing scenarios and is the standard sampling rate for music CDs. |\
| | | | |* Currently, iOS only supports stereo channels. |\
| | | | |::: |
|^^| | | | | \
| |Microphone capture |Supports capturing audio from the phone's microphone. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Silent audio frame |Supports silent capture without actually enabling the device's audio capture capability. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Audio loudness |Supports adjusting audio loudness, for example, increasing loudness in noisy environments for clearer sound or decreasing loudness in quiet environments to avoid harshness. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Volume |Supports setting background music volume and host voice volume. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |In-ear monitor |During the live stream, the host can use headphones to monitor their own voice in real time. Particularly when singing, the in-ear monitor (IEM) feature allows the host to hear the sound effects as the audience does, which is crucial for accurately maintaining pitch. Due to differences between network transmission and airborne sound, the IEM feature helps the host better manage their performance, reduce latency issues, and quickly address any audio shortcomings, thereby optimizing the overall live streaming experience. |* iOS: Supported |\
| | | |* Android: Not supported |Not supported |
|^^| | | | | \
| |Mute |Supports muted streaming. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Get mute status |Supports getting whether the current status is muted. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Background music |Supports adding background music during stream pushing, and offers features such as loop playback, start, pause, resume, and stop playback. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Audio noise reduction |Reduces or eliminates background noise in audio through technical means to improve sound quality and listening experience. This is commonly used to filter out ambient noise, such as wind, traffic noise, or other unwanted sound interferences. It helps ensure clarity of sound, allowing the audience to focus more on the main audio content. |* iOS: Not supported |\
| | | |* Android: Supported |* iOS: Not supported |\
| | | | |* Android: Supported |
|^^| | | | | \
| |Custom audio processing |Supports custom processing of audio data captured by the SDK. |Supported |Not supported |
|^^| | | | | \
| |External audio capture |Supports inputting external audio sources. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Audio mixing |Besides the primary audio stream, the live pusher supports adding multiple audio input sources. The live pusher automatically mixes all audio streams before sending them to the encoding module, while it also supports local playback of the mixed audio. |Supported |Not supported |
| | | | | | \
|Video encoding |\
| |H.264 hardware encoding |Supports H.264 hardware encoding. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |H.264 software encoding |Supports H.264 software encoding. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |H.265 hardware encoding |Supports H.265 hardware encoding. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |H.265 software encoding |Supports H.265 software encoding. |\
| | | |Supported |Supported |\
| | | | | |
| | | | | | \
|Stream pushing |Automatic reconnection |Supports automatic reconnection after stream pushing fails. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |SEI message transmission |Supplemental Enhancement Information (SEI) packages text information with audio and video content through the streaming channel, sent from the host side (stream pushing end) and received at the audience side (stream pulling end), achieving precise synchronization of text data with audio and video content. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Background mode |During the live stream, the host can continue pushing the stream when the app enters the background. Background mode offers the following types of streaming: last frame, black frame, and image. |Supported |\
| | | |:::tip |\
| | | |For Android, the background mode also supports camera streaming. |\
| | | |::: |Supported |\
| | | | |:::tip |\
| | | | |For Android, the background mode also supports camera streaming. |\
| | | | |::: |
|^^| | | | | \
| |Dynamic screen orientation switch |During the live stream, the host can switch between landscape and portrait modes on their phone at any time. The screen orientation automatically adapts without interrupting the live stream. |* iOS: Supported |\
| | | |* Android: Not supported |\
| | | | |\
| | | | |Not supported |
|^^| | | | | \
| |Adaptive Bitrate (ABR) streaming |\
| | |Supports automatically adjusting the streaming bitrate based on network conditions, with multiple mode settings for smoother streaming. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Adjust resolution in real time |\
| | |Supports adjusting the streaming resolution in real time during the live stream.  |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Streaming screen fill mode |Supports adjusting the fill mode of the streaming screen. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Screen recording and streaming |\
| | |By using screen recording and streaming, the host can push the content on their phone to the server in real time, allowing the audience to see the host's screen operations or game visuals. This is commonly used in scenarios such as game broadcasting and mobile app demos.  |Supported |* iOS: Not supported |\
| | | | |* Android: Supported |
|^^| | | | | \
| |Screenshots |During the live stream, the host can take screenshots of exciting live moments and save them on their phone. |Supported |Not supported |
|^^| | | | | \
| |Recording |During the live stream, the host can record exciting live moments and save them on their phone. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Interactive live streaming |Supports audience co-hosting and host PK battles. |\
| | |:::tip |\
| | |This is an additional capability requiring [enabling the RTC service](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-69865) and integrating the RTC SDK. |\
| | |::: |\
| | | |Supported |Not supported |
| | | | | | \
|Additional features |Configure event listeners |\
| | |By configuring event listeners, you can get data such as streaming errors, status, network quality, and first frame of the live pusher, as well as audio and video data. |Supported |Supported |\
| | | | | |
|^^| | | | | \
| |Subscribe to audio and video data |By subscribing to audio and video data, you can save the audio and video data before encoding, as well as the captured audio and video data. |Supported |Not supported |

<span id="b1681aaf"></span>
### Player SDK

| || | | | | \
|Feature | |<div style="width: 100px">Description</div> |Android & iOS |\
| | | | |Flutter |React Native |
|---|---|---|---|---|---|
| | | | | | | \
|Playback format |\
| |FLV |Supports playing FLV streams. |Supported |Supported |Supported |
|^^| | | | | | \
| |HLS |Supports playing HLS streams. |Supported |Supported |Supported |
|^^| | | | | | \
| |RTM |\
| | |Supports playing RTM streams. |\
| | |:::tip |\
| | |Pure audio or pure video streams are not supported. |\
| | |::: |\
| | | |Only supported by the **Premium** edition |Supported |Supported |
|^^| | | | | | \
| |RTMP |Supports playing RTMP streams. |Supported |Supported |Supported |
|^^| | | | | | \
| |CMAF |Supports playing CMAF streams. |\
| | | |* iOS: Not supported |\
| | | |* Android: Supported |* iOS: Not supported |\
| | | | |* Android: Supported |* iOS: Not supported |\
| | | | | |* Android: Supported |
| | | | | | | \
|Transmission protocol |\
| |TCP |Supports TCP protocol. |Supported |Supported |Supported |
|^^| | | | | | \
| |QUIC |Supports QUIC protocol. |Supported |Supported |Supported |
|^^| | | | | | \
| |TLS |Supports TLS protocol. |Supported |Supported |Supported |
|^^| | | | | | \
| |HTTP 2.0 |Supports HTTP 2.0 protocol. |\
| | |:::tip |\
| | |RTM streams are not supported.  |\
| | |::: |Supported |Supported |Supported |
|^^| | | | | | \
| |HTTP header |Supports custom HTTP headers when requesting video resources.  |Supported |Not supported |Supported |
| | | | | | | \
|Video decoding |H.264 hardware decoding |Supports H.264 hardware decoding. |Supported |Supported |Supported |
|^^| | | | | | \
| |H.264 software decoding |Supports H.264 software decoding. |Supported |Supported |Supported |
|^^| | | | | | \
| |H.265 hardware decoding |\
| | |Supports H.265 hardware decoding. |Supported |Supported |Supported |
|^^| | | | | | \
| |H.265 software decoding |Supports H.265 software decoding. |Supported |Supported |Supported |
|^^| | | | | | \
| |H.265 downgrade |The system automatically implements a downgrade strategy if H.265 hardware decoding fails. The system automatically switches to playing an H.264 backup stream if the H.264 backup stream is set. The system attempts to play using H.265 software decoding if no H.264 backup stream is set. |Supported |Supported |Supported |
|^^| | | | | | \
| |AAC-HE |Supports AAC-HE audio encoding format. |Supported |Supported |Supported |
|^^| | | | | | \
| |AAC-LC |Supports AAC-LC audio encoding format. |Supported |Supported |Supported |
| | | | | | | \
|Playback control |Start and stop playback |Supports starting or stopping playback. |Supported |Supported |Supported |
|^^| | | | | | \
| |Pause and resume playback |Supports pausing or resuming playback. |Supported |Supported |Supported |
|^^| | | | | | \
| |Get current playback status |Supports getting the current playback status. |Supported |Supported |Supported |
|^^| | | | | | \
| |Manual quality switch |Supports manual switching between different quality levels. |Supported |Not supported |Supported |
|^^| | | | | | \
| |Set player buffer time |The player pre-downloads a certain amount of data to ensure continuity and smoothness of playback. The longer the buffer time, the better the player can maintain uninterrupted video or audio playback during network fluctuations or latency. |\
| | |:::tip |\
| | |To implement this feature, contact BytePlus MediaLive [technical support](https://console.byteplus.com/workorder/create). |\
| | |::: |Supported |Not supported |Supported |
| | | | | | | \
|Video effects |Configure rendering view |Configure the rendering view to display the video screen of the player. |Supported |Supported |Supported |
|^^| | | | | | \
| |Screen fill mode |Supports adjusting the fill mode of the playback screen. |Supported |Supported |Supported |
|^^| | | | | | \
| |Screen rotation angle |Supports configuring the rotation angle of the playback screen, allowing clockwise rotation at 0°, 90°, 180°, and 270°. |Supported |Supported |Supported |
|^^| | | | | | \
| |Mirroring |Supports configuring the mirroring mode of the playback screen, such as horizontal and vertical mirroring. |Supported |Not supported |Supported |
|^^| | | | | | \
| |Picture-in-Picture (PiP) playback |\
| | |By minimizing the player window and placing it in a corner of the interface, the audience can browse other content or open other apps while watching the live stream, enhancing user experience. |\
| | |:::tip |\
| | |To implement this feature, contact BytePlus MediaLive [technical support](https://console.byteplus.com/workorder/create). |\
| | |::: |Supported |Not supported |Supported |
|^^| | | | | | \
| |SDR (Standard Dynamic Range) video playback |Supports the playback of SDR video. |Supported |Supported |Supported |
|^^| | | | | | \
| |Super-resolution (SR) |Super-resolution refers to the process of reconstructing high-resolution images from observed low-resolution ones. Real-time mobile super-resolution utilizes algorithmic techniques to reconstruct low-resolution frames in real time on the device, producing high-resolution frames displayed on the screen. This improves the detail and contrast of video content, optimizing the overall clarity and viewing experience. |Supported |Not supported |Supported |
|^^| | | | | | \
| |Video sharpening |Video sharpening is an image processing technique used to enhance the clarity and detail of video images. Through sharpening, the edges and details within the video become more pronounced, making the visuals appear clearer and more vivid. |Supported |Not supported |Supported |
| | | | | | | \
|Audio effects |\
| |Volume adjustment |Supports adjusting the playback volume. |Supported |Supported |Supported |
|^^| | | | | | \
| |Mute |Supports muted playback. |Supported |Supported |Supported |
|^^| | | | | | \
| |Get mute status |Supports getting the current mute status. |Supported |Supported |Supported |
|^^| | | | | | \
| |Background audio playback |Allows audio to continue playing when the app switches to the background. |Supported |Supported |Supported |
|^^| | | | | | \
| |Pure audio playback |Supports playing pure audio. |\
| | |:::tip |\
| | |Applicable only to FLV streams. |\
| | |::: |Supported |Supported |Supported |
|^^| | | | | | \
| |Stereo audio |Supports playing stereo audio. |Supported |Supported |Supported |
| | | | | | | \
|Playback strategy |Retry on playback failure |If the live stream is interrupted due to network issues or other problems, the player attempts to retry. |Supported |Supported |Supported |
|^^| | | | | | \
| |Local DNS pre-resolution |\
| | |Enabling local DNS pre-resolution can optimize the player's startup time. |Supported |Supported |Supported |
|^^| | | | | | \
| |Configure one or more playback addresses |Supports configuring one or more playback addresses. By configuring multiple playback addresses, features that rely on multiple streams, such as ABR streaming and primary-backup stream switching, can be achieved. |Supported |Supported |Supported |
|^^| | | | | | \
| |ABR streaming |ABR is a streaming technology that uses a series of algorithmic strategies to dynamically switch between different quality media streams. This adaptation to network bandwidth changes helps prevent stuttering during the live stream and enhances both playback quality and viewing experience. |\
| | |:::tip |\
| | |Applicable only to FLV streams. |\
| | |::: |\
| | | |Supported |Supported |Supported |
|^^| | | | | | \
| |IP address streaming |Supports streaming by setting the IP address of the playback domain to reduce the time to the first frame. |Supported |Not supported |Supported |
|^^| | | | | | \
| |Primary-Backup stream switch |If the primary stream address fails or encounters playback errors, the player automatically switches to the backup stream address. If the backup stream address fails or encounters playback errors, the player switches back to the primary stream address. |Supported |Supported |Supported |
|^^| | | | | | \
| |Multiple instances |Supports adding multiple players to one interface for simultaneous playback. |Supported |Supported |Supported |
|^^| | | | | | \
| |Dynamic frame chasing |\
| | |During the live stream, video streams may experience latency or stuttering due to network fluctuations or other factors. Dynamic frame chasing technology adjusts the playback speed of frames or skips certain frames to catch up with real-time live streaming, reducing latency. |Supported |Supported |Supported |
|^^| | | | | | \
| |Instant playback optimization |Reduces the time to first frame to achieve instant playback. |\
| | |:::tip |\
| | |To implement this feature, contact BytePlus MediaLive [technical support](https://console.byteplus.com/workorder/create). |\
| | |::: |Supported |Not supported |Supported |
| | | | | | | \
|Additional features |Screenshots |Supports capturing the current live-stream image within the player and generating an image. |Supported |Not supported |Supported |
|^^| | | | | | \
| |SEI message reception |SEI packages text information with audio and video content through the streaming channel, sent from the host side (stream pushing end) and received at the audience side (stream pulling end), achieving precise synchronization of text data with audio and video content. |Supported |Supported |Supported |
|^^| | | | | | \
| |Configure event listeners |By configuring event listeners, you can get internal status information of the player, including playback status, error information, audio/video first-frame callbacks, and periodic statistical data. |Supported |Supported |Supported |
|^^| | | | | | \
| |Subscribe to audio and video data |By subscribing to decoded audio and video data, you can get audio and video frame data for custom processing and rendering operations. |Supported |Not supported |Not supported |
| | | | | | | \
|Video security |Commercial DRM (Digital Rights Management)  |Supports playing DRM encrypted streams on iOS platforms. |Supported |Not supported |Not supported |
| | | | | | | \
|Quality assurance |Log reporting |Supports reporting SDK logs, and collecting and analyzing playback tracking data related to audio and video live streaming. |Supported |Supported |Supported |

<span id="db2409b9"></span>
## Using the SDKs
The following table lists the topics you may find useful while integrating each SDK:

| | | | \
|**SDK** |**Platform** |**Topics** |
|---|---|---|
| | | | \
|Broadcast SDK |Android |* [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android) |\
| | |* [Initializing for Android](/docs/byteplus-media-live/docs-initializing-for-android) |\
| | |* [Broadcast SDK for Android: Basic features](/docs/byteplus-media-live/docs-implementing-basic-features) |\
| | |* [Broadcast SDK for Android: Advanced features](/docs/byteplus-media-live/docs-implementing-advanced-features) |\
| | |* [Broadcast SDK for Android: Overview](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api-overview) |
|^^| | | \
| |iOS |* [Integrating the SDK for iOS](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-ios) |\
| | |* [Initializing for iOS](/docs/byteplus-media-live/docs-initializing-for-ios) |\
| | |* [Broadcast SDK for iOS: Basic features](/docs/byteplus-media-live/docs-implementing-basic-features-1) |\
| | |* [Broadcast SDK for iOS: Advanced features](/docs/byteplus-media-live/docs-implementing-advanced-features-1) |\
| | |* [Broadcast SDK for iOS: Overview](/docs/byteplus-media-live/docs-broadcast-sdk-for-ios-api-overview) |
|^^| | | \
| |React Native |* [Integrating the SDK for React Native](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-rn) |\
| | |* [Initializing for React Native](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-initializing-for-rn) |\
| | |* [Broadcast SDK for React Native: Basic features](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-rnbroadcast-basic-features) |\
| | |* [Broadcast SDK for React Native: Advanced features](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-rnbroadcast-advanced-features) |\
| | |* [Broadcast SDK for React Native: Overview](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-broadcast-sdk-for-rn-api-overview) |
| | | | \
|Player SDK |Android |* [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android) |\
| | |* [Initializing for Android](/docs/byteplus-media-live/docs-initializing-for-android) |\
| | |* [Player SDK for Android: Basic features](/docs/byteplus-media-live/docs-implementing-basic-features-2) |\
| | |* [Player SDK for Android: Advanced features](/docs/byteplus-media-live/docs-implementing-advanced-features-2) |\
| | |* [Player SDK for Android: Overview](/docs/byteplus-media-live/docs-player-android-api-overview) |
|^^| | | \
| |iOS |* [Integrating the SDK for iOS](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-ios) |\
| | |* [Initializing for iOS](/docs/byteplus-media-live/docs-initializing-for-ios) |\
| | |* [Player SDK for iOS: Basic features](/docs/byteplus-media-live/docs-implementing-basic-features-3) |\
| | |* [Player SDK for iOS: Advanced features](/docs/byteplus-media-live/docs-implementing-advanced-features-3) |\
| | |* [Player SDK for iOS: Overview](/docs/byteplus-media-live/docs-player-sdk-for-ios-api-overview) |
|^^| | | \
| |React Native |* [Integrating the SDK for React Native](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-rn) |\
| | |* [Initializing for React Native](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-initializing-for-rn) |\
| | |* [Player SDK for React Native: Basic features](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-rnplayer-basic-features) |\
| | |* [Player SDK for React Native: Advanced features](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-rnplayer-advanced-features) |\
| | |* [Player SDK for React Native: Overview](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-player-sdk-for-rn-api-overview) |
|^^| | | \
| |Flutter |* [Integrating the Player SDK for Flutter](/docs/byteplus-media-live/integrating-the-player-sdk-for-flutter) |\
| | |* [Initializing the Player SDK for Flutter](/docs/byteplus-media-live/initializing-the-player-sdk-for-flutter) |\
| | |* [Player SDK for Flutter: Basic features](/docs/byteplus-media-live/player-sdk-for-flutter-basic-features) |\
| | |* [Player SDK for Flutter: Advanced features](/docs/byteplus-media-live/player-sdk-for-flutter-advanced-features) |

<span id="f202fd8c"></span>
## Glossary
For explanations of the terminologies related to the SDKs, refer to [Glossary](https://docs.byteplus.com/byteplus-media-live/docs/glossary).

<span id="f157007f"></span>
## High stability
The native SDKs have an excellent track record of serving hundreds of millions of daily active users (DAUs) with a crash rate of less than 0.001%.
<span id="64bb3a6f"></span>
## Continuous optimization of user experience
After years of continuous optimization, the native SDKs have achieved industry-leading levels in both technical and user experience indicators.
<span id="a7ae5437"></span>
## Easy to integrate
You can integrate the native SDKs both automatically or manually. Several demos are available to assist you in efficiently implementing your unique business logic.
<span id="3a65bf9c"></span>
## Extensibility
You can integrate the native SDKs along with the Real-time Communication (RTC) SDK, Effects SDK, and Video Editor SDK to have extended features such as co-hosting, beauty AR, and special effects.
<span id="6af74d52"></span>
## Hardware encoding and decoding
We continuously optimize the support for hardware encoding and decoding on medium and low-end mobile devices. These enhancements have resulted in improved performance of the native SDKs, as well as reduced encoding and decoding times.
<span id="38ca4480"></span>
## Network monitoring capability
TTNET provides network monitoring and app acceleration services, which optimize the mobile network environment and provide a platform for data display.

BytePlus MediaLive VeLiveQuickStartDemo is designed to help you get started with developing a mobile app using the BytePlus MediaLive SDKs for Android and iOS. With simple UI design, it allows you to quickly understand the core code logic for implementing the key features offered by the SDKs.
VeLiveQuickStartDemo contains three types of features:

* Basic features, including push-pull streaming.
* Advanced features, including:
   * Adaptive bitrate
   * Pushing external audio and video sources
   * H.265 hardware encoding
   * Picture-in-Picture (PiP)
* Interactive live features, including co-hosting with audience members and host PK battle.

This article provides a comprehensive guide on how to run VeLiveQuickStartDemo for Android.
<span id="e42b27e5"></span>
## System requirements

* Android 5.0 (SDK API Level 21) or higher
* Android Studio 4.0 or higher
* A physical Android device running Android 5.0 or higher
* Ensure the CPU architecture that you use is armeabi-v7a or arm64-v8a

<span id="d1ed29bd"></span>
## Prerequisites
Complete the following tasks before you start:

* Sign up for a BytePlus account. For detailed instructions, refer to [Sign Up and Verify BytePlus account](https://docs.byteplus.com/en/docs/byteplus-platform/docs-signing-up-your-account).
* Activate the BytePlus MediaLive service and add domain names for push-pull streaming through the console. Refer to [Getting started with BytePlus MediaLive](/docs/byteplus-media-live/docs-getting-started) for detailed instructions.
* If you want to experience interactive live features, you also need to enable the BytePlus RTC service. You can find detailed instructions in [enable RTC service](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-69865).

<span id="8c0e37b0"></span>
## Preparations
You need to prepare an SDK license, an App ID, and token information before you run the demo.
<span id="0706aa76"></span>
### **Downloading a MediaLive license**
Follow the instructions in [SDK management](/docs/byteplus-media-live/docs-sdk-management) to create an SDK application and then download the corresponding SDK license. Note down the App ID and package name as you will need them in future steps.
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/ab6a8e0a0518458bbc61967cbc9e88cb~tplv-goo7wpa0wc-image.image =864x)
<span id="9ae537a8"></span>
### **Acquiring an RTC App ID and  App Key**
:::tip
If you do not want to experience interactive live features, you can skip this section.
:::

1. Log in to the [BytePlus RTC console.](https://console.byteplus.com/rtc/workplaceRTC)
2. In the left navigation pane, click **Application Management**.
3. Click **Create an App** and enter your app name in the dialog box that opens. Leave the **Affiliated project** field at the default value.
4. Click **OK** to save the settings.
5. Locate your application in the application list and take note of your App ID and App Key.
   ![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/b565075eda70420d85d70cc7cc950223~tplv-goo7wpa0wc-image.image =864x)

<span id="b01ced66"></span>
## Running the demo
This section introduces the detailed steps for setting up and running the demo.
<span id="30f72781"></span>
### Downloading the source code

1. Go to GitHub and clone the [VeLiveQuickStartDemo](https://github.com/byteplus-sdk/VeLiveQuickStartDemo.git) repository.
2. The directory tree of the demo is as follows:

```Plain
Android/VeLiveQuickStartDemo/app/src/main/java/com/ttsdk/quickstart
├── app // Entry point of the demo app
├── features // Features
│   ├── basic // Basic features
│   │   ├── PullStreamActivity.java // pull streaming
│   │   └── PushCameraActivity.java // Video capture and push streaming
│   ├── advanced // Advanced features
│   │   ├── PictureInPictureActivity.java // Picture-in-Picture
│   │   ├── PushAutoBitrateActivity.java // Adaptive bitrate
│   │   ├── PushBeautyActivity.java // Beauty AR and special effects
│   │   ├── PushCustomActivity.java // Pushing external audio and video sources
│   │   ├── PushH265CodecActivity.java // H.265 hardware encoding
│   │   └── PullRTMActivity.java // Pulling an RTM stream
│   └── interact // Interactive live features
│       ├── link // Co-hosting with audience members
│       ├── manager // Common host and audience activities
│       └── pk // Host PK battle
└── helper // Utilities, such as SDK initialization and external video capture
```

<span id="743d56e6"></span>
### Integrating the SDK license

1. Rename the MediaLive SDK license you have downloaded as `ttsdk.lic`.
2. Replace the original `ttsdk.lic` file in the `Android/VeLiveQuickStartDemo/app/src/main/assets/`directory with your own SDK license.

<span id="e7a73684"></span>
### Gradle sync

1. Open `Android/VeLiveQuickStartDemo` in Android Studio.
2. Click **Sync Project with Gradle Files** to sync the project with the Gradle files.

<span id="77e37fbf"></span>
### Configuring push-pull streaming

1. In Android Studio, navigate to `app/src/main/java/com.ttsdk.quickstart/helper` and open the `VeLiveSDKHelper.java` file.
2. Enter the App ID, License file name,domain name space, push-pull streaming domain name, and app name for live streaming. 
   ```Java
   // The App ID
   public static String TTSDK_APP_ID = "536110";
   
   // License File Name. If you replace the License File, you need to modify the file name here. If you want to do a quick SDK verification, you can directly replace the content of the original License File (ttsdk.lic).
   public static String TTSDK_LICENSE_NAME = "ttsdk.lic";
   
   // Configure the AccessKey ID and AccessKey secret, which are used for API request authentication.
   public static String ACCESS_KEY_ID = "";
   public static String SECRET_ACCESS_KEY = "";
   
   // The Domain name space
   public static String LIVE_VHOST = "push.example.com";
       
   /* 
   * Example of push-pull streaming address composition: https://{Domain}/{AppName}/{StreamName}.flv
   * Configure the AppName used in the push-pull streaming address, which supports uppercase and lowercase letters, numbers, underscores, and hyphens, with a maximum length of 30 characters. Here is an example: live
   */
   public static String LIVE_APP_NAME = "live";
   
   // Configure the push streaming domain name
   public static String LIVE_PUSH_DOMAIN = "push.example.com";
   
   // Configure the pull streaming domain name
   public static String LIVE_PULL_DOMAIN = "pull.example.com";
   ```


<span id="5609c16c"></span>
### Configuring co-hosting and host PK battle

1. In Android Studio, open the `app/src/main/java/com.ttsdk.quickstart/helper/VeLiveSDKHelper.java` file.
2. Enter the RTC App ID and App Key.
   ```Java
   // The RTC App ID
   public static String RTC_APPID ="";   
   // The RTC App Key
   public static String RTC_APPKEY ="";    
   ```


<span id="3c9d8600"></span>
### Configuring the package name

1. In Android Studio, open the `app/build.gradle` file.
2. Set `applicationId` to the package name you used when creating your SDK application in the [Downloading a MediaLive license](/docs/byteplus-media-live/docs-running-the-quickstartdemo-for-android#0706aa76) section.

<span id="67945fc7"></span>
### Compiling the demo

1. Connect the physical Android device you have prepared in the [Prerequisites](/docs/byteplus-media-live/docs-running-the-quickstartdemo-for-android#d1ed29bd) section to your computer, and set it as the target device in Android Studio.
2. Click the **Run** button to initiate the compilation process.

If the compilation process completes without any errors, the demo app will be installed on the connected mobile device.

This topic introduces how to integrate BytePlus MediaLive Broadcast or Player SDK into your Android project.
<span id="4c323730"></span>
## System requirements

* Android 4.3 or higher
* CPU architecture: armv7a or arm64

<span id="Prerequisites"></span>
## Prerequisites
Make sure that you have obtained an SDK license. For more information on how to get the license, see [Getting your SDK license](/docs/byteplus-media-live/docs-sdk-management#ececc6b2).
<span id="Integrating the SDK"></span>
## Integrating the SDK
You can integrate the SDK through one of the following methods:

* Automatic integration (recommended): Use Gradle to download the SDK package automatically.
* Manual integration: [Contact your technical support](https://console.byteplus.com/workorder/create) for assistance if you want to integrate the SDK manually.

This topic introduces how to automatically integrate the SDK into your project.
<span id="6828829a"></span>
#### **Step 1: Configure Maven Repositories**
To integrate the SDK, configure multiple Maven repositories to ensure all necessary dependencies are downloaded correctly. Follow these steps:

1. Open the `build.gradle` file in the root directory.
2. Set the primary repository URL to `https://artifact.byteplus.com/repository/public`. Here's the code snippet:
   ```Groovy
   allprojects {
       repositories {
           google()
           mavenCentral()
           maven {
               url "https://artifact.byteplus.com/repository/public" // BytePlus public Maven repo
           }
       }
   }
   ```

3. Configure additional Maven repositories for components not in the primary repository:
   * **For AGP versions below 7.1**: Add this line to the root `build.gradle`:
      ```Groovy
      apply from: 'https://ve-vos.volccdn.com/script/vevos-repo-base.gradle'
      ```

   * **For AGP 7.1 and above**: Copy the Maven configuration from `https://ve-vos.volccdn.com/script/vevos-repo-base.gradle` into the `dependencyResolutionManagement` block of `settings.gradle`.

<span id="8c111919"></span>
#### **Step 2: Configuring the environment and dependencies**

1. Open the `build.gradle` file in the main project and then complete the following configurations: 
   * Configure the CPU architecture used by the app in `defaultConfig`. Both armv7a and arm64 are supported.
   * Add the dependencies in `dependencies`.
   ```Groovy
   android {
      defaultConfig {
          ndk {
              // Set the SO library architecture to support armv7a or arm64.
              abiFilters 'armeabi-v7a', 'arm64-v8a'
           }
      }
   }
   
   dependencies {
       ......
      // Add the following dependencies to use standard features.
      implementation 'com.bytedanceapi:ttsdk-ttlivepush:x.x.x.x' // Broadcast SDK.
      implementation 'com.bytedanceapi:ttsdk-ttlivepull_standard:x.x.x.x' // Player SDK.
   }
   ```

   * To pull streams using the RTM protocol, replace `implementation 'com.bytedanceapi:ttsdk-ttlivepull_standard:x.x.x.x'` with `implementation 'com.bytedanceapi:ttsdk-ttlivepull_premium:x.x.x.x'`.
   * To pull streams using the QUIC protocol, add both `implementation 'com.bytedanceapi:ttsdk-ttquic:x.x.x.x'` and `implementation 'com.bytedanceapi:ttsdk-ttlivepull_standard:x.x.x.x'` dependencies.
   * To play CMAF streams, add both `implementation 'com.bytedanceapi:ttsdk-ttcmaf:x.x.x.x'` and `implementation 'com.bytedanceapi:ttsdk-ttlivepull_standard:x.x.x.x'` dependencies.
   :::tip
   * Replace `x.x.x.x` with the specific SDK version. We recommend that you use the latest version. For more information about the version number, see [SDK for Android release notes](/docs/byteplus-media-live/docs-native-sdk-release-notes).
   * To use the interactive live function, you need to add RTC SDK-related dependencies. Please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) and contact technical support to obtain the integration method for the adapted SDK version.
   * For the implementation of the core functions of the interactive live broadcast scene on the Android side, please refer to [Implementing interactive live for Android](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-implementing-interactive-live-for-android).
   :::
2. Click **Sync Project with Gradle Files** to synchronize the SDK. The SDK will be automatically downloaded and integrated into the project. If the integration fails, check your network connection with the JCenter repository.

<span id="Configuring application permissions"></span>
## Configuring permissions

1. Declare the permissions required by the app in the `AndroidManifest.xml` file:
   ```XML
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
   <uses-permission android:name="android.permission.INTERNET" />
   <!-- Required only when using the Broadcast SDK: -->
   <uses-permission android:name="android.permission.BLUETOOTH" />
   <!-- For Android 12 (API level 31) and above, also declare the following: -->
   <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
   ```

2. Add code for dynamically requesting permissions:
   ```XML
   private boolean checkPermission(int request) {
           String permissions[] = new String[]{
                   Manifest.permission.CAMERA,
                   Manifest.permission.RECORD_AUDIO,
                   Manifest.permission.MODIFY_AUDIO_SETTINGS,
                   Manifest.permission.ACCESS_NETWORK_STATE
           };
           List<String> permissionList = new ArrayList<>();
           for (String permission : permissions) {
               boolean granted = ContextCompat.checkSelfPermission(this, permission) == PackageManager.PERMISSION_GRANTED;
               if (granted) continue;
               permissionList.add(permission);
           }
           if (permissionList.isEmpty()) return true;
   
           String permissionsToGrant[] = new String[permissionList.size()];
           permissionList.toArray(permissionsToGrant);
           ActivityCompat.requestPermissions(this, permissionsToGrant, request);
           return false;
   }
   ```


<span id="Adding a license"></span>
## Adding a license
Copy the license file you obtained in [Prerequisites](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android#Prerequisites) to your project directory. For example, copy the `License2_test.lic` file to the `assets` directory, as shown in the following screenshot. Take note of the directory path to the license file as you will use it when initializing the SDK.
Make sure the package name associated with the license file is the same as that of your project. Otherwise, the license authentication will fail.
![Image](https://sf16-resources.bytepluscdn.com/obj/byteplus-public-aiso/doc-center/0c295cb-file_path2.png =676x)
<span id="Implementing code obfuscation"></span>
## Implementing code obfuscation
Add the following lines to the `proguard-rules.pro` file to prevent SDK-related classes from obfuscation.
```XML
-keep class com.pandora.**{*;}
-keep class com.ss.**{*;} 
-keep class com.bytedance.**{*;}
-keep class com.pandora.ttlicense2.**{*;}
-keep class com.bytertc.**{*;} 
-keep class log.**{*;}
```

If you are integrating the RTC SDK, you also need to configure obfuscation rules for the RTC SDK. Please refer to [Obfuscating your code for Android Apps](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-78295) for details.

This topic introduces how to initialize BytePlus MediaLive Broadcast or Player SDK in your Android project. You only need to initialize the SDK once for both stream pushing and pulling.
<span id="e276cc57"></span>
## Prerequisites
You have integrated the SDK into your project by following the instructions provided in [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android).
<span id="a7180685"></span>
## Initializing the SDK
Call `Env.start` to initialize the SDK:
```Java
// Initialize the environment.
Env.start(new Config.Builder()
   .setApplicationContext(sApplicationContext)
   .setAppID("Your App ID")
   .setAppName("Your application name")
   .setAppVersion(BuildConfig.VERSION_NAME) // A valid version number should contain two or more separators, such as "1.3.2".
   .setAppChannel("Your app channel")
   .setLicenseUri("Your license URI")
   .setLicenseCallback(mLicenseCallback) // Set the license callbacks.
   .setBizType(BIZ_TYPE_LIVE) // Initialize the MediaLive SDK.
   .build());

// Enable logcat. It is recommended to enable logcat during development and disable logcat when compiling the release APK.
// LicenseManager.turnOnLogcat(true);

// License callbacks.
LicenseManager.Callback mLicenseCallback =new LicenseManager.Callback() {
        @Override
        public void onLicenseLoadSuccess(@NonNull String licenseUri, @NonNull String licenseId) {
            licenseID = licenseId; // License ID, through which you can get the license information.
        }

        @Override
        public void onLicenseLoadError(@NonNull String licenseUri, @NonNull Exception e, boolean retryAble) {
           
        }

        @Override
        public void onLicenseLoadRetry(@NonNull String licenseUri) {
           
        }

        @Override
        public void onLicenseUpdateSuccess(@NonNull String licenseUri, @NonNull String licenseId) {
          licenseID = licenseId;
        }

        @Override
        public void onLicenseUpdateError(@NonNull String licenseUri, @NonNull Exception e, boolean retryAble) {
           
        }

        @Override
        public void onLicenseUpdateRetry(@NonNull String licenseUri) {
          
        }
    };
    
// Get the license information.
License license = LicenseManager.getInstance().getLicense(licenseID); // You can get the license ID through mLicenseCallback.
if (license != null) {
    StringBuilder builder = new StringBuilder();
    builder.append("License id:" + license.getId()).append("\n")
           .append("License package:" + license.getPackageName()).append("\n")
           .append("License test:" + license.getType()).append("\n")
           .append("License version:" + license.getVersion()).append("\n");

    if (license.getModules() != null) {
        String names = "";
        for (License.Module module : license.getModules()) {
            names = "module name:" + module.getName() + ", start time:" +
            TimeUtil.format(module.getStartTime(), Times.YYYY_MM_DD_KK_MM_SS)
                    + ", expire time:" + TimeUtil.format(module.getExpireTime(), Times.YYYY_MM_DD_KK_MM_SS) + "\n";
            builder.append("License modules:" + names);
        }
    }
 }
```

The following table contains a detailed description for each parameter required for initialization:

| | | | | | \
|**Parameter** |**Required** |**Data Type** |**Description** |**Example** |
|---|---|---|---|---|
| | | | | | \
|AppID |Yes |String |App ID, which is the unique identifier of your SDK application. For details, see procedure for [creating an SDK application](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-sdk-management#creating-an-sdk-application). |`123456` |
| | | | | | \
|AppName |Yes |String |Application name, which is the name of your SDK application. For details, see procedure for [creating an SDK application](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-sdk-management#creating-an-sdk-application). |`video_demo` |
| | | | | | \
|AppVersion |Yes |String |The version number of your Android app. A valid version number should contain two or more separators, such as "1.3.2". |`1.3.2` |
| | | | | | \
|AppChannel |Yes |String |The channel through which to download the app. You can also use this parameter to distinguish between app builds for different environments, such as production, testing, and debugging. |`google_play` |
| | | | | | \
|LicenseUri |Yes |String |The local path to the license file. |`assets:///license2/license2_test.lic` |

<span id="d2590b44"></span>
## Uploading logs
By default, automatic SDK log uploading is enabled for debugging and analytical purposes. To protect confidential data, you can call `Env.openAppLog(false)` to disable log uploading before [Initializing the SDK](/docs/byteplus-media-live/docs-initializing-for-android#a7180685).

This topic introduces how to implement the basic features of the BytePlus MediaLive Broadcast SDK for Android.
<span id="1fc894d8"></span>
## Prerequisites
You have integrated and initialized the Broadcast SDK by following the instructions provided in [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android) and [Initializing for Android](/docs/byteplus-media-live/docs-initializing-for-android).
<span id="3a41955f"></span>
## Considerations
Because the Broadcast SDK uses various Android audio and video interfaces that may not function properly on simulated devices, we recommend that you use a physical device for testing.
<span id="(Optional) Configuring audio and video settings"></span>
## Configuring initial settings
Configure the initial settings for the live pusher. You can use the default settings or custom ones.

* Video settings:

```Java
// Create a VeLiveVideoCaptureConfiguration instance.
VeLiveVideoCaptureConfiguration videoCaptureConfig = new VeLiveVideoCaptureConfiguration();
// Set the width of the captured video, in pixels. The default value is 720.
videoCaptureConfig.setWidth(720);
// Set the height of the captured video, in pixels. The default value is 1,280.
videoCaptureConfig.setHeight(1280);
// Set the frame rate of the captured video, in fps. The default value is 15.
videoCaptureConfig.setFps(15);
```


* Audio settings:

```Java
// Create a VeLiveAudioCaptureConfiguration instance.
VeLiveAudioCaptureConfiguration audioCaptureConfig = new VeLiveAudioCaptureConfiguration();
// Set the sample rate. The default value is VeLiveAudioSampleRate44100.
audioCaptureConfig.setSampleRate(VeLiveAudioSampleRate44100);
// Set the number of audio channels. The default value is VeLiveAudioChannelStereo.
audioCaptureConfig.setChannel(VeLiveAudioChannelStereo);
```


* Settings of the live pusher:

```Java
// Create a VeLivePusherConfiguration instance.
VeLivePusherConfiguration config = new VeLivePusherConfiguration();
// Set the context.
config.setContext(mContext);
// The number of attempts to reconnect after the initial attempt fails. The default value is 3.
config.setReconnectCount(3);
// The time interval between each attempt to reconnect, in seconds. The default value is 5.
config.setReconnectIntervalSeconds(5);
// Configure video capture settings.
config.setVideoCaptureConfig(videoCaptureConfig);
// Configure audio capture settings.
config.setAudioCaptureConfig(audioCaptureConfig);
```

<span id="Creating the engine for stream pushing"></span>
## Creating the live pusher
After configuring the initial settings, create the live pusher as follows:
```Java
mLivePusher = config.build();
```

<span id="8abc21c1"></span>
## Setting observers
Set observers to listen for live pusher events.
```Java
// Set an observer to listen for live pusher events.
mLivePusher.setObserver(this);
// Set an observer to periodically report push streaming statistics.
mLivePusher.setStatisticsObserver(this, 3);

// Add a listener for video frames captured by the live pusher.
mLivePusher.addVideoFrameListener(this);
// Removes the listener.
mLivePusher.removeVideoFrameListener(this);

// Add a listener for audio frames captured by the live pusher.
mLivePusher.addAudioFrameListener(this);
// Remove the listener.
mLivePusher.removeAudioFrameListener(this);
```

<span id="Enabling camera preview"></span>
## Setting the camera preview
You can display the camera preview by calling [setRenderView](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setrenderview).
```Java
mLivePusher.setRenderView(findViewById(R.id.render_view));
```

<span id="dce364b1"></span>
## Configuring the mirroring setting
Configure the mirroring setting by calling [setVideoMirror](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setvideomirror). You can choose one of the following mirroring options:

* Mirror the captured video. When enabled, both the preview and the pushed video are mirrored.

```Java
mLivePusher.setVideoMirror(VeLiveVideoMirrorCapture, true);
```


* Mirror the preview. When enabled, only the preview is mirrored.

```Java
mLivePusher.setVideoMirror(VeLiveVideoMirrorPreview, true);
```


* Mirror the video before encoding. When enabled, only the pushed video is mirrored.

```Java
mLivePusher.setVideoMirror(VeLiveVideoMirrorPushStream, true);
```

<span id="Starting audio and video capture"></span>
## Starting video capture
Start video capture by calling [startVideoCapture](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-startvideocapture). You can choose one of the following capture options. If necessary, you can switch to another capture option by calling [switchVideoCapture](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-switchvideocapture).

* Capture the video with the front-facing camera.

```Java
// Start video capture.
mLivePusher.startVideoCapture(VeLiveVideoCaptureFrontCamera);
// Switch capture option.
mLivePusher.switchVideoCapture(VeLiveVideoCaptureFrontCamera);
```


* Capture the video with the rear camera.

```Java
// Start video capture.
mLivePusher.startVideoCapture(VeLiveVideoCaptureBackCamera);
// Switch capture option.
mLivePusher.switchVideoCapture(VeLiveVideoCaptureBackCamera);
```


* Capture the video with an external device or source. For details, refer to [Using an external video or audio source](/docs/byteplus-media-live/docs-implementing-advanced-features#Using an external audio and video source).

:::tip
After enabling external video capture, you must call [pushExternalVideoFrame](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-pushexternalvideoframe) to push external video data.
:::
```Java
// Start video capture.
mLivePusher.startVideoCapture(VeLiveVideoCaptureExternal);
// Switch capture option.
mLivePusher.switchVideoCapture(VeLiveVideoCaptureExternal);
```


* Use a static image as the video source. You can use this option in the entire live session or switch to it temporarily when the app is running in the background. For details, refer to [Pushing a static image](/docs/byteplus-media-live/docs-implementing-advanced-features#41c82b61).

:::tip
Before enabling this capture option, you must call [updateCustomImage](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-updatecustomimage) to update your custom image.
:::
```Java
// Start video capture.
mLivePusher.startVideoCapture(VeLiveVideoCaptureCustomImage);
// Switch capture option.
mLivePusher.switchVideoCapture(VeLiveVideoCaptureCustomImage);
```


* Use the last frame as the video source. You can use this method when the app is running in the background.

:::tip
To use this capture option, ensure that the live pusher has captured at least one video frame. In most cases, you can call [switchVideoCapture](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-switchvideocapture) to switch to this option from other capture options.
:::
```Java
mLivePusher.switchVideoCapture(VeLiveVideoCaptureLastFrame);
```


* Use a black frame as the video source. You can use this method when the app is running in the background.

```Java
// Start video capture.
mLivePusher.startVideoCapture(VeLiveVideoCaptureDummyFrame);
// Switch capture option.
mLivePusher.switchVideoCapture(VeLiveVideoCaptureDummyFrame);
```

<span id="ceb8e5a7"></span>
## Starting audio capture
Start audio capture by calling [startAudioCapture](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-startaudiocapture). You can choose one of the following capture options. If necessary, you can switch to another capture option by calling [switchAudioCapture](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-switchaudiocapture).

* Capture the audio with the default microphone.

```Java
// Start audio capture.
mLivePusher.startAudioCapture(VeLiveAudioCaptureMicrophone);
// Switch capture option.
mLivePusher.switchAudioCapture(VeLiveAudioCaptureMicrophone);
```


* Capture the audio with an external device or source. For details, refer to [Using an external video or audio source](/docs/byteplus-media-live/docs-implementing-advanced-features#Using an external audio and video source).

:::tip
After enabling external audio capture, you must call [pushExternalAudioFrame](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-pushexternalaudioframe) to push external audio data.
:::
```Java
// Start audio capture.
mLivePusher.startAudioCapture(VeLiveAudioCaptureExternal);
// Switch capture option.
mLivePusher.switchAudioCapture(VeLiveAudioCaptureExternal);
```


* Use muted frames as the audio source.

:::tip
On the audience side, this option has the same **** effect as calling [setMute](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setmute) to mute the audio. However, when using this option, the microphone will not capture any audio. In contrast, if you call [setMute](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setmute) to mute the audio, the microphone will continue to capture the audio.
:::
```Java
// Start audio capture.
mLivePusher.startAudioCapture(VeLiveAudioCaptureMuteFrame);
// Switch capture option.
mLivePusher.switchAudioCapture(VeLiveAudioCaptureMuteFrame);
```

<span id="975a0676"></span>
## Configuring video encoding parameters
Configure video encoding parameters by calling [setVideoEncoderConfiguration](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setvideoencoderconfiguration). You can call the method before or after live streaming starts. We provide optimal video encoding settings that are tailored to the resolution you have chosen. You can use the default settings or customize them according to your requirements.
```Java
VeLiveVideoEncoderConfiguration videoEncoderConfig = new VeLiveVideoEncoderConfiguration();
// Set the video resolution. The SDK provides default settings based on different video resolutions.
videoEncoderConfig.setResolution(VeLiveVideoResolution720P);
// The video codec. The default value is VeLiveVideoCodecH264.
videoEncoderConfig.setCodec(VeLiveVideoCodecH264);
// The target encoding bitrate, in Kbps.
videoEncoderConfig.setBitrate(1200);
// The minimum video encoding bitrate, in Kbps, when the adaptive bitrate (ABR) feature is enabled.
videoEncoderConfig.setMinBitrate(800);
// The maximum video encoding bitrate, in Kbps, when the adaptive bitrate (ABR) feature is enabled.
videoEncoderConfig.setMaxBitrate(1900);
// The video GOP size, in seconds. The default value is 2.
videoEncoderConfig.setGopSize(2);
// The encoded frame rate, in fps. The default value is 15.
videoEncoderConfig.setFps(15);
// Whether to enable B frames. The default value is false.
videoEncoderConfig.setEnableBFrame(false);
// Whether to enable hardware encoding. The default value is true.
videoEncoderConfig.setEnableAccelerate(true);
// Pass in the above settings to the live pusher.
mLivePusher.setVideoEncoderConfiguration(videoEncoderConfig);
```

<span id="789a1c70"></span>
## Configuring audio encoding parameters
You can use the default settings provided by the SDK or custom ones.
```Java
VeLiveAudioEncoderConfiguration audioEncoderConfig = new VeLiveAudioEncoderConfiguration();
// The audio encoding bitrate, in Kbps. The default value is 64.
audioEncoderConfig.setBitrate(64);
// The encoding sample rate. The default value is VeLiveAudioSampleRate44100.
audioEncoderConfig.setSampleRate(VeLiveAudioSampleRate44100);
// The number of audio channels. The default value is VeLiveAudioChannelStereo.
audioEncoderConfig.setChannel(VeLiveAudioChannelStereo);
// The AAC encoding format. The default value is VeLiveAudioAACProfileLC.
audioEncoderConfig.setProfile(VeLiveAudioAACProfileLC);
// Pass in the above settings to the live pusher.
mLivePusher.setAudioEncoderConfiguration(audioEncoderConfig);
```

<span id="Beauty AR and special effects"></span>
## Implementing beauty AR and special effects
You can implement beauty AR and special effects by integrating the [Effects SDK](https://www.byteplus.com/en/product/effects) into your Android project. [Contact your sales representative ](https://www.byteplus.com/en/contact)to acquire the Effects SDK 4.2.3 or higher, SDK license, and resource packages.

1. Initialize the Effects SDK as follows:

```Java
// The following code takes effect only after you have integrated the Effects SDK into your project.
VeLiveVideoEffectManager effectManager = mLivePusher.getVideoEffectManager();
// Set the path to the SDK license.
String licPath = VeLiveEffectHelper.getLicensePath("xxx.licbag");
// Set the path to the algorithm model.
String algoModePath = VeLiveEffectHelper.getModelPath();
// Create a video effects configuration instance.
VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration licConfig = VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.create(licPath);
// Initialize the special effects manager.
effectManager.setupWithConfig(licConfig);
// Configure the path to the algorithm model package of the special effects.
effectManager.setAlgorithmModelPath(algoModePath);
// Enable beauty AR and special effects.
effectManager.setEnable(true, new VeLivePusherDef.VeLiveVideoEffectCallback() {
    @Override
    public void onResult(int result, String msg) {
        if (result != 0) {
            Log.e("VeLiveQuickStartDemo", "Effect init error:" + msg);
        }
    }
});
```


2. Configure beauty AR and special effects settings.
   * Set beauty AR:

```Java
// Set the path to the special effects resource. You can usually find the resource in the reshape_lite and beauty_Android_lite directories.
String beautyPath = "xxx/ComposeMakeup.bundle/xxx";
// Set the special effects you want to apply to the video.
mLivePusher.getVideoEffectManager().setComposeNodes(new String[]{ beautyPath });
// Set the intensity of the special effect. You can retrieve nodeKey in the .config_file file. Please contact your sales representative if you do not have the .config_file file.
mLivePusher.getVideoEffectManager().updateComposerNodeIntensity(beautyPath, "whiten", 0.5F);
```


* Set the filter:

```Java
// Set the path to the filter resource. You can usually find the resource in the Filter_01_xx directory.
String filterPath = "xxx/FilterResource.bundle/xxx";
mLivePusher.getVideoEffectManager().setFilter(filterPath);
// Set the intensity of the filter.
mLivePusher.getVideoEffectManager().updateFilterIntensity(0.5F);
```


* Set the sticker:

```Java
// Set the path to the sticker resource. You can usually find the resource in the stickers_xxx directory.
String stickerPath = "xxx/StickerResource.bundle/xxx";
mLivePusher.getVideoEffectManager().setSticker(stickerPath);
```

<span id="Switching cameras"></span>
## Watermarking
You can add a watermark to the streamed video by calling [setWatermark](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setwatermark). You can add semi-transparent watermarks.
```Java
// The Bitmap.createBitmap(100, 100, Bitmap.Config.ARGB_8888) method creates a 100*100 pixel watermark image. You can disable watermarking by setting the image parameter to NULL.
mLivePusher.setWatermark(Bitmap.createBitmap(100, 100, Bitmap.Config.ARGB_8888), 0.2f, 0.3f, 1.0f);
```

<span id="822d4891"></span>
## Configuring the camera settings
Call [getCameraDevice](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-getcameradevice) to get the camera manager. With the camera manager, you can do the following:

* Enable or disable the flashlight:

```Java
// Enable the flashlight.
mLivePusher.getCameraDevice().enableTorch(true);
// Disable the flashlight.
mLivePusher.getCameraDevice().enableTorch(false);
```


* Set the zoom factor:

```Java
// Get the maximum zoom factor.
float maxRatio = mLivePusher.getCameraDevice().getMaxZoomRatio();
// Get the minimum zoom factor.
float minRatio = mLivePusher.getCameraDevice().getMinZoomRatio();
// Set the zoom factor.
float ratio = 3.0f;
mLivePusher.getCameraDevice().setZoomRatio(Float.min(maxRatio, Float.max(minRatio, ratio)));
```


* Enable or disable autofocus:

```Java
if (mLivePusher.getCameraDevice().isAutoFocusEnabled()) {
    // Disable autofocus.
    mLivePusher.getCameraDevice().enableAutoFocus(false);
} else {
    // Enable autofocus.
    mLivePusher.getCameraDevice().enableAutoFocus(true);
}
```


* Set the focus position:

```Java
mLivePusher.getCameraDevice().setFocusPosition(100, 100, 50, 50);
```

<span id="Muting the microphone"></span>
## Configuring the microphone settings
Call [getAudioDevice](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-getaudiodevice) to get the audio device manager. With the audio device manager, you can do the following:

* Set the volume:

```Java
// Get the current volume.
float voiceLoudness = mLivePusher.getAudioDevice().getVoiceLoudness();
// Set the volume. The value range is [0.0-1.0].
mLivePusher.getAudioDevice().setVoiceLoudness(0.5);
```


* Set in-ear monitoring:

```Java
// Check whether in-ear monitoring is enabled.
boolean echoEnable = mLivePusher.getAudioDevice().isEnableEcho();
if (echoEnable) {
    // Disable in-ear monitoring.
    mLivePusher.getAudioDevice().enableEcho(false);
} else {
    // Enable in-ear monitoring.
    mLivePusher.getAudioDevice().enableEcho(true);
}
```

<span id="Background mode"></span>
## Changing the video orientation
You can call [setOrientation](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setorientation) to set the video orientation.
```Java
// Set the video orientation to match the current orientation of the status bar of the app.
mLivePusher.setOrientation(VeLiveOrientationLandscape);
```

<span id="bd663148"></span>
## Muting
Call [setMute](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setmute) to mute or unmute the audio.
```Java
if (mLivePusher.isMute()) {
    // Unmute the audio.
    mLivePusher.setMute(false);
} else {
    // Mute the audio.
    mLivePusher.setMute(true);
}
```

<span id="9f1cb489"></span>
## Setting log level
You can call `setLogLevel` to set the level of the output log.
```Java
// Output DEBUG, INFO, WARNING, and ERROR
VeLivePusher.setLogLevel(VeLiveLogLevelDebug);
```

<span id="c9fff9d6"></span>
## Starting the live stream
Call [startPush](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-startpush) to start push streaming.
:::tip
Refer to [Generating live-streaming addresses](/docs/byteplus-media-live/docs-generating-live-stream-addresses) for how to get live-streaming addresses.
:::
```Java
mLivePusher.startPush("rtmp://push.example.com/push");
```

<span id="Releasing the engine for stream pushing"></span>
## Stopping the live stream
Call [stopPush](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-stoppush) to stop push streaming.
```Java
mLivePusher.stopPush();
```

<span id="4a7bab41"></span>
## Destroying the live pusher
Call [release](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-release) to destroy the engine.
```Java
mLivePusher.release();
mLivePusher = null;
```


This topic introduces how to implement the advanced features of the BytePlus MediaLive Broadcast SDK for Android.
<span id="11c0d7a8"></span>
## Prerequisites
You have integrated and initialized the Broadcast SDK by following the instructions provided in [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android) and [Initializing for Android](/docs/byteplus-media-live/docs-initializing-for-android).
<span id="0eb0db28"></span>
## Considerations
Because the Broadcast SDK uses various Android audio and video interfaces that may not function properly on simulated devices, we recommend that you use a physical device for testing.
<span id="8833d5f7"></span>
## QUIC stream pushing
This feature enables you to stream with the QUIC protocol. Use the following steps to implement QUIC push streaming:

1. Use the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) to generate an RTMP push streaming address.
2. Replace `rtmp` in the RTMP push streaming address with `rtmpq` to get the QUIC push streaming address. For example:
   * RTMP push streaming address: `rtmp://example.push/stream`
   * QUIC push streaming address: `rtmpq://example.push/stream`
3. Pass in the QUIC push streaming address when calling [startPush](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-startpush).

```Java
mLivePusher.startPush("rtmpq://example.push/stream");
```

:::tip
The SDK will automatically switch to the RTMP address if it fails to push with the QUIC address.
:::
<span id="4bfb9108"></span>
## Streaming with multiple addresses
To enhance the stability and availability of your streaming, you can call [startPushWithUrls](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-startpushwithurls) to set multiple push streaming addresses. If the SDK fails to push with one address, it will automatically switch to the next one.
:::tip
There is no limit to the number of URLs that can be set. The SDK will try all addresses in their input sequence. An error will occur if the SDK fails to stream with any of the addresses.
:::
```Java
List<String> urls = new ArrayList<>();
urls.add("rtmp://example.push/stream_1");
urls.add("rtmp://example.push/stream_2");
mLivePusher.startPushWithUrls(urls.toArray(new String[0]));
```

<span id="f96f75cb"></span>
## H.265 hardware encoding
This feature can reduce bandwidth consumption while maintaining the same image quality, or improve the image quality without increasing bandwidth consumption.
:::tip
You need to acquire a **Premium** license to use this feature.
:::
Use the following steps to enable H.265 hardware encoding:

1. Contact [BytePlus technical support](https://console.byteplus.com/workorder/create) for assistance with configuring an allowlist for device models that support H.265 hardware encoding.
2. Configure hardware encoding settings and create the live pusher.

```Java
// Create a VeLivePusherConfiguration instance.
VeLivePusherConfiguration config = new VeLivePusherConfiguration();
// Create a VeLiveVideoEncoderConfiguration instance.
VeLivePusherDef.VeLiveVideoEncoderConfiguration encoderConfiguration = new VeLivePusherDef.VeLiveVideoEncoderConfiguration();
// Set the codec to H.265.
encoderConfiguration.setCodec(VeLivePusherDef.VeLiveVideoCodec.VeLiveVideoCodecByteVC1);
// Create the live pusher.
mLivePusher = config.build();
```

<span id="Using an external audio and video source"></span>
## Using an external video or audio source
If your app already has the ability to capture and process audio and video, you can use the Broadcast SDK to stream the external data.
**Using an external video source**
The SDK supports external video data in the format of OpenGL texture, ByteBuffer, and ByteArray.
:::tip
* The OpenGL texture format supports both 2D and OES formats.
* If you choose to use binary data, it must be in the I420 pixel format. When using binary data, you must also provide the width and height of the video frame.
* The OpenGL texture must use the same OpenGL environment as the live pusher. You can get the environment by calling [getEGLContext](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-geteglcontext).
:::

1. Start capturing external video.

```Java
mLivePusher.startVideoCapture(VeLiveVideoCaptureExternal);
```


2. Push external video data.
   * OpenGL 2D Texture

```Java
VeLiveVideoFrame videoFrame = new VeLiveVideoFrame(720, 1280, TimeUtils.currentTimeUs(), 0, false, null);
videoFrame.setReleaseCallback(() -> {
    // Release the memory when videoFrame is released.
});
mLivePusher.pushExternalVideoFrame(videoFrame);
```


* OpenGL OES Texture

```Java
VeLiveVideoFrame videoFrame = new VeLiveVideoFrame(720, 1280, TimeUtils.currentTimeUs(), 0, true, null);
videoFrame.setReleaseCallback(() -> {
    // Release the memory when videoFrame is released.
});
mLivePusher.pushExternalVideoFrame(videoFrame);
```


* ByteBuffer

```Java
ByteBuffer byteBuffer = ByteBuffer.allocateDirect(720 * 1280 * 3 / 2); // I420 format.
VeLiveVideoFrame videoFrame = new VeLiveVideoFrame(720, 1280, TimeUtils.currentTimeUs(), byteBuffer);
videoFrame.setReleaseCallback(() -> {
    // Release the memory when videoFrame is released.
});
mLivePusher.pushExternalVideoFrame(videoFrame);
```


* ByteArray

```Java
byte[] data = new byte[(720 * 1280 * 3 / 2)]; // I420 format.
VeLiveVideoFrame videoFrame = new VeLiveVideoFrame(720, 1280, TimeUtils.currentTimeUs(), data);
videoFrame.setReleaseCallback(() -> {
    // Release the memory when videoFrame is released.
});
mLivePusher.pushExternalVideoFrame(videoFrame);
```

**Using an external audio source**
The SDK supports external audio data in the format of ByteBuffer.
:::tip
The SDK supports binary data with sample rates of 8000/16000/32000/44100/48000 Hz and a bit depth of 16 bits, with single or dual audio channels.
:::

1. Start capturing external audio.

```Java
mLivePusher.startAudioCapture(VeLiveAudioCaptureExternal);
```


2. Push external audio data.

```Java
// Push audio data with a sample rate of 44100 Hz, 16-bit depth, and double audio channels.
ByteBuffer byteBuffer = ByteBuffer.allocateDirect(44100 * 2 * 2);
VeLiveAudioFrame audioFrame = new VeLiveAudioFrame(VeLiveAudioSampleRate44100, VeLiveAudioChannelStereo, TimeUtils.currentTimeUs(), byteBuffer);
mLivePusher.pushExternalAudioFrame(audioFrame);
```

<span id="f7641cfb"></span>
## **Video mixing**
The SDK supports incorporating multiple video sources with the primary video input, creating a mixed view. The SDK will then pass the mixed view to the transmission module and then stream it.

1. Call [addVideoStream](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMixerManager-addvideostream) to add a video stream to the mixer.

```Java
VeLiveMixerManager mixerManager = mLivePusher.getMixerManager();
mMixerVideoId = mixerManager.addVideoStream();
```


2. Call [updateStreamMixDescription](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMixerManager-updatestreammixdescription) to configure the video mixing settings.

```Java
VeLivePusherDef.VeLiveMixVideoLayout videoLayout = new VeLivePusherDef.VeLiveMixVideoLayout();
videoLayout.streamId = mMixerVideoId;
videoLayout.x = 0;
videoLayout.y = 0;
videoLayout.width = 0.5f;
videoLayout.height = 0.3f;
videoLayout.zOrder = 1;
videoLayout.renderMode = VeLivePusherRenderModeHidden;
description.mixVideoStreams.add(videoLayout);
mLivePusher.getMixerManager().updateStreamMixDescription(description);
```


3. Call [sendCustomVideoFrame](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMixerManager-sendcustomvideoframe) to send a custom video frame with a specified stream ID. Refer to [Using an external video or audio source](/docs/byteplus-media-live/docs-implementing-advanced-features#Using an external audio and video source) for the supported video data formats.

```Java
VeLiveVideoFrame videoFrame = new VeLiveVideoFrame(720, 1280, TimeUtils.currentTimeUs(), 0, false, null);
videoFrame.setReleaseCallback(() -> {
    // Release the memory when videoFrame is released.
});
mLivePusher.getMixerManager().sendCustomVideoFrame(videoFrame, mMixerVideoId);
```


4. Call [removeVideoStream](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMixerManager-removevideostream) to remove the video stream.

```Java
mLivePusher.getMixerManager().removeVideoStream(mMixerVideoId);
```

<span id="9ecc26a9"></span>
## Audio mixing
The SDK supports mixing multiple audio sources with the primary audio input. The SDK will pass the mixed audio to the transmission module and then stream it, while also providing the capability to play it locally.

1. Call [addAudioStream](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#addaudiostream-2) add an audio stream to the mixer.

```Java
Object mStreamHandler = mLivePusher.getMixerManager().addAudioStream(VeLiveAudioMixPlayAndPush);
```


2. (Optional) Call [updateStreamMixDescription](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMixerManager-updatestreammixdescription) to adjust the volume of the mixed audio stream.

```Java
VeLivePusherDef.VeLiveStreamMixDescription mMixDescription = new  VeLivePusherDef.VeLiveStreamMixDescription();
VeLivePusherDef.VeLiveMixAudioLayout layout = new VeLivePusherDef.VeLiveMixAudioLayout();
layout.streamId = (int)mStreamHandler;
layout.volume = volume;
mMixDescription.mixAudioStreams.add(layout);
mMixerManager.updateStreamMixDescription(mMixDescription);
```


3. Pass in the audio frame data. The audio data must be of type float32 and is stored in little-endian byte order. See [VeLiveAudioFrame](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#veliveaudioframe) for details.

```Java
ByteBuffer buffer = null;
long pts;
VeLiveAudioFrame frame = new VeLiveAudioFrame(VeLiveAudioSampleRate44100, VeLiveAudioChannelStereo, pts, buffer)
mMixerManager.sendCustomAudioFrame(frame, (int)mStreamHandler);
```


4. Call [removeAudioStream](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMixerManager-removeaudiostream) to remove the mixed audio stream.

```Java
mLivePusher.getMixerManager().removeAudioStream((int)mStreamHandler)
```

<span id="6ba8c5d4"></span>
## Screen recording and streaming
In addition to camera capture and streaming, the SDK also supports screen recording and streaming, which is commonly used in scenarios such as game broadcasting and mobile app demos. By using screen recording and streaming, hosts can push the content on their phones to the server in real time, allowing the audience to see the host's screen operations or game visuals.
:::tip
You can only implement this feature after upgrading your SDK to version 1.47.300.1 or above. 
:::

1. In the `AndroidManifest.xml` file, do the following:
   1. Add the following permission declarations to ensure the app can run the screen recording and streaming feature stably on the corresponding Android versions.
      ```XML
      <!-- Applicable for Android 9 (API level 28) and above -->
      <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
      <!-- Applicable for Android 14 (API level 34) and above -->
      <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION"/>
      <!-- Applicable for Android 13 (API level 33) and above -->
      <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
      ```

      * `FOREGROUND_SERVICE` permission: Allows the app to run services in the foreground, ensuring the app is not killed by the system while in the background.
      * `FOREGROUND_SERVICE_MEDIA_PROJECTION` permission: Required since Android 14 for screen sharing and recording features to ensure proper screen content capture.
      * `POST_NOTIFICATIONS` permission: The app must declare this permission to send foreground service notifications starting from Android 13.
   2. Add the following foreground service declaration.
      ```XML
      <application ...>
      <!-- Declare the foreground service used for screen sharing. Here declares the SDK's built-in service. You can also replace it with a custom service. -->
          <service
              android:name="com.ss.avframework.live.capture.video.VeLiveScreenRecorder$ForegroundService"
              android:foregroundServiceType="mediaProjection"
              android:exported="false" />
      </application>
      ```

      :::tip
      * Starting from Android 11 (API level 30), Google requires all operations involving screen capture (`MediaProjection`) to be performed in a foreground service to ensure users are aware when an app is capturing screen content, enhancing privacy and security.
      * For more information on custom service, [create a ticket](https://console.byteplus.com/workorder/create) to contact technical support.
      :::
2. Create a live pusher and configure listeners related to screen capture.
   ```Java
   // Create a live pusher.
   VeLivePusherConfiguration config = new VeLivePusherConfiguration();
   mLivePusher = config.build();
   // Listen for live pusher events.
   mLivePusher.setObserver(pusherObserver);
   
   private VeLivePusherObserver pusherObserver = new VeLivePusherObserver() {
       @Override
       public void onError(int code, int subCode, String msg) {
           // Listen for live pusher error events.
           if (code == VeLivePusherScreenCaptureNotSupportError.value()) {
               // The current device's system version is too low to support screen capture.
           } else if (code == VeLivePusherScreenCaptureStartError.value()) {
               // Screen capture failed to start, possibly due to user denial of authorization.
           } else if (code == VeLivePusherScreenCaptureInterruptedError.value()) {
               // Screen capture is interrupted by the system.
           }
       }
   
       @Override
       public void onScreenRecording(boolean open) {
           // Listen for screen capture status changes and handle according to the status.
           if (open) {
               // Start mixing system audio when screen capture begins.
               mLivePusher.startMixSystemAudio();
           } else {
              // Stop mixing system audio when screen capture stops.
               mLivePusher.stopMixSystemAudio();
           }
       }
   };
   ```

3. Start screen capture and push the stream.
   ```Java
   // Start audio capture, using the microphone as the audio source.
   mLivePusher.startAudioCapture(VeLiveAudioCaptureMicrophone);
   
   // If the device's system version is Android 13 (API level 33) or above, you must request users to grant POST_NOTIFICATIONS permission when the app is running. Once granted, the app can send notifications indicating that the screen is being captured.
   if (Build.VERSION.SDK_INT >= 33 &&
       ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
         != PackageManager.PERMISSION_GRANTED) {
       ActivityCompat.requestPermissions(
           this,
           arrayOf(Manifest.permission.POST_NOTIFICATIONS),
           1001
       )
   }
   
   // Start video capture, using the device's screen content as the video source.
   mLivePusher.startVideoCapture(VeLiveVideoCaptureScreen);
   
   // Push the stream.
   mLivePusher.startPush("rtmp://xxx");
   ```

4. Call the following methods as needed.
   ```Java
   // Stop pushing the stream.
   mLivePusher.stopPush();
   // Destroy the live pusher.
   mLivePusher.release();
   ```


<span id="41c82b61"></span>
## **Pushing a static image**
The SDK supports pushing a static image. Call [updateCustomImage](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-updatecustomimage) to set the static image to push, and then call [startVideoCapture](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-startvideocapture) to set the static image as the video source.
```Java
Bitmap bitmap = Bitmap.createBitmap(100, 100, Bitmap.Config.ARGB_8888);
// Set the static image to push.
mLivePusher.updateCustomImage(bitmap);
// Set the static image as the video source.
mLivePusher.startVideoCapture(VeLiveVideoCaptureCustomImage);
```

<span id="03b1975f"></span>
## Playing background music
Hosts may choose to incorporate background music or karaoke to enhance the atmosphere in some live events. Use the following code to play and control the background music.

1. Call [createPlayer](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-createplayer) to create a `VeLiveMediaPlayer` instance.

```Java
VeLiveMediaPlayer mediaPlayer = mLivePusher.createPlayer();
```


2. Set the path to the music file with the [prepare](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-prepare) property. Supported file formats include MP3, AAC, M4A, and WAV.

```Java
mediaPlayer.prepare("xxx/music.mp3");
```


3. Call [enableMixer](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-enablemixer) to set whether to mix the audio into the live audio stream.

```Java
mediaPlayer.enableMixer(true);
```


4. Call [enableBGMLoop](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-enablebgmloop) to set whether to loop the music file.

```Java
mediaPlayer.enableBGMLoop(true);
```


5. Call [start](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-start) to start playback.

```Java
mediaPlayer.start();
```


6. Call [setBGMVolume](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-setbgmvolume) and [setVoiceVolume](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-setvoicevolume) to adjust the volumes of the background music and the host.

```Java
// Set the volume of the background music.
mediaPlayer.setBGMVolume(0.8f);
// Set the volume of the host.
mediaPlayer.setVoiceVolume(1.0f);
```


7. Call [seek](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-seek) to set the playback progress. You can first call [getDuration](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-getduration) to get the duration of the music file.

```Java
mediaPlayer.seek(3000);
```


8. Call [pause](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-pause) and [resume](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-resume) to pause and resume playback.

```Java
// Pause playback.
mediaPlayer.pause();
// Resume playback.
mediaPlayer.resume();
```


9. Call [stop](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-stop) to stop playback.

```Java
mediaPlayer.stop();
```

<span id="8bb01c51"></span>
## **Capturing a screenshot**
With this feature, hosts can capture screenshots of their live events and save them to their mobile phones.
```Java
mLivePusher.snapshot(new VeLivePusherDef.VeLiveSnapshotListener() {
    @Override
    public void onSnapshotComplete(Bitmap image) {
        // Save the image to the local photo album.
    }
});
```

<span id="6b3cedc6"></span>
## **SEI**
Call [sendSeiMessage](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-sendseimessage) to send custom information with key frames or all frames.
```Java
// Send an SEI message.
mLivePusher.sendSeiMessage("key", "value", -1, true, true);
```

<span id="c7775e14"></span>
## **Custom video processing**
Use the following code to process the video frames captured by the SDK.

1. Call [setVideoFrameFilter](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setvideoframefilter) to set a protocol for custom video processing.

```Java
mLivePusher.setVideoFrameFilter(new VeLivePusherDef.VeLiveVideoFrameFilter() {
    @Override
    public int onVideoProcess(VeLiveVideoFrame srcFrame, VeLiveVideoFrame dstFrame) {
        dstFrame.adopt(srcFrame.getWidth(), srcFrame.getHeight(), srcFrame.getPts(), 0, false, null);
        return 0;
    }
});
```


2. Remove the protocol for custom video processing.

```Java
mLivePusher.setVideoFrameFilter(null);
```

<span id="c07cd8db"></span>
## **Custom audio processing**
Use the following code to process the audio frames captured by the SDK.

1. Call [setAudioFrameFilter](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-setaudioframefilter) to set the callback for custom audio processing.

```Java
mLivePusher.setAudioFrameFilter(new VeLivePusherDef.VeLiveAudioFrameFilter() {
    @Override
    public int onAudioProcess(VeLiveAudioFrame srcFrame, VeLiveAudioFrame dstFrame) {
        // Process the audio frame and pass the processed frame to dstFrame
        ByteBuffer byteBuffer = ByteBuffer.allocateDirect(srcFrame.getBuffer().capacity());
        dstFrame.adopt(srcFrame.getSampleRate(), srcFrame.getChannels(), srcFrame.getPts(), byteBuffer);
        return 0;
    }
});
```


2. Remove the protocol for custom audio processing.

```Java
mLivePusher.setAudioFrameFilter(null);
```

<span id="248989ad"></span>
## **Subscribing to video data**
Use the following code to subscribe to captured video frames or video frames to be encoded.

1. Call [addVideoFrameListener](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-addvideoframelistener) to add video frame listener.

```Java
mLivePusher.addVideoFrameListener(this);
```


2. Call [getObservedVideoFrameSource](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-getobservedvideoframesource) to set the source of the video frame that the listener needs. You can get a captured video frame from [onCaptureVideoFrame](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-oncapturevideoframe) and a video frame to be encoded from [onPreEncodeVideoFrame](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-onpreencodevideoframe).

```Java
@NonNull
@Override
public VeLivePusherDef.VeLiveVideoFrameSource getObservedVideoFrameSource() {
 // Subscribe to both captured video frames and video frames prior to encoding.
   return new VeLivePusherDef.VeLiveVideoFrameSource(VeLiveVideoFrameSourceCapture | VeLiveVideoFrameSourcePreEncode);
}
@Override
public void onCaptureVideoFrame(VeLiveVideoFrame frame) {
    // Get a captured video frame.
}
@Override
public void onPreEncodeVideoFrame(VeLiveVideoFrame frame) {
    // Get a video frame to be encoded.
}
```


3. Call [removeVideoFrameListener](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-removevideoframelistener) to remove the listener.

```Java
mLivePusher.removeVideoFrameListener(this);
```

<span id="0b041a32"></span>
## **Subscribing to audio data**
Use the following code to subscribe to captured audio frames or audio frames prior to encoding.

1. Call [addAudioFrameListener](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-addaudioframelistener) to add an audio frame listener.

```Java
mLivePusher.addAudioFrameListener(this);
```


2. Implement the [VeLiveAudioFrameListener](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-callback#veliveaudioframelistener) callback.

```Java
@NonNull
@Override
public VeLivePusherDef.VeLiveAudioFrameSource getObservedAudioFrameSource() {
 // Subscribe to both captured audio frames and audio frames prior to encoding.
    return new VeLivePusherDef.VeLiveAudioFrameSource(VeLiveAudioFrameSourceCapture | VeLiveAudioFrameSourcePreEncode);
}
@Override
public void onCaptureAudioFrame(VeLiveAudioFrame frame) {
    // Get a captured audio frame
}
@Override
public void onPreEncodeAudioFrame(VeLiveAudioFrame frame) {
    // Get an audio frame to be encoded
}
```


3. Call [removeAudioFrameListener](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-removeaudioframelistener) to remove the listener.

```Java
mLivePusher.removeAudioFrameListener(this);
```

<span id="6066aef1"></span>
## **Local recording**
During the live streaming event, the host may want to record the streamed content locally and save it on their mobile phones. Use the following code to record:

1. Configure recording settings and call [startFileRecording](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-startfilerecording) to start recording.

```Java
// Create a VeLiveFileRecorderConfiguration instance.
VeLivePusherDef.VeLiveFileRecorderConfiguration recordConfig = new VeLivePusherDef.VeLiveFileRecorderConfiguration();
// Set the width of the recorded video.
recordConfig.setWidth(720);
// Set the height of the recorded video.
recordConfig.setHeight(1280);
// Set the frame rate of the recorded video.
recordConfig.setFps(15);
// Set the bitrate of the recorded video.
recordConfig.setBitrate(2000);

mLivePusher.startFileRecording("xxx/record.mp4", recordConfig, new VeLivePusherDef.VeLiveFileRecordingListener() {
    @Override
    public void onFileRecordingStarted() {
        // Occurs when recording starts.
    }
    @Override
    public void onFileRecordingStopped() {
        // Occurs when recording stops.
    }
    @Override
    public void onFileRecordingError(int errorCode, String message) {
        // The error code. See VeLivePusherCode for details.
        // Occurs when an error occurs during recording.
    }
});
```


2. Call [stopFileRecording](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-stopfilerecording) to stop recording.

```Java
mLivePusher.stopFileRecording();
```

<span id="ecc45871"></span>
## Background mode
The SDK allows the host to continue streaming even when the app is switched to the background. The SDK offers several options for pushing video frames:

* pushing the last video frame captured,
* pushing a black frame,
* pushing a static image.

:::tip
To use this feature, the app must have permission to record audio in background mode.
:::
Call [switchVideoCapture](/docs/byteplus-media-live/docs-broadcast-sdk-for-android-api#VeLivePusher-switchvideocapture) to set the type of video frames to push.
```Java
@Override
protected void onPause() {
    super.onPause();
    // Push the last frame captured.
    mLivePusher.switchVideoCapture(VeLiveVideoCaptureLastFrame);
    // Push a black frame.
    // mLivePusher.switchVideoCapture(VeLiveVideoCaptureDummyFrame);
    // Push a static image.
    // Bitmap bitmap = Bitmap.createBitmap(100, 100, Bitmap.Config.ARGB_8888);
    // mLivePusher.updateCustomImage(bitmap);
    // mLivePusher.switchVideoCapture(VeLiveVideoCaptureCustomImage);
}

@Override
protected void onResume() {
    super.onResume();
    // You can store the video capture type before the app switches to the background, and use the same capture type when the app switches back to the foreground.
    mLivePusher.switchVideoCapture(VeLiveVideoCaptureFrontCamera);
}
```


The Broadcast SDK offers a solution integrated with the BytePlus Effects SDK. By calling the special effect processing APIs provided by the Broadcast SDK, you can quickly integrate special effect features and add beauty AR, filters, stickers, and other special effects to locally captured video. Compared to integrating third-party beauty AR through the [Custom video processing](/docs/byteplus-media-live/docs-implementing-advanced-features#c7775e14) feature of the Broadcast SDK, this solution is faster to integrate, easier to use, and delivers better results.
This topic describes how to integrate the BytePlus Effects SDK into a live streaming app and call the Broadcast SDK APIs to implement beauty AR, filters, and other features. Additionally, you can refer to [Running VeLiveQuickStartDemo for Android](/docs/byteplus-media-live/docs-running-the-quickstartdemo-for-android) to complete the integration of the BytePlus Effects SDK.
<span id="e888142c"></span>
## Prerequisites

* This feature requires payment. You can contact [technical support](https://console.byteplus.com/workorder/create) to get the Standard or Lite version of the BytePlus Effects SDK (version **4.4.3** or above), as well as a license and resource pack that meet your business requirements.
   :::tip
   For complete authorization information, see [Online authorization](https://docs.byteplus.com/en/docs/effects/docs-online-license-guide).
   :::
* You have integrated the Broadcast SDK into your project. For more information, see  [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android).

<span id="1d3caae5"></span>
## Integrating the BytePlus Effects SDK and resource files
You must integrate the BytePlus Effects SDK and resource files before calling the Broadcast SDK APIs to implement special effects. This section describes how to integrate the BytePlus Effects SDK and its resource files.

1. Extract the SDK package and locate the `effectAAR-release.aar` file.
   ![Image](https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_afb350c7e003157d1c0f43378607e4f1.png =864x)
2. Copy the AAR file found in Step 1 into the `app/libs` directory under the project. If the `libs` directory does not exist, create one.
   ![Image](https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_d847fd7610d87ae88f00b0243bb445a9.png =864x)
3. Open the project in Android Studio, edit the app's `build.gradle` file, and add the BytePlus Effects SDK dependency in the `dependencies` section.
   ```Java
   dependencies {
             // ...
       implementation(name: 'effectAAR-release', ext: 'aar')
       // ...
   }
   ```

4. Extract the special effects resource pack. The extracted resources are as follows.
   ![Image](https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_953f3d09a84861d721193b2db4c1d4e9.png =864x)
5. Copy the extracted resource pack to the project's `assets` directory. The special effects resources are as follows after the copy.
   ![Image](https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_198a0926e6b240cff0622afce6f43076.png =864x)
   ![Image](https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_2e6316418192e3612084a377406875ca.png =864x)
6. When the app starts, the `VeLiveEffectHelper.initVideoEffectResource();` method copies resource files from the `assets` directory to the app's private directory in external storage at `storage/xx/"$packageName"/assets/resource/`.
   ```Java
   package com.ttsdk.quickstart.helper;
   
   import android.content.Context;
   import android.text.TextUtils;
   
   import com.pandora.common.env.Env;
   
   import java.io.File;
   import java.io.FileInputStream;
   import java.io.FileOutputStream;
   import java.io.IOException;
   import java.io.InputStream;
   import java.io.OutputStream;
   
   public class VeLiveEffectHelper {
   
       /**
        * Get the license file path.
        */
       public static String getLicensePath(String name) {
           return Env.getApplicationContext().getExternalFilesDir("assets").getAbsolutePath()
                   + "/resource/LicenseBag.bundle/" + name;
       }
   
       /**
        * Get the model file path.
        */
       public static String getModelPath() {
           return Env.getApplicationContext().getExternalFilesDir("assets").getAbsolutePath()
                   + "/resource/ModelResource.bundle";
       }
   
       /**
        * Get the beauty AR file path.
        */
       public static String getBeautyPathByName(String subPath) {
           return Env.getApplicationContext().getExternalFilesDir("assets").getAbsolutePath()
                   + "/resource/ComposeMakeup.bundle/ComposeMakeup/" + subPath;
       }
   
       /**
        * Get the stickers file path. 
        * @param name Stickers file name. 
        */
       public static String getStickerPathByName(String name) {
           return Env.getApplicationContext().getExternalFilesDir("assets").getAbsolutePath()
                   + "/resource/StickerResource.bundle/stickers/" + name;
       }
   
       /**
        * Get the filters file path.
        * @param name Filters file name. 
        */
       public static String getFilterPathByName(String name) {
           return Env.getApplicationContext().getExternalFilesDir("assets").getAbsolutePath()
                   + "/resource/FilterResource.bundle/Filter/" + name;
       }
   
       /**
        * Initialize beauty AR resource files.
        * Copy the resource files from the installation package to external storage.
        */
       public static void initVideoEffectResource() {
           Context context = Env.getApplicationContext();
           File versionFile = new File(getExternalResourcePath(), "version");
           if (versionFile.exists()) {
               String oldVer = readVersion(versionFile.getAbsolutePath());
               copyAssetFolder(context, "resource/version", versionFile.getAbsolutePath());
               String newVer = readVersion(versionFile.getAbsolutePath());
               if (TextUtils.equals(oldVer, newVer)) {
                   return;
               }
           } else {
               copyAssetFile(context, "resource/version", versionFile.getAbsolutePath());
           }
           updateEffectResource(context);
       }
   
       private static String readVersion(String fileName) {
           String version = "";
           try {
               FileInputStream fin = new FileInputStream(fileName);
               int length = fin.available();
               byte [] buffer = new byte[length];
               fin.read(buffer);
               version = new String(buffer);
               fin.close();
           } catch(Exception e){
               e.printStackTrace();
           }
           return version;
       }
   
       private static void updateEffectResource(Context context) {
           File licensePath = new File(getExternalResourcePath(), "LicenseBag.bundle");
           removeFile(licensePath.getAbsolutePath());
           copyAssetFolder(context, "resource/LicenseBag.bundle", licensePath.getAbsolutePath());
           File modelPath = new File(getExternalResourcePath(), "ModelResource.bundle");
           removeFile(modelPath.getAbsolutePath());
           copyAssetFolder(context, "resource/ModelResource.bundle", modelPath.getAbsolutePath());
           File stickerPath = new File(getExternalResourcePath(), "StickerResource.bundle");
           removeFile(stickerPath.getAbsolutePath());
           copyAssetFolder(context, "resource/StickerResource.bundle", stickerPath.getAbsolutePath());
           File filterPath = new File(getExternalResourcePath(), "FilterResource.bundle");
           removeFile(filterPath.getAbsolutePath());
           copyAssetFolder(context, "resource/FilterResource.bundle", filterPath.getAbsolutePath());
           File composerPath = new File(getExternalResourcePath(), "ComposeMakeup.bundle");
           removeFile(composerPath.getAbsolutePath());
           copyAssetFolder(context, "resource/ComposeMakeup.bundle", composerPath.getAbsolutePath());
       }
   
       private static void removeFile(String filePath) {
           if(filePath == null || filePath.length() == 0){
               return;
           }
           try {
               File file = new File(filePath);
               if(file.exists()){
                   removeFile(file);
               }
           }catch (Exception ex){
               ex.printStackTrace();
           }
       }
   
       private static void removeFile(File file){
           // If it is a file, delete it directly. 
           if(file.isFile()){
               file.delete();
               return;
           }
           // If it is a directory, check recursively. If it is an empty directory, delete it directly. If it is a file, delete it during traversal.
           if(file.isDirectory()){
               File[] childFile = file.listFiles();
               if(childFile == null || childFile.length == 0){
                   file.delete();
                   return;
               }
               for(File f : childFile){
                   removeFile(f);
               }
               file.delete();
           }
       }
   
       public static String getExternalResourcePath() {
           return Env.getApplicationContext().getExternalFilesDir("assets").getAbsolutePath() + "/resource/";
       }
   
       public static boolean copyAssetFolder(Context context, String srcName, String dstName) {
           try {
               boolean result = true;
               String fileList[] = context.getAssets().list(srcName);
               if (fileList == null) return false;
   
               if (fileList.length == 0) {
                   result = copyAssetFile(context, srcName, dstName);
               } else {
                   File file = new File(dstName);
                   result = file.mkdirs();
                   for (String filename : fileList) {
                       result &= copyAssetFolder(context, srcName + File.separator + filename, dstName + File.separator + filename);
                   }
               }
               return result;
           } catch (IOException e) {
               e.printStackTrace();
               return false;
           }
       }
   
       public static boolean copyAssetFile(Context context, String srcName, String dstName) {
           try {
               InputStream in = context.getAssets().open(srcName);
               File outFile = new File(dstName);
               OutputStream out = new FileOutputStream(outFile);
               byte[] buffer = new byte[1024];
               int read;
               while ((read = in.read(buffer)) != -1) {
                   out.write(buffer, 0, read);
               }
               in.close();
               out.close();
               return true;
           } catch (IOException e) {
               e.printStackTrace();
               return false;
           }
       }
   
   }
   ```


<span id="4da7890a"></span>
## Calling the Broadcast SDK APIs
This section describes how to call the Broadcast SDK APIs to implement beauty AR, stickers, and other features.
<span id="8fe1d0fe"></span>
### API sequence diagram
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/5bc86ae3d6c9480e8bb6d002dfaacc04~tplv-goo7wpa0wc-image.image =1148x)

<span id="f367c718"></span>
### Initialization
After calling `config.build();` to create the engine and start video capture, you must first initialize the special effects resources and set the paths to the special effects resources and license before you can enable special effects and see special effects in the local preview. You must set the complete license file path, that is, specify the exact license file. For the model file path, you can specify up to the `ModelResource.bundle` layer.
After integration is complete, you can check the callback result by calling `setEnable`. A value of `0` indicates successful integration, while any other value indicates integration failure.
```Java
//  Stream pushing configuration.
VeLivePusherConfiguration config = new VeLivePusherConfiguration();
//  Configuration context.
config.setContext(this);
//  Number of failed reconnection attempts.
config.setReconnectCount(10);
//  Create a live pusher.
mLivePusher = config.build();

//  Note: This method takes effect only when the BytePlus Effects SDK is integrated into the project.
VeLiveVideoEffectManager effectManager = mLivePusher.getVideoEffectManager();
//  License path. Find the correct path according to the project configuration.
String licPath = VeLiveEffectHelper.getLicensePath("xxx.licbag");
// Path to the special effects model resource pack.
String algoModePath = VeLiveEffectHelper.getModelPath();
if (!VeLiveSDKHelper.isFileExists(licPath)) {
    return;
}
//  Create special effects configuration.
VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration licConfig = VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.create(licPath);
//  Set special effects configuration.
effectManager.setupWithConfig(licConfig);
//  Set algorithm model path.
effectManager.setAlgorithmModelPath(algoModePath);
//  Enable special effects processing.
effectManager.setEnable(true, new VeLivePusherDef.VeLiveVideoEffectCallback() {
    @Override
    public void onResult(int result, String msg) {
        if (result != 0) {
            Log.e("VeLiveQuickStartDemo", "Effect init error:" + msg);
        }
    }
});

//  Disable special effects processing. 
effectManager.setEnable(false, new VeLivePusherDef.VeLiveVideoEffectCallback() {
    @Override
    public void onResult(int result, String msg) {
        if (result != 0) {
            Log.e("VeLiveQuickStartDemo", "Effect init error:" + msg);
        }
    }
});
```

<span id="adaa4c7a"></span>
### Beauty AR
Beauty AR resources are stored in the `ComposeMakeup.bundle` file. You must use `setComposeNodes` to set the resource path and use `updateComposerNodeIntensity` to update the special effect intensity so that the beauty AR effect is displayed. The resource keys that can be set by `updateComposerNodeIntensity` can be found in   [Resource keys](https://docs.byteplus.com/en/docs/effects/docs-functions-of-resource-keys-v421-and-later).
:::warning
You must set the resource path to the `../ComposeMakeup.bundle/ComposeMakeup/beauty_Android_lite` layer.
:::
```Java
//  Locate the correct resource path based on the resource pack for special effects, typically in the `reshape_lite` or `beauty_Android_lite` directories.
String beautyPath = VeLiveEffectHelper.getBeautyPathByName("xxx");
if (!VeLiveSDKHelper.isFileExists(beautyPath)) {
    return;
}
//  Set the beauty AR resource pack.
mLivePusher.getVideoEffectManager().setComposeNodes(new String[]{ beautyPath });
//  Set the intensity of beauty AR. You can get the NodeKey from the `.config_file` in the resource pack. If the `.config_file` does not exist, contact your technical support. 
mLivePusher.getVideoEffectManager().updateComposerNodeIntensity(beautyPath, "whiten", 0.5F);
```

<span id="69a8b031"></span>
### Filters
Filter resources are stored in the `FilterResource.bundle` file. You must use `setFilter` to set the resource path and use `updateFilterIntensity` to set the filter intensity before the filter effect can be displayed.
:::warning
You must set the filter path to a specific filter name, for example, `../FilterResource.bundle/Filter/Filter_01_38`.
:::
```Java
//  Filter resource pack. Locate the correct resource path, usually in the `Filter_01_xx` directory. 
String filterPath = VeLiveEffectHelper.getFilterPathByName("xxx");
if (!VeLiveSDKHelper.isFileExists(filterPath)) {
    return;
}
//  Set the path to the filter resource pack.  
mLivePusher.getVideoEffectManager().setFilter(filterPath);
//  Set filter intensity.
mLivePusher.getVideoEffectManager().updateFilterIntensity(0.5F);
```

<span id="255eb7a0"></span>
### Stickers
Sticker resources are stored in the `StickerResource.bundle` file. You must use `setSticker` to set the resource path before the sticker effect can be displayed.
:::warning
You must set the sticker path to a specific sticker name, for example, `../StickerResource.bundle/stickers/stickers_zhaocaimao`.
:::
```Java
//  Sticker resource pack. Locate the correct resource path, usually in the `stickers_xxx` directory. 
String stickerPath = VeLiveEffectHelper.getStickerPathByName("xxx");
if (!VeLiveSDKHelper.isFileExists(stickerPath)) {
    return;
}
//  Set the path to the sticker resource pack.
mLivePusher.getVideoEffectManager().setSticker(stickerPath);
```

<span id="4cd919bd"></span>
### Style makeup
Style makeup resources are stored in the `ComposeMakeup.bundle` file. You must use `setComposeNodes` to set the resource path and use `updateComposerNodeIntensity` to update the special effect intensity so that the style makeup effect is displayed. The resource keys that can be set by `updateComposerNodeIntensity` can be found in   [Resource keys](https://docs.byteplus.com/en/docs/effects/docs-functions-of-resource-keys-v421-and-later).
:::warning
You must set the style makeup path to a specific style makeup name, for example, `../ComposeMakeup.bundle/ComposeMakeup/style_makeup/aidou`.
:::
```Java
//  Locate the correct resource path based on the resource pack for special effects, typically in the `style_makeup` directory. 
String beautyPath = VeLiveEffectHelper.getBeautyPathByName("style_makeup/aidou");
if (!VeLiveSDKHelper.isFileExists(beautyPath)) {
    return;
}
//  Set the beauty AR resource pack. 
mLivePusher.getVideoEffectManager().setComposeNodes(new String[]{ beautyPath });
//  Set the intensity of beauty AR. You can get the NodeKey from the `.config_file` in the resource pack. If the `.config_file` does not exist, contact your technical support. 
mLivePusher.getVideoEffectManager().updateComposerNodeIntensity(beautyPath, "Filter_ALL", 0.5F);
mLivePusher.getVideoEffectManager().updateComposerNodeIntensity(beautyPath, "Makeup_ALL", 0.5F);
```


# Methods
| Method | Description |
| --- | --- |
| [build](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-build) | Creates the live pusher. |
| [setReconnectIntervalSeconds](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-setreconnectintervalseconds) | Sets the time interval between each attempt to reconnect. |
| [getReconnectIntervalSeconds](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-getreconnectintervalseconds) | Gets the time interval between each attempt to reconnect. |
| [setReconnectCount](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-setreconnectcount) | Sets the number of attempts to reconnect after the initial attempt fails. |
| [getReconnectCount](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-getreconnectcount) | Gets the number of attempts to reconnect after the initial attempt fails. |
| [setVideoCaptureConfig](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-setvideocaptureconfig) | Sets the video capture configurations. |
| [getVideoCaptureConfig](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-getvideocaptureconfig) | Gets the video capture configurations. |
| [setAudioCaptureConfig](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-setaudiocaptureconfig) | Sets the audio capture configurations. |
| [getAudioCaptureConfig](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-getaudiocaptureconfig) | Gets the audio capture configurations. |
| [setContext](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-setcontext) | Sets the context of the application. |
| [getContext](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-getcontext) | Gets the context of the application. |
| [setExtraParameters](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-setextraparameters) | Sets advanced parameters. You can leave this parameter empty. If you need to use it, please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support. |
| [getExtraParams](docs-broadcast-sdk-for-android-type-definition#VeLivePusherConfiguration-getextraparams) | Gets advanced parameters. |

## VeLivePusher
| Method | Description |
| --- | --- |
| [createPlayer](docs-broadcast-sdk-for-android-api#VeLivePusher-createplayer) | Creates the media player. |
| [setObserver](docs-broadcast-sdk-for-android-api#VeLivePusher-setobserver) | Sets an observer to listen for live pusher events, including errors, statuses, network quality, device information, and first frame rendering. |
| [setStatisticsObserver](docs-broadcast-sdk-for-android-api#VeLivePusher-setstatisticsobserver) | Sets an observer to periodically report push-stream statistics. |
| [release](docs-broadcast-sdk-for-android-api#VeLivePusher-release) | Stops capturing and pushing streams and destroys the pusher. Call this method after [stopPush](docs-broadcast-sdk-for-android-api#VeLivePusher-stoppush) is called. |
| [setRenderView](docs-broadcast-sdk-for-android-api#VeLivePusher-setrenderview) | Sets the preview for the local camera. If beauty AR is applied to the captured video or if it undergoes any other processing, the preview will display the processed video. |
| [setRenderFillMode](docs-broadcast-sdk-for-android-api#VeLivePusher-setrenderfillmode) | Sets fill mode for the local camera preview. |
| [setVideoMirror](docs-broadcast-sdk-for-android-api#VeLivePusher-setvideomirror) | Enables or disables mirroring for the local preview and the streamed video. |
| [startVideoCapture](docs-broadcast-sdk-for-android-api#VeLivePusher-startvideocapture) | Starts video capture. |
| [stopVideoCapture](docs-broadcast-sdk-for-android-api#VeLivePusher-stopvideocapture) | Stops video capture. |
| [startAudioCapture](docs-broadcast-sdk-for-android-api#VeLivePusher-startaudiocapture) | Starts audio capture. |
| [stopAudioCapture](docs-broadcast-sdk-for-android-api#VeLivePusher-stopaudiocapture) | Stops audio capture. |
| [switchVideoCapture](docs-broadcast-sdk-for-android-api#VeLivePusher-switchvideocapture) | Switches the video capture type. |
| [switchAudioCapture](docs-broadcast-sdk-for-android-api#VeLivePusher-switchaudiocapture) | Switches audio capture type. |
| [getCurrentVideoCaptureType](docs-broadcast-sdk-for-android-api#VeLivePusher-getcurrentvideocapturetype) | Gets the current video capture type. |
| [getCurrentAudioCaptureType](docs-broadcast-sdk-for-android-api#VeLivePusher-getcurrentaudiocapturetype) | Gets the current audio capture type. |
| [updateCustomImage](docs-broadcast-sdk-for-android-api#VeLivePusher-updatecustomimage) | Sets a static image to push. When using this method, you must call [startVideoCapture](docs-broadcast-sdk-for-android-api#VeLivePusher-startvideocapture) and set [VeLiveVideoCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoCaptureType) to `VeLiveVideoCaptureCustomImage`. |
| [getCameraDevice](docs-broadcast-sdk-for-android-api#VeLivePusher-getcameradevice) | Gets the camera manager. With the camera manager, you can do the following:<ul><li>Control the flashlight</li><li>Set the camera zoom</li><li>Set autofocus</li></ul> |
| [setVideoEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-setvideoencoderconfiguration) | Sets video encoding parameters for the pushed stream. |
| [getVideoEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-getvideoencoderconfiguration) | Gets video encoding parameters for the pushed stream. |
| [setAudioEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-setaudioencoderconfiguration) | Sets audio encoding parameters for the pushed stream. |
| [getAudioEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-getaudioencoderconfiguration) | Gets audio encoding parameters for the pushed stream. |
| [startPush](docs-broadcast-sdk-for-android-api#VeLivePusher-startpush) | Starts streaming. |
| [startPushWithUrls](docs-broadcast-sdk-for-android-api#VeLivePusher-startpushwithurls) | Starts streaming with one or more push stream addresses. |
| [stopPush](docs-broadcast-sdk-for-android-api#VeLivePusher-stoppush) | Stops streaming. |
| [isPushing](docs-broadcast-sdk-for-android-api#VeLivePusher-ispushing) | Checks whether the streaming is currently ongoing. You can use this method to query the status of the live pusher. |
| [setWatermark](docs-broadcast-sdk-for-android-api#VeLivePusher-setwatermark) | Sets a watermark for the pushed stream. |
| [startFileRecording](docs-broadcast-sdk-for-android-api#VeLivePusher-startfilerecording) | Starts local recording. |
| [stopFileRecording](docs-broadcast-sdk-for-android-api#VeLivePusher-stopfilerecording) | Stops local recording. |
| [setProperty](docs-broadcast-sdk-for-android-api#VeLivePusher-setproperty) | Set advanced configurations. You can contact BytePlus technical support for more information about how to use this method. |
| [pushExternalVideoFrame](docs-broadcast-sdk-for-android-api#VeLivePusher-pushexternalvideoframe) | Pushes an external video frame. |
| [pushExternalAudioFrame](docs-broadcast-sdk-for-android-api#VeLivePusher-pushexternalaudioframe) | Pushes an external audio frame. |
| [setOrientation](docs-broadcast-sdk-for-android-api#VeLivePusher-setorientation) | Sets the orientation of the pushed video frame. The default orientation is portrait. |
| [sendSeiMessage](docs-broadcast-sdk-for-android-api#VeLivePusher-sendseimessage) | Sends an SEI message through the video frame. The SEI messages are strings in JSON format. |
| [setMute](docs-broadcast-sdk-for-android-api#VeLivePusher-setmute) | Sets whether to mute the stream. |
| [isMute](docs-broadcast-sdk-for-android-api#VeLivePusher-ismute) | Checks whether the stream is muted. |
| [getVideoEffectManager](docs-broadcast-sdk-for-android-api#VeLivePusher-getvideoeffectmanager) | Gets the special effects manager. With the special effects manager, you can do the following:<ul><li>Set beauty AR</li><li>Set special effects</li><li>Set materials</li><li>Set stickers</li><li>Set filters</li></ul> |
| [addVideoFrameFilter](docs-broadcast-sdk-for-android-api#VeLivePusher-addvideoframefilter) | Sets custom video processing. |
| [getAudioDevice](docs-broadcast-sdk-for-android-api#VeLivePusher-getaudiodevice) | Gets the audio device manager. |
| [setAudioFrameFilter](docs-broadcast-sdk-for-android-api#VeLivePusher-setaudioframefilter) | Sets custom audio processing. |
| [getMixerManager](docs-broadcast-sdk-for-android-api#VeLivePusher-getmixermanager) | Gets the audio and video mixer. |
| [startMixSystemAudio](docs-broadcast-sdk-for-android-api#VeLivePusher-startmixsystemaudio) | Starts system audio capture. |
| [stopMixSystemAudio](docs-broadcast-sdk-for-android-api#VeLivePusher-stopmixsystemaudio) | Stops system audio capture. |
| [isScreenRecording](docs-broadcast-sdk-for-android-api#VeLivePusher-isscreenrecording) | Gets whether the SDK is capturing the screen at this moment. |
| [addVideoFrameListener](docs-broadcast-sdk-for-android-api#VeLivePusher-addvideoframelistener) | Adds a video frame listener. |
| [removeVideoFrameListener](docs-broadcast-sdk-for-android-api#VeLivePusher-removevideoframelistener) | Removes the video frame listener. |
| [addAudioFrameListener](docs-broadcast-sdk-for-android-api#VeLivePusher-addaudioframelistener) | Adds an audio frame listener. |
| [removeAudioFrameListener](docs-broadcast-sdk-for-android-api#VeLivePusher-removeaudioframelistener) | Removes the audio frame listener. |
| [snapshot](docs-broadcast-sdk-for-android-api#VeLivePusher-snapshot) | Takes a screenshot. |
| [setLogLevel](docs-broadcast-sdk-for-android-api#VeLivePusher-setloglevel) | Sets the level of the output log. |
| [setEGLContext](docs-broadcast-sdk-for-android-api#VeLivePusher-seteglcontext) | Sets the context of OpenGL. |
| [setEGLVersion](docs-broadcast-sdk-for-android-api#VeLivePusher-seteglversion) | Sets the version number of OpenGL. The default value is `2`. |
| [getEGLContext](docs-broadcast-sdk-for-android-api#VeLivePusher-geteglcontext) | Gets the context of OpenGL. |
| [removeVideoFrameFilter](docs-broadcast-sdk-for-android-api#VeLivePusher-removevideoframefilter) | Removes the video frame filter. |

## VeLiveMixerManager
| Method | Description |
| --- | --- |
| [updateStreamMixDescription](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-updatestreammixdescription) | Updates the configurations for audio and video mixing. |
| [addVideoStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-addvideostream) | Adds a video stream to the mixer. |
| [VeLiveMixerManager.addAudioStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-addaudiostream) | Adds an audio stream to the mixer. |
| [removeVideoStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-removevideostream) | Removes a non-primary video stream from the mixer. |
| [VeLiveMixerManager.addAudioStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-addaudiostream-2) | Adds an audio stream to the mixer, and sets the mixing type. |
| [removeAudioStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-removeaudiostream) | Removes a non-primary audio stream from the mixer. |
| [getOriginVideoStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-getoriginvideostream) | Gets the ID of the primary video stream. |
| [getOriginAudioStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-getoriginaudiostream) | Gets the ID of the primary audio stream. |
| [getOriginScreenStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-getoriginscreenstream) | Gets the ID of the primary screen stream. |
| [getOriginSystemAudioStream](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-getoriginsystemaudiostream) | Gets the ID of the primary system audio stream. |
| [sendCustomVideoFrame](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-sendcustomvideoframe) | Sends a custom video frame with a specified stream ID. |
| [sendCustomAudioFrame](docs-broadcast-sdk-for-android-api#VeLiveMixerManager-sendcustomaudioframe) | Sends a custom audio frame with a specified stream ID. |

## VeLiveVideoEffectManager
| Method | Description |
| --- | --- |
| [setupWithConfig](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setupwithconfig) | Initializes the special effects manager. |
| [updateLicense](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-updatelicense) | Updates the special effects license. This method is effective only if you authenticate the license online. |
| [setAlgorithmModelPath](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setalgorithmmodelpath) | Sets the path to the algorithm model package of the special effects. |
| [setEnable](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setenable) | Creates or destroys the special effects engine. |
| [setComposeNodes](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setcomposenodes) | Sets the special effects you want to apply to the video. You can choose effects from ComposeMakeup.bundle. |
| [appendComposeNodes](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-appendcomposenodes) | Adds one or more effects to the existing effects settings that you have configured by calling [setComposeNodes](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setcomposenodes). |
| [removeComposeNodes](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-removecomposenodes) | Removes one or more special effects resource set by the [setComposeNodes](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setcomposenodes) or [appendComposeNodes](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-appendcomposenodes) methods. |
| [updateComposerNodeIntensity](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-updatecomposernodeintensity) | Sets the intensity of a special effect. |
| [setFilter](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setfilter) | Sets the color filter. |
| [updateFilterIntensity](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-updatefilterintensity) | Sets the intensity of the color filter. |
| [setSticker](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setsticker) | Sets the sticker. |
| [setAdvancedFeature](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setadvancedfeature) | Advanced functions of BytePlus Effects. |

## VeLiveCameraDevice
| Method | Description |
| --- | --- |
| [setParameter](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-setparameter) | Sets camera parameters. |
| [getParameter](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-getparameter) | Gets camera parameters. |
| [getRealFpsRange](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-getrealfpsrange) | Gets the frame rate range supported by the camera. |
| [enableTorch](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-enabletorch) | Enables or disables the flashlight. |
| [setZoomRatio](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-setzoomratio) | Sets the zoom factor of the camera. |
| [getCurrentZoomRatio](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-getcurrentzoomratio) | Gets the current zoom factor of the camera. |
| [getMaxZoomRatio](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-getmaxzoomratio) | Gets the maximum zoom factor of the camera. |
| [getMinZoomRatio](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-getminzoomratio) | Gets the minimum zoom factor of the camera. |
| [isAutoFocusEnabled](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-isautofocusenabled) | Checks whether autofocus is supported. |
| [enableAutoFocus](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-enableautofocus) | Enables or disables autofocus. |
| [setFocusPosition](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-setfocusposition) | Sets the focus position of the camera. |
| [isExposurePositionSupported](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-isexposurepositionsupported) | Checks if manual exposure setting is available for the currently used camera. |
| [setExposurePosition](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-setexposureposition) | Sets the manual exposure position for the currently used camera. |
| [getMinExposureCompensation](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-getminexposurecompensation) | Gets the minimum exposure compensation of the camera. |
| [getMaxExposureCompensation](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-getmaxexposurecompensation) | Gets the maximum exposure compensation of the camera. |
| [setExposureCompensation](docs-broadcast-sdk-for-android-api#VeLiveCameraDevice-setexposurecompensation) | Sets the exposure compensation for the currently used camera. |

## VeLiveAudioDevice
| Method | Description |
| --- | --- |
| [setVoiceLoudness](docs-broadcast-sdk-for-android-api#VeLiveAudioDevice-setvoiceloudness) | Sets the volume. |
| [getVoiceLoudness](docs-broadcast-sdk-for-android-api#VeLiveAudioDevice-getvoiceloudness) | Gets the current volume. |

## VeLiveMediaPlayer
| Method | Description |
| --- | --- |
| [release](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-release) | Destroys the media player instance. |
| [setListener](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-setlistener) | Sets the observer for playback statuses. |
| [prepare](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-prepare) | Sets the file path. Supported file formats include MP3, AAC, M4A, WAV. |
| [start](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-start) | Start playback. |
| [stop](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-stop) | Stops playback. |
| [pause](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-pause) | Pauses playback. |
| [resume](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-resume) | Resumes playback. |
| [getDuration](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-getduration) | Gets the duration of the media file. |
| [seek](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-seek) | Sets the playback progress. |
| [enableMixer](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-enablemixer) | Enables or disables mixing the audio to the live stream. |
| [enableAutoEq](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-enableautoeq) | Enables or disables automatic volume equalization. |
| [setFrameListener](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-setframelistener) | Sets the observer for audio and video frames. |
| [setBGMVolume](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-setbgmvolume) | Sets the playback volume. |
| [setVoiceVolume](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-setvoicevolume) | Sets the audio capture volume. |
| [enableBGMLoop](docs-broadcast-sdk-for-android-api#VeLiveMediaPlayer-enablebgmloop) | Sets whether to loop the video. |

# Callbacks
| Method | Description |
| --- | --- |
| [onResult](docs-broadcast-sdk-for-android-callback#VeLiveVideoEffectCallback-onresult) | Occurs when special effects are processed. |
| [onEffectHandle](docs-broadcast-sdk-for-android-callback#VeLiveVideoEffectHandleCallback-oneffecthandle) | Occurs when the [setAdvancedFeature](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setadvancedfeature) method is called. Please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method. |
| [VeLivePusherObserver.onError](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onerror) | Occurs when a streaming error occurs. |
| [onStatusChange](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onstatuschange) | Occurs when the streaming status changes. |
| [onFirstVideoFrame](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onfirstvideoframe) | Occurs when the live pusher sends the first video frame. |
| [onFirstAudioFrame](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onfirstaudioframe) | Occurs when the live pusher sends the first audio frame. |
| [onCameraOpened](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-oncameraopened) | Occurs when the camera is turned on or turned off. |
| [onMicrophoneOpened](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onmicrophoneopened) | Occurs when the microphone is turned on or turned off. |
| [onScreenRecording](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onscreenrecording) | Occurs when screen capture is turned on or turned off. |
| [onNetworkQuality](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onnetworkquality) | Occurs when the network quality changes. |
| [onAudioPowerQuality](docs-broadcast-sdk-for-android-callback#VeLivePusherObserver-onaudiopowerquality) | Occurs when the audio volume level changes. |
| [onStatistics](docs-broadcast-sdk-for-android-callback#VeLivePusherStatisticsObserver-onstatistics) | Occurs periodically to report streaming statistics. By default, the callback is triggered every 5 seconds. You can call [setStatisticsObserver](docs-broadcast-sdk-for-android-api#VeLivePusher-setstatisticsobserver) to modify the callback time interval. |
| [onLogMonitor](docs-broadcast-sdk-for-android-callback#VeLivePusherStatisticsObserver-onlogmonitor) | Occurs periodically to return log information. |
| [onFileRecordingStarted](docs-broadcast-sdk-for-android-callback#VeLiveFileRecordingListener-onfilerecordingstarted) | Occurs when recording starts. |
| [onFileRecordingStopped](docs-broadcast-sdk-for-android-callback#VeLiveFileRecordingListener-onfilerecordingstopped) | Occurs when recording stops. |
| [onFileRecordingError](docs-broadcast-sdk-for-android-callback#VeLiveFileRecordingListener-onfilerecordingerror) | Occurs when an error occurs during recording. |
| [onVideoFrame](docs-broadcast-sdk-for-android-callback#VeLiveMediaPlayerFrameListener-onvideoframe) | Occurs when the media player decodes a video frame. |
| [onAudioFrame](docs-broadcast-sdk-for-android-callback#VeLiveMediaPlayerFrameListener-onaudioframe) | Occurs when the media player decodes an audio frame. |
| [VeLiveMediaPlayerListener.onError](docs-broadcast-sdk-for-android-callback#VeLiveMediaPlayerListener-onerror) | Occurs when an error occurs in the media player. |
| [onStop](docs-broadcast-sdk-for-android-callback#VeLiveMediaPlayerListener-onstop) | Occurs when the playback stops. |
| [onProgress](docs-broadcast-sdk-for-android-callback#VeLiveMediaPlayerListener-onprogress) | Occurs every 100 ms to report the playback progress. |
| [onStart](docs-broadcast-sdk-for-android-callback#VeLiveMediaPlayerListener-onstart) | Occurs when the playback starts. |
| [onSnapshotComplete](docs-broadcast-sdk-for-android-callback#VeLiveSnapshotListener-onsnapshotcomplete) | Screenshot success callback. |
| [onAudioProcess](docs-broadcast-sdk-for-android-callback#VeLiveAudioFrameFilter-onaudioprocess) | Occurs when the SDK captures an audio frame. You can use the callback to process the frame in a custom way. |
| [onVideoProcess](docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameFilter-onvideoprocess) | Occurs when the SDK captures a video frame. You can use the callback to process the frame in a custom way. |
| [getObservedAudioFrameSource](docs-broadcast-sdk-for-android-callback#VeLiveAudioFrameListener-getobservedaudioframesource) | Sets the source of the audio frame that the listener needs. |
| [getObservedVideoFrameSource](docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-getobservedvideoframesource) | Sets the source of the video frame that the listener needs. |
| [onCaptureAudioFrame](docs-broadcast-sdk-for-android-callback#VeLiveAudioFrameListener-oncaptureaudioframe) | Occurs when an audio frame is captured. This callback will be triggered only if you return `VeLiveAudioFrameSourceCapture` when implementing the [getObservedAudioFrameSource](docs-broadcast-sdk-for-android-callback#VeLiveAudioFrameListener-getobservedaudioframesource) callback method. |
| [onPreEncodeAudioFrame](docs-broadcast-sdk-for-android-callback#VeLiveAudioFrameListener-onpreencodeaudioframe) | Occurs when an audio frame is to be encoded. This callback will be triggered only if you return `VeLiveAudioFrameSourcePreEncode` when implementing the [getObservedAudioFrameSource](docs-broadcast-sdk-for-android-callback#VeLiveAudioFrameListener-getobservedaudioframesource) callback method. |
| [onCaptureVideoFrame](docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-oncapturevideoframe) | Occurs when a video frame is captured. This callback will be triggered only if you return `VeLiveVideoFrameSourceCapture` when implementing the [getObservedVideoFrameSource](docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-getobservedvideoframesource) callback method. |
| [onPreEncodeVideoFrame](docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-onpreencodevideoframe) | Occurs when a video frame is to be encoded. This callback will be triggered only if you return `VeLiveVideoFrameSourcePreEncode` when implementing the [getObservedVideoFrameSource](docs-broadcast-sdk-for-android-callback#VeLiveVideoFrameListener-getobservedvideoframesource) callback method. |

<span id="VeLiveCameraDevice"></span>
# VeLiveCameraDevice
```java
public interface com.ss.avframework.live.VeLiveCameraDevice
```
The camera manager.
## Member Functions
| Return | Name |
| --- | --- |
| int | [setParameter](#VeLiveCameraDevice-setparameter) |
| Parameter | [getParameter](#VeLiveCameraDevice-getparameter) |
| int[] | [getRealFpsRange](#VeLiveCameraDevice-getrealfpsrange) |
| int | [enableTorch](#VeLiveCameraDevice-enabletorch) |
| int | [setZoomRatio](#VeLiveCameraDevice-setzoomratio) |
| float | [getCurrentZoomRatio](#VeLiveCameraDevice-getcurrentzoomratio) |
| float | [getMaxZoomRatio](#VeLiveCameraDevice-getmaxzoomratio) |
| float | [getMinZoomRatio](#VeLiveCameraDevice-getminzoomratio) |
| boolean | [isAutoFocusEnabled](#VeLiveCameraDevice-isautofocusenabled) |
| int | [enableAutoFocus](#VeLiveCameraDevice-enableautofocus) |
| int | [setFocusPosition](#VeLiveCameraDevice-setfocusposition) |
| boolean | [isExposurePositionSupported](#VeLiveCameraDevice-isexposurepositionsupported) |
| int | [setExposurePosition](#VeLiveCameraDevice-setexposureposition) |
| float | [getMinExposureCompensation](#VeLiveCameraDevice-getminexposurecompensation) |
| float | [getMaxExposureCompensation](#VeLiveCameraDevice-getmaxexposurecompensation) |
| int | [setExposureCompensation](#VeLiveCameraDevice-setexposurecompensation) |

## Instructions
<span id="VeLiveCameraDevice-setparameter"></span>
### setParameter
```java
int com.ss.avframework.live.VeLiveCameraDevice.setParameter(Parameter parameter)
```
Sets camera parameters.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| parameter | Parameter | The camera parameter object, which specifies the camera parameters. |


**Notes**

Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-getparameter"></span>
### getParameter
```java
Parameter com.ss.avframework.live.VeLiveCameraDevice.getParameter()
```
Gets camera parameters.

**Return Value**



The value of the camera parameter. The data type is determined by the parameter name you set when calling the method.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-getrealfpsrange"></span>
### getRealFpsRange
```java
int[] com.ss.avframework.live.VeLiveCameraDevice.getRealFpsRange()
```
Gets the frame rate range supported by the camera.

**Return Value**



The frame rate range supported by the camera.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-enabletorch"></span>
### enableTorch
```java
int com.ss.avframework.live.VeLiveCameraDevice.enableTorch(boolean enable)
```
Enables or disables the flashlight.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Whether to enable the flashlight. <br/><ul><li>true: Enable;</li><li>false: (Default) Disable.</li></ul> |


**Return Value**



- 0: Success;
- ≠ 0: Failure.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-setzoomratio"></span>
### setZoomRatio
```java
int com.ss.avframework.live.VeLiveCameraDevice.setZoomRatio(float ratio)
```
Sets the zoom factor of the camera.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| ratio | float | The zoom factor. The SDK uses the original size by default. The range of the zoom factor is [[getMinZoomRatio](#VeLiveCameraDevice-getminzoomratio),[getMaxZoomRatio](#VeLiveCameraDevice-getmaxzoomratio)]. |


**Return Value**



- 0: Success;
- ≠ 0: Failure.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-getcurrentzoomratio"></span>
### getCurrentZoomRatio
```java
float com.ss.avframework.live.VeLiveCameraDevice.getCurrentZoomRatio()
```
Gets the current zoom factor of the camera.

**Return Value**



- ≤ 0: The camera does not support zooming;
- \> 0: The zoom factor.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-getmaxzoomratio"></span>
### getMaxZoomRatio
```java
float com.ss.avframework.live.VeLiveCameraDevice.getMaxZoomRatio()
```
Gets the maximum zoom factor of the camera.

**Return Value**



- ≤ 0: The camera does not support zooming;
- \> 0: The maximum zoom factor.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-getminzoomratio"></span>
### getMinZoomRatio
```java
float com.ss.avframework.live.VeLiveCameraDevice.getMinZoomRatio()
```
Gets the minimum zoom factor of the camera.

**Return Value**



- ≤ 0: The camera does not support zooming;
- \> 0: The minimum zoom factor.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-isautofocusenabled"></span>
### isAutoFocusEnabled
```java
boolean com.ss.avframework.live.VeLiveCameraDevice.isAutoFocusEnabled()
```
Checks whether autofocus is supported.

**Return Value**



- true: Supported;
- false: Not supported.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-enableautofocus"></span>
### enableAutoFocus
```java
int com.ss.avframework.live.VeLiveCameraDevice.enableAutoFocus(boolean enable)
```
Enables or disables autofocus.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Whether to enable autofocus.<ul><li>true: (Default) Enable;</li><li>false: Disable.</li></ul> |


**Return Value**



- 0: Success;
- ≠ 0: Failure.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-setfocusposition"></span>
### setFocusPosition
```java
int com.ss.avframework.live.VeLiveCameraDevice.setFocusPosition(
    int viewW,
    int viewH,
    int x,
    int y
)
```
Sets the focus position of the camera.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| viewW | int | The width of the current view. |
| viewH | int | The height of the current view. |
| x | int | The horizontal coordinate of the focus point from the upper left corner of the current view. |
| y | int | The vertical coordinate of the focus point from the upper left corner of the current view. |


**Return Value**



- 0: Success;
- ≠ 0: Failure.

**Notes**


Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-isexposurepositionsupported"></span>
### isExposurePositionSupported
```java
boolean com.ss.avframework.live.VeLiveCameraDevice.isExposurePositionSupported()
```
Checks if manual exposure setting is available for the currently used camera.

**Return Value**

- YES: Available.
- NO: Unavailable.

**Notes**

You must call [startVideoCapture](#VeLivePusher-startvideocapture) to start SDK internal video capturing before calling this API.
<span id="VeLiveCameraDevice-setexposureposition"></span>
### setExposurePosition
```java
int com.ss.avframework.live.VeLiveCameraDevice.setExposurePosition(
    int viewW,
    int viewH,
    int x,
    int y
)
```
Sets the manual exposure position for the currently used camera.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| viewW | int | The width of the current view. |
| viewH | int | The height of the current view. |
| x | int | The horizontal coordinate of the focus point from the upper left corner of the current view. |
| y | int | The vertical coordinate of the focus point from the upper left corner of the current view. |


**Return Value**

- =0: Success.
- ≠0: Failure.

**Notes**

- You must call [startVideoCapture](#VeLivePusher-startvideocapture) to start SDK internal video capturing, and use SDK internal rendering before calling this API.
- The camera exposure point setting will be invalid after calling [stopVideoCapture](#VeLivePusher-stopvideocapture) to stop internal capturing.
<span id="VeLiveCameraDevice-getminexposurecompensation"></span>
### getMinExposureCompensation
```java
float com.ss.avframework.live.VeLiveCameraDevice.getMinExposureCompensation()
```
Gets the minimum exposure compensation of the camera.

**Return Value**

- ≤0: The camera does not support exposure;
- \>0: The minimum exposure compensation.

**Notes**

Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-getmaxexposurecompensation"></span>
### getMaxExposureCompensation
```java
float com.ss.avframework.live.VeLiveCameraDevice.getMaxExposureCompensation()
```
Gets the maximum exposure compensation of the camera.

**Return Value**

- ≤0: The camera does not support exposure;
- \>0: The maximum exposure compensation.

**Notes**

Call this method after calling [startVideoCapture](#VeLivePusher-startvideocapture) to start camera capture.
<span id="VeLiveCameraDevice-setexposurecompensation"></span>
### setExposureCompensation
```java
int com.ss.avframework.live.VeLiveCameraDevice.setExposureCompensation(float value)
```
Sets the exposure compensation for the currently used camera.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| value | float | The range of the exposure compensation is [[getMinExposureCompensation](#VeLiveCameraDevice-getminexposurecompensation),[getMaxExposureCompensation](#VeLiveCameraDevice-getmaxexposurecompensation)], Default to 0, which means no exposure compensation. |


**Return Value**

- =0: Success.
- ≠0: Failure.

**Notes**



- You must call [startVideoCapture](#VeLivePusher-startvideocapture) to start SDK internal video capturing, and use SDK internal rendering before calling this API.
- The camera exposure compensation setting will be invalid after calling [stopVideoCapture](#VeLivePusher-stopvideocapture) to stop internal capturing.
<span id="VeLiveVideoEffectManager"></span>
# VeLiveVideoEffectManager
```java
public interface com.ss.avframework.live.VeLiveVideoEffectManager
```
The special effects manager. With the special effects manager, you can do the following:
- Set beauty AR
- Set special effects
- Set materials
- Set stickers
- Set filters
## Member Functions
| Return | Name |
| --- | --- |
| int | [setupWithConfig](#VeLiveVideoEffectManager-setupwithconfig) |
| void | [updateLicense](#VeLiveVideoEffectManager-updatelicense) |
| void | [setEnable](#VeLiveVideoEffectManager-setenable) |
| int | [setAlgorithmModelPath](#VeLiveVideoEffectManager-setalgorithmmodelpath) |
| int | [setComposeNodes](#VeLiveVideoEffectManager-setcomposenodes) |
| int | [appendComposeNodes](#VeLiveVideoEffectManager-appendcomposenodes) |
| int | [removeComposeNodes](#VeLiveVideoEffectManager-removecomposenodes) |
| int | [updateComposerNodeIntensity](#VeLiveVideoEffectManager-updatecomposernodeintensity) |
| int | [setFilter](#VeLiveVideoEffectManager-setfilter) |
| int | [updateFilterIntensity](#VeLiveVideoEffectManager-updatefilterintensity) |
| int | [setSticker](#VeLiveVideoEffectManager-setsticker) |
| int | [setAdvancedFeature](#VeLiveVideoEffectManager-setadvancedfeature) |

## Instructions
<span id="VeLiveVideoEffectManager-setupwithconfig"></span>
### setupWithConfig
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.setupWithConfig(VeLiveVideoEffectLicenseConfiguration config)
```
Initializes the special effects manager.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| config | VeLiveVideoEffectLicenseConfiguration | The special effects configurations. See [VeLiveVideoEffectLicenseConfiguration](docs-broadcast-sdk-for-android-type-definition#VeLivePusherDef-VeLiveVideoEffectLicenseConfiguration) for details. |


**Return Value**



- 0: Success;
- -1: Failure.
<span id="VeLiveVideoEffectManager-updatelicense"></span>
### updateLicense
```java
void com.ss.avframework.live.VeLiveVideoEffectManager.updateLicense(VeLiveVideoEffectCallback callback)
```
Updates the special effects license. This method is effective only if you authenticate the license online.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| callback | VeLiveVideoEffectCallback | The result callback. |


**Notes**

- Call this method after you set the video effects license by calling [setupWithConfig](#VeLiveVideoEffectManager-setupwithconfig).
- This method is an asynchronous operation.
<span id="VeLiveVideoEffectManager-setenable"></span>
### setEnable
```java
void com.ss.avframework.live.VeLiveVideoEffectManager.setEnable(
    boolean enable,
    VeLiveVideoEffectCallback callback
)
```
Creates or destroys the special effects engine.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Whether to create or destroy the special effects engine.<br/><ul><li>true: Create;</li><li>false: (Default) Destroy.</li></ul> |
| callback | VeLiveVideoEffectCallback | [VeLiveVideoEffectCallback](docs-broadcast-sdk-for-android-callback#VeLiveVideoEffectCallback), the listener for special effect events. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

- Call this method after calling [setupwithconfig](#VeLiveVideoEffectManager-setupwithconfig) and [setAlgorithmModelPath](#VeLiveVideoEffectManager-setalgorithmmodelpath);
- This method does not enable or disable video special effects. Call [setComposeNodes](#VeLiveVideoEffectManager-setcomposenodes) after calling this method to enable video special effects;
- In most cases, the special effects engine will be destroyed when the effects manager is destroyed. However, if you have high performance requirements, you can call this method to manually destroy the special effects engine when you are not using special effects-related features;
- Creating or destroying the special effects engine repeatedly can result in increased processing time.
<span id="VeLiveVideoEffectManager-setalgorithmmodelpath"></span>
### setAlgorithmModelPath
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.setAlgorithmModelPath(String path)
```
Sets the path to the algorithm model package of the special effects.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| path | String | The path to the algorithm model package of the special effects. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

Call this method after you set the special effects license by calling [setupWithConfig](#VeLiveVideoEffectManager-setupwithconfig).
<span id="VeLiveVideoEffectManager-setcomposenodes"></span>
### setComposeNodes
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.setComposeNodes(String[] nodes)
```
Sets the special effects you want to apply to the video. You can choose effects from ComposeMakeup.bundle.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| nodes | String[] | The paths to the special effects resource. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

- Call this method after calling [setEnable](#VeLiveVideoEffectManager-setenable).
- If you make multiple calls to this method, only the last call takes effect;
- To add more effects to the existing effects settings, call [appendComposeNodes](#VeLiveVideoEffectManager-appendcomposenodes).
<span id="VeLiveVideoEffectManager-appendcomposenodes"></span>
### appendComposeNodes
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.appendComposeNodes(String[] nodes)
```
Adds one or more effects to the existing effects settings that you have configured by calling [setComposeNodes](#VeLiveVideoEffectManager-setcomposenodes).

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| nodes | String[] | The paths to the special effects resource. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

Call this method after calling [setEnable](#VeLiveVideoEffectManager-setenable).
<span id="VeLiveVideoEffectManager-removecomposenodes"></span>
### removeComposeNodes
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.removeComposeNodes(String[] nodes)
```
Removes one or more special effects resource set by the [setComposeNodes](#VeLiveVideoEffectManager-setcomposenodes) or [appendComposeNodes](#VeLiveVideoEffectManager-appendcomposenodes) methods.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| nodes | String[] | The paths to the special effects resource. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

Call this method after calling [setEnable](#VeLiveVideoEffectManager-setenable).
<span id="VeLiveVideoEffectManager-updatecomposernodeintensity"></span>
### updateComposerNodeIntensity
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.updateComposerNodeIntensity(
    String node,
    String key,
    float intensity
)
```
Sets the intensity of a special effect.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| node | String | The path to the special effects resource. |
| key | String | The key of the resource. |
| intensity | float | The intensity of the effect. The value range is [0.0, 1.0]. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

- Call this method after calling [setComposeNodes](#VeLiveVideoEffectManager-setcomposenodes) or [appendComposeNodes](#VeLiveVideoEffectManager-appendcomposenodes);
- This method is only applicable to special effects that contain the three parameters mentioned above. For effects that do not have the intensity parameter, such as stickers, the method does not have any effect.
<span id="VeLiveVideoEffectManager-setfilter"></span>
### setFilter
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.setFilter(String path)
```
Sets the color filter.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| path | String | The absolute path to the filter resource. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

Call this method after calling [setEnable](#VeLiveVideoEffectManager-setenable).
<span id="VeLiveVideoEffectManager-updatefilterintensity"></span>
### updateFilterIntensity
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.updateFilterIntensity(float intensity)
```
Sets the intensity of the color filter.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| intensity | float | The intensity. The value range is [0.0, 1.0]. |


**Return Value**

- 0: Success;
- -1: Failure.

**Notes**

Call this method after calling [setFilter](#VeLiveVideoEffectManager-setfilter).
<span id="VeLiveVideoEffectManager-setsticker"></span>
### setSticker
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.setSticker(String path)
```
Sets the sticker.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| path | String | The absolute path to the sticker resource. |


**Return Value**



- 0: Success;
- -1: Failure.

**Notes**

Call this method after calling [setEnable](#VeLiveVideoEffectManager-setenable).
<span id="VeLiveVideoEffectManager-setadvancedfeature"></span>
### setAdvancedFeature
```java
int com.ss.avframework.live.VeLiveVideoEffectManager.setAdvancedFeature(
    VeLiveVideoEffectHandleCallback callback,
    boolean isGLThread,
    boolean isAsync
)
```
Advanced functions of BytePlus Effects.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| callback | VeLiveVideoEffectHandleCallback | A callback function that takes a handle as an argument. |
| isGLThread | boolean | Whether the callback is called in the GL thread. |
| isAsync | boolean | Whether the callback is executed synchronously. |


**Notes**

Call the method after calling [setEnable](#VeLiveVideoEffectManager-setenable). Do not perform frequent synchronization operations in the main thread.
<span id="VeLivePusher"></span>
# VeLivePusher
```java
public interface com.ss.avframework.live.VeLivePusher
```
The live pusher.
## Static Functions
| Return | Name |
| --- | --- |
| static void | [setLogLevel](#VeLivePusher-setloglevel) |
| static void | [setEGLVersion](#VeLivePusher-seteglversion) |
| static void | [setEGLContext](#VeLivePusher-seteglcontext) |
| static EGLContext | [getEGLContext](#VeLivePusher-geteglcontext) |

## Member Functions
| Return | Name |
| --- | --- |
| void | [release](#VeLivePusher-release) |
| void | [setObserver](#VeLivePusher-setobserver) |
| void | [setStatisticsObserver](#VeLivePusher-setstatisticsobserver) |
| void | [setRenderView](#VeLivePusher-setrenderview) |
| void | [setRenderFillMode](#VeLivePusher-setrenderfillmode) |
| void | [setVideoMirror](#VeLivePusher-setvideomirror) |
| void | [startVideoCapture](#VeLivePusher-startvideocapture) |
| void | [stopVideoCapture](#VeLivePusher-stopvideocapture) |
| void | [startAudioCapture](#VeLivePusher-startaudiocapture) |
| void | [stopAudioCapture](#VeLivePusher-stopaudiocapture) |
| void | [switchVideoCapture](#VeLivePusher-switchvideocapture) |
| void | [switchAudioCapture](#VeLivePusher-switchaudiocapture) |
| VeLiveVideoCaptureType | [getCurrentVideoCaptureType](#VeLivePusher-getcurrentvideocapturetype) |
| VeLiveAudioCaptureType | [getCurrentAudioCaptureType](#VeLivePusher-getcurrentaudiocapturetype) |
| void | [updateCustomImage](#VeLivePusher-updatecustomimage) |
| VeLiveCameraDevice | [getCameraDevice](#VeLivePusher-getcameradevice) |
| void | [setVideoEncoderConfiguration](#VeLivePusher-setvideoencoderconfiguration) |
| VeLiveVideoEncoderConfiguration | [getVideoEncoderConfiguration](#VeLivePusher-getvideoencoderconfiguration) |
| void | [setAudioEncoderConfiguration](#VeLivePusher-setaudioencoderconfiguration) |
| VeLiveAudioEncoderConfiguration | [getAudioEncoderConfiguration](#VeLivePusher-getaudioencoderconfiguration) |
| void | [startPush](#VeLivePusher-startpush) |
| void | [startPushWithUrls](#VeLivePusher-startpushwithurls) |
| void | [stopPush](#VeLivePusher-stoppush) |
| boolean | [isPushing](#VeLivePusher-ispushing) |
| int | [setWatermark](#VeLivePusher-setwatermark) |
| void | [startFileRecording](#VeLivePusher-startfilerecording) |
| void | [stopFileRecording](#VeLivePusher-stopfilerecording) |
| int | [setProperty](#VeLivePusher-setproperty) |
| int | [pushExternalVideoFrame](#VeLivePusher-pushexternalvideoframe) |
| int | [pushExternalAudioFrame](#VeLivePusher-pushexternalaudioframe) |
| void | [setOrientation](#VeLivePusher-setorientation) |
| int | [sendSeiMessage](#VeLivePusher-sendseimessage) |
| void | [setMute](#VeLivePusher-setmute) |
| boolean | [isMute](#VeLivePusher-ismute) |
| VeLiveVideoEffectManager | [getVideoEffectManager](#VeLivePusher-getvideoeffectmanager) |
| int | [addVideoFrameFilter](#VeLivePusher-addvideoframefilter) |
| int | [removeVideoFrameFilter](#VeLivePusher-removevideoframefilter) |
| VeLiveAudioDevice | [getAudioDevice](#VeLivePusher-getaudiodevice) |
| void | [setAudioFrameFilter](#VeLivePusher-setaudioframefilter) |
| VeLiveMediaPlayer | [createPlayer](#VeLivePusher-createplayer) |
| VeLiveMixerManager | [getMixerManager](#VeLivePusher-getmixermanager) |
| void | [startMixSystemAudio](#VeLivePusher-startmixsystemaudio) |
| void | [stopMixSystemAudio](#VeLivePusher-stopmixsystemaudio) |
| boolean | [isScreenRecording](#VeLivePusher-isscreenrecording) |
| int | [addVideoFrameListener](#VeLivePusher-addvideoframelistener) |
| int | [removeVideoFrameListener](#VeLivePusher-removevideoframelistener) |
| int | [addAudioFrameListener](#VeLivePusher-addaudioframelistener) |
| int | [removeAudioFrameListener](#VeLivePusher-removeaudioframelistener) |
| void | [snapshot](#VeLivePusher-snapshot) |

## Instructions
<span id="VeLivePusher-setloglevel"></span>
### setLogLevel
```java
static void com.ss.avframework.live.VeLivePusher.setLogLevel(VeLivePusherLogLevel logLevel)
```
Sets the level of the output log.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| logLevel | VeLivePusherLogLevel | The log level. See [VeLivePusherLogLevel](broadcast-sdk-for-android-type-definition#VeLivePusherLogLevel) for details. |

<span id="VeLivePusher-seteglversion"></span>
### setEGLVersion
```java
static void com.ss.avframework.live.VeLivePusher.setEGLVersion(int version)
```
Sets the version number of OpenGL. The default value is `2`.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| version | int | The version number of OpenGL. Supported values include `2` and `3`， which correspond to OpenGL 2.0 and 3.0 respectively. |

<span id="VeLivePusher-seteglcontext"></span>
### setEGLContext
```java
static void com.ss.avframework.live.VeLivePusher.setEGLContext(EGLContext context)
```
Sets the context of OpenGL.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| context | EGLContext | The context of OpenGL. |

<span id="VeLivePusher-geteglcontext"></span>
### getEGLContext
```java
static EGLContext com.ss.avframework.live.VeLivePusher.getEGLContext()
```
Gets the context of OpenGL.

**Return Value**



The context of the current OpenGL.
<span id="VeLivePusher-release"></span>
### release
```java
void com.ss.avframework.live.VeLivePusher.release()
```
Stops capturing and pushing streams and destroys the pusher. Call this method after [stopPush](#VeLivePusher-stoppush) is called.
<span id="VeLivePusher-setobserver"></span>
### setObserver
```java
void com.ss.avframework.live.VeLivePusher.setObserver(VeLivePusherObserver observer)
```
Sets an observer to listen for live pusher events, including errors, statuses, network quality, device information, and first frame rendering.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| observer | VeLivePusherObserver | The observer. Refer to [VeLivePusherObserver](broadcast-sdk-for-android-callback#VeLivePusherObserver) for details. |


**Notes**



- This method must be called after the live pusher is created;
- If you make multiple calls to this method, only the last call takes effect.
<span id="VeLivePusher-setstatisticsobserver"></span>
### setStatisticsObserver
```java
void com.ss.avframework.live.VeLivePusher.setStatisticsObserver(
    VeLivePusherStatisticsObserver observer,
    int interval
)
```
Sets an observer to periodically report push-stream statistics.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| observer | VeLivePusherStatisticsObserver | The observer. Refer to [VeLivePusherStatisticsObserver](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLivePusherStatisticsObserver) for details. |
| interval | int | The time interval between two callbacks, in seconds. The default value is `5`. |


**Notes**



- This method must be called after the live pusher is created;
- If you make multiple calls to this method, only the last call takes effect.
<span id="VeLivePusher-setrenderview"></span>
### setRenderView
```java
void com.ss.avframework.live.VeLivePusher.setRenderView(View view)
```
Sets the preview for the local camera. If beauty AR is applied to the captured video or if it undergoes any other processing, the preview will display the processed video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| view | View | The preview view. |

<span id="VeLivePusher-setrenderfillmode"></span>
### setRenderFillMode
```java
void com.ss.avframework.live.VeLivePusher.setRenderFillMode(VeLivePusherRenderMode mode)
```
Sets fill mode for the local camera preview.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| mode | VeLivePusherRenderMode | The fill mode. |

<span id="VeLivePusher-setvideomirror"></span>
### setVideoMirror
```java
void com.ss.avframework.live.VeLivePusher.setVideoMirror(
    VeLiveVideoMirrorType type,
    boolean mirror
)
```
Enables or disables mirroring for the local preview and the streamed video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveVideoMirrorType | Mirror mode. See [VeLiveVideoMirrorType](broadcast-sdk-for-android-type-definition#VeLiveVideoMirrorType) for details. |
| mirror | boolean | Whether to enable mirroring. <br/><ul><li>true: Enable;</li><li>false: Disable.</li></ul> |

<span id="VeLivePusher-startvideocapture"></span>
### startVideoCapture
```java
void com.ss.avframework.live.VeLivePusher.startVideoCapture(VeLiveVideoCaptureType type)
```
Starts video capture.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveVideoCaptureType | The video capture type. See [VeLiveVideoCaptureType](broadcast-sdk-for-android-type-definition#VeLiveVideoCaptureType) for details. |


**Notes**


After calling this method, you can stop video capture by calling [stopVideoCapture](#VeLivePusher-stopvideocapture).
<span id="VeLivePusher-stopvideocapture"></span>
### stopVideoCapture
```java
void com.ss.avframework.live.VeLivePusher.stopVideoCapture()
```
Stops video capture.

**Notes**


After calling this method, you can start video capture by calling [startVideoCapture](#VeLivePusher-startvideocapture).
<span id="VeLivePusher-startaudiocapture"></span>
### startAudioCapture
```java
void com.ss.avframework.live.VeLivePusher.startAudioCapture(VeLiveAudioCaptureType type)
```
Starts audio capture.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveAudioCaptureType | The audio capture type. See [VeLiveAudioCaptureType](broadcast-sdk-for-android-type-definition#VeLiveAudioCaptureType) for details. |


**Notes**


After calling this method, you can stop audio capture by calling [stopAudioCapture](#VeLivePusher-stopaudiocapture).
<span id="VeLivePusher-stopaudiocapture"></span>
### stopAudioCapture
```java
void com.ss.avframework.live.VeLivePusher.stopAudioCapture()
```
Stops audio capture.

**Notes**


After calling this method, you can start audio capture by calling [startAudioCapture](#VeLivePusher-startaudiocapture).
<span id="VeLivePusher-switchvideocapture"></span>
### switchVideoCapture
```java
void com.ss.avframework.live.VeLivePusher.switchVideoCapture(VeLiveVideoCaptureType type)
```
Switches the video capture type.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveVideoCaptureType | The video capture type. See [VeLiveVideoCaptureType](broadcast-sdk-for-android-type-definition#VeLiveVideoCaptureType) for details. |


**Notes**


This method must be called after [startVideoCapture](#VeLivePusher-startvideocapture) is called.
<span id="VeLivePusher-switchaudiocapture"></span>
### switchAudioCapture
```java
void com.ss.avframework.live.VeLivePusher.switchAudioCapture(VeLiveAudioCaptureType type)
```
Switches audio capture type.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveAudioCaptureType | The audio capture type. See [VeLiveAudioCaptureType](broadcast-sdk-for-android-type-definition#VeLiveAudioCaptureType) for details. |


**Notes**


This method must be called after [startVideoCapture](#VeLivePusher-startvideocapture) is called.
<span id="VeLivePusher-getcurrentvideocapturetype"></span>
### getCurrentVideoCaptureType
```java
VeLiveVideoCaptureType com.ss.avframework.live.VeLivePusher.getCurrentVideoCaptureType()
```
Gets the current video capture type.

**Return Value**

The video capture type. See [VeLiveVideoCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoCaptureType) for details.
<span id="VeLivePusher-getcurrentaudiocapturetype"></span>
### getCurrentAudioCaptureType
```java
VeLiveAudioCaptureType com.ss.avframework.live.VeLivePusher.getCurrentAudioCaptureType()
```
Gets the current audio capture type.

**Return Value**

The audio capture type. See [VeLiveAudioCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioCaptureType) for details.
<span id="VeLivePusher-updatecustomimage"></span>
### updateCustomImage
```java
void com.ss.avframework.live.VeLivePusher.updateCustomImage(Bitmap image)
```
Sets a static image to push. When using this method, you must call [startVideoCapture](#VeLivePusher-startvideocapture) and set [VeLiveVideoCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoCaptureType) to `VeLiveVideoCaptureCustomImage`.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| image | Bitmap | The static image to push. |

<span id="VeLivePusher-getcameradevice"></span>
### getCameraDevice
```java
VeLiveCameraDevice com.ss.avframework.live.VeLivePusher.getCameraDevice()
```
Gets the camera manager. With the camera manager, you can do the following:
- Control the flashlight
- Set the camera zoom
- Set autofocus

**Return Value**

The camera manager. See [VeLiveCameraDevice](#VeLiveCameraDevice) for details.

**Notes**

To use this method, you must first call startVideoCapture and set [VeLiveVideoCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoCaptureType) to `VeLiveVideoCaptureFrontCamera` or `VeLiveVideoCaptureBackCamera`.
<span id="VeLivePusher-setvideoencoderconfiguration"></span>
### setVideoEncoderConfiguration
```java
void com.ss.avframework.live.VeLivePusher.setVideoEncoderConfiguration(VeLiveVideoEncoderConfiguration config)
```
Sets video encoding parameters for the pushed stream.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| config | VeLiveVideoEncoderConfiguration | The video encoding parameters, including the video resolution, encoding format, target bitrate, and GOP size. For details, see [VeLiveVideoEncoderConfiguration](docs-broadcast-sdk-for-android-type-definition#velivevideoencoderconfiguration). |


**Notes**

This method can be called before or after live streaming starts.
<span id="VeLivePusher-getvideoencoderconfiguration"></span>
### getVideoEncoderConfiguration
```java
VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusher.getVideoEncoderConfiguration()
```
Gets video encoding parameters for the pushed stream.

**Return Value**

The video encoding parameters, including the video resolution, encoding format, target bitrate, and GOP size. For details, see [VeLiveVideoEncoderConfiguration](docs-broadcast-sdk-for-android-type-definition#velivevideoencoderconfiguration).
<span id="VeLivePusher-setaudioencoderconfiguration"></span>
### setAudioEncoderConfiguration
```java
void com.ss.avframework.live.VeLivePusher.setAudioEncoderConfiguration(VeLiveAudioEncoderConfiguration config)
```
Sets audio encoding parameters for the pushed stream.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| config | VeLiveAudioEncoderConfiguration | The audio encoding parameters. See [VeLiveAudioEncoderConfiguration](docs-broadcast-sdk-for-android-type-definition#VeLivePusherDef-VeLiveAudioEncoderConfiguration) for details. |


**Notes**


This method must be called before calling [startPush](#VeLivePusher-startpush) or [startPushWithUrls](#VeLivePusher-startpushwithurls).
<span id="VeLivePusher-getaudioencoderconfiguration"></span>
### getAudioEncoderConfiguration
```java
VeLiveAudioEncoderConfiguration com.ss.avframework.live.VeLivePusher.getAudioEncoderConfiguration()
```
Gets audio encoding parameters for the pushed stream.

**Return Value**

The audio encoding parameters. See [VeLiveAudioEncoderConfiguration](docs-broadcast-sdk-for-android-type-definition#veliveaudioencoderconfiguration) for details.
<span id="VeLivePusher-startpush"></span>
### startPush
```java
void com.ss.avframework.live.VeLivePusher.startPush(String url)
```
Starts streaming.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| url | String | The push stream address. |

<span id="VeLivePusher-startpushwithurls"></span>
### startPushWithUrls
```java
void com.ss.avframework.live.VeLivePusher.startPushWithUrls(String[] urls)
```
Starts streaming with one or more push stream addresses.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| urls | String[] | A list of push stream addresses. |


**Notes**



When the first push stream address in the array is unavailable, the SDK will automatically switch to the subsequent addresses.
<span id="VeLivePusher-stoppush"></span>
### stopPush
```java
void com.ss.avframework.live.VeLivePusher.stopPush()
```
Stops streaming.

**Notes**

After you have stopped streaming, you can restart streaming by calling [startPush](#VeLivePusher-startpush) or [startPushWithUrls](#VeLivePusher-startpushwithurls).
<span id="VeLivePusher-ispushing"></span>
### isPushing
```java
boolean com.ss.avframework.live.VeLivePusher.isPushing()
```
Checks whether the streaming is currently ongoing. You can use this method to query the status of the live pusher.

**Return Value**

Whether the streaming is currently ongoing.
- true: The streaming is currently ongoing;
- false: The streaming has stopped.
<span id="VeLivePusher-setwatermark"></span>
### setWatermark
```java
int com.ss.avframework.live.VeLivePusher.setWatermark(
    Bitmap image,
    float x,
    float y,
    float scale
)
```
Sets a watermark for the pushed stream.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| image | Bitmap | The watermark image. Setting it to null means disabling watermarking. |
| x | float | The horizontal offset of the watermark, which represents the ratio of the distance between the left edge of the watermark and the left edge of the video to the width of the video. The value range is [0.0,1.0]. |
| y | float | The vertical offset of the watermark, which represents the ratio of the distance between the top edge of the watermark and the top edge of the video to the height of the video. The value range is [0.0,1.0]. |
| scale | float | The uniform scaling of the watermark. The value range is [0.0, 1.0]. |


**Return Value**



- 0: Success;
- < 0: Failure.
<span id="VeLivePusher-startfilerecording"></span>
### startFileRecording
```java
void com.ss.avframework.live.VeLivePusher.startFileRecording(
    String path,
    VeLiveFileRecorderConfiguration config,
    VeLiveFileRecordingListener listener
)
```
Starts local recording.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| path | String | The directory for saving the recording file. You cannot leave this parameter empty. |
| config | VeLiveFileRecorderConfiguration | The recording configurations. See [VeLiveFileRecorderConfiguration](docs-broadcast-sdk-for-android-type-definition#VeLivePusherDef-VeLiveFileRecorderConfiguration) for details. |
| listener | VeLiveFileRecordingListener | The listener for recording events. See [VeLiveFileRecordingListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveFileRecordingListener) for details. |

<span id="VeLivePusher-stopfilerecording"></span>
### stopFileRecording
```java
void com.ss.avframework.live.VeLivePusher.stopFileRecording()
```
Stops local recording.

**Notes**


This method must be called after calling [startFileRecording](#VeLivePusher-startfilerecording).
<span id="VeLivePusher-setproperty"></span>
### setProperty
```java
int com.ss.avframework.live.VeLivePusher.setProperty(
    String key,
    Object value
)
```
Set advanced configurations. You can contact BytePlus technical support for more information about how to use this method.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| key | String | The JSON key. |
| value | Object | The JSON value. |


**Return Value**



- 0: Success;
- -1: Failure.
<span id="VeLivePusher-pushexternalvideoframe"></span>
### pushExternalVideoFrame
```java
int com.ss.avframework.live.VeLivePusher.pushExternalVideoFrame(VeLiveVideoFrame frame)
```
Pushes an external video frame.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveVideoFrame | The external video frame. See [VeLiveVideoFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoFrame) for details. |


**Return Value**

- 0: Success;
- < 0: Failure.

**Notes**

To use this method, you must first call startVideoCapture and set [VeLiveVideoCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoCaptureType) to `VeLiveVideoCaptureExternal`.
<span id="VeLivePusher-pushexternalaudioframe"></span>
### pushExternalAudioFrame
```java
int com.ss.avframework.live.VeLivePusher.pushExternalAudioFrame(VeLiveAudioFrame frame)
```
Pushes an external audio frame.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveAudioFrame | The external audio frame. See [VeLiveAudioFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioFrame) for details. |


**Return Value**

- 0: Success;
- < 0: Failure.

**Notes**

To use this method, you must first call startAudioCapture and set [VeLiveAudioCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioCaptureType) to `VeLiveAudioCaptureExternal`.
<span id="VeLivePusher-setorientation"></span>
### setOrientation
```java
void com.ss.avframework.live.VeLivePusher.setOrientation(VeLiveOrientation orientation)
```
Sets the orientation of the pushed video frame. The default orientation is portrait.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| orientation | VeLiveOrientation | The orientation of the pushed video frame. See [VeLiveOrientation](broadcast-sdk-for-android-type-definition#VeLiveOrientation) for details. |

<span id="VeLivePusher-sendseimessage"></span>
### sendSeiMessage
```java
int com.ss.avframework.live.VeLivePusher.sendSeiMessage(
    String key,
    Object value,
    int repeat,
    boolean isKeyFrame,
    boolean allowsCovered
)
```
Sends an SEI message through the video frame. The SEI messages are strings in JSON format.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| key | String | The JSON key. |
| value | Object | The JSON value. |
| repeat | int | The number of times the message is sent. For example, if you set `repeat` to `20` and set `isKeyFrame` to `true`, the SDK will add the SEI message to 20 consecutive key frames starting from the time the method is called. |
| isKeyFrame | boolean | Whether SEI messages are only included in key frames. <br/><ul><li>true: Add the SEI message to key frames only;</li><li>false: Add the SEI message to all types of frames.</li></ul> |
| allowsCovered | boolean | Whether to allow overwriting. <br/><ul><li>true: Allow overwriting;</li><li>false: Do not allow overwriting.</li></ul> |


**Return Value**



- 0: Success;
- < 0: Failure.

**Notes**


This method must be called after calling [startPush](#VeLivePusher-startpush) or [startPushWithUrls](#VeLivePusher-startpushwithurls).
<span id="VeLivePusher-setmute"></span>
### setMute
```java
void com.ss.avframework.live.VeLivePusher.setMute(boolean mute)
```
Sets whether to mute the stream.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| mute | boolean | Whether to mute the stream. <br/><ul><li>true: Mute;</li><li>false: (Default) Do not mute.</li></ul> |

<span id="VeLivePusher-ismute"></span>
### isMute
```java
boolean com.ss.avframework.live.VeLivePusher.isMute()
```
Checks whether the stream is muted.

**Return Value**



- true: The stream is muted;
- false: The stream is not muted.
<span id="VeLivePusher-getvideoeffectmanager"></span>
### getVideoEffectManager
```java
VeLiveVideoEffectManager com.ss.avframework.live.VeLivePusher.getVideoEffectManager()
```
Gets the special effects manager. With the special effects manager, you can do the following:
- Set beauty AR
- Set special effects
- Set materials
- Set stickers
- Set filters

**Return Value**

The special effects manager. See [VeLiveVideoEffectManager](#VeLiveVideoEffectManager) for details.

**Notes**

You must first integrate the BytePlus Effects SDK before calling this method.
<span id="VeLivePusher-addvideoframefilter"></span>
### addVideoFrameFilter
```java
int com.ss.avframework.live.VeLivePusher.addVideoFrameFilter(
    VeLivePixelFormat format,
    VeLiveVideoBufferType bufferType,
    VeLiveVideoFrameFilter filter
)
```
Sets custom video processing.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| format | VeLivePixelFormat | The pixel format. See [VeLivePixelFormat](docs-broadcast-sdk-for-android-type-definition#VeLivePixelFormat) for details. |
| bufferType | VeLiveVideoBufferType | The buffer type of the video data. See [VeLiveVideoBufferType](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoBufferType) for details. |
| filter | VeLiveVideoFrameFilter | The video frame filter callback. See [VeLiveVideoFrameFilter](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveVideoFrameFilter) for details. |


**Return Value**



- 0: Success;
- < 0: Failure.
<span id="VeLivePusher-removevideoframefilter"></span>
### removeVideoFrameFilter
```java
int com.ss.avframework.live.VeLivePusher.removeVideoFrameFilter(VeLiveVideoFrameFilter filter)
```
Removes the video frame filter.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| filter | VeLiveVideoFrameFilter | The video filter, need to be consistent with the instance passed in `addVideoFrameFilter`. See [VeLiveVideoFrameFilter](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveVideoFrameFilter) for details. |


**Return Value**



- 0: Success;
- < 0: Failure.

**Notes**



Calling this method will return a failure if the listener has not been added or has been removed.
<span id="VeLivePusher-getaudiodevice"></span>
### getAudioDevice
```java
VeLiveAudioDevice com.ss.avframework.live.VeLivePusher.getAudioDevice()
```
Gets the audio device manager.

**Return Value**

The audio device manager. See [VeLiveAudioDevice](#VeLiveAudioDevice) for details.

**Notes**

To use this method, you must first call startAudioCapture and set [VeLiveAudioCaptureType](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioCaptureType) to `VeLiveAudioCaptureMicrophone`.
<span id="VeLivePusher-setaudioframefilter"></span>
### setAudioFrameFilter
```java
void com.ss.avframework.live.VeLivePusher.setAudioFrameFilter(VeLiveAudioFrameFilter filter)
```
Sets custom audio processing.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| filter | VeLiveAudioFrameFilter | The audio filter. See VeLiveAudioFrameFilter for details. |

<span id="VeLivePusher-createplayer"></span>
### createPlayer
```java
VeLiveMediaPlayer com.ss.avframework.live.VeLivePusher.createPlayer()
```
Creates the media player.

**Return Value**

The media player. See [VeLiveMediaPlayer](#VeLiveMediaPlayer) for details.
<span id="VeLivePusher-getmixermanager"></span>
### getMixerManager
```java
VeLiveMixerManager com.ss.avframework.live.VeLivePusher.getMixerManager()
```
Gets the audio and video mixer.

**Return Value**

The audio and video mixer. See [VeLiveMixerManager](#VeLiveMixerManager) for details.
<span id="VeLivePusher-startmixsystemaudio"></span>
### startMixSystemAudio
```java
void com.ss.avframework.live.VeLivePusher.startMixSystemAudio()
```
Starts system audio capture.
<span id="VeLivePusher-stopmixsystemaudio"></span>
### stopMixSystemAudio
```java
void com.ss.avframework.live.VeLivePusher.stopMixSystemAudio()
```
Stops system audio capture.
<span id="VeLivePusher-isscreenrecording"></span>
### isScreenRecording
```java
boolean com.ss.avframework.live.VeLivePusher.isScreenRecording()
```
Gets whether the SDK is capturing the screen at this moment.
<span id="VeLivePusher-addvideoframelistener"></span>
### addVideoFrameListener
```java
int com.ss.avframework.live.VeLivePusher.addVideoFrameListener(VeLiveVideoFrameListener listener)
```
Adds a video frame listener.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| listener | VeLiveVideoFrameListener | The listener. See [VeLiveVideoFrameListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveVideoFrameListener) for details. |


**Return Value**



- 0: Success;
- < 0: Failure.
<span id="VeLivePusher-removevideoframelistener"></span>
### removeVideoFrameListener
```java
int com.ss.avframework.live.VeLivePusher.removeVideoFrameListener(VeLiveVideoFrameListener listener)
```
Removes the video frame listener.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| listener | VeLiveVideoFrameListener | The listener. See [VeLiveVideoFrameListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveVideoFrameListener) for details. |


**Return Value**



- 0: Success;
- < 0: Failure.

**Notes**



Calling this method will return a failure if the listener has not been added or has been removed.
<span id="VeLivePusher-addaudioframelistener"></span>
### addAudioFrameListener
```java
int com.ss.avframework.live.VeLivePusher.addAudioFrameListener(VeLiveAudioFrameListener listener)
```
Adds an audio frame listener.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| listener | VeLiveAudioFrameListener | The listener. See [VeLiveAudioFrameListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveAudioFrameListener) for details. |


**Return Value**



- 0: Success;
- < 0: Failure.
<span id="VeLivePusher-removeaudioframelistener"></span>
### removeAudioFrameListener
```java
int com.ss.avframework.live.VeLivePusher.removeAudioFrameListener(VeLiveAudioFrameListener listener)
```
Removes the audio frame listener.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| listener | VeLiveAudioFrameListener | The listener. See [VeLiveAudioFrameListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveAudioFrameListener) for details. |


**Return Value**



- 0: Success;
- < 0: Failure.

**Notes**



Calling this method will return a failure if the listener has not been added or has been removed.
<span id="VeLivePusher-snapshot"></span>
### snapshot
```java
void com.ss.avframework.live.VeLivePusher.snapshot(VeLiveSnapshotListener listener)
```
Takes a screenshot.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| listener | VeLiveSnapshotListener | The listener for the screenshot. See [VeLiveSnapshotListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveSnapshotListener) for details. |

<span id="VeLiveMixerManager"></span>
# VeLiveMixerManager
```java
public interface com.ss.avframework.live.VeLiveMixerManager
```
The audio and video mixer.
## Member Functions
| Return | Name |
| --- | --- |
| int | [addVideoStream](#VeLiveMixerManager-addvideostream) |
| int | [addAudioStream](#VeLiveMixerManager-addaudiostream) |
| int | [addAudioStream](#VeLiveMixerManager-addaudiostream-2) |
| int | [getOriginVideoStream](#VeLiveMixerManager-getoriginvideostream) |
| int | [getOriginAudioStream](#VeLiveMixerManager-getoriginaudiostream) |
| int | [getOriginScreenStream](#VeLiveMixerManager-getoriginscreenstream) |
| int | [getOriginSystemAudioStream](#VeLiveMixerManager-getoriginsystemaudiostream) |
| void | [sendCustomVideoFrame](#VeLiveMixerManager-sendcustomvideoframe) |
| void | [sendCustomAudioFrame](#VeLiveMixerManager-sendcustomaudioframe) |
| void | [updateStreamMixDescription](#VeLiveMixerManager-updatestreammixdescription) |
| void | [removeVideoStream](#VeLiveMixerManager-removevideostream) |
| void | [removeAudioStream](#VeLiveMixerManager-removeaudiostream) |

## Instructions
<span id="VeLiveMixerManager-addvideostream"></span>
### addVideoStream
```java
int com.ss.avframework.live.VeLiveMixerManager.addVideoStream()
```
Adds a video stream to the mixer.

**Return Value**



The video stream ID.
<span id="VeLiveMixerManager-addaudiostream"></span>
### addAudioStream
```java
int com.ss.avframework.live.VeLiveMixerManager.addAudioStream()
```
Adds an audio stream to the mixer.

**Return Value**



The audio stream ID.
<span id="VeLiveMixerManager-addaudiostream-2"></span>
### addAudioStream
```java
int com.ss.avframework.live.VeLiveMixerManager.addAudioStream(VeLiveAudioMixType type)
```
Adds an audio stream to the mixer, and sets the mixing type.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveAudioMixType | The mixing type. For details, see [VeLiveAudioMixType](broadcast-sdk-for-android-type-definition#VeLiveAudioMixType). |


**Return Value**



The audio stream ID.
<span id="VeLiveMixerManager-getoriginvideostream"></span>
### getOriginVideoStream
```java
int com.ss.avframework.live.VeLiveMixerManager.getOriginVideoStream()
```
Gets the ID of the primary video stream.
<span id="VeLiveMixerManager-getoriginaudiostream"></span>
### getOriginAudioStream
```java
int com.ss.avframework.live.VeLiveMixerManager.getOriginAudioStream()
```
Gets the ID of the primary audio stream.
<span id="VeLiveMixerManager-getoriginscreenstream"></span>
### getOriginScreenStream
```java
int com.ss.avframework.live.VeLiveMixerManager.getOriginScreenStream()
```
Gets the ID of the primary screen stream.
<span id="VeLiveMixerManager-getoriginsystemaudiostream"></span>
### getOriginSystemAudioStream
```java
int com.ss.avframework.live.VeLiveMixerManager.getOriginSystemAudioStream()
```
Gets the ID of the primary system audio stream.
<span id="VeLiveMixerManager-sendcustomvideoframe"></span>
### sendCustomVideoFrame
```java
void com.ss.avframework.live.VeLiveMixerManager.sendCustomVideoFrame(
    VeLiveVideoFrame frame,
    int streamId
)
```
Sends a custom video frame with a specified stream ID.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveVideoFrame | The custom video frame. See [VeLiveVideoFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoFrame) for details. |
| streamId | int | The ID of the video stream to mix. |

<span id="VeLiveMixerManager-sendcustomaudioframe"></span>
### sendCustomAudioFrame
```java
void com.ss.avframework.live.VeLiveMixerManager.sendCustomAudioFrame(
    VeLiveAudioFrame frame,
    int streamId
)
```
Sends a custom audio frame with a specified stream ID.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveAudioFrame | The custom audio frame. See [VeLiveAudioFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioFrame) for details. |
| streamId | int | The ID of the audio stream to mix. |

<span id="VeLiveMixerManager-updatestreammixdescription"></span>
### updateStreamMixDescription
```java
void com.ss.avframework.live.VeLiveMixerManager.updateStreamMixDescription(VeLiveStreamMixDescription mixDescription)
```
Updates the configurations for audio and video mixing.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| mixDescription | VeLiveStreamMixDescription | The updated configurations for audio and video mixing. See [VeLiveStreamMixDescription](docs-broadcast-sdk-for-android-type-definition#VeLivePusherDef-VeLiveStreamMixDescription) for details. |

<span id="VeLiveMixerManager-removevideostream"></span>
### removeVideoStream
```java
void com.ss.avframework.live.VeLiveMixerManager.removeVideoStream(int streamId)
```
Removes a non-primary video stream from the mixer.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| streamId | int | The ID of the video stream to remove. |

<span id="VeLiveMixerManager-removeaudiostream"></span>
### removeAudioStream
```java
void com.ss.avframework.live.VeLiveMixerManager.removeAudioStream(int streamId)
```
Removes a non-primary audio stream from the mixer.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| streamId | int | The ID of the audio stream to remove. |

<span id="VeLiveMediaPlayer"></span>
# VeLiveMediaPlayer
```java
public interface com.ss.avframework.live.VeLiveMediaPlayer
```
The media player.
## Member Functions
| Return | Name |
| --- | --- |
| void | [release](#VeLiveMediaPlayer-release) |
| void | [setListener](#VeLiveMediaPlayer-setlistener) |
| int | [prepare](#VeLiveMediaPlayer-prepare) |
| int | [start](#VeLiveMediaPlayer-start) |
| int | [stop](#VeLiveMediaPlayer-stop) |
| void | [pause](#VeLiveMediaPlayer-pause) |
| void | [resume](#VeLiveMediaPlayer-resume) |
| long | [getDuration](#VeLiveMediaPlayer-getduration) |
| int | [seek](#VeLiveMediaPlayer-seek) |
| void | [enableMixer](#VeLiveMediaPlayer-enablemixer) |
| void | [enableAutoEq](#VeLiveMediaPlayer-enableautoeq) |
| void | [setFrameListener](#VeLiveMediaPlayer-setframelistener) |
| void | [setBGMVolume](#VeLiveMediaPlayer-setbgmvolume) |
| void | [setVoiceVolume](#VeLiveMediaPlayer-setvoicevolume) |
| void | [enableBGMLoop](#VeLiveMediaPlayer-enablebgmloop) |

## Instructions
<span id="VeLiveMediaPlayer-release"></span>
### release
```java
void com.ss.avframework.live.VeLiveMediaPlayer.release()
```
Destroys the media player instance.
<span id="VeLiveMediaPlayer-setlistener"></span>
### setListener
```java
void com.ss.avframework.live.VeLiveMediaPlayer.setListener(VeLiveMediaPlayerListener listener)
```
Sets the observer for playback statuses.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| listener | VeLiveMediaPlayerListener | The observer that listens for playback statuses. For details, see [VeLiveMediaPlayerListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveMediaPlayerListener). |


**Notes**



If you make multiple calls to this method, only the last call takes effect.
<span id="VeLiveMediaPlayer-prepare"></span>
### prepare
```java
int com.ss.avframework.live.VeLiveMediaPlayer.prepare(String url)
```
Sets the file path. Supported file formats include MP3, AAC, M4A, WAV.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| url | String | The file path. |


**Return Value**



- 0: Success;
- ≠ 0: Failure.
<span id="VeLiveMediaPlayer-start"></span>
### start
```java
int com.ss.avframework.live.VeLiveMediaPlayer.start()
```
Start playback.

**Notes**

This method must be called after you call [start](#VeLiveMediaPlayer-start) to start playback.
<span id="VeLiveMediaPlayer-stop"></span>
### stop
```java
int com.ss.avframework.live.VeLiveMediaPlayer.stop()
```
Stops playback.

**Return Value**



- 0: Success;
- ≠ 0: Failure.

**Notes**

This method must be called after you call [start](#VeLiveMediaPlayer-start) to start playback.
<span id="VeLiveMediaPlayer-pause"></span>
### pause
```java
void com.ss.avframework.live.VeLiveMediaPlayer.pause()
```
Pauses playback.

**Notes**

This method must be called after you call [start](#VeLiveMediaPlayer-start) to start playback.
<span id="VeLiveMediaPlayer-resume"></span>
### resume
```java
void com.ss.avframework.live.VeLiveMediaPlayer.resume()
```
Resumes playback.

**Notes**


This method must be called after you call [pause](#VeLiveMediaPlayer-pause) to pause playback.
<span id="VeLiveMediaPlayer-getduration"></span>
### getDuration
```java
long com.ss.avframework.live.VeLiveMediaPlayer.getDuration()
```
Gets the duration of the media file.

**Return Value**



- \> 0: The duration of the media file, in milliseconds;
- ≤ 0: Failure.

**Notes**


This method must be called after you call [start](#VeLiveMediaPlayer-start) to start playback.
<span id="VeLiveMediaPlayer-seek"></span>
### seek
```java
int com.ss.avframework.live.VeLiveMediaPlayer.seek(long posMs)
```
Sets the playback progress.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| posMs | long | The playback progress, in milliseconds. |


**Return Value**



- 0: Success;
- ≠ 0: Failure.
<span id="VeLiveMediaPlayer-enablemixer"></span>
### enableMixer
```java
void com.ss.avframework.live.VeLiveMediaPlayer.enableMixer(boolean enable)
```
Enables or disables mixing the audio to the live stream.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Whether to enable or disable mixing the audio to the live stream. <br/><ul><li>ture: Enable;</li><li>false: (Default) Disable.</li></ul> |

<span id="VeLiveMediaPlayer-enableautoeq"></span>
### enableAutoEq
```java
void com.ss.avframework.live.VeLiveMediaPlayer.enableAutoEq(
    float sourceLufs,
    float targetLufs
)
```
Enables or disables automatic volume equalization.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| sourceLufs | float | The source volume. |
| targetLufs | float | The target volume. |

<span id="VeLiveMediaPlayer-setframelistener"></span>
### setFrameListener
```java
void com.ss.avframework.live.VeLiveMediaPlayer.setFrameListener(VeLiveMediaPlayerFrameListener listener)
```
Sets the observer for audio and video frames.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| listener | VeLiveMediaPlayerFrameListener | The observer that listens for audio and video frames. For details, see [VeLiveMediaPlayerFrameListener](docs-broadcast-sdk-for-android-callback#VeLivePusherDef-VeLiveMediaPlayerFrameListener) |


**Notes**



If you make multiple calls to this method, only the last call takes effect.
<span id="VeLiveMediaPlayer-setbgmvolume"></span>
### setBGMVolume
```java
void com.ss.avframework.live.VeLiveMediaPlayer.setBGMVolume(float volume)
```
Sets the playback volume.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| volume | float | The playback volume. The value range is [0.0, 4.0]. |

<span id="VeLiveMediaPlayer-setvoicevolume"></span>
### setVoiceVolume
```java
void com.ss.avframework.live.VeLiveMediaPlayer.setVoiceVolume(float volume)
```
Sets the audio capture volume.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| volume | float | The audio capture volume. The value range is [0.0, 4.0]. |


**Notes**


This method must be called after you call [start](#VeLiveMediaPlayer-start) to start playing background music.
<span id="VeLiveMediaPlayer-enablebgmloop"></span>
### enableBGMLoop
```java
void com.ss.avframework.live.VeLiveMediaPlayer.enableBGMLoop(boolean loop)
```
Sets whether to loop the video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| loop | boolean | Whether to loop the video. <br/><ul><li>true: Loop;</li><li>false: (Default) Do not loop.</li></ul> |

<span id="VeLiveAudioDevice"></span>
# VeLiveAudioDevice
```java
public interface com.ss.avframework.live.VeLiveAudioDevice
```
The audio device manager.
## Member Functions
| Return | Name |
| --- | --- |
| void | [setVoiceLoudness](#VeLiveAudioDevice-setvoiceloudness) |
| float | [getVoiceLoudness](#VeLiveAudioDevice-getvoiceloudness) |

## Instructions
<span id="VeLiveAudioDevice-setvoiceloudness"></span>
### setVoiceLoudness
```java
void com.ss.avframework.live.VeLiveAudioDevice.setVoiceLoudness(float level)
```
Sets the volume.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| level | float | The volume. The value range is [0.0, 4.0]. |

<span id="VeLiveAudioDevice-getvoiceloudness"></span>
### getVoiceLoudness
```java
float com.ss.avframework.live.VeLiveAudioDevice.getVoiceLoudness()
```
Gets the current volume.

**Return Value**



The current volume.

<span id="VeLivePusherDef-VeLiveVideoFrameFilter"></span>
# VeLiveVideoFrameFilter
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameFilter
```
A custom video processing callback.
## Member Functions
| Return | Name |
| --- | --- |
| default int | [onVideoProcess](#VeLiveVideoFrameFilter-onvideoprocess) |

## Instructions
<span id="VeLiveVideoFrameFilter-onvideoprocess"></span>
### onVideoProcess
```java
default int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameFilter.onVideoProcess(
    VeLiveVideoFrame srcFrame,
    VeLiveVideoFrame dstFrame
)
```
Occurs when the SDK captures a video frame. You can use the callback to process the frame in a custom way.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| srcFrame | VeLiveVideoFrame | The source video frame. See [VeLiveVideoFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoFrame) for details. |
| dstFrame | VeLiveVideoFrame | The processed video frame. See [VeLiveVideoFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoFrame) for details. |


**Return Value**

- 0: The video frame is successfully processed;
- < 0: The processing has failed. The frame will be discarded by the SDK;
- \> 0: The processing has failed. The frame will be passed to the encoder by the SDK.
<span id="VeLivePusherDef-VeLiveVideoFrameListener"></span>
# VeLiveVideoFrameListener
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameListener
```
The listener for video frames.
## Member Functions
| Return | Name |
| --- | --- |
| default VeLiveVideoFrameSource | [getObservedVideoFrameSource](#VeLiveVideoFrameListener-getobservedvideoframesource) |
| default void | [onCaptureVideoFrame](#VeLiveVideoFrameListener-oncapturevideoframe) |
| default void | [onPreEncodeVideoFrame](#VeLiveVideoFrameListener-onpreencodevideoframe) |

## Instructions
<span id="VeLiveVideoFrameListener-getobservedvideoframesource"></span>
### getObservedVideoFrameSource
```java
default VeLiveVideoFrameSource com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameListener.getObservedVideoFrameSource()
```
Sets the source of the video frame that the listener needs.

**Return Value**

The source type of the video frame you want to subscribe to. See [VeLiveVideoFrameSource](docs-broadcast-sdk-for-android-type-definition#velivevideoframesource) for details.
<span id="VeLiveVideoFrameListener-oncapturevideoframe"></span>
### onCaptureVideoFrame
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameListener.onCaptureVideoFrame(VeLiveVideoFrame frame)
```
Occurs when a video frame is captured. This callback will be triggered only if you return `VeLiveVideoFrameSourceCapture` when implementing the [getObservedVideoFrameSource](#VeLiveVideoFrameListener-getobservedvideoframesource) callback method.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveVideoFrame | The captured video frame. See [VeLiveVideoFrame](#VeLivePusherDef-VeLiveVideoFrameFilter) for details. |

<span id="VeLiveVideoFrameListener-onpreencodevideoframe"></span>
### onPreEncodeVideoFrame
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameListener.onPreEncodeVideoFrame(VeLiveVideoFrame frame)
```
Occurs when a video frame is to be encoded. This callback will be triggered only if you return `VeLiveVideoFrameSourcePreEncode` when implementing the [getObservedVideoFrameSource](#VeLiveVideoFrameListener-getobservedvideoframesource) callback method.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveVideoFrame | The video frame to be encoded. See [VeLiveVideoFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoFrame) for details. |

<span id="VeLivePusherDef-VeLiveVideoEffectCallback"></span>
# VeLiveVideoEffectCallback
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectCallback
```
The listener for special effect events.
## Member Functions
| Return | Name |
| --- | --- |
| default void | [onResult](#VeLiveVideoEffectCallback-onresult) |

## Instructions
<span id="VeLiveVideoEffectCallback-onresult"></span>
### onResult
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectCallback.onResult(
    int result,
    String msg
)
```
Occurs when special effects are processed.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| result | int | The result. |
| msg | String | The message. |

<span id="VeLivePusherDef-VeLiveMediaPlayerListener"></span>
# VeLiveMediaPlayerListener
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener
```
Observer that listens for playback-related events of the media player.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| String | "has_video_stream" | [KEY_HAS_VIDEO_STREAM](#VeLiveMediaPlayerListener-key_has_video_stream) |
| String | "has_audio_stream" | [KEY_HAS_AUDIO_STREAM](#VeLiveMediaPlayerListener-key_has_audio_stream) |
| String | "duration" | [KEY_DURATION](#VeLiveMediaPlayerListener-key_duration) |
| String | "video_width" | [KEY_VIDEO_WIDTH](#VeLiveMediaPlayerListener-key_video_width) |
| String | "video_height" | [KEY_VIDEO_HEIGHT](#VeLiveMediaPlayerListener-key_video_height) |

## Member Functions
| Return | Name |
| --- | --- |
| default void | [onStart](#VeLiveMediaPlayerListener-onstart) |
| default void | [onProgress](#VeLiveMediaPlayerListener-onprogress) |
| default void | [onStop](#VeLiveMediaPlayerListener-onstop) |
| default void | [onError](#VeLiveMediaPlayerListener-onerror) |

## Instructions
<span id="VeLiveMediaPlayerListener-key_has_video_stream"></span>
### KEY_HAS_VIDEO_STREAM
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.KEY_HAS_VIDEO_STREAM = "has_video_stream"
```
Whether there is a video stream.
<span id="VeLiveMediaPlayerListener-key_has_audio_stream"></span>
### KEY_HAS_AUDIO_STREAM
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.KEY_HAS_AUDIO_STREAM = "has_audio_stream"
```
Whether there is an audio stream.
<span id="VeLiveMediaPlayerListener-key_duration"></span>
### KEY_DURATION
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.KEY_DURATION = "duration"
```
The duration of the video, in milliseconds.
<span id="VeLiveMediaPlayerListener-key_video_width"></span>
### KEY_VIDEO_WIDTH
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.KEY_VIDEO_WIDTH = "video_width"
```
The width of the video.
<span id="VeLiveMediaPlayerListener-key_video_height"></span>
### KEY_VIDEO_HEIGHT
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.KEY_VIDEO_HEIGHT = "video_height"
```
The height of the video.
## Instructions
<span id="VeLiveMediaPlayerListener-onstart"></span>
### onStart
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.onStart(Bundle info)
```
Occurs when the playback starts.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| info | Bundle | \- |

<span id="VeLiveMediaPlayerListener-onprogress"></span>
### onProgress
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.onProgress(long timeMs)
```
Occurs every 100 ms to report the playback progress.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| timeMs | long | The playback progress, in milliseconds. |

<span id="VeLiveMediaPlayerListener-onstop"></span>
### onStop
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.onStop()
```
Occurs when the playback stops.
<span id="VeLiveMediaPlayerListener-onerror"></span>
### onError
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerListener.onError(
    int code,
    String msg
)
```
Occurs when an error occurs in the media player.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| code | int | The error code. See [VeLivePusherErrorCode](broadcast-sdk-for-android-api-error-code#VeLivePusherErrorCode) for details. |
| msg | String | The error message. |

<span id="VeLivePusherDef-VeLiveAudioFrameListener"></span>
# VeLiveAudioFrameListener
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameListener
```
The listener for audio frames.
## Member Functions
| Return | Name |
| --- | --- |
| default VeLiveAudioFrameSource | [getObservedAudioFrameSource](#VeLiveAudioFrameListener-getobservedaudioframesource) |
| default void | [onCaptureAudioFrame](#VeLiveAudioFrameListener-oncaptureaudioframe) |
| default void | [onPreEncodeAudioFrame](#VeLiveAudioFrameListener-onpreencodeaudioframe) |

## Instructions
<span id="VeLiveAudioFrameListener-getobservedaudioframesource"></span>
### getObservedAudioFrameSource
```java
default VeLiveAudioFrameSource com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameListener.getObservedAudioFrameSource()
```
Sets the source of the audio frame that the listener needs.

**Return Value**

The source type of the audio frame. See [VeLiveAudioFrameSource](docs-broadcast-sdk-for-android-type-definition#VeLivePusherDef-VeLiveAudioFrameSource) for details.
<span id="VeLiveAudioFrameListener-oncaptureaudioframe"></span>
### onCaptureAudioFrame
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameListener.onCaptureAudioFrame(VeLiveAudioFrame frame)
```
Occurs when an audio frame is captured. This callback will be triggered only if you return `VeLiveAudioFrameSourceCapture` when implementing the [getObservedAudioFrameSource](#VeLiveAudioFrameListener-getobservedaudioframesource) callback method.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveAudioFrame | The captured audio frame data. See [VeLiveAudioFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioFrame). |

<span id="VeLiveAudioFrameListener-onpreencodeaudioframe"></span>
### onPreEncodeAudioFrame
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameListener.onPreEncodeAudioFrame(VeLiveAudioFrame frame)
```
Occurs when an audio frame is to be encoded. This callback will be triggered only if you return `VeLiveAudioFrameSourcePreEncode` when implementing the [getObservedAudioFrameSource](#VeLiveAudioFrameListener-getobservedaudioframesource) callback method.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveAudioFrame | The audio frame to be encoded. See [VeLiveAudioFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioFrame) for details. |

<span id="VeLivePusherDef-VeLiveMediaPlayerFrameListener"></span>
# VeLiveMediaPlayerFrameListener
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerFrameListener
```
Observer that listens for audio and video frames of the media player.
## Member Functions
| Return | Name |
| --- | --- |
| default void | [onAudioFrame](#VeLiveMediaPlayerFrameListener-onaudioframe) |
| default void | [onVideoFrame](#VeLiveMediaPlayerFrameListener-onvideoframe) |

## Instructions
<span id="VeLiveMediaPlayerFrameListener-onaudioframe"></span>
### onAudioFrame
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerFrameListener.onAudioFrame(VeLiveAudioFrame frame)
```
Occurs when the media player decodes an audio frame.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveAudioFrame | The audio frame. See [VeLiveAudioFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioFrame) for details. |

<span id="VeLiveMediaPlayerFrameListener-onvideoframe"></span>
### onVideoFrame
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveMediaPlayerFrameListener.onVideoFrame(VeLiveVideoFrame frame)
```
Occurs when the media player decodes a video frame.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| frame | VeLiveVideoFrame | The video frame, including the timestamp, pixel format, and other information. See [VeLiveVideoFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveVideoFrame) for details. |

<span id="VeLiveSnapshotListener"></span>
# VeLiveSnapshotListener
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveSnapshotListener
```
The listener for screenshot capturing events.
## Member Functions
| Return | Name |
| --- | --- |
| default void | [onSnapshotComplete](#VeLiveSnapshotListener-onsnapshotcomplete) |

## Instructions
<span id="VeLiveSnapshotListener-onsnapshotcomplete"></span>
### onSnapshotComplete
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveSnapshotListener.onSnapshotComplete(Bitmap image)
```
Screenshot success callback.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| image | Bitmap | The screenshot image. |

<span id="VeLivePusherDef-VeLiveAudioFrameFilter"></span>
# VeLiveAudioFrameFilter
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameFilter
```
A custom audio processing callback.
## Member Functions
| Return | Name |
| --- | --- |
| default int | [onAudioProcess](#VeLiveAudioFrameFilter-onaudioprocess) |

## Instructions
<span id="VeLiveAudioFrameFilter-onaudioprocess"></span>
### onAudioProcess
```java
default int com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameFilter.onAudioProcess(
    VeLiveAudioFrame srcFrame,
    VeLiveAudioFrame dstFrame
)
```
Occurs when the SDK captures an audio frame. You can use the callback to process the frame in a custom way.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| srcFrame | VeLiveAudioFrame | The source audio frame. See [VeLiveAudioFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioFrame) for details. |
| dstFrame | VeLiveAudioFrame | The processed audio frame. See [VeLiveAudioFrame](docs-broadcast-sdk-for-android-type-definition#VeLiveAudioFrame) for details.<ul><li>0: Success;</li><li>≠ 0: Failure. The frame will be passed to the encoder by the SDK.</li></ul> |

<span id="VeLivePusherObserver"></span>
# VeLivePusherObserver
```java
public interface com.ss.avframework.live.VeLivePusherObserver
```
The observer for live pusher events, including errors, statuses, network quality, device information, and first frame rendering.
## Member Functions
| Return | Name |
| --- | --- |
| default void | [onError](#VeLivePusherObserver-onerror) |
| default void | [onStatusChange](#VeLivePusherObserver-onstatuschange) |
| default void | [onFirstVideoFrame](#VeLivePusherObserver-onfirstvideoframe) |
| default void | [onFirstAudioFrame](#VeLivePusherObserver-onfirstaudioframe) |
| default void | [onCameraOpened](#VeLivePusherObserver-oncameraopened) |
| default void | [onMicrophoneOpened](#VeLivePusherObserver-onmicrophoneopened) |
| default void | [onScreenRecording](#VeLivePusherObserver-onscreenrecording) |
| default void | [onNetworkQuality](#VeLivePusherObserver-onnetworkquality) |
| default void | [onAudioPowerQuality](#VeLivePusherObserver-onaudiopowerquality) |

## Instructions
<span id="VeLivePusherObserver-onerror"></span>
### onError
```java
default void com.ss.avframework.live.VeLivePusherObserver.onError(
    int code,
    int subCode,
    String msg
)
```
Occurs when a streaming error occurs.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| code | int | The error code. See [VeLivePusherErrorCode](broadcast-sdk-for-android-api-error-code#VeLivePusherErrorCode) for details. |
| subCode | int | The subcode. |
| msg | String | The error message. |

<span id="VeLivePusherObserver-onstatuschange"></span>
### onStatusChange
```java
default void com.ss.avframework.live.VeLivePusherObserver.onStatusChange(VeLivePusherStatus status)
```
Occurs when the streaming status changes.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| status | VeLivePusherStatus | The updated streaming status. See [VeLivePusherStatus](broadcast-sdk-for-android-type-definition#VeLivePusherStatus) for details. |

<span id="VeLivePusherObserver-onfirstvideoframe"></span>
### onFirstVideoFrame
```java
default void com.ss.avframework.live.VeLivePusherObserver.onFirstVideoFrame(
    VeLiveFirstFrameType type,
    long timestampMs
)
```
Occurs when the live pusher sends the first video frame.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveFirstFrameType | The type of the first frame. See [VeLiveFirstFrameType](broadcast-sdk-for-android-type-definition#VeLiveFirstFrameType) for details. |
| timestampMs | long | The timestamp, in milliseconds. |

<span id="VeLivePusherObserver-onfirstaudioframe"></span>
### onFirstAudioFrame
```java
default void com.ss.avframework.live.VeLivePusherObserver.onFirstAudioFrame(
    VeLiveFirstFrameType type,
    long timestampMs
)
```
Occurs when the live pusher sends the first audio frame.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| type | VeLiveFirstFrameType | The type of the first audio frame. See [VeLiveFirstFrameType](broadcast-sdk-for-android-type-definition#VeLiveFirstFrameType) for details. |
| timestampMs | long | The timestamp, in milliseconds. |

<span id="VeLivePusherObserver-oncameraopened"></span>
### onCameraOpened
```java
default void com.ss.avframework.live.VeLivePusherObserver.onCameraOpened(boolean open)
```
Occurs when the camera is turned on or turned off.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| open | boolean | Whether the updated status of the camera is on. <br/><ul><li>true: On;</li><li>false: Off.</li></ul> |

<span id="VeLivePusherObserver-onmicrophoneopened"></span>
### onMicrophoneOpened
```java
default void com.ss.avframework.live.VeLivePusherObserver.onMicrophoneOpened(boolean open)
```
Occurs when the microphone is turned on or turned off.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| open | boolean | Whether the updated status of the microphone is on. <br/><ul><li>true: On;</li><li>false: Off.</li></ul> |

<span id="VeLivePusherObserver-onscreenrecording"></span>
### onScreenRecording
```java
default void com.ss.avframework.live.VeLivePusherObserver.onScreenRecording(boolean open)
```
Occurs when screen capture is turned on or turned off.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| open | boolean | Whether the updated status of screen capture is on. <br/><ul><li>true: On;</li><li>false: Off.</li></ul> |

<span id="VeLivePusherObserver-onnetworkquality"></span>
### onNetworkQuality
```java
default void com.ss.avframework.live.VeLivePusherObserver.onNetworkQuality(VeLiveNetworkQuality quality)
```
Occurs when the network quality changes.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| quality | VeLiveNetworkQuality | The updated network quality. See [VeLiveNetworkQuality](broadcast-sdk-for-android-type-definition#VeLiveNetworkQuality) for details. |

<span id="VeLivePusherObserver-onaudiopowerquality"></span>
### onAudioPowerQuality
```java
default void com.ss.avframework.live.VeLivePusherObserver.onAudioPowerQuality(
    VeLiveAudioPowerLevel level,
    float value
)
```
Occurs when the audio volume level changes.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| level | VeLiveAudioPowerLevel | The updated volume level. See [VeLiveAudioPowerLevel](broadcast-sdk-for-android-type-definition#VeLiveAudioPowerLevel) for details. |
| value | float | The current volume measured in decibel value (dB).<ul><li>A value of -1 indicates that the corresponding volume decibel value is not available.</li><li>Decibel values less than 1 correspond to the VeLiveAudioPowerLevelSilent level.</li><li>Decibel values greater than 1 and less than or equal to 15 correspond to the VeLiveAudioPowerLevelQuiet level.</li><li>Decibel values greater than 15 and less than or equal to 30 correspond to the VeLiveAudioPowerLevelLight level.</li><li>Decibel values greater than 30 and less than or equal to 60 correspond to the VeLiveAudioPowerLevelNormal level.</li><li>Decibel values greater than 60 and less than or equal to 85 correspond to the VeLiveAudioPowerLevelLoud level.</li><li>Decibel values greater than 85 correspond to the VeLiveAudioPowerLevelNoisy level.</li></ul> |

<span id="VeLivePusherDef-VeLivePusherStatisticsObserver"></span>
# VeLivePusherStatisticsObserver
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatisticsObserver
```
The observer that periodically reports streaming statistics.
## Member Functions
| Return | Name |
| --- | --- |
| default void | [onStatistics](#VeLivePusherStatisticsObserver-onstatistics) |
| default void | [onLogMonitor](#VeLivePusherStatisticsObserver-onlogmonitor) |

## Instructions
<span id="VeLivePusherStatisticsObserver-onstatistics"></span>
### onStatistics
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatisticsObserver.onStatistics(VeLivePusherStatistics statistics)
```
Occurs periodically to report streaming statistics. By default, the callback is triggered every 5 seconds. You can call [setStatisticsObserver](docs-broadcast-sdk-for-android-api#VeLivePusher-setstatisticsobserver) to modify the callback time interval.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| statistics | VeLivePusherStatistics | The streaming statistics. See [VeLivePusherStatistics](docs-broadcast-sdk-for-android-type-definition#VeLivePusherDef-VeLivePusherStatistics) for details. |

<span id="VeLivePusherStatisticsObserver-onlogmonitor"></span>
### onLogMonitor
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatisticsObserver.onLogMonitor(JSONObject logInfo)
```
Occurs periodically to return log information.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| logInfo | JSONObject | The log information. |

<span id="VeLivePusherDef"></span>
# VeLivePusherDef
```java
public class com.ss.avframework.live.VeLivePusherDef
```
The type definition.
<span id="VeLiveFileRecordingListener"></span>
# VeLiveFileRecordingListener
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecordingListener
```
The observer for recording events.
## Member Functions
| Return | Name |
| --- | --- |
| default void | [onFileRecordingStarted](#VeLiveFileRecordingListener-onfilerecordingstarted) |
| default void | [onFileRecordingStopped](#VeLiveFileRecordingListener-onfilerecordingstopped) |
| default void | [onFileRecordingError](#VeLiveFileRecordingListener-onfilerecordingerror) |

## Instructions
<span id="VeLiveFileRecordingListener-onfilerecordingstarted"></span>
### onFileRecordingStarted
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecordingListener.onFileRecordingStarted()
```
Occurs when recording starts.
<span id="VeLiveFileRecordingListener-onfilerecordingstopped"></span>
### onFileRecordingStopped
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecordingListener.onFileRecordingStopped()
```
Occurs when recording stops.
<span id="VeLiveFileRecordingListener-onfilerecordingerror"></span>
### onFileRecordingError
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecordingListener.onFileRecordingError(
    int errorCode,
    String message
)
```
Occurs when an error occurs during recording.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| errorCode | int | The error code. See [VeLivePusherErrorCode](broadcast-sdk-for-android-api-error-code#VeLivePusherErrorCode) for details. |
| message | String | The error message. |

<span id="VeLivePusherDef-VeLiveVideoEffectHandleCallback"></span>
# VeLiveVideoEffectHandleCallback
```java
public interface com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectHandleCallback
```
A video effects callback.
## Member Functions
| Return | Name |
| --- | --- |
| default void | [onEffectHandle](#VeLiveVideoEffectHandleCallback-oneffecthandle) |

## Instructions
<span id="VeLiveVideoEffectHandleCallback-oneffecthandle"></span>
### onEffectHandle
```java
default void com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectHandleCallback.onEffectHandle(Object handle)
```
Occurs when the [setAdvancedFeature](docs-broadcast-sdk-for-android-api#VeLiveVideoEffectManager-setadvancedfeature) method is called. Please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| handle | Object | The video effect object. |

<span id="VeLivePusherErrorCode"></span>
# VeLivePusherErrorCode
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLivePusherErrorCode
```
The error code.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePusherSuccess | 0 | No error. |
| VeLivePusherInvalidLicense | -1 | SDK license error, possibly caused by an invalid or expired certificate. |
| VeLivePusherInvalidParameter | -2 | Parameter error, possibly caused by an invalid parameter value or parameter type. |
| VeLivePusherVideoCaptureError | -3 | Video capture error, possibly caused by the lack of access to the video device. |
| VeLivePusherAudioCaptureError | -4 | Audio capture error, possibly caused by the lack of access to the audio device. |
| VeLivePusherVideoEncoderError | -5 | Video encoding error, possibly caused by a configuration issue with the video encoder. If the error is not eliminated, please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method. |
| VeLivePusherAudioEncoderError | -6 | Audio encoding error, possibly caused by a configuration issue with the audio encoder. If the error is not eliminated, please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method. |
| VeLivePusherTransportError | -7 | Network error, which might be caused by network connection issues such as network instability or high latency. If the error is not eliminated, please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method. |
| VeLivePusherVideoEffectError | -8 | Special effects error. Please check if the Effects SDK has been integrated and initialized, and if the path of the effects resources is correctly set. If the error is not eliminated, please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method. |
| VeLivePusherAudioDeviceError | -9 | Audio device error. Please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method. |
| VeLivePusherLicenseUnsupportedH265 | -10 | The license does not support H265. |
| VeLivePusherScreenCaptureNotSupportError | -11 | The current system version does not support screen capture. |
| VeLivePusherScreenCaptureStartError | -12 | The request for screen capture permission was denied by the user. |
| VeLivePusherScreenCaptureInterruptedError | -13 | Screen capture was interrupted by the system, you can [contact support](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980). |
| VeLivePusherError | -100 | Internal error. Please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support for assistance when using this callback method. |


<span id="VeLiveVideoEncoderConfiguration"></span>
# VeLiveVideoEncoderConfiguration
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration
```
The video encoding configurations.
## Member Functions
| Return | Name |
| --- | --- |
| VeLiveVideoResolution | [getResolution](#VeLiveVideoEncoderConfiguration-getresolution) |
| VeLiveVideoEncoderConfiguration | [setResolution](#VeLiveVideoEncoderConfiguration-setresolution) |
| VeLiveVideoCodec | [getCodec](#VeLiveVideoEncoderConfiguration-getcodec) |
| VeLiveVideoEncoderConfiguration | [setCodec](#VeLiveVideoEncoderConfiguration-setcodec) |
| int | [getBitrate](#VeLiveVideoEncoderConfiguration-getbitrate) |
| VeLiveVideoEncoderConfiguration | [setBitrate](#VeLiveVideoEncoderConfiguration-setbitrate) |
| int | [getMinBitrate](#VeLiveVideoEncoderConfiguration-getminbitrate) |
| VeLiveVideoEncoderConfiguration | [setMinBitrate](#VeLiveVideoEncoderConfiguration-setminbitrate) |
| int | [getMaxBitrate](#VeLiveVideoEncoderConfiguration-getmaxbitrate) |
| VeLiveVideoEncoderConfiguration | [setMaxBitrate](#VeLiveVideoEncoderConfiguration-setmaxbitrate) |
| int | [getGopSize](#VeLiveVideoEncoderConfiguration-getgopsize) |
| VeLiveVideoEncoderConfiguration | [setGopSize](#VeLiveVideoEncoderConfiguration-setgopsize) |
| int | [getFps](#VeLiveVideoEncoderConfiguration-getfps) |
| VeLiveVideoEncoderConfiguration | [setFps](#VeLiveVideoEncoderConfiguration-setfps) |
| boolean | [isEnableBFrame](#VeLiveVideoEncoderConfiguration-isenablebframe) |
| VeLiveVideoEncoderConfiguration | [setEnableBFrame](#VeLiveVideoEncoderConfiguration-setenablebframe) |
| boolean | [isEnableAccelerate](#VeLiveVideoEncoderConfiguration-isenableaccelerate) |
| VeLiveVideoEncoderConfiguration | [setEnableAccelerate](#VeLiveVideoEncoderConfiguration-setenableaccelerate) |

## Instructions
<span id="VeLiveVideoEncoderConfiguration-getresolution"></span>
### getResolution
```java
public VeLiveVideoResolution com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.getResolution()
```
Gets the video resolution.

**Return Value**

The video resolution. See [VeLiveVideoResolution](#VeLivePusherDef-VeLiveVideoResolution) for details.
<span id="VeLiveVideoEncoderConfiguration-setresolution"></span>
### setResolution
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setResolution(VeLiveVideoResolution resolution)
```
Sets the video resolution.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| resolution | VeLiveVideoResolution | The video resolution. The default value is `VeLiveVideoResolution720P`. See [VeLiveVideoResolution](#VeLivePusherDef-VeLiveVideoResolution) for details. |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveVideoEncoderConfiguration-getcodec"></span>
### getCodec
```java
public VeLiveVideoCodec com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.getCodec()
```
Gets the video codec.

**Return Value**

The video codec. See [VeLiveVideoCodec](#VeLiveVideoCodec) for details.
<span id="VeLiveVideoEncoderConfiguration-setcodec"></span>
### setCodec
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setCodec(VeLiveVideoCodec codec)
```
Sets the video codec.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| codec | VeLiveVideoCodec | The video codec. See [VeLiveVideoCodec](#VeLiveVideoCodec) for details. |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveVideoEncoderConfiguration-getbitrate"></span>
### getBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.getBitrate()
```
Get the encoded video bitrate.

**Return Value**

The encoded video bitrate.
<span id="VeLiveVideoEncoderConfiguration-setbitrate"></span>
### setBitrate
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setBitrate(int bitrate)
```
Sets the encoded video bitrate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| bitrate | int | The encoded video bitrate, in Kbps. The default value depends on the value of the `resolution` parameter. |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveVideoEncoderConfiguration-getminbitrate"></span>
### getMinBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.getMinBitrate()
```
Gets the minimum encoded video bitrate.

**Return Value**

The minimum encoded video bitrate.
<span id="VeLiveVideoEncoderConfiguration-setminbitrate"></span>
### setMinBitrate
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setMinBitrate(int minBitrate)
```
Sets the minimum encoded video bitrate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| minBitrate | int | The minimum encoded video bitrate, in Kbps, when the adaptive bitrate (ABR) feature is enabled. The default value depends on the value of the `resolution` parameter. |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveVideoEncoderConfiguration-getmaxbitrate"></span>
### getMaxBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.getMaxBitrate()
```
Gets the maximum encoded video bitrate.

**Return Value**

The maximum encoded video bitrate.
<span id="VeLiveVideoEncoderConfiguration-setmaxbitrate"></span>
### setMaxBitrate
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setMaxBitrate(int maxBitrate)
```
Sets the maximum encoded video bitrate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| maxBitrate | int | The maximum video encoding bitrate, in Kbps, when the adaptive bitrate (ABR) feature is enabled. The default value depends on the value of the `resolution` parameter. |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveVideoEncoderConfiguration-getgopsize"></span>
### getGopSize
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.getGopSize()
```
Gets the encoded video GOP size.

**Return Value**

The encoded video GOP size.
<span id="VeLiveVideoEncoderConfiguration-setgopsize"></span>
### setGopSize
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setGopSize(int gopSize)
```
Sets the encoded video GOP size.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| gopSize | int | The encoded video GOP size, in seconds. The default value is `2`. |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveVideoEncoderConfiguration-getfps"></span>
### getFps
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.getFps()
```
Gets the encoded frame rate.

**Return Value**

The encoded frame rate.
<span id="VeLiveVideoEncoderConfiguration-setfps"></span>
### setFps
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setFps(int fps)
```
Sets the encoded frame rate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| fps | int | The encoded frame rate, in fps. The default value is `15`. |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveVideoEncoderConfiguration-isenablebframe"></span>
### isEnableBFrame
```java
public boolean com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.isEnableBFrame()
```
Gets whether to enable B frames.

**Return Value**

Whether to enable B frames.

- true: Enable;
- false: Disable.
<span id="VeLiveVideoEncoderConfiguration-setenablebframe"></span>
### setEnableBFrame
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setEnableBFrame(boolean enableBFrame)
```
Sets whether to enable B frames.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enableBFrame | boolean | Whether to enable B frames. <br/><ul><li>true: Enable;</li><li>false: (Default) Disable.</li></ul> |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration).
<span id="VeLiveVideoEncoderConfiguration-isenableaccelerate"></span>
### isEnableAccelerate
```java
public boolean com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.isEnableAccelerate()
```
Gets whether to enable hardware encoding.

**Return Value**

Whether to enable hardware encoding.

- true: Enable;
- false: Disable.
<span id="VeLiveVideoEncoderConfiguration-setenableaccelerate"></span>
### setEnableAccelerate
```java
public VeLiveVideoEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEncoderConfiguration.setEnableAccelerate(boolean enableAccelerate)
```
Enables hardware encoding.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enableAccelerate | boolean | Whether to enable hardware encoding. <br/><ul><li>true: (Default) Enable;</li><li>false: Disable.</li></ul> |


**Return Value**

The video encoding configurations. See [VeLiveVideoEncoderConfiguration](#velivevideoencoderconfiguration) for details.
<span id="VeLiveAudioCodec"></span>
# VeLiveAudioCodec
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioCodec
```
The audio encoding format.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioCodecFdkAAC | 0 | FDKAAC. |
| VeLiveAudioCodecMediaCodecAAC | 1 | Mediacodec AAC. |
| VeLiveAudioCodecFFmpegAAC | 2 | FFMPEG AAC. |

<span id="VeLiveVideoFrame"></span>
# VeLiveVideoFrame
```java
public class com.ss.avframework.live.VeLiveVideoFrame
```
The information of a video frame.
## Member Functions
| Return | Name |
| --- | --- |
| VeLiveVideoFrame | [VeLiveVideoFrame](#VeLiveVideoFrame-velivevideoframe) |
| VeLiveVideoFrame | [VeLiveVideoFrame](#VeLiveVideoFrame-velivevideoframe-2) |
| VeLiveVideoFrame | [VeLiveVideoFrame](#VeLiveVideoFrame-velivevideoframe-3) |
| VeLiveVideoFrame | [VeLiveVideoFrame](#VeLiveVideoFrame-velivevideoframe-4) |
| void | [retain](#VeLiveVideoFrame-retain) |
| synchronized void | [release](#VeLiveVideoFrame-release) |
| VeLiveVideoBufferType | [getBufferType](#VeLiveVideoFrame-getbuffertype) |
| VeLiveVideoFrame | [setBufferType](#VeLiveVideoFrame-setbuffertype) |
| VeLivePixelFormat | [getPixelFormat](#VeLiveVideoFrame-getpixelformat) |
| VeLiveVideoFrame | [setPixelFormat](#VeLiveVideoFrame-setpixelformat) |
| VeLiveVideoRotation | [getRotation](#VeLiveVideoFrame-getrotation) |
| VeLiveVideoFrame | [setRotation](#VeLiveVideoFrame-setrotation) |
| int | [getWidth](#VeLiveVideoFrame-getwidth) |
| int | [getHeight](#VeLiveVideoFrame-getheight) |
| int | [getRotatedWidth](#VeLiveVideoFrame-getrotatedwidth) |
| int | [getRotatedHeight](#VeLiveVideoFrame-getrotatedheight) |
| long | [getPts](#VeLiveVideoFrame-getpts) |
| int | [getTextureId](#VeLiveVideoFrame-gettextureid) |
| void | [setTextureId](#VeLiveVideoFrame-settextureid) |
| Matrix | [getTextureMatrix](#VeLiveVideoFrame-gettexturematrix) |
| VeLiveVideoFrame | [setTextureMatrix](#VeLiveVideoFrame-settexturematrix) |
| ByteBuffer | [getBuffer](#VeLiveVideoFrame-getbuffer) |
| byte[] | [getData](#VeLiveVideoFrame-getdata) |
| Runnable | [getReleaseCallback](#VeLiveVideoFrame-getreleasecallback) |
| VeLiveVideoFrame | [setReleaseCallback](#VeLiveVideoFrame-setreleasecallback) |

## Instructions
<span id="VeLiveVideoFrame-velivevideoframe"></span>
### VeLiveVideoFrame
```java
public com.ss.avframework.live.VeLiveVideoFrame.VeLiveVideoFrame()
```
No-parameter video frame initialization method, applicable to scenarios where an empty video frame object needs to be created first and then set through other methods.
<span id="VeLiveVideoFrame-velivevideoframe-2"></span>
### VeLiveVideoFrame
```java
public com.ss.avframework.live.VeLiveVideoFrame.VeLiveVideoFrame(
    int width,
    int height,
    long pts,
    int texId,
    boolean isOes,
    Matrix matrix
)
```
Video frame initialization method based on texture ID, applicable to scenarios where video rendering needs to be performed through OpenGL textures, including detailed information such as texture ID, whether it is an OES texture, and texture matrix.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| width | int | The width of the video frame, in pixels. |
| height | int | The height of the video frame, in pixels. |
| pts | long | The timestamp of the video frame, in µs. |
| texId | int | The texture ID. |
| isOes | boolean | Whether it is an OES texture. |
| matrix | Matrix | The texture matrix. |

<span id="VeLiveVideoFrame-velivevideoframe-3"></span>
### VeLiveVideoFrame
```java
public com.ss.avframework.live.VeLiveVideoFrame.VeLiveVideoFrame(
    int width,
    int height,
    long pts,
    ByteBuffer byteBuffer
)
```
Video frame initialization method based on ByteBuffer, applicable to scenarios where video data is stored in ByteBuffer format, usually used in applications for efficient memory processing and direct manipulation of byte streams.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| width | int | The width of the video frame, in pixels. |
| height | int | The height of the video frame, in pixels. |
| pts | long | The timestamp of the video frame, in µs. |
| byteBuffer | ByteBuffer | The video data in the format of ByteBuffer. The default format is I420. You can call [setPixelFormat](#VeLiveVideoFrame-setpixelformat) to set the video format. |


**Notes**



You must ensure that the stride of the YUV data is equal to `width`.
<span id="VeLiveVideoFrame-velivevideoframe-4"></span>
### VeLiveVideoFrame
```java
public com.ss.avframework.live.VeLiveVideoFrame.VeLiveVideoFrame(
    int width,
    int height,
    long pts,
    byte[] data
)
```
Video frame initialization method based on byte[] array, applicable to scenarios where video data is stored in byte[] array format, usually used for directly processing video frames using byte arrays.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| width | int | The width of the video frame, in pixels. |
| height | int | The height of the video frame, in pixels. |
| pts | long | The timestamp of the video frame, in µs. |
| data | byte[] | The video data in the format of byte[]. The default format is I420. You can call [setPixelFormat](#VeLiveVideoFrame-setpixelformat) to set the video format. |


**Notes**



You must ensure that the stride of the YUV data is equal to `width`.
<span id="VeLiveVideoFrame-retain"></span>
### retain
```java
public void com.ss.avframework.live.VeLiveVideoFrame.retain()
```
Increases the reference count of the `VeLiveVideoFrame` object. Call this method to increase the reference count by 1 if you need to continue using the `VeLiveVideoFrame` object.
<span id="VeLiveVideoFrame-release"></span>
### release
```java
public synchronized void com.ss.avframework.live.VeLiveVideoFrame.release()
```
Releases the reference to the `VeLiveVideoFrame` object. Call this method to reduce the reference count by 1 when you no longer need to use the `VeLiveVideoFrame` object. When the reference count is reduced to 0, it means there is no reference to the object, and the object can be safely released or destroyed.
<span id="VeLiveVideoFrame-getbuffertype"></span>
### getBufferType
```java
public VeLiveVideoBufferType com.ss.avframework.live.VeLiveVideoFrame.getBufferType()
```
Gets the data type of the video.

**Return Value**

The data type of the video. See [VeLiveVideoBufferType](#VeLiveVideoBufferType) for details.
<span id="VeLiveVideoFrame-setbuffertype"></span>
### setBufferType
```java
public VeLiveVideoFrame com.ss.avframework.live.VeLiveVideoFrame.setBufferType(VeLiveVideoBufferType bufferType)
```
Sets the data type of the video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| bufferType | VeLiveVideoBufferType | The data type of the video. See [VeLiveVideoBufferType](#VeLiveVideoBufferType) for details. |


**Return Value**

The video frame object. See [VeLiveVideoFrame](#VeLiveVideoFrame) for details.
<span id="VeLiveVideoFrame-getpixelformat"></span>
### getPixelFormat
```java
public VeLivePixelFormat com.ss.avframework.live.VeLiveVideoFrame.getPixelFormat()
```
Gets the pixel format.

**Return Value**

The pixel format. See [VeLivePixelFormat](#VeLivePixelFormat) for details.
<span id="VeLiveVideoFrame-setpixelformat"></span>
### setPixelFormat
```java
public VeLiveVideoFrame com.ss.avframework.live.VeLiveVideoFrame.setPixelFormat(VeLivePixelFormat pixelFormat)
```
Sets the pixel format.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| pixelFormat | VeLivePixelFormat | The pixel format. See [VeLivePixelFormat](#VeLivePixelFormat) for details. |


**Return Value**

The video frame object. See [VeLiveVideoFrame](#VeLiveVideoFrame) for details.
<span id="VeLiveVideoFrame-getrotation"></span>
### getRotation
```java
public VeLiveVideoRotation com.ss.avframework.live.VeLiveVideoFrame.getRotation()
```
Gets the rotation angle in a clockwise direction.

**Return Value**

The rotation angle in a clockwise direction. See [VeLiveVideoRotation](#VeLiveVideoRotation) for details.
<span id="VeLiveVideoFrame-setrotation"></span>
### setRotation
```java
public VeLiveVideoFrame com.ss.avframework.live.VeLiveVideoFrame.setRotation(VeLiveVideoRotation rotation)
```
Sets the rotation angle in a clockwise direction.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| rotation | VeLiveVideoRotation | The rotation angle in a clockwise direction. See [VeLiveVideoRotation](#VeLiveVideoRotation) for details. |


**Return Value**

The video frame object. See [VeLiveVideoFrame](#VeLiveVideoFrame) for details.
<span id="VeLiveVideoFrame-getwidth"></span>
### getWidth
```java
public int com.ss.avframework.live.VeLiveVideoFrame.getWidth()
```
Gets the width of the video frame.

**Return Value**



The width of the video frame.
<span id="VeLiveVideoFrame-getheight"></span>
### getHeight
```java
public int com.ss.avframework.live.VeLiveVideoFrame.getHeight()
```
Gets the height of the video frame.

**Return Value**



The height of the video frame.
<span id="VeLiveVideoFrame-getrotatedwidth"></span>
### getRotatedWidth
```java
public int com.ss.avframework.live.VeLiveVideoFrame.getRotatedWidth()
```
Gets the width of the rotated video frame.

**Return Value**



The width of the rotated video frame.
<span id="VeLiveVideoFrame-getrotatedheight"></span>
### getRotatedHeight
```java
public int com.ss.avframework.live.VeLiveVideoFrame.getRotatedHeight()
```
Gets the height of the rotated video frame.

**Return Value**



The height of the rotated video frame.
<span id="VeLiveVideoFrame-getpts"></span>
### getPts
```java
public long com.ss.avframework.live.VeLiveVideoFrame.getPts()
```
Gets the timestamp of the video frame.

**Return Value**



The timestamp of the video frame, in μs.
<span id="VeLiveVideoFrame-gettextureid"></span>
### getTextureId
```java
public int com.ss.avframework.live.VeLiveVideoFrame.getTextureId()
```
Gets the texture ID.

**Return Value**



The texture ID.
<span id="VeLiveVideoFrame-settextureid"></span>
### setTextureId
```java
public void com.ss.avframework.live.VeLiveVideoFrame.setTextureId(int textureId)
```
Sets the texture ID of the current video frame, which is used to identify the texture resource in the GPU during image rendering.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| textureId | int | Texture ID, used to identify the texture resource bound to the current frame. |

<span id="VeLiveVideoFrame-gettexturematrix"></span>
### getTextureMatrix
```java
public Matrix com.ss.avframework.live.VeLiveVideoFrame.getTextureMatrix()
```
Gets the texture transformation matrix of the current video frame. This matrix is used to transform texture coordinates, such as rotation, scaling, or flipping.

**Return Value**

The Matrix object representing the texture transformation matrix for the current frame.
<span id="VeLiveVideoFrame-settexturematrix"></span>
### setTextureMatrix
```java
public VeLiveVideoFrame com.ss.avframework.live.VeLiveVideoFrame.setTextureMatrix(Matrix matrix)
```
Sets the texture transformation matrix of the current video frame. This matrix is used to perform geometric transformations on image textures before rendering.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| matrix | Matrix | Texture transformation matrix. |


**Return Value**

A `VeLiveVideoFrame` instance that supports method chaining.
<span id="VeLiveVideoFrame-getbuffer"></span>
### getBuffer
```java
public ByteBuffer com.ss.avframework.live.VeLiveVideoFrame.getBuffer()
```
Gets the video data in the format of ByteBuffer.

**Return Value**

The video data in the format of ByteBuffer.
<span id="VeLiveVideoFrame-getdata"></span>
### getData
```java
public byte[] com.ss.avframework.live.VeLiveVideoFrame.getData()
```
Gets the video data in the format of byte [].

**Return Value**

The video data in the format of byte [].
<span id="VeLiveVideoFrame-getreleasecallback"></span>
### getReleaseCallback
```java
public Runnable com.ss.avframework.live.VeLiveVideoFrame.getReleaseCallback()
```
Gets the internal release callback.

**Return Value**

The internal release callback.
<span id="VeLiveVideoFrame-setreleasecallback"></span>
### setReleaseCallback
```java
public VeLiveVideoFrame com.ss.avframework.live.VeLiveVideoFrame.setReleaseCallback(Runnable releaseCallback)
```
Sets the internal release callback.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| releaseCallback | Runnable | The internal release callback. |


**Return Value**

The video frame object. See [VeLiveVideoFrame](#VeLiveVideoFrame) for details.
<span id="VeLiveVideoCodec"></span>
# VeLiveVideoCodec
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCodec
```
The video encoding format.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveVideoCodecH264 | h264 | H.264. |
| VeLiveVideoCodecByteVC1 | bytevc1 | ByteVC1, an encoding format developed by BytePlus. |

<span id="VeLivePusherStatistics"></span>
# VeLivePusherStatistics
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics
```
Push-stream statistics.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| int | - | [encodeWidth](#VeLivePusherStatistics-encodewidth) |
| int | - | [encodeHeight](#VeLivePusherStatistics-encodeheight) |
| int | - | [captureWidth](#VeLivePusherStatistics-capturewidth) |
| int | - | [captureHeight](#VeLivePusherStatistics-captureheight) |
| double | - | [captureFps](#VeLivePusherStatistics-capturefps) |
| double | - | [encodeFps](#VeLivePusherStatistics-encodefps) |
| double | - | [transportFps](#VeLivePusherStatistics-transportfps) |
| int | - | [fps](#VeLivePusherStatistics-fps) |
| int | - | [videoBitrate](#VeLivePusherStatistics-videobitrate) |
| int | - | [minVideoBitrate](#VeLivePusherStatistics-minvideobitrate) |
| int | - | [maxVideoBitrate](#VeLivePusherStatistics-maxvideobitrate) |
| double | - | [encodeVideoBitrate](#VeLivePusherStatistics-encodevideobitrate) |
| double | - | [transportVideoBitrate](#VeLivePusherStatistics-transportvideobitrate) |
| double | - | [encodeAudioBitrate](#VeLivePusherStatistics-encodeaudiobitrate) |
| String | - | [url](#VeLivePusherStatistics-url) |
| String | - | [codec](#VeLivePusherStatistics-codec) |

## Instructions
<span id="VeLivePusherStatistics-encodewidth"></span>
### encodeWidth
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.encodeWidth
```
The width of the encoded video, in pixels.
<span id="VeLivePusherStatistics-encodeheight"></span>
### encodeHeight
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.encodeHeight
```
The height of the encoded video, in pixels.
<span id="VeLivePusherStatistics-capturewidth"></span>
### captureWidth
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.captureWidth
```
The width of the captured video, in pixels.
<span id="VeLivePusherStatistics-captureheight"></span>
### captureHeight
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.captureHeight
```
The height of the captured video, in pixels.
<span id="VeLivePusherStatistics-capturefps"></span>
### captureFps
```java
public double com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.captureFps
```
The captured frame rate, in fps.
<span id="VeLivePusherStatistics-encodefps"></span>
### encodeFps
```java
public double com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.encodeFps
```
The encoded frame rate, in fps.
<span id="VeLivePusherStatistics-transportfps"></span>
### transportFps
```java
public double com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.transportFps
```
The transmission frame rate, in fps. You can use this parameter to showcase the real-time frame rate on the user interface.
<span id="VeLivePusherStatistics-fps"></span>
### fps
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.fps
```
The encoded frame rate you specify in the [setVideoEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-setvideoencoderconfiguration) method, in fps.
<span id="VeLivePusherStatistics-videobitrate"></span>
### videoBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.videoBitrate
```
The encoded bitrate you specify in the [setVideoEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-setvideoencoderconfiguration) method, in Kbps.
<span id="VeLivePusherStatistics-minvideobitrate"></span>
### minVideoBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.minVideoBitrate
```
The minimum encoded bitrate you specify in the [setVideoEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-setvideoencoderconfiguration) method, in Kbps.
<span id="VeLivePusherStatistics-maxvideobitrate"></span>
### maxVideoBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.maxVideoBitrate
```
The maximum encoded bitrate you specify in the [setVideoEncoderConfiguration](docs-broadcast-sdk-for-android-api#VeLivePusher-setvideoencoderconfiguration) method, in Kbps.
<span id="VeLivePusherStatistics-encodevideobitrate"></span>
### encodeVideoBitrate
```java
public double com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.encodeVideoBitrate
```
The encoded video bitrate, in Kbps.
<span id="VeLivePusherStatistics-transportvideobitrate"></span>
### transportVideoBitrate
```java
public double com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.transportVideoBitrate
```
The transmission bitrate, in Kbps. You can use this parameter to showcase the real-time bitrate on the user interface.
<span id="VeLivePusherStatistics-encodeaudiobitrate"></span>
### encodeAudioBitrate
```java
public double com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.encodeAudioBitrate
```
The audio encoding bitrate, in Kbps.
<span id="VeLivePusherStatistics-url"></span>
### url
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.url
```
The push stream address.
<span id="VeLivePusherStatistics-codec"></span>
### codec
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatistics.codec
```
The video codec.
<span id="VeLivePusherRenderMode"></span>
# VeLivePusherRenderMode
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLivePusherRenderMode
```
The render mode.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePusherRenderModeFill | 0 | Stretch the video to fill the screen. The aspect ratio of the video might change. |
| VeLivePusherRenderModeFit | 1 | Display the full video. The video is uniformly scaled until one dimension of the video hits the boundary of the screen. Any remaining space on the screen will be filled with background color. |
| VeLivePusherRenderModeHidden | 2 | Uniformly scale the video until the screen is completely filled. Part of the video may be cropped. |

<span id="VeLiveVideoEffectLicenseType"></span>
# VeLiveVideoEffectLicenseType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseType
```
The authentication method for the special effects license.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveVideoEffectLicenseTypeOffLine | 0 | Authenticate offline. |
| VeLiveVideoEffectLicenseTypeOnLine | 1 | Authenticate online. |

<span id="VeLiveAudioBufferType"></span>
# VeLiveAudioBufferType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioBufferType
```
The data type of the pushed audio.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioBufferTypeUnknown | 0 | Unknown data type. |
| VeLiveAudioBufferTypeByteBuffer | 1 | ByteBuffer. |

<span id="VeLiveAudioChannel"></span>
# VeLiveAudioChannel
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioChannel
```
The number of audio channels for streaming.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioChannelMono | 1 | Mono, which is suitable for voice communication and saves bandwidth. |
| VeLiveAudioChannelStereo | 2 | Stereo, which provides a richer audio experience and is suitable for music playback. |

<span id="VeLiveFirstFrameType"></span>
# VeLiveFirstFrameType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveFirstFrameType
```
The type of the first frame.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveFirstCaptureFrame | 0 | The first audio or video frame captured by the microphone or the camera. |
| VeLiveFirstRenderFrame | 1 | The first video frame rendered, which is the first frame displayed on the screen. |
| VeLiveFirstEncodedFrame | 2 | The first audio or video frame encoded in a certain format. |
| VeLiveFirstSendFrame | 3 | The first audio or video frame transmitted through the network. |

<span id="VeLiveVideoCaptureType"></span>
# VeLiveVideoCaptureType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureType
```
Video capture type.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveVideoCaptureFrontCamera | 0 | Capture the video with the front-facing camera. |
| VeLiveVideoCaptureBackCamera | 1 | Capture the video with the rear camera. |
| VeLiveVideoCaptureScreen | 2 | Capture the screen. |
| VeLiveVideoCaptureExternal | 3 | Capture the video with an external device or source. |
| VeLiveVideoCaptureCustomImage | 4 | Use a static image as the video source. |
| VeLiveVideoCaptureLastFrame | 5 | Use the last frame as the video source. |
| VeLiveVideoCaptureDummyFrame | 6 | Use a black frame as the video source. This is usually used for debugging purposes or in special circumstances. |

<span id="VeLiveVideoProfile"></span>
# VeLiveVideoProfile
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveVideoProfile
```
The enumeration type of camera configurations.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveVideoProfileUnknown | 0 | Unknown codec. |
| VeLiveVideoProfileH264Baseline | 1 | H.264, using Baseline level. |
| VeLiveVideoProfileH264Main | 2 | H.264, using Main level. |
| VeLiveVideoProfileH264High | 3 | H.264, using High level. |
| VeLiveVideoProfileByteVC1Main | 4 | ByteVC1, using Main level. |

<span id="VeLiveVideoRotation"></span>
# VeLiveVideoRotation
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveVideoRotation
```
The rotation angle of the video frame relative to the app.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveVideoRotation0 | 0 | Do not rotate. |
| VeLiveVideoRotation90 | 90 | Rotate by 90 degrees clockwise. |
| VeLiveVideoRotation180 | 180 | Rotate by 180 degrees clockwise. |
| VeLiveVideoRotation270 | 270 | Rotate by 270 degrees clockwise. |

<span id="VeLiveVideoFrameSource"></span>
# VeLiveVideoFrameSource
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameSource
```
The source of the video frame.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| int | 1 | [VeLiveVideoFrameSourceCapture](#VeLiveVideoFrameSource-velivevideoframesourcecapture) |
| int | 1 << 1 | [VeLiveVideoFrameSourcePreEncode](#VeLiveVideoFrameSource-velivevideoframesourcepreencode) |

## Member Functions
| Return | Name |
| --- | --- |
| VeLiveVideoFrameSource | [VeLiveVideoFrameSource](#VeLiveVideoFrameSource-velivevideoframesource) |

## Instructions
<span id="VeLiveVideoFrameSource-velivevideoframesourcecapture"></span>
### VeLiveVideoFrameSourceCapture
```java
public static final int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameSource.VeLiveVideoFrameSourceCapture = 1
```
The original video frame captured by the camera or other video sources.
<span id="VeLiveVideoFrameSource-velivevideoframesourcepreencode"></span>
### VeLiveVideoFrameSourcePreEncode
```java
public static final int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameSource.VeLiveVideoFrameSourcePreEncode = 1 << 1
```
The video frame to be encoded after undergoing various processes, such as filtering and rotation.
## Instructions
<span id="VeLiveVideoFrameSource-velivevideoframesource"></span>
### VeLiveVideoFrameSource
```java
public com.ss.avframework.live.VeLivePusherDef.VeLiveVideoFrameSource.VeLiveVideoFrameSource(int source)
```
Creates a video frame source.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| source | int | The identifier of the video frame source. When the value is `VeLiveVideoFrameSourceCapture | VeLiveVideoFrameSourcePreEncode`, it means both `VeLiveVideoFrameSourceCapture` and `VeLiveVideoFrameSourcePreEncode` are subscribed. |

<span id="VeLiveAudioProfile"></span>
# VeLiveAudioProfile
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioProfile
```
AAC encoding format.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioAACProfileLC | 0 | LC-AAC. |
| VeLiveAudioAACProfileHEv1 | 1 | HEv1-AAC. |
| VeLiveAudioAACProfileHEv2 | 2 | HEv2-AAC. |

<span id="VeLiveVideoBufferType"></span>
# VeLiveVideoBufferType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveVideoBufferType
```
The data type of the video.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveVideoBufferTypeUnknown | 0 | Unknown data type, which is the default type if you do not specify any type. |
| VeLiveVideoBufferTypeTexture | 1 | OpenGL texture. |
| VeLiveVideoBufferTypeByteBuffer | 2 | ByteBuffer. |
| VeLiveVideoBufferTypeByteArray | 3 | ByteArray. |

<span id="VeLiveAudioCaptureConfiguration"></span>
# VeLiveAudioCaptureConfiguration
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveAudioCaptureConfiguration
```
The audio capture configurations.
## Member Functions
| Return | Name |
| --- | --- |
| VeLiveAudioSampleRate | [getSampleRate](#VeLiveAudioCaptureConfiguration-getsamplerate) |
| VeLiveAudioCaptureConfiguration | [setSampleRate](#VeLiveAudioCaptureConfiguration-setsamplerate) |
| VeLiveAudioChannel | [getChannel](#VeLiveAudioCaptureConfiguration-getchannel) |
| VeLiveAudioCaptureConfiguration | [setChannel](#VeLiveAudioCaptureConfiguration-setchannel) |

## Instructions
<span id="VeLiveAudioCaptureConfiguration-getsamplerate"></span>
### getSampleRate
```java
public VeLiveAudioSampleRate com.ss.avframework.live.VeLivePusherDef.VeLiveAudioCaptureConfiguration.getSampleRate()
```
Gets the sample rate.

**Return Value**

The sample rate. See [VeLiveAudioSampleRate](#VeLiveAudioSampleRate) for details.
<span id="VeLiveAudioCaptureConfiguration-setsamplerate"></span>
### setSampleRate
```java
public VeLiveAudioCaptureConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveAudioCaptureConfiguration.setSampleRate(VeLiveAudioSampleRate sampleRate)
```
Sets the sample rate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| sampleRate | VeLiveAudioSampleRate | The sample rate. The default value is `VeLiveAudioSampleRate44100`. See [VeLiveAudioSampleRate](#VeLiveAudioSampleRate) for details. |


**Return Value**

The audio capture configurations. See [VeLiveAudioCaptureConfiguration](#VeLivePusherDef-VeLiveAudioCaptureConfiguration) for details.
<span id="VeLiveAudioCaptureConfiguration-getchannel"></span>
### getChannel
```java
public VeLiveAudioChannel com.ss.avframework.live.VeLivePusherDef.VeLiveAudioCaptureConfiguration.getChannel()
```
Gets the number of audio channels.

**Return Value**

The number of audio channels. See [VeLiveAudioChannel](#VeLiveAudioChannel) for details.
<span id="VeLiveAudioCaptureConfiguration-setchannel"></span>
### setChannel
```java
public VeLiveAudioCaptureConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveAudioCaptureConfiguration.setChannel(VeLiveAudioChannel channel)
```
Sets the number of audio channels.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| channel | VeLiveAudioChannel | The number of audio channels. The default value is `VeLiveAudioChannelStereo`. See [VeLiveAudioChannel](#VeLiveAudioChannel) for details. |


**Return Value**

The audio capture configurations. See [VeLiveAudioCaptureConfiguration](#VeLivePusherDef-VeLiveAudioCaptureConfiguration) for details.
<span id="VeLiveStreamMixDescription"></span>
# VeLiveStreamMixDescription
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveStreamMixDescription
```
The configurations for audio and video mixing.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| ArrayList\<VeLiveMixVideoLayout> | new ArrayList<>() | [mixVideoStreams](#VeLiveStreamMixDescription-mixvideostreams) |
| ArrayList\<VeLiveMixAudioLayout> | new ArrayList<>() | [mixAudioStreams](#VeLiveStreamMixDescription-mixaudiostreams) |
| String | "#000000" | [backgroundColor](#VeLiveStreamMixDescription-backgroundcolor) |

## Instructions
<span id="VeLiveStreamMixDescription-mixvideostreams"></span>
### mixVideoStreams
```java
public final ArrayList<VeLiveMixVideoLayout> com.ss.avframework.live.VeLivePusherDef.VeLiveStreamMixDescription.mixVideoStreams = new ArrayList<>()
```
An array of video mixing configurations, where each array element represents the mixing configurations of a video stream. See [VeLiveMixVideoLayout](#VeLivePusherDef-VeLiveMixVideoLayout) for details.
<span id="VeLiveStreamMixDescription-mixaudiostreams"></span>
### mixAudioStreams
```java
public final ArrayList<VeLiveMixAudioLayout> com.ss.avframework.live.VeLivePusherDef.VeLiveStreamMixDescription.mixAudioStreams = new ArrayList<>()
```
An array of audio mixing configurations, where each array element represents the mixing configurations of an audio stream. See [VeLiveMixAudioLayout](#velivemixaudiolayout) for details.
<span id="VeLiveStreamMixDescription-backgroundcolor"></span>
### backgroundColor
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveStreamMixDescription.backgroundColor = "#000000"
```
The background color of the mixed video, in #RRGGBB format.
<span id="VeLiveAudioSampleRate"></span>
# VeLiveAudioSampleRate
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioSampleRate
```
The sample rate of the pushed audio.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioSampleRate8000 | 8000 | 8K. |
| VeLiveAudioSampleRate16000 | 16000 | 16K. |
| VeLiveAudioSampleRate32000 | 32000 | 32K. |
| VeLiveAudioSampleRate44100 | 44100 | 44.1K. |
| VeLiveAudioSampleRate48000 | 48000 | 48K. |

<span id="VeLiveAudioPowerLevel"></span>
# VeLiveAudioPowerLevel
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioPowerLevel
```
The volume level.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioPowerLevelSilent | 0 | Muted. The volume is 1 dB or less. |
| VeLiveAudioPowerLevelQuiet | 1 | Quiet. The volume is below 15 dB. |
| VeLiveAudioPowerLevelLight | 2 | Soft, close to whisper. The volume is between 16 dB and 30 dB. |
| VeLiveAudioPowerLevelNormal | 3 | Normal, similar to the volume in a daily conversation. The volume is between 30 dB and 60 dB. |
| VeLiveAudioPowerLevelLoud | 4 | Loud, similar to the volume of the noise at cafes. The volume is between 61 dB and 85 dB. |
| VeLiveAudioPowerLevelNoise | 5 | Noisy, similar to the volume of the noise on a busy street or at a concert. The volume is higher than 85 dB. |

<span id="VeLiveVideoCaptureConfiguration"></span>
# VeLiveVideoCaptureConfiguration
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureConfiguration
```
The video capture configurations.
## Member Functions
| Return | Name |
| --- | --- |
| int | [getWidth](#VeLiveVideoCaptureConfiguration-getwidth) |
| VeLiveVideoCaptureConfiguration | [setWidth](#VeLiveVideoCaptureConfiguration-setwidth) |
| int | [getHeight](#VeLiveVideoCaptureConfiguration-getheight) |
| VeLiveVideoCaptureConfiguration | [setHeight](#VeLiveVideoCaptureConfiguration-setheight) |
| int | [getFps](#VeLiveVideoCaptureConfiguration-getfps) |
| VeLiveVideoCaptureConfiguration | [setFps](#VeLiveVideoCaptureConfiguration-setfps) |

## Instructions
<span id="VeLiveVideoCaptureConfiguration-getwidth"></span>
### getWidth
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureConfiguration.getWidth()
```
Gets the width of the captured video.

**Return Value**

The width of the captured video.
<span id="VeLiveVideoCaptureConfiguration-setwidth"></span>
### setWidth
```java
public VeLiveVideoCaptureConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureConfiguration.setWidth(int width)
```
Sets the width of the captured video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| width | int | The width of the captured video. The default value is `720`. |


**Return Value**

The video capture configurations. See [VeLiveVideoCaptureConfiguration](#VeLivePusherDef-VeLiveVideoCaptureConfiguration) for details.
<span id="VeLiveVideoCaptureConfiguration-getheight"></span>
### getHeight
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureConfiguration.getHeight()
```
Gets the height of the captured video.

**Return Value**



The height of the captured video.
<span id="VeLiveVideoCaptureConfiguration-setheight"></span>
### setHeight
```java
public VeLiveVideoCaptureConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureConfiguration.setHeight(int height)
```
Sets the height of the captured video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| height | int | The height of the captured video. The default value is `1280`. |


**Return Value**

The video capture configurations. See [VeLiveVideoCaptureConfiguration](#VeLivePusherDef-VeLiveVideoCaptureConfiguration) for details.
<span id="VeLiveVideoCaptureConfiguration-getfps"></span>
### getFps
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureConfiguration.getFps()
```
Gets the captured frame rate.

**Return Value**

The captured frame rate.
<span id="VeLiveVideoCaptureConfiguration-setfps"></span>
### setFps
```java
public VeLiveVideoCaptureConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoCaptureConfiguration.setFps(int fps)
```
Sets the captured frame rate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| fps | int | The captured frame rate. The default value is `15`. |


**Return Value**

The video capture configurations. See [VeLiveVideoCaptureConfiguration](#VeLivePusherDef-VeLiveVideoCaptureConfiguration) for details.
<span id="VeLivePixelFormat"></span>
# VeLivePixelFormat
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLivePixelFormat
```
The data format of the video frame.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePixelFormatUnknown | 0 | Unknown format. |
| VeLivePixelFormatI420 | 1 | I420. |
| VeLivePixelFormatNV12 | 2 | NV12. |
| VeLivePixelFormatNV21 | 3 | NV21. |
| VeLivePixelFormat2DTexture | 4 | 2D texture. |
| VeLivePixelFormatOesTexture | 5 | OES texture. |

<span id="VeLivePusherStatus"></span>
# VeLivePusherStatus
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLivePusherStatus
```
The connection state between the live pusher and the server.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePushStatusNone | 0 | The initial state. |
| VeLivePushStatusConnecting | 1 | Connecting to the server. |
| VeLivePushStatusConnectSuccess | 2 | The connection with the server is established. |
| VeLivePushStatusReconnecting | 3 | Reconnecting to the server. |
| VeLivePushStatusConnectStop | 4 | Stops connecting to the server. |
| VeLivePushStatusConnectError | 5 | Fails to connect to the server. |
| VeLivePushStatusDisconnected | 6 | The connection with the server is lost. |

<span id="VeLiveVideoResolution"></span>
# VeLiveVideoResolution
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveVideoResolution
```
The video resolution with a set of predefined configurations.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| VeLiveVideoResolution | newVeLiveVideoResolution(360, 640, 15, 500, 250, 800) | [VeLiveVideoResolution360P](#VeLiveVideoResolution-velivevideoresolution360p) |
| VeLiveVideoResolution | newVeLiveVideoResolution(480, 864, 15, 800, 320, 1266) | [VeLiveVideoResolution480P](#VeLiveVideoResolution-velivevideoresolution480p) |
| VeLiveVideoResolution | newVeLiveVideoResolution(540, 960, 15, 1000, 500, 1520) | [VeLiveVideoResolution540P](#VeLiveVideoResolution-velivevideoresolution540p) |
| VeLiveVideoResolution | newVeLiveVideoResolution(720, 1280, 15, 1200, 800, 1900) | [VeLiveVideoResolution720P](#VeLiveVideoResolution-velivevideoresolution720p) |
| VeLiveVideoResolution | newVeLiveVideoResolution(1080, 1920, 20, 2500, 1000, 3800) | [VeLiveVideoResolution1080P](#VeLiveVideoResolution-velivevideoresolution1080p) |

## Instructions
<span id="VeLiveVideoResolution-velivevideoresolution360p"></span>
### VeLiveVideoResolution360P
```java
public static final VeLiveVideoResolution com.ss.avframework.live.VeLivePusherDef.VeLiveVideoResolution.VeLiveVideoResolution360P = newVeLiveVideoResolution(360, 640, 15, 500, 250, 800)
```
360P.
- Resolution in landscape mode: 640x360
- Resolution in portrait mode: 360x640
- Frame rate: 15 fps
- Target bitrate: 500 Kbps
- Minimum bitrate: 250 Kbps
- Maximum bitrate: 800 Kbps
<span id="VeLiveVideoResolution-velivevideoresolution480p"></span>
### VeLiveVideoResolution480P
```java
public static final VeLiveVideoResolution com.ss.avframework.live.VeLivePusherDef.VeLiveVideoResolution.VeLiveVideoResolution480P = newVeLiveVideoResolution(480, 864, 15, 800, 320, 1266)
```
480P.
- Resolution in landscape mode: 864x480
- Resolution in portrait mode: 480x864
- Frame rate: 15 fps
- Target bitrate: 800 Kbps
- Minimum bitrate: 320 Kbps
- Maximum bitrate: 1266 Kbps
<span id="VeLiveVideoResolution-velivevideoresolution540p"></span>
### VeLiveVideoResolution540P
```java
public static final VeLiveVideoResolution com.ss.avframework.live.VeLivePusherDef.VeLiveVideoResolution.VeLiveVideoResolution540P = newVeLiveVideoResolution(540, 960, 15, 1000, 500, 1520)
```
540P.
- Resolution in landscape mode: 960x540
- Resolution in portrait mode: 540x960
- Frame rate: 15 fps
- Target bitrate: 1000 Kbps
- Minimum bitrate: 500 Kbps
- Maximum bitrate: 1520 Kbps
<span id="VeLiveVideoResolution-velivevideoresolution720p"></span>
### VeLiveVideoResolution720P
```java
public static final VeLiveVideoResolution com.ss.avframework.live.VeLivePusherDef.VeLiveVideoResolution.VeLiveVideoResolution720P = newVeLiveVideoResolution(720, 1280, 15, 1200, 800, 1900)
```
720P.
- Resolution in landscape mode: 1280x720
- Resolution in portrait mode: 720x1280
- Frame rate: 15 fps
- Target bitrate: 1200 Kbps
- Minimum bitrate: 800 Kbps
- Maximum bitrate: 1900 Kbps
<span id="VeLiveVideoResolution-velivevideoresolution1080p"></span>
### VeLiveVideoResolution1080P
```java
public static final VeLiveVideoResolution com.ss.avframework.live.VeLivePusherDef.VeLiveVideoResolution.VeLiveVideoResolution1080P = newVeLiveVideoResolution(1080, 1920, 20, 2500, 1000, 3800)
```
1080P.
- Resolution in landscape mode: 1920x1080
- Resolution in portrait mode: 1080x1920
- Frame rate: 20 fps
- Target bitrate: 2500 Kbps
- Minimum bitrate: 1000 Kbps
- Maximum bitrate: 3800 Kbps
<span id="VeLiveAudioFrame"></span>
# VeLiveAudioFrame
```java
public class com.ss.avframework.live.VeLiveAudioFrame
```
The information of an audio frame.
## Member Functions
| Return | Name |
| --- | --- |
| VeLiveAudioFrame | [VeLiveAudioFrame](#VeLiveAudioFrame-veliveaudioframe) |
| VeLiveAudioBufferType | [getBufferType](#VeLiveAudioFrame-getbuffertype) |
| VeLiveAudioSampleRate | [getSampleRate](#VeLiveAudioFrame-getsamplerate) |
| VeLiveAudioChannel | [getChannels](#VeLiveAudioFrame-getchannels) |
| int | [getSamplesPerChannel](#VeLiveAudioFrame-getsamplesperchannel) |
| long | [getPts](#VeLiveAudioFrame-getpts) |
| ByteBuffer | [getBuffer](#VeLiveAudioFrame-getbuffer) |

## Instructions
<span id="VeLiveAudioFrame-veliveaudioframe"></span>
### VeLiveAudioFrame
```java
public com.ss.avframework.live.VeLiveAudioFrame.VeLiveAudioFrame(
    VeLiveAudioSampleRate sampleRate,
    VeLiveAudioChannel channel,
    long pts,
    ByteBuffer buffer
)
```
The initialization method of the audio frame.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| sampleRate | VeLiveAudioSampleRate | The audio sample rate. See [VeLiveAudioSampleRate](broadcast-sdk-for-android-type-definition#VeLiveAudioSampleRate) for details. |
| channel | VeLiveAudioChannel | The number of audio channels. See [VeLiveAudioChannel](broadcast-sdk-for-android-type-definition#VeLiveAudioChannel) for details. |
| pts | long | The timestamp of the audio frame, in μs. |
| buffer | ByteBuffer | The audio data in the format of ByteBuffer. |

<span id="VeLiveAudioFrame-getbuffertype"></span>
### getBufferType
```java
public VeLiveAudioBufferType com.ss.avframework.live.VeLiveAudioFrame.getBufferType()
```
Gets the audio data type.

**Return Value**

The audio data type. See [VeLiveAudioBufferType](#VeLiveAudioBufferType) for details.
<span id="VeLiveAudioFrame-getsamplerate"></span>
### getSampleRate
```java
public VeLiveAudioSampleRate com.ss.avframework.live.VeLiveAudioFrame.getSampleRate()
```
Gets the audio sample rate.

**Return Value**

The audio sample rate. See [VeLiveAudioSampleRate](#VeLiveAudioSampleRate) for details.
<span id="VeLiveAudioFrame-getchannels"></span>
### getChannels
```java
public VeLiveAudioChannel com.ss.avframework.live.VeLiveAudioFrame.getChannels()
```
Gets the number of audio channels.

**Return Value**

The number of audio channels. See [VeLiveAudioChannel](#VeLiveAudioChannel) for details.
<span id="VeLiveAudioFrame-getsamplesperchannel"></span>
### getSamplesPerChannel
```java
public int com.ss.avframework.live.VeLiveAudioFrame.getSamplesPerChannel()
```
Get the number of sampling points of each channel.

**Return Value**

Number of sampling points.
<span id="VeLiveAudioFrame-getpts"></span>
### getPts
```java
public long com.ss.avframework.live.VeLiveAudioFrame.getPts()
```
Gets the audio timestamp, in μs.

**Return Value**



The timestamp of the audio frame, in μs.
<span id="VeLiveAudioFrame-getbuffer"></span>
### getBuffer
```java
public ByteBuffer com.ss.avframework.live.VeLiveAudioFrame.getBuffer()
```
Gets the audio data. The audio data is stored in little-endian byte order.

**Return Value**



The audio data in the format of ByteBuffer.
<span id="VeLiveNetworkQuality"></span>
# VeLiveNetworkQuality
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveNetworkQuality
```
The network quality.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveNetworkQualityUnknown | 0 | Network status not found. |
| VeLiveNetworkQualityBad | 1 | Bad network condition. |
| VeLiveNetworkQualityPoor | 2 | Poor network condition. |
| VeLiveNetworkQualityGood | 3 | Good network condition. |

<span id="VeLivePusherLogLevel"></span>
# VeLivePusherLogLevel
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLivePusherLogLevel
```
The output log level.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveLogLevelVerbose | AVLog.VERBOSE | Output VERBOSE, DEBUG, INFO, WARNING and ERROR. |
| VeLiveLogLevelDebug | AVLog.DEBUG | Output DEBUG, INFO, WARNING and ERROR. |
| VeLiveLogLevelInfo | AVLog.INFO | Output INFO, WARNING and ERROR. |
| VeLiveLogLevelWarn | AVLog.WARN | Output WARNING and ERROR. |
| VeLiveLogLevelError | AVLog.ERROR | Output ERROR. |
| VeLiveLogLevelNone | AVLog.NONE | Disable logging. |

<span id="VeLiveAudioBitDepth"></span>
# VeLiveAudioBitDepth
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioBitDepth
```
The audio bit depth.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioBitDepth16 | 16 | 16bit. |

<span id="VeLiveMixAudioLayout"></span>
# VeLiveMixAudioLayout
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveMixAudioLayout
```
Audio mixing configurations.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| int | -1 | [streamId](#VeLiveMixAudioLayout-streamid) |
| float | 1.0f | [volume](#VeLiveMixAudioLayout-volume) |

## Member Functions
| Return | Name |
| --- | --- |
| void | [update](#VeLiveMixAudioLayout-update) |

## Instructions
<span id="VeLiveMixAudioLayout-streamid"></span>
### streamId
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveMixAudioLayout.streamId = -1
```
The unique identifier for an audio stream.
<span id="VeLiveMixAudioLayout-volume"></span>
### volume
```java
public float com.ss.avframework.live.VeLivePusherDef.VeLiveMixAudioLayout.volume = 1.0f
```
The volume of the mixed audio stream. The value range is [0.0,4.0]. If you set [VeLiveAudioMixType](#VeLiveAudioMixType) to `VeLiveAudioMixPlayAndPush`, this variable takes effect on both the host and the audience sides.
## Instructions
<span id="VeLiveMixAudioLayout-update"></span>
### update
```java
public void com.ss.avframework.live.VeLivePusherDef.VeLiveMixAudioLayout.update(VeLiveMixAudioLayout other)
```
Updates audio mixing configurations.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| other | VeLiveMixAudioLayout | New audio mixing configurations. See [VeLiveMixAudioLayout](#VeLivePusherDef-VeLiveMixAudioLayout) for details. |

<span id="VeLivePusherConfiguration"></span>
# VeLivePusherConfiguration
```java
public class com.ss.avframework.live.VeLivePusherConfiguration
```
The initial configurations for the live pusher.
## Member Functions
| Return | Name |
| --- | --- |
| VeLivePusherConfiguration | [setReconnectIntervalSeconds](#VeLivePusherConfiguration-setreconnectintervalseconds) |
| int | [getReconnectIntervalSeconds](#VeLivePusherConfiguration-getreconnectintervalseconds) |
| VeLivePusherConfiguration | [setReconnectCount](#VeLivePusherConfiguration-setreconnectcount) |
| int | [getReconnectCount](#VeLivePusherConfiguration-getreconnectcount) |
| VeLivePusherConfiguration | [setVideoCaptureConfig](#VeLivePusherConfiguration-setvideocaptureconfig) |
| VeLiveVideoCaptureConfiguration | [getVideoCaptureConfig](#VeLivePusherConfiguration-getvideocaptureconfig) |
| VeLivePusherConfiguration | [setAudioCaptureConfig](#VeLivePusherConfiguration-setaudiocaptureconfig) |
| VeLiveAudioCaptureConfiguration | [getAudioCaptureConfig](#VeLivePusherConfiguration-getaudiocaptureconfig) |
| VeLivePusherConfiguration | [setContext](#VeLivePusherConfiguration-setcontext) |
| Context | [getContext](#VeLivePusherConfiguration-getcontext) |
| VeLivePusherConfiguration | [setExtraParameters](#VeLivePusherConfiguration-setextraparameters) |
| LiveSdkSetting | [getExtraParams](#VeLivePusherConfiguration-getextraparams) |
| VeLivePusher | [build](#VeLivePusherConfiguration-build) |

## Instructions
<span id="VeLivePusherConfiguration-setreconnectintervalseconds"></span>
### setReconnectIntervalSeconds
```java
public VeLivePusherConfiguration com.ss.avframework.live.VeLivePusherConfiguration.setReconnectIntervalSeconds(int interval)
```
Sets the time interval between each attempt to reconnect.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| interval | int | The time interval between each attempt to reconnect, in seconds. The default value is `5`. |

<span id="VeLivePusherConfiguration-getreconnectintervalseconds"></span>
### getReconnectIntervalSeconds
```java
public int com.ss.avframework.live.VeLivePusherConfiguration.getReconnectIntervalSeconds()
```
Gets the time interval between each attempt to reconnect.

**Return Value**



The time interval between each attempt to reconnect, in seconds.
<span id="VeLivePusherConfiguration-setreconnectcount"></span>
### setReconnectCount
```java
public VeLivePusherConfiguration com.ss.avframework.live.VeLivePusherConfiguration.setReconnectCount(int maxCount)
```
Sets the number of attempts to reconnect after the initial attempt fails.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| maxCount | int | The number of attempts to reconnect after the initial attempt fails. The default value is `3`. |

<span id="VeLivePusherConfiguration-getreconnectcount"></span>
### getReconnectCount
```java
public int com.ss.avframework.live.VeLivePusherConfiguration.getReconnectCount()
```
Gets the number of attempts to reconnect after the initial attempt fails.

**Return Value**



The number of attempts to reconnect after the initial attempt fails.
<span id="VeLivePusherConfiguration-setvideocaptureconfig"></span>
### setVideoCaptureConfig
```java
public VeLivePusherConfiguration com.ss.avframework.live.VeLivePusherConfiguration.setVideoCaptureConfig(VeLiveVideoCaptureConfiguration config)
```
Sets the video capture configurations.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| config | VeLiveVideoCaptureConfiguration | The video capture configurations. See [VeLiveVideoCaptureConfiguration](#VeLivePusherDef-VeLiveVideoCaptureConfiguration) for details. |


**Return Value**

The pusher configurations. See [VeLivePusherConfiguration](#VeLivePusherConfiguration) for details.
<span id="VeLivePusherConfiguration-getvideocaptureconfig"></span>
### getVideoCaptureConfig
```java
public VeLiveVideoCaptureConfiguration com.ss.avframework.live.VeLivePusherConfiguration.getVideoCaptureConfig()
```
Gets the video capture configurations.

**Return Value**

The video capture configurations. See [VeLiveVideoCaptureConfiguration](#VeLivePusherDef-VeLiveVideoCaptureConfiguration) for details.
<span id="VeLivePusherConfiguration-setaudiocaptureconfig"></span>
### setAudioCaptureConfig
```java
public VeLivePusherConfiguration com.ss.avframework.live.VeLivePusherConfiguration.setAudioCaptureConfig(VeLiveAudioCaptureConfiguration config)
```
Sets the audio capture configurations.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| config | VeLiveAudioCaptureConfiguration | The audio capture configurations. See [VeLiveAudioCaptureConfiguration](#VeLivePusherDef-VeLiveAudioCaptureConfiguration) for details. |


**Return Value**

The pusher configurations. See [VeLiveAudioCaptureConfiguration](#VeLivePusherDef-VeLiveAudioCaptureConfiguration) for details.
<span id="VeLivePusherConfiguration-getaudiocaptureconfig"></span>
### getAudioCaptureConfig
```java
public VeLiveAudioCaptureConfiguration com.ss.avframework.live.VeLivePusherConfiguration.getAudioCaptureConfig()
```
Gets the audio capture configurations.

**Return Value**

The audio capture configurations. See [VeLiveAudioCaptureConfiguration](#VeLivePusherDef-VeLiveAudioCaptureConfiguration) for details.
<span id="VeLivePusherConfiguration-setcontext"></span>
### setContext
```java
public VeLivePusherConfiguration com.ss.avframework.live.VeLivePusherConfiguration.setContext(Context context)
```
Sets the context of the application.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| context | Context | The context of the application. |


**Return Value**

The pusher configurations. See [VeLivePusherConfiguration](#VeLivePusherConfiguration) for details.
<span id="VeLivePusherConfiguration-getcontext"></span>
### getContext
```java
public Context com.ss.avframework.live.VeLivePusherConfiguration.getContext()
```
Gets the context of the application.

**Return Value**



The context of the application.
<span id="VeLivePusherConfiguration-setextraparameters"></span>
### setExtraParameters
```java
public VeLivePusherConfiguration com.ss.avframework.live.VeLivePusherConfiguration.setExtraParameters(String params)
```
Sets advanced parameters. You can leave this parameter empty. If you need to use it, please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| params | String | Extension parameters. |


**Return Value**

The pusher configurations. See [VeLivePusherConfiguration](#VeLivePusherConfiguration) for details.
<span id="VeLivePusherConfiguration-getextraparams"></span>
### getExtraParams
```java
public LiveSdkSetting com.ss.avframework.live.VeLivePusherConfiguration.getExtraParams()
```
Gets advanced parameters.

**Return Value**



Advanced parameters.
<span id="VeLivePusherConfiguration-build"></span>
### build
```java
public VeLivePusher com.ss.avframework.live.VeLivePusherConfiguration.build()
```
Creates the live pusher.

**Return Value**

The live pusher. See [VeLivePusher](docs-broadcast-sdk-for-android-api#VeLivePusher) for details.
<span id="VeLiveOrientation"></span>
# VeLiveOrientation
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveOrientation
```
The video orientation.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveOrientationLandscape | 0 | The landscape mode. |
| VeLiveOrientationPortrait | 1 | The portrait mode. |

<span id="VeLiveVideoMirrorType"></span>
# VeLiveVideoMirrorType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveVideoMirrorType
```
The mirror type.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveVideoMirrorCapture | 0 | Mirror the captured video. When turned on, both the preview and the pushed video are mirrored. |
| VeLiveVideoMirrorPreview | 1 | Mirror the preview. When turned on, only the preview is mirrored. |
| VeLiveVideoMirrorPushStream | 2 | Mirror the video before encoding. When turned on, only the pushed video is mirrored. |

<span id="VeLiveFileRecorderConfiguration"></span>
# VeLiveFileRecorderConfiguration
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration
```
The local recording configurations.
## Member Functions
| Return | Name |
| --- | --- |
| int | [getWidth](#VeLiveFileRecorderConfiguration-getwidth) |
| VeLiveFileRecorderConfiguration | [setWidth](#VeLiveFileRecorderConfiguration-setwidth) |
| int | [getHeight](#VeLiveFileRecorderConfiguration-getheight) |
| VeLiveFileRecorderConfiguration | [setHeight](#VeLiveFileRecorderConfiguration-setheight) |
| int | [getFps](#VeLiveFileRecorderConfiguration-getfps) |
| VeLiveFileRecorderConfiguration | [setFps](#VeLiveFileRecorderConfiguration-setfps) |
| int | [getBitrate](#VeLiveFileRecorderConfiguration-getbitrate) |
| VeLiveFileRecorderConfiguration | [setBitrate](#VeLiveFileRecorderConfiguration-setbitrate) |

## Instructions
<span id="VeLiveFileRecorderConfiguration-getwidth"></span>
### getWidth
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.getWidth()
```
Gets the width of the recorded video.

**Return Value**

The width of the recorded video.
<span id="VeLiveFileRecorderConfiguration-setwidth"></span>
### setWidth
```java
public VeLiveFileRecorderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.setWidth(int width)
```
Sets the width of the recorded video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| width | int | The width of the recorded video. The default value is `360`. |


**Return Value**

The local recording configurations. See [VeLiveFileRecorderConfiguration](#VeLivePusherDef-VeLiveFileRecorderConfiguration) for details.
<span id="VeLiveFileRecorderConfiguration-getheight"></span>
### getHeight
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.getHeight()
```
Gets the height of the recorded video.

**Return Value**

The height of the recorded video.
<span id="VeLiveFileRecorderConfiguration-setheight"></span>
### setHeight
```java
public VeLiveFileRecorderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.setHeight(int height)
```
Sets the height of the recorded video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| height | int | The height of the recorded video, the default value is `640`. |


**Return Value**

The local recording configurations. See [VeLiveFileRecorderConfiguration](#VeLivePusherDef-VeLiveFileRecorderConfiguration) for details.
<span id="VeLiveFileRecorderConfiguration-getfps"></span>
### getFps
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.getFps()
```
Gets the frame rate of the recorded video.

**Return Value**

The frame rate of the recorded video.
<span id="VeLiveFileRecorderConfiguration-setfps"></span>
### setFps
```java
public VeLiveFileRecorderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.setFps(int fps)
```
Sets the frame rate of the recorded video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| fps | int | The frame rate of the recorded video. The default value is `15`. |


**Return Value**

The local recording configurations. See [VeLiveFileRecorderConfiguration](#VeLivePusherDef-VeLiveFileRecorderConfiguration) for details.
<span id="VeLiveFileRecorderConfiguration-getbitrate"></span>
### getBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.getBitrate()
```
Gets the bitrate of the recorded video.

**Return Value**

The bitrate of the recorded video.
<span id="VeLiveFileRecorderConfiguration-setbitrate"></span>
### setBitrate
```java
public VeLiveFileRecorderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveFileRecorderConfiguration.setBitrate(int bitrate)
```
Sets the bitrate of the recorded video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| bitrate | int | The bitrate of the recorded video, in Kbps. The default value is `2000`. |


**Return Value**

The local recording configurations. See [VeLiveFileRecorderConfiguration](#VeLivePusherDef-VeLiveFileRecorderConfiguration) for details.
<span id="VeLiveMixVideoLayout"></span>
# VeLiveMixVideoLayout
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout
```
Video mixing configurations.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| int | -1 | [streamId](#VeLiveMixVideoLayout-streamid) |
| float | 0 | [x](#VeLiveMixVideoLayout-x) |
| float | 0 | [y](#VeLiveMixVideoLayout-y) |
| float | 1 | [width](#VeLiveMixVideoLayout-width) |
| float | 1 | [height](#VeLiveMixVideoLayout-height) |
| float | 1 | [alpha](#VeLiveMixVideoLayout-alpha) |
| int | 0 | [zOrder](#VeLiveMixVideoLayout-zorder) |
| VeLivePusherRenderMode | VeLivePusherRenderMode.VeLivePusherRenderModeFill | [renderMode](#VeLiveMixVideoLayout-rendermode) |
| boolean | true | [enableAlpha](#VeLiveMixVideoLayout-enablealpha) |

## Member Functions
| Return | Name |
| --- | --- |
| void | [update](#VeLiveMixVideoLayout-update) |

## Instructions
<span id="VeLiveMixVideoLayout-streamid"></span>
### streamId
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.streamId = -1
```
The unique identifier for a video stream.
<span id="VeLiveMixVideoLayout-x"></span>
### x
```java
public float com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.x = 0
```
The horizontal offset, which represents the ratio of the distance between the left edge of the video and the left edge of the screen to the width of the screen. The value range is [0.0,1.0], where `0.0` indicates the left edge and `1.0` indicates the right edge.
<span id="VeLiveMixVideoLayout-y"></span>
### y
```java
public float com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.y = 0
```
The vertical offset, which represents the ratio of the distance between the top edge of the video and the top edge of the screen to the height of the screen. The value range is [0.0,1.0], where `0.0` indicates the top edge and `1.0` indicates the bottom edge.
<span id="VeLiveMixVideoLayout-width"></span>
### width
```java
public float com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.width = 1
```
The ratio of the video width to the screen width. The value range is [0.0,1.0], where `1.0` indicates that the video occupies the entire screen width.
<span id="VeLiveMixVideoLayout-height"></span>
### height
```java
public float com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.height = 1
```
The ratio of the video height to the screen height. The value range is [0.0,1.0], where `1.0` indicates that the video occupies the entire screen height.
<span id="VeLiveMixVideoLayout-alpha"></span>
### alpha
```java
public float com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.alpha = 1
```
The video transparency. The value range is [0.0, 1.0], where `0.0` indicates full transparency and `1.0` indicates full opacity.
<span id="VeLiveMixVideoLayout-zorder"></span>
### zOrder
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.zOrder = 0
```
The level of video within the final mixed video. The value range is [0,100], where `0` represents the bottom layer. The higher the value, the higher the level of the video in the final output.
<span id="VeLiveMixVideoLayout-rendermode"></span>
### renderMode
```java
public VeLivePusherRenderMode com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.renderMode = VeLivePusherRenderMode.VeLivePusherRenderModeFill
```
The render mode of the video. See [VeLivePusherRenderMode](#VeLivePusherRenderMode) for details.
<span id="VeLiveMixVideoLayout-enablealpha"></span>
### enableAlpha
```java
public boolean com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.enableAlpha = true
```
Whether to retain the original Alpha channel value of the video stream. The default is retain. When the value of [alpha](#VeLiveMixVideoLayout-alpha) is within the range of [0.0, 1.0], this configuration is ignored.


- YES: Retain;
- NO: Do not retain.
## Instructions
<span id="VeLiveMixVideoLayout-update"></span>
### update
```java
public void com.ss.avframework.live.VeLivePusherDef.VeLiveMixVideoLayout.update(VeLiveMixVideoLayout other)
```
Updates video mixing configurations.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| other | VeLiveMixVideoLayout | New video mixing configurations. See [VeLiveMixVideoLayout](#VeLivePusherDef-VeLiveMixVideoLayout) for details. |

<span id="VeLiveVideoEffectLicenseConfiguration"></span>
# VeLiveVideoEffectLicenseConfiguration
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration
```
The special effects configurations.
## Static Functions
| Return | Name |
| --- | --- |
| static VeLiveVideoEffectLicenseConfiguration | [create](#VeLiveVideoEffectLicenseConfiguration-create) |
| static VeLiveVideoEffectLicenseConfiguration | [create](#VeLiveVideoEffectLicenseConfiguration-create-2) |

## Member Functions
| Return | Name |
| --- | --- |
| VeLiveVideoEffectLicenseType | [getType](#VeLiveVideoEffectLicenseConfiguration-gettype) |
| String | [getPath](#VeLiveVideoEffectLicenseConfiguration-getpath) |
| String | [getKey](#VeLiveVideoEffectLicenseConfiguration-getkey) |
| String | [getSecret](#VeLiveVideoEffectLicenseConfiguration-getsecret) |
| String | [getUrl](#VeLiveVideoEffectLicenseConfiguration-geturl) |

## Instructions
<span id="VeLiveVideoEffectLicenseConfiguration-create"></span>
### create
```java
public static VeLiveVideoEffectLicenseConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.create(String path)
```
Initializes the license configurations in local authentication mode.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| path | String | The local cache path for the video effects license. You can get the path through the [getPath](#VeLiveVideoEffectLicenseConfiguration-getpath) property. |


**Return Value**

A VeLiveVideoEffectLicenseConfiguration object that uses the specified local path for license authentication.
<span id="VeLiveVideoEffectLicenseConfiguration-create-2"></span>
### create
```java
public static VeLiveVideoEffectLicenseConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.create(
    String key,
    String secret,
    String url
)
```
Initializes the license configurations in online authentication mode.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| key | String | The online authentication key for the video effects license. You can get it through the [getKey](#VeLiveVideoEffectLicenseConfiguration-getkey) property. |
| secret | String | The online authentication secret for the video effects license. You can get it through the [getSecret](#VeLiveVideoEffectLicenseConfiguration-getsecret) property. |
| url | String | The online authentication address for the video effects license. You can get it through the [getUrl](broadcast-sdk-for-android-type-definition#VeLiveVideoEffectLicenseConfiguration-geturl) property. If you set it to null, the SDK will use the default URL. |


**Return Value**

A VeLiveVideoEffectLicenseConfiguration object that uses the specified key, secret and address for online license authentication.
<span id="VeLiveVideoEffectLicenseConfiguration-gettype"></span>
### getType
```java
public VeLiveVideoEffectLicenseType com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.getType()
```
Gets the special effects license type.

**Return Value**

The special effects license type. See [VeLiveVideoEffectLicenseType](#VeLiveVideoEffectLicenseType) for details..
<span id="VeLiveVideoEffectLicenseConfiguration-getpath"></span>
### getPath
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.getPath()
```
Gets the local path to the video effects license. When [VeLiveVideoEffectLicenseType](#VeLiveVideoEffectLicenseType) is `VeLiveVideoEffectLicenseTypeOffLine`, return the local path of the license file.

**Return Value**

The local path to the video effects license.
<span id="VeLiveVideoEffectLicenseConfiguration-getkey"></span>
### getKey
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.getKey()
```
Gets the online authentication key for the video effects licenses, when [VeLiveVideoEffectLicenseType](#VeLiveVideoEffectLicenseType) is `VeLiveVideoEffectLicenseTypeOnLine`.

**Return Value**

The online authentication key for the video effects license.
<span id="VeLiveVideoEffectLicenseConfiguration-getsecret"></span>
### getSecret
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.getSecret()
```
Gets the online authentication secret for the video effects license, when [VeLiveVideoEffectLicenseType](#VeLiveVideoEffectLicenseType) is `VeLiveVideoEffectLicenseTypeOnLine`.

**Return Value**

The online authentication secret for the video effects license.
<span id="VeLiveVideoEffectLicenseConfiguration-geturl"></span>
### getUrl
```java
public String com.ss.avframework.live.VeLivePusherDef.VeLiveVideoEffectLicenseConfiguration.getUrl()
```
Gets the online authentication address for the video effects license, when [VeLiveVideoEffectLicenseType](#VeLiveVideoEffectLicenseType) is `VeLiveVideoEffectLicenseTypeOnLine`.

**Return Value**

The online authentication address for the video effects license.
<span id="VeLiveAudioFrameSource"></span>
# VeLiveAudioFrameSource
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameSource
```
The source of the audio frame.
## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| int | 1 | [VeLiveAudioFrameSourceCapture](#VeLiveAudioFrameSource-veliveaudioframesourcecapture) |
| int | 1 << 1 | [VeLiveAudioFrameSourcePreEncode](#VeLiveAudioFrameSource-veliveaudioframesourcepreencode) |

## Member Functions
| Return | Name |
| --- | --- |
| VeLiveAudioFrameSource | [VeLiveAudioFrameSource](#VeLiveAudioFrameSource-veliveaudioframesource) |

## Instructions
<span id="VeLiveAudioFrameSource-veliveaudioframesourcecapture"></span>
### VeLiveAudioFrameSourceCapture
```java
public static final int com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameSource.VeLiveAudioFrameSourceCapture = 1
```
The original audio frame captured by the microphone or other audio sources.
<span id="VeLiveAudioFrameSource-veliveaudioframesourcepreencode"></span>
### VeLiveAudioFrameSourcePreEncode
```java
public static final int com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameSource.VeLiveAudioFrameSourcePreEncode = 1 << 1
```
The audio frame to be encoded after undergoing various processes, such as noise cancellation and echo cancellation.
## Instructions
<span id="VeLiveAudioFrameSource-veliveaudioframesource"></span>
### VeLiveAudioFrameSource
```java
public com.ss.avframework.live.VeLivePusherDef.VeLiveAudioFrameSource.VeLiveAudioFrameSource(int source)
```
Creates an audio frame source.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| source | int | The identifier of the audio frame source. When the value is `VeLiveAudioFrameSourceCapture | VeLiveAudioFrameSourcePreEncode`, it means both `VeLiveAudioFrameSourceCapture` and `VeLiveAudioFrameSourcePreEncode` are subscribed. |

<span id="VeLiveAudioEncoderConfiguration"></span>
# VeLiveAudioEncoderConfiguration
```java
public static class com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration
```
The audio encoding configurations.
## Member Functions
| Return | Name |
| --- | --- |
| int | [getBitrate](#VeLiveAudioEncoderConfiguration-getbitrate) |
| VeLiveAudioEncoderConfiguration | [setBitrate](#VeLiveAudioEncoderConfiguration-setbitrate) |
| VeLiveAudioSampleRate | [getSampleRate](#VeLiveAudioEncoderConfiguration-getsamplerate) |
| VeLiveAudioEncoderConfiguration | [setSampleRate](#VeLiveAudioEncoderConfiguration-setsamplerate) |
| VeLiveAudioChannel | [getChannel](#VeLiveAudioEncoderConfiguration-getchannel) |
| VeLiveAudioEncoderConfiguration | [setChannel](#VeLiveAudioEncoderConfiguration-setchannel) |
| VeLiveAudioProfile | [getProfile](#VeLiveAudioEncoderConfiguration-getprofile) |
| VeLiveAudioEncoderConfiguration | [setProfile](#VeLiveAudioEncoderConfiguration-setprofile) |

## Instructions
<span id="VeLiveAudioEncoderConfiguration-getbitrate"></span>
### getBitrate
```java
public int com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.getBitrate()
```
Gets the audio encoding bitrate.

**Return Value**

The audio encoding bitrate.
<span id="VeLiveAudioEncoderConfiguration-setbitrate"></span>
### setBitrate
```java
public VeLiveAudioEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.setBitrate(int bitrate)
```
Sets the audio encoding bitrate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| bitrate | int | The audio encoding bitrate, in Kbps. The default value is `64`. |


**Return Value**

The audio encoding configurations. See [VeLiveAudioEncoderConfiguration](#veliveaudioencoderconfiguration) for details.
<span id="VeLiveAudioEncoderConfiguration-getsamplerate"></span>
### getSampleRate
```java
public VeLiveAudioSampleRate com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.getSampleRate()
```
Gets the encoding sample rate.

**Return Value**

The encoding sample rate. See [VeLiveAudioSampleRate](#VeLiveAudioSampleRate) for details.
<span id="VeLiveAudioEncoderConfiguration-setsamplerate"></span>
### setSampleRate
```java
public VeLiveAudioEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.setSampleRate(VeLiveAudioSampleRate sampleRate)
```
Sets the encoding sample rate.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| sampleRate | VeLiveAudioSampleRate | The encoding sample rate. The default value is `VeLiveAudioSampleRate44100`. See [VeLiveAudioSampleRate](#VeLiveAudioSampleRate) for details. |


**Return Value**

The audio encoding configurations. See [VeLiveAudioEncoderConfiguration](#veliveaudioencoderconfiguration) for details.
<span id="VeLiveAudioEncoderConfiguration-getchannel"></span>
### getChannel
```java
public VeLiveAudioChannel com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.getChannel()
```
Gets the number of audio channels for streaming.

**Return Value**

The number of audio channels for streaming. See [VeLiveAudioChannel](#VeLiveAudioChannel) for details.
<span id="VeLiveAudioEncoderConfiguration-setchannel"></span>
### setChannel
```java
public VeLiveAudioEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.setChannel(VeLiveAudioChannel channel)
```
Sets the number of audio channels for streaming.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| channel | VeLiveAudioChannel | The number of audio channels for streaming. The default value is `VeLiveAudioChannelStereo`. See [VeLiveAudioChannel](#VeLiveAudioChannel) for details. |


**Return Value**

The audio encoding configurations. See [VeLiveAudioEncoderConfiguration](#veliveaudioencoderconfiguration) for details.
<span id="VeLiveAudioEncoderConfiguration-getprofile"></span>
### getProfile
```java
public VeLiveAudioProfile com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.getProfile()
```
Gets the audio encoding format.

**Return Value**

The audio encoding format. See [VeLiveAudioProfile](#VeLiveAudioProfile) for details.
<span id="VeLiveAudioEncoderConfiguration-setprofile"></span>
### setProfile
```java
public VeLiveAudioEncoderConfiguration com.ss.avframework.live.VeLivePusherDef.VeLiveAudioEncoderConfiguration.setProfile(VeLiveAudioProfile profile)
```
Sets the audio encoding format.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| profile | VeLiveAudioProfile | The audio encoding format. The default value is `VeLiveAudioAACProfileLC`. See [VeLiveAudioProfile](#VeLiveAudioProfile) for details. |


**Return Value**

The audio encoding configurations. See [VeLiveAudioEncoderConfiguration](#veliveaudioencoderconfiguration) for details.
<span id="VeLiveAudioMixType"></span>
# VeLiveAudioMixType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioMixType
```
The audio mixing type.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioMixPush | 0 | The audience can hear the mixed audio, but the host cannot. |
| VeLiveAudioMixPlayAndPush | 1 | Both the host and audience can hear the mixed audio. |

<span id="VeLiveAudioCaptureType"></span>
# VeLiveAudioCaptureType
```java
public enum com.ss.avframework.live.VeLivePusherDef.VeLiveAudioCaptureType
```
Audio capture type.
## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveAudioCaptureMicrophone | 0 | Capture the audio with the default microphone. |
| VeLiveAudioCaptureVoiceCommunication | 1 | Capture the audio in voice call mode, which will activate the 3A features of the hardware, including automatic gain control, automatic frequency control, and automatic noise suppression. |
| VeLiveAudioCaptureVoiceRecognition | 2 | Capture the audio in screen recording. |
| VeLiveAudioCaptureExternal | 3 | Capture the audio with an external device or source. |
| VeLiveAudioCaptureMuteFrame | 4 | Use muted frames as the audio source. |

This topic introduces how to implement the basic features of the BytePlus MediaLive Player SDK for Android.
<span id="Prerequisite"></span>
## Prerequisite
You have integrated and initialized the Player SDK by following the instructions provided in [Integrating the SDK for Android](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android) and [Initializing for Android](/docs/byteplus-media-live/docs-initializing-for-android).
<span id="2ae88a3d"></span>
## Considerations
The Player SDK uses various Android audio and video interfaces that may not function properly on simulated devices. We recommend that you use a physical device for testing.
<span id="57cfff9c"></span>
## Creating a player
To implement the basic features of the Player SDK, you need to first create a player.
```Java
VeLivePlayer mLivePlayer = new VideoLiveManager(Env.getApplicationContext());
```

:::warning
To ensure optimal playback performance, we recommend that you create a new player instance for each playback session instead of reusing an existing one.
:::
<span id="cd8daa3d"></span>
## Configuring the player
Configure the initial settings of the player by calling [setConfig](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setconfig).
```Java
// Create a VeLivePlayerConfiguration instance.
VeLivePlayerConfiguration config = new VeLivePlayerConfiguration();
// Enable periodic callbacks that provide playback information.
config.enableStatisticsCallback = true;
// Enable local DNS prefetch.
config.enableLiveDNS = true;
// Configure the initial settings of the player.
mLivePlayer.setConfig(config);
```

<span id="3bca6fdf"></span>
## Setting a player observer
You can set a player observer to listen to the live player's events, such as status updates, playback errors, the first audio and video frame received, and periodic statistical data. For details, refer to [VeLivePlayerObserver](/docs/byteplus-media-live/docs-player-android-api-callback#veliveplayerobserver).
```Java
// Create a player observer instance.
VeLivePlayerObserver mLivePlayerObserver = new VeLivePlayerObserver() {
        
  @Override
  public void onError(VeLivePlayer player, VeLivePlayerError error) {
    // Triggered when an error occurs to the player.
  }
        
  @Override
  public void onFirstVideoFrameRender(VeLivePlayer player, boolean isFirstFrame) {
    // Triggered when the first video frame is rendered. 
  }

  @Override
  public void onFirstAudioFrameRender(VeLivePlayer player, boolean isFirstFrame) {
     // Triggered when the first audio frame is rendered.
  }

  @Override
  public void onStallStart(VeLivePlayer player) {
    // Triggered when a stutter starts.
  }

  @Override
  public void onStallEnd(VeLivePlayer player) {
    // Triggered when a stutter stops.
  }

  @Override
  public void onVideoRenderStall(VeLivePlayer player, long stallTime) {
    // Triggered when video rendering stutters.
  }

  @Override
  public void onAudioRenderStall(VeLivePlayer player, long stallTime) {
    // Triggered when audio rendering stutters.
  }

  @Override
  public void onResolutionSwitch(VeLivePlayer player, VeLivePlayerDef.VeLivePlayerResolution resolution, VeLivePlayerError error, VeLivePlayerDef.VeLivePlayerResolutionSwitchReason reason) {
    // Triggered when the video resolution changes.
  }

  @Override
  public void onVideoSizeChanged(VeLivePlayer player, int width, int height) {
    // Triggered when the video size changes.
  }

  @Override
  public void onReceiveSeiMessage(VeLivePlayer player, String message) {
    // Triggered when the Player SDK receives an SEI message.
  }

  @Override
  public void onMainBackupSwitch(VeLivePlayer player, VeLivePlayerDef.VeLivePlayerStreamType streamType, VeLivePlayerError error) {
    // Triggered when the player switches between the primary stream and the backup stream.
  }

  @Override
  public void onPlayerStatusUpdate(VeLivePlayer player, VeLivePlayerDef.VeLivePlayerStatus status) {
    // Triggered when the playback status changes.
  }

  @Override
  public void onStatistics(VeLivePlayer player, VeLivePlayerStatistics statistics) {
    // Triggered periodically to report information.
  }

  @Override
  public void onSnapshotComplete(VeLivePlayer player, Bitmap bitmap) {
    // Triggered when a screenshot is taken.
  }

  @Override
  public void onRenderVideoFrame(VeLivePlayer player, VeLivePlayerVideoFrame videoFrame) {
    // Triggered when the player decodes a video frame.
  }

  @Override
  public void onRenderAudioFrame(VeLivePlayer player, VeLivePlayerAudioFrame audioFrame) {
    // Triggered when the player decodes an audio frame.
  }
}

// Set the player observer.
mLivePlayer.setObserver(mLivePlayerObserver);
```

<span id="5fa81cd6"></span>
## Setting the player view
For the player to display the video, you need to set a view for video rendering. You can choose `SurfaceView` or `TextureView` according to your needs.
<span id="34a59716"></span>
### Setting SurfaceView

1. Declare `SurfaceView` in the layout XML file.

```XML
<SurfaceView
    android:id="@+id/surfaceView"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />
```


1. Call [setSurfaceHolder](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setsurfaceholder) to pass in `SurfaceView`.

```Java
SurfaceView surfaceView = findViewById(R.id.surfaceView);
mLivePlayer.setSurfaceHolder(surfaceView.getHolder());
```

:::tip
If you use `SurfaceView` to render video frames, your device's API level must be 24 or higher. Otherwise, view hierarchy issues, out-of-sync animations, or other issues may occur. If your device's API level is lower than 24, we recommend that you use other rendering methods or upgrade the API level to get the best playback experience.
:::
<span id="bbde89d5"></span>
### Setting TextureView

1. Declare `TextureView` in the layout XML file.

```XML
<TextureView
    android:id="@+id/textureView"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@null" />
```


2. Call [setSurface](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setsurface) to pass in `TextureView`.

```Java
TextureView textureView = findViewById(R.id.textureView);

// Configure the SurfaceTexture observer.
textureView.setSurfaceTextureListener(new TextureView.SurfaceTextureListener() {

    @Override
    public void onSurfaceTextureAvailable(SurfaceTexture surfaceTexture, int width, int height) {
        // Triggered when the SurfaceTexture of TextureView is created.
        mLivePlayer.setSurface(new Surface(surfaceTexture));
    }
    
    @Override
    public void onSurfaceTextureSizeChanged(SurfaceTexture surfaceTexture, int width, int height) { 
        // Triggered when the size of TextureView changes.
    }
    
    @Override
    public boolean onSurfaceTextureDestroyed(SurfaceTexture surfaceTexture) {
       // Triggered before TextureView is destroyed. Returning true means destroying SurfaceTexture manually.
        return true;
    }
    
    @Override
    public void onSurfaceTextureUpdated(SurfaceTexture surfaceTexture) {
       // Triggered when TextureView is updated.    
    }
});
```

<span id="30c15445"></span>
## Setting the playing URL
You can set a pull stream address by calling [setPlayUrl](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setplayurl), which supports live streaming protocols such as RTMP, FLV and HLS.
```Java
String playUrl = "http://pull.example.com/live/stream.flv";
// Set the playing URL.
mLivePlayer.setPlayUrl(playUrl);
```

If you need to set multiple playing URLs, you can call [setPlayStreamData](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setplaystreamdata) which supports features including:

* stream pulling using the RTM protocol,
* stream pulling using the QUIC protocol,
* setting a primary and a backup stream address,
* resolution switching,
* adaptive bitrate (ABR).

For details, refer to [Player SDK for Android: Advanced features](/docs/byteplus-media-live/docs-implementing-advanced-features-2).
<span id="cea29a5c"></span>
## Adjusting the playback screen
You can configure the fill mode, mirroring setting, and rotation for a better playback experience.
<span id="704174bc"></span>
### Setting the fill mode
Call [setRenderFillMode](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setrenderfillmode) to set the fill mode of the playback screen.
```Java
// Set the fill mode to aspect fill.
mLivePlayer.setRenderFillMode(VeLivePlayerFillModeAspectFill);
```

<span id="270000c7"></span>
### Setting the mirroring
Call [setRenderMirror](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setrendermirror) to configure the mirroring setting of the playback screen.
```Java
// Configure the mirroring setting to horizontal.
mLivePlayer.setRenderMirror(VeLivePlayerMirrorHorizontal);
```

<span id="216c12ff"></span>
### Setting the rotation angle
Call [setRenderRotation](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setrenderrotation) to set the rotation angle of the playback screen.
```Java
// Rotate the video 90 degrees clockwise.
mLivePlayer.setRenderRotation(VeLivePlayerRotation90);
```

<span id="229da003"></span>
## Starting playback
Call [play](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-play) to start playback.
```Java
mLivePlayer.play();
```

You can call [isPlaying](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-isplaying) to get the current playback status.
```Java
boolean isPlaying = mLivePlayer.isPlaying();
```

<span id="06fe73a1"></span>
## Pausing playback
Call [pause](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-pause) to pause playback.
```Java
mLivePlayer.pause();
```

:::tip
In live streaming, pausing and stopping playback have the same effect. If you call `play` after pausing playback, the player will resume pulling the stream.
:::
<span id="3b4f405a"></span>
## Stopping playback
Call [stop](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-stop) to stop playback. This method does not destroy the player.
```Java
mLivePlayer.stop();
```

<span id="73f9cec0"></span>
## Destroying the player
After you stop playback, call [destroy](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-destroy) to destroy the player in order to free up RAM.
```Java
mLivePlayer.destroy();
```

<span id="d6ab5c5d"></span>
## Setting the background mode
By default, the player continues playing the audio when the application is running in the background. To pause audio playback, add the following code:
```Java
@Override
protected void onResume() {
    super.onResume();
    if (mLivePlayer != null) {
        mLivePlayer.play(); // Resume playback when the application switches to the foreground.
    }
}
 
@Override
protected void onPause() {
    super.onPause();
    if (mLivePlayer != null) {
        mLivePlayer.pause(); // Pause playback when the application switches to the background.
    }
}
```

<span id="1e608386"></span>
## Muting
Call [setMute](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setmute) to mute or unmute the audio.
```Java
mLivePlayer.setMute(true); // Mute the audio.
```

You can query whether the audio is muted by calling [isMute](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-ismute).
```Java
boolean isMute = mLivePlayer.isMute();
```

<span id="d64e04e8"></span>
## Setting the player volume
Call [setPlayerVolume](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setplayervolume) to set the player volume.
```Java
mLivePlayer.setPlayerVolume(0.5f);
```

<span id="94d5f4c4"></span>
## Setting log level
You can call `setLogLevel` to set the level of the output log.
```Java
// Output DEBUG, INFO, WARNING, and ERROR
VeLivePlayer.setLogLevel(VeLivePlayerLogConfig.VeLivePlayerLogLevel.VeLivePlayerLogLevelDebug);
```



This topic introduces how to implement the advanced features of the BytePlus MediaLive Player SDK for Android.
<span id="75fa227a"></span>
## Prerequisites

* If you want to pull streams using the Real Time Media (RTM) protocol, you must integrate the **Premium** edition of the Player SDK. For more information, see [Step 2: Configuring the environment and dependencies](/docs/byteplus-media-live/docs-integrating-the-broadcast-and-player-sdks-for-android#8c111919).
* You have implemented the basic features of the Player SDK by following the instructions provided in [Player SDK for Android: Basic features](/docs/byteplus-media-live/docs-implementing-basic-features-2).

<span id="00f4cec7"></span>
## Considerations
The Player SDK uses various Android audio and video interfaces that may not function properly on simulated devices, we recommend that you use a physical device for testing.
<span id="af29cf39"></span>
## RTM stream pulling
This feature should be used in conjunction with the live-streaming service provided by BytePlus MediaLive. For details, refer to [Introduction to Real Time Media](/docs/byteplus-media-live/docs-introduction-to-real-time-media).
:::warning
RTM protocol does not support pure audio or pure video streaming.
:::
<span id="6bce4b53"></span>
### Preparation

* Make sure that you have integrated the **Premium** edition of the Player SDK.
* Use the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) to generate RTM and FLV pull stream addresses. The FLV stream address can serve as an automatic fallback address if RTM stream pulling fails.

<span id="7e61a39f"></span>
### Retry strategy
When RTM stream pulling fails, a retry mechanism is triggered. 
You can customize the maximum number of retries and the retry interval by calling the [setConfig](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-implementing-basic-features-2#configuring-the-player) method to configure the following properties of `VeLivePlayerConfiguration`.

* `retryMaxCount`: Maximum number of retries. The default value is `5`.
* `retryIntervalTimeMs`: The retry interval. The default value is `5000` ms.

:::tip
The retry strategy depends on whether a backup stream exists.

* If a backup stream exists: The retry interval does not take effect. Each retry is performed immediately, and each switch between the primary and backup streams consumes one retry count.
* If no backup stream exists: The first 3 retries are performed immediately. Starting from the 4th retry, subsequent retries are performed at intervals set by `retryIntervalTimeMs`. 
:::
Because some player errors are difficult to recover from even after retries, the player will directly downgrade to FLV stream pulling. Therefore, to make sure that retries for RTM stream pulling adhere to `retryMaxCount`, call the following method before starting to pull the stream.
```Java
mLivePlayer.setProperty(VeLivePlayerProperty.VeLivePlayerKeySetForceRTMRetry, true);
```

<span id="19922329"></span>
### Downgrade strategy
If you set both the RTM and FLV pull stream addresses, the player automatically downgrades to FLV stream pulling when the number of retries for RTM stream pulling exceeds `retryMaxCount`. When the number of retries for FLV stream pulling exceeds `retryMaxCount`, the player stops pulling the stream.
:::tip
Once downgraded to FLV stream pulling, the player cannot automatically recover to RTM stream pulling. To use the RTM stream, you must pull the stream again.
:::
<span id="88effa8b"></span>
### Integration
Set the RTM and FLV pull stream addresses for playing. The sample code is as follows.
```Java
// Set the RTM stream address.
VeLivePlayerStream playStreamRTM = new VeLivePlayerStream();
playStreamRTM.url = "https://pull.example.com/live/stream.sdp";
playStreamRTM.format = VeLivePlayerFormatRTM;
playStreamRTM.resolution = VeLivePlayerResolutionOrigin;
playStreamRTM.streamType = VeLivePlayerStreamTypeMain;

// Set the FLV stream address.
VeLivePlayerStream playStreamFLV = new VeLivePlayerStream();
playStreamFLV.url = "https://pull.example.com/live/stream.flv";
playStreamFLV.format = VeLivePlayerFormatFLV;
playStreamFLV.resolution = VeLivePlayerResolutionOrigin;
playStreamFLV.streamType = VeLivePlayerStreamTypeMain;

// Create a VeLivePlayerStreamData instance.
VeLivePlayerStreamData streamData = new VeLivePlayerStreamData();
// Set the list of primary stream addresses.
streamData.mainStreamList = new ArrayList<>();

// Add the RTM stream address to the list of primary stream addresses.
streamData.mainStreamList.add(playStreamRTM);

// Add the FLV stream address to the list of primary stream addresses.
streamData.mainStreamList.add(playStreamFLV);

// Set the default live streaming format to RTM and the default transmission protocol to TLS.
streamData.defaultFormat = VeLivePlayerFormatRTM;
streamData.defaultProtocol = VeLivePlayerProtocolTLS;

// Set the playback source.
mLivePlayer.setPlayStreamData(streamData);

// Start playback.
mLivePlayer.play();
```

<span id="4d503d05"></span>
## QUIC stream pulling
This feature should be used in conjunction with the live-streaming service provided by BytePlus MediaLive.
Use the following steps to pull a stream using the QUIC protocol:

1. Use the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) to generate an FLV stream pulling address.
2. Pass in the FLV stream pulling address and set the streaming protocol to QUIC by using the following code:
   ```Java
   // Set the FLV address.
   VeLivePlayerStreamData.VeLivePlayerStream playStreamFLV = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamFLV.url = "https://pull.example.com/live/stream.flv";
   playStreamFLV.format = VeLivePlayerFormatFLV;
   playStreamFLV.resolution = VeLivePlayerResolutionOrigin;
   playStreamFLV.streamType = VeLivePlayerStreamTypeMain;
   
   // Create a VeLivePlayerStreamData instance.
   VeLivePlayerStreamData streamData = new VeLivePlayerStreamData();
   streamData.mainStreamList = new ArrayList<>();
   
   // Add the FLV stream.
   streamData.mainStreamList.add(playStreamFLV);
   
   // Set the default format and protocol.
   streamData.defaultFormat = VeLivePlayerFormatFLV;
   streamData.defaultProtocol = VeLivePlayerProtocolQUIC; // QUIC.
   
   // Pass in the pull-stream configurations.
   mLivePlayer.setPlayStreamData(streamData);
   
   // Start playback.
   mLivePlayer.play();
   ```


:::tip
The player automatically switches to the TCP protocol if it fails to pull the stream using the QUIC protocol.
:::
<span id="Using an IP address in the playing URL"></span>
## Using an IP address as the pull stream address
You can use an IP address as the pull streaming address to reduce the time-to-first-frame.
:::tip
- When using setUrlHostIP to map domain names and IP addresses, disable the DNS pre-resolution feature in the initial configuration by setting [enableLiveDNS](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-player-android-api-keytype#enablelivedns) to false.
- Call this method to set the mapping of domain names and IP addresses before calling [play](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-player-android-api-reference#play) to start playback.
:::
Use the following steps to set an IP address as the stream pulling address:

1. Obtain the pull streaming address.
2. Resolve the IP address from the pull streaming address.
3. Associate the IP address with the domain name for stream pulling by calling [setUrlHostIP](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-seturlhostip):
   ```Java
   // Set the stream pulling address.
   mLivePlayer.setPlayUrl("https://pull.example.com/live/stream.flv");
   // Associate the IP address with the domain name for stream pulling.
   List<String> valueList = new ArrayList<>();
   valueList.add("xxx.xxx.xxx.xxx"); // Add the IP address.
   Map<String, List<String>> map = new HashMap<>();
   map.put("pull.example.com", valueList); // Replace "pull.example.com" with your domain name for stream pulling.
   
   // Set the mapping of domain names to server IP addresses.
   mLivePlayer.setUrlHostIP(map);
   
   // Start playback.
   mLivePlayer.play();
   ```


<span id="Setting multiple addresses for stream pulling"></span>
## Primary and backup streams
This feature is primarily utilized for ensuring disaster tolerance during live-streaming events. If you set a primary and a backup stream address for the player, when the player fails to pull streaming from one address or if an error occurs during playback, the player automatically switches to the other address. The primary and the backup stream addresses can come from the same live-streaming service provider or different providers.
Use the following steps to set a primary and a backup stream address:

1. Obtain a primary and a backup stream address. If you are using the live-streaming service provided by BytePlus MediaLive, you can use the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) to generate the addresses.
2. Set the primary and the backup stream addresses by using the following code:
   ```Java
   // Set the primary stream address.
   VeLivePlayerStreamData.VeLivePlayerStream playStreamMain = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamMain.url = "https://pull.example.com/live/primary.flv";
   playStreamMain.format = VeLivePlayerFormatFLV;
   playStreamMain.resolution = VeLivePlayerResolutionOrigin;
   playStreamMain.streamType = VeLivePlayerStreamTypeMain; // Set the stream type to primary.
   
   // Set the backup stream address.
   VeLivePlayerStreamData.VeLivePlayerStream playStreamBackup = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamBackup.url = "https://pull.example.com/live/backup.flv";
   playStreamBackup.format = VeLivePlayerFormatFLV;
   playStreamBackup.resolution = VeLivePlayerResolutionOrigin;
   playStreamBackup.streamType = VeLivePlayerStreamTypeBackup; // Set the stream type to backup.
   
   // Create a VeLivePlayerStreamData instance.
   VeLivePlayerStreamData streamData = new VeLivePlayerStreamData();
   
   // Enable the player to switch between the primary and the backup stream addresses.
   streamData.enableMainBackupSwitch = true;
   
   // Add the primary stream address.
   streamData.mainStreamList = new ArrayList<>();
   streamData.mainStreamList.add(playStreamMain);
   
   // Add the backup stream address.
   streamData.backupStreamList = new ArrayList<>();
   streamData.backupStreamList.add(playStreamBackup);
   
   // Pass in the pull streaming configurations.
   mLivePlayer.setPlayStreamData(streamData);
   
   // Start playback.
   mLivePlayer.play();
   ```

3. When the player switches between the primary and the backup stream addresses, the [onMainBackupSwitch](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onmainbackupswitch) callback function will be triggered.
   ```Java
   public void onMainBackupSwitch(VeLivePlayer player, VeLivePlayerDef.VeLivePlayerStreamType streamType, VeLivePlayerError error) {
     // Triggered when a switch is complete.
   }
   ```


<span id="23c93996"></span>
## Resolution switching
You can set multiple pull streaming addresses with different resolutions and switch between these addresses during playback.
Use the following steps to enable resolution switching:

1. Obtain the pull streaming addresses of different resolutions. If you are using the live-streaming service provided by BytePlus MediaLive, do the following:
   1. [Configuring a transcoding task](/docs/byteplus-media-live/docs-configuring-transcoding) to generate multiple transcoded streams of different resolutions.
   2. Use the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) or call [GeneratePlayURL](/docs/byteplus-media-live/docs-generateplayurl) to generate the corresponding pull streaming addresses for the original and the transcoded streams.
2. Set the pull streaming addresses. The following addresses are used as examples in the sample code.
   
   | | | \
   |**Resolution** |**Pull streaming address** |
   |---|---|
   | | | \
   |Original (Orgin) |https://pull.example.com/live/123456.flv |
   | | | \
   |Ultra high definition (UHD) |https://pull.example.com/live/123456_uhd.flv |
   | | | \
   |High definition (HD) |https://pull.example.com/live/123456_hd.flv |
   | | | \
   |Standard definition (SD) |https://pull.example.com/live/123456_sd.flv |
   | | | \
   |Low definition (LD) |https://pull.example.com/live/123456_ld.flv |

   ```Java
   // Set multiple pull streaming addresses with different resolutions.
   VeLivePlayerStreamData.VeLivePlayerStream playStreamOrgin = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamOrgin.url = "https://pull.example.com/live/123456.flv";
   playStreamOrgin.format = VeLivePlayerFormatFLV;
   playStreamOrgin.resolution = VeLivePlayerResolutionOrigin; // Original.
   playStreamOrgin.streamType = VeLivePlayerStreamTypeMain;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamUHD = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamUHD.url = "https://pull.example.com/live/123456_uhd.flv";
   playStreamUHD.format = VeLivePlayerFormatFLV;
   playStreamUHD.resolution = VeLivePlayerResolutionUHD; // UHD.
   playStreamUHD.streamType = VeLivePlayerStreamTypeMain;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamHD = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamHD.url = "https://pull.example.com/live/123456_hd.flv";
   playStreamHD.format = VeLivePlayerFormatFLV;
   playStreamHD.resolution = VeLivePlayerResolutionHD; // HD.
   playStreamHD.streamType = VeLivePlayerStreamTypeMain;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamSD = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamSD.url = "https://pull.example.com/live/123456_sd.flv";
   playStreamSD.format = VeLivePlayerFormatFLV;
   playStreamSD.resolution = VeLivePlayerResolutionSD; // SD.
   playStreamSD.streamType = VeLivePlayerStreamTypeMain;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamLD = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamLD.url = "https://pull.example.com/live/123456_ld.flv";
   playStreamLD.format = VeLivePlayerFormatFLV;
   playStreamLD.resolution = VeLivePlayerResolutionLD; // LD.
   playStreamLD.streamType = VeLivePlayerStreamTypeMain;
   
   // Create a VeLivePlayerStreamData instance.
   VeLivePlayerStreamData streamData = new VeLivePlayerStreamData();
   
   // Add the pull streaming addresses.
   streamData.mainStreamList = new ArrayList<>();
   streamData.mainStreamList.add(playStreamOrgin);
   streamData.mainStreamList.add(playStreamUHD);
   streamData.mainStreamList.add(playStreamHD);
   streamData.mainStreamList.add(playStreamSD);
   streamData.mainStreamList.add(playStreamLD);
   
   // Set the default resolution to original.
   streamData.defaultResolution = VeLivePlayerResolutionOrigin;
   
   // Pass in the pull streaming configurations.
   mLivePlayer.setPlayStreamData(streamData);
   
   // Start playback.
   mLivePlayer.play();
   ```

3. Call [switchResolution](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-switchresolution) to change the resolution.
   ```Java
   mLivePlayer.switchResolution(VeLivePlayerResolutionUHD); // Switch to UHD.
   ```

4. When the switch is successful, the [onResolutionSwitch](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onresolutionswitch) callback function will be triggered.
   ```Java
   public void onResolutionSwitch(VeLivePlayer player, VeLivePlayerDef.VeLivePlayerResolution resolution, VeLivePlayerError error, VeLivePlayerDef.VeLivePlayerResolutionSwitchReason reason) {
     // Triggered when the resolution switch is complete.
   }
   ```


<span id="5b3ef3d2"></span>
## ABR stream pulling
Adaptive bitrate (ABR) is a streaming media transmission technology that utilizes a range of algorithms to enable automatic switching between pull streaming addresses of varying resolutions based on network and bandwidth conditions. By doing so, this feature effectively minimizes playback stutters, resulting in enhanced playback quality and an improved viewing experience.
:::tip
ABR stream pulling only applies to FLV streams.
:::
Use the following steps to enable resolution switching:

1. Obtain the pull streaming addresses of different resolutions. If you are using the live-streaming service provided by BytePlus MediaLive, do the following:
   1. [Configuring a transcoding task](/docs/byteplus-media-live/docs-configuring-transcoding) to generate multiple transcoded streams of different resolutions.
   2. Use the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) or call [GeneratePlayURL](/docs/byteplus-media-live/docs-generateplayurl) to generate the corresponding pull streaming addresses for the original and the transcoded streams.
2. Set the pull streaming addresses. The following addresses are used as examples in the sample code.
   
   | | | | \
   |**Resolution** |**Pull streaming address** |**Bitrate (Kbps)** |
   |---|---|---|
   | | | | \
   |Original (Orgin) |https://pull.example.com/live/123456.flv |2500 |
   | | | | \
   |Ultra high definition (UHD) |https://pull.example.com/live/123456_uhd.flv |2500 |
   | | | | \
   |High definition (HD) |https://pull.example.com/live/123456_hd.flv |1000 |
   | | | | \
   |Standard definition (SD) |https://pull.example.com/live/123456_sd.flv |800 |
   | | | | \
   |Low definition (LD) |https://pull.example.com/live/123456_ld.flv |500 |

   :::tip
   The encoding bitrate for each address must be identical to the one specified in the transcoding configurations. For example, if you set the bitrate of the UHD stream to 2500 Kbps in the transcoding configurations, you must set the `playStreamUHD.bitrate` to `2500` in the code.
   :::
   ```Java
   // Set multiple pull streaming addresses with different resolutions.
   VeLivePlayerStreamData.VeLivePlayerStream playStreamOrgin = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamOrgin.url = "https://pull.example.com/live/123456.flv";
   playStreamOrgin.format = VeLivePlayerFormatFLV;
   playStreamOrgin.resolution = VeLivePlayerResolutionOrigin; // Original.
   playStreamOrgin.streamType = VeLivePlayerStreamTypeMain;
   playStreamOrgin.bitrate = 2500;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamUHD = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamUHD.url = "https://pull.example.com/live/123456_uhd.flv";
   playStreamUHD.format = VeLivePlayerFormatFLV;
   playStreamUHD.resolution = VeLivePlayerResolutionUHD; // UHD.
   playStreamUHD.streamType = VeLivePlayerStreamTypeMain;
   playStreamUHD.bitrate = 2500;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamHD = new VeLivePlayerStreamData.VeLivePlayerStream();
    playStreamHD.url = "https://pull.example.com/live/123456_hd.flv";
   playStreamHD.format = VeLivePlayerFormatFLV;
   playStreamHD.resolution = VeLivePlayerResolutionHD; // HD.
   playStreamHD.streamType = VeLivePlayerStreamTypeMain;
   playStreamHD.bitrate = 1000;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamSD = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamSD.url = "https://pull.example.com/live/123456_sd.flv";
   playStreamSD.format = VeLivePlayerFormatFLV;
   playStreamSD.resolution = VeLivePlayerResolutionSD; // SD.
   playStreamSD.streamType = VeLivePlayerStreamTypeMain;
   playStreamSD.bitrate = 800;
   
   VeLivePlayerStreamData.VeLivePlayerStream playStreamLD = new VeLivePlayerStreamData.VeLivePlayerStream();
   playStreamLD.url = "https://pull.example.com/live/123456_ld.flv";
   playStreamLD.format = VeLivePlayerFormatFLV;
   playStreamLD.resolution = VeLivePlayerResolutionLD; // LD.
   playStreamLD.streamType = VeLivePlayerStreamTypeMain;
   playStreamLD.bitrate = 500;
   
   // Create a VeLivePlayerStreamData instance.
   VeLivePlayerStreamData streamData = new VeLivePlayerStreamData();
   
   // Add the pull streaming addresses.
   streamData.mainStreamList = new ArrayList<>();
   streamData.mainStreamList.add(playStreamOrgin);
   streamData.mainStreamList.add(playStreamUHD);
   streamData.mainStreamList.add(playStreamHD);
   streamData.mainStreamList.add(playStreamSD);
   streamData.mainStreamList.add(playStreamLD);
   
   // Set the default resolution to original.
   streamData.defaultResolution = VeLivePlayerResolutionOrigin;
   
   // Enable ABR.
   streamData.enableABR = true;
   
   // Pass in the pull streaming configurations.
   mLivePlayer.setPlayStreamData(streamData);
   
   // Start playback.
   mLivePlayer.play();
   ```

3. When a resolution switch is complete, the [onResolutionSwitch](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onresolutionswitch) callback function will be triggered.
   ```Java
   public void onResolutionSwitch(VeLivePlayer player, VeLivePlayerDef.VeLivePlayerResolution resolution, VeLivePlayerError error, VeLivePlayerDef.VeLivePlayerResolutionSwitchReason reason) {
     // Triggered when a resolution switch is complete.
   }
   ```


<span id="756b5d71"></span>
## Snapshot capturing
This feature enables you to capture the current video frame and generate an image.

1. Call [snapshot](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-snapshot) to take a snapshot. This feature takes effect during playback only.
   ```Java
   int result = mLivePlayer.snapshot();
   ```

2. After a snapshot is taken, the [onSnapshotComplete](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onsnapshotcomplete) callback function will be triggered with the image data.
   ```Java
   public void onSnapshotComplete(VeLivePlayer player, Bitmap bitmap) {
     // The callback function returns the image data through Bitmap.
   }
   ```


<span id="34e237fb"></span>
## SEI
Supplemental enhancement information (SEI) is the supplemental information of a live stream. You can use SEI to transmit custom data or metadata.

1. Call [enableSei](/docs/byteplus-media-live/docs-player-android-api-keytype#VeLivePlayerConfiguration-enablesei) before calling [play](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-play) to enable the player to receive SEI messages.
   ```Java
   // Create a VeLivePlayerConfiguration instance.
   VeLivePlayerConfiguration config = new VeLivePlayerConfiguration();
   
   // Enable the player to receive SEI messages.
    config.enableSei = true;
           
   // Configure the initial settings of the player.
   mLivePlayer.setConfig(config);
   ```

2. When the live stream contains an SEI message, the [onReceiveSeiMessage](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onreceiveseimessage) callback will be triggered containing the message.
   ```Java
   public void onReceiveSeiMessage(VeLivePlayer player, String message) 
     // Triggered when an SEI message is received.
   }
   ```


<span id="8b4f2be3"></span>
## Subscribing to video data
By subscribing to decoded video data, you can perform custom video processing and rendering. The Player SDK supports subscribing to video data in the following pixel formats and encapsulation formats:

| | | | \
|**Format** |**Enumeration** |**Description** |
|---|---|---|
| | | | \
|Pixel format |\
|[VeLivePlayerPixelFormat](/docs/byteplus-media-live/docs-player-android-api-keytype#veliveplayerpixelformat) |`VeLivePlayerPixelFormatRGBA32` |RGBA32 |
|^^| | | \
| |`VeLivePlayerPixelFormatTexture` |2D Texture |
| | | | \
|Encapsulation format[VeLivePlayerVideoBufferType](/docs/byteplus-media-live/docs-player-android-api-keytype#veliveplayervideobuffertype) |`VeLivePlayerVideoBufferTypeByteBuffer` |ByteBuffer |
|^^| | | \
| |`VeLivePlayerVideoBufferTypeByteArray` |ByteArray |
|^^| | | \
| |`VeLivePlayerVideoBufferTypeTexture` |Texture |

The supported combinations of pixel formats and encapsulation formats are shown in the table below:

| | | | \
|**Encapsulation format/Pixel format** |**VeLivePlayerPixelFormatRGBA32** |**VeLivePlayerPixelFormatTexture** |
|---|---|---|
| | | | \
|VeLivePlayerVideoBufferTypeByteBuffer |√ |× |
| | | | \
|VeLivePlayerVideoBufferTypeByteArray |√ |× |
| | | | \
|VeLivePlayerVideoBufferTypeTexture |× |√ (Optimal performance) |


1. Subscribe to video data by calling [enableVideoFrameObserver](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-enablevideoframeobserver).
   ```Java
   mLivePlayer.enableVideoFrameObserver(true, VeLivePlayerPixelFormatRGBA32, VeLivePlayerVideoBufferTypeByteBuffer);
   ```

2. The [onRenderVideoFrame](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onrendervideoframe) callback function returns the decoded video data.
   ```Java
   public void onRenderVideoFrame(VeLivePlayer player, VeLivePlayerVideoFrame videoFrame) {
     // Returns decoded video data.
   }
   ```


<span id="2397b8f8"></span>
## Subscribing to audio data
By subscribing to decoded audio data, you can perform custom audio processing and rendering. The Player SDK supports subscribing to audio data in PCM Float32 pixel format and ByteArray encapsulation format.

1. Subscribe to audio data by calling [enableAudioFrameObserver](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-enableaudioframeobserver).
   ```Java
   mLivePlayer.enableAudioFrameObserver(true, true);
   ```

2. The [onRenderAudioFrame](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onrenderaudioframe) callback function returns the decoded audio data.
   ```Java
   void onRenderAudioFrame(VeLivePlayer player, VeLivePlayerAudioFrame audioFrame) {
     // Returns decoded audio data.
   }
   ```


<span id="84bd3b42"></span>
## Super-resolution
Super-resolution (SR) is a technology that reconstructs low-resolution images into high-resolution ones. Real-time SR on the client side uses algorithms to perform real-time reconstruction of low-resolution frames on client devices. This generates high-resolution frames, which are then displayed on the screen. SR enhances video details and contrast, improving video clarity and the viewing experience.

1. Enable SR by calling [setEnableSuperResolution](/docs/byteplus-media-live/docs-player-android-api-reference#VeLivePlayer-setenablesuperresolution).
2. If the SDK fails to enable SR, the [onStreamFailedOpenSuperResolution](/docs/byteplus-media-live/docs-player-android-api-callback#VeLivePlayerObserver-onstreamfailedopensuperresolution) callback will be triggered.
   ```Java
   void onStreamFailedOpenSuperResolution(VeLivePlayer player, VeLivePlayerError error);
   ```


Possible reasons for failure to enable SR include:

* The resolution of the original stream is higher than the maximum resolution supported by SR, which is 1300*750.
* The frame rate of the original stream is higher than the maximum frame rate supported by SR, which is 30 fps.
* The client device does not support SR.

Please contact BytePlus technical support if the maximum resolution and frame rate do not meet your business requirements.

# Methods
| Method | Description |
| --- | --- |
| [setConfig](docs-player-android-api-reference#VeLivePlayer-setconfig) | Initializes the player and configures whether to turn on SEI messaging, hardware decoding, local DNS prefetch, and other configurations. |
| [getStreamList](docs-player-android-api-reference#VeLivePlayer-getstreamlist) | Gets the stream information. |
| [setEnableSharpen](docs-player-android-api-reference#VeLivePlayer-setenablesharpen) | Set whether to enable video sharpening. |
| [setObserver](docs-player-android-api-reference#VeLivePlayer-setobserver) | Sets the player observer to listen to the live player's events, such as playback errors or status updates, rendering of the first audio and video frame, and resolution switching. |
| [setRenderFillMode](docs-player-android-api-reference#VeLivePlayer-setrenderfillmode) | Sets the fill mode of the player screen. |
| [getVersion](docs-player-android-api-reference#VeLivePlayer-getversion) | Gets the version number of the Player SDK. |
| [setLogLevel](docs-player-android-api-reference#VeLivePlayer-setloglevel) | Sets the level of the output log. |
| [setSurfaceHolder](docs-player-android-api-reference#VeLivePlayer-setsurfaceholder) | Sets the `SurfaceHolder` object for video rendering and playback. Use this method if you use `SurfaceView` for playback. |
| [setSurface](docs-player-android-api-reference#VeLivePlayer-setsurface) | Sets the `Surface` object for video rendering and playback. Use this method if you use `SurfaceView` or `TextureView` for playback. |
| [setPlayUrl](docs-player-android-api-reference#VeLivePlayer-setplayurl) | Sets a pull stream address. |
| [setPlayerVolume](docs-player-android-api-reference#VeLivePlayer-setplayervolume) | Sets the player volume. |
| [setMute](docs-player-android-api-reference#VeLivePlayer-setmute) | Sets whether to mute playback. |
| [isMute](docs-player-android-api-reference#VeLivePlayer-ismute) | Checks whether playback is muted. |
| [setUrlHostIP](docs-player-android-api-reference#VeLivePlayer-seturlhostip) | Sets the mapping of domain names to server IP addresses. |
| [setProperty](docs-player-android-api-reference#VeLivePlayer-setproperty) | Configures advanced settings for the player, including offscreen rendering, maximum buffer duration, and adaptive bitrate (ABR) algorithms. [Create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support if you need further information. |
| [snapshot](docs-player-android-api-reference#VeLivePlayer-snapshot) | Takes a screenshot of the video. |
| [enableVideoFrameObserver](docs-player-android-api-reference#VeLivePlayer-enablevideoframeobserver) | Sets the video frame observer. |
| [enableAudioFrameObserver](docs-player-android-api-reference#VeLivePlayer-enableaudioframeobserver) | Sets the audio frame observer. |
| [setRenderRotation](docs-player-android-api-reference#VeLivePlayer-setrenderrotation) | Sets the clockwise rotation angle of the video. |
| [setRenderMirror](docs-player-android-api-reference#VeLivePlayer-setrendermirror) | Configures mirroring settings. |
| [setEnableSuperResolution](docs-player-android-api-reference#VeLivePlayer-setenablesuperresolution) | Enables or disables super resolution. You must first contact BytePlus [technical support](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to activate the feature before using it. |
| [isPlaying](docs-player-android-api-reference#VeLivePlayer-isplaying) | Checks whether the player is playing. |
| [switchResolution](docs-player-android-api-reference#VeLivePlayer-switchresolution) | Changes the video resolution. |
| [destroy](docs-player-android-api-reference#VeLivePlayer-destroy) | Stops playback and destroys the player. |
| [stop](docs-player-android-api-reference#VeLivePlayer-stop) | Stops playback. This method does not destroy the player. |
| [pause](docs-player-android-api-reference#VeLivePlayer-pause) | Pauses playback. |
| [play](docs-player-android-api-reference#VeLivePlayer-play) | Starts or resumes playback. |
| [setPlayStreamData](docs-player-android-api-reference#VeLivePlayer-setplaystreamdata) | Sets multiple live streams. Call this method if you need to enable features requiring multiple live streams, such as adaptive bitrate (ABR), manual resolution switching, and primary and backup streams. |

# Callbacks
| Method | Description |
| --- | --- |
| [onError](docs-player-android-api-callback#VeLivePlayerObserver-onerror) | Occurs when a player error occurs. |
| [onFirstVideoFrameRender](docs-player-android-api-callback#VeLivePlayerObserver-onfirstvideoframerender) | Occurs when the first video frame is rendered at the beginning of playback or after a retry during playback. |
| [onFirstAudioFrameRender](docs-player-android-api-callback#VeLivePlayerObserver-onfirstaudioframerender) | Occurs when the first audio frame is rendered at the beginning of playback or after a retry during playback. |
| [onStallStart](docs-player-android-api-callback#VeLivePlayerObserver-onstallstart) | Occurs when a playback stutter starts. |
| [onStallEnd](docs-player-android-api-callback#VeLivePlayerObserver-onstallend) | Occurs when a playback stutter stops, that is, when playback resumes after there is enough audio buffer. |
| [onVideoRenderStall](docs-player-android-api-callback#VeLivePlayerObserver-onvideorenderstall) | Occurs when video rendering stutters. |
| [onAudioRenderStall](docs-player-android-api-callback#VeLivePlayerObserver-onaudiorenderstall) | Occurs when audio rendering stutters. |
| [onResolutionSwitch](docs-player-android-api-callback#VeLivePlayerObserver-onresolutionswitch) | Occurs when the video resolution changes. |
| [onVideoSizeChanged](docs-player-android-api-callback#VeLivePlayerObserver-onvideosizechanged) | Occurs when the video size changes. |
| [onReceiveSeiMessage](docs-player-android-api-callback#VeLivePlayerObserver-onreceiveseimessage) | String SEI message callback. This callback is triggered when the player SDK receives an SEI message. It is necessary to enable the `enableSei` property in `VeLivePlayerConfiguration`. When the `enableBinarySei` property is enabled, the string SEI message will no longer be sent. |
| [onReceiveBinarySeiMessage](docs-player-android-api-callback#VeLivePlayerObserver-onreceivebinaryseimessage) | Binary SEI message callback. This callback is triggered when the player SDK receives an SEI message. It is necessary to enable the `enableBinarySei` property in `VeLivePlayerConfiguration`. When the `enableBinarySei` property is enabled, the string SEI message will no longer be sent. |
| [onMainBackupSwitch](docs-player-android-api-callback#VeLivePlayerObserver-onmainbackupswitch) | Occurs when the player switches between the primary stream and the backup stream. |
| [onPlayerStatusUpdate](docs-player-android-api-callback#VeLivePlayerObserver-onplayerstatusupdate) | Occurs when the playback status changes. |
| [onStatistics](docs-player-android-api-callback#VeLivePlayerObserver-onstatistics) | Occurs periodically to report information such as the current pull stream address, bitrate, and frame rate. |
| [onSnapshotComplete](docs-player-android-api-callback#VeLivePlayerObserver-onsnapshotcomplete) | Occurs when a screenshot is taken after [snapshot](docs-player-android-api-reference#VeLivePlayer-snapshot) is called. |
| [onRenderVideoFrame](docs-player-android-api-callback#VeLivePlayerObserver-onrendervideoframe) | Occurs when the player decodes a video frame. Call [enableVideoFrameObserver](docs-player-android-api-reference#VeLivePlayer-enablevideoframeobserver) to enable video frame callback. |
| [onRenderAudioFrame](docs-player-android-api-callback#VeLivePlayerObserver-onrenderaudioframe) | Occurs when the player decodes an audio frame. Call [enableAudioFrameObserver](docs-player-android-api-reference#VeLivePlayer-enableaudioframeobserver) to enable audio frame callback. |
| [onStreamFailedOpenSuperResolution](docs-player-android-api-callback#VeLivePlayerObserver-onstreamfailedopensuperresolution) | Occurs when the SDK fails to enable super resolution after [setEnableSuperResolution](docs-player-android-api-reference#VeLivePlayer-setenablesuperresolution) is called. |
| [onStreamFailedOpenSharpen](docs-player-android-api-callback#VeLivePlayerObserver-onstreamfailedopensharpen) | Occurs when the SDK fails to enable sharpen after [setEnableSuperResolution](docs-player-android-api-reference#VeLivePlayer-setenablesuperresolution) is called. |

<span id="VeLivePlayer"></span>
# VeLivePlayer
```java
public abstract class com.ss.videoarch.liveplayer.VeLivePlayer
```
The live player.
## Static Functions
| Return | Name |
| --- | --- |
| static String | [getVersion](#VeLivePlayer-getversion) |
| static void | [setLogLevel](#VeLivePlayer-setloglevel) |

## Member Functions
| Return | Name |
| --- | --- |
| abstract void | [setConfig](#VeLivePlayer-setconfig) |
| abstract void | [setObserver](#VeLivePlayer-setobserver) |
| abstract void | [setRenderFillMode](#VeLivePlayer-setrenderfillmode) |
| abstract void | [setSurfaceHolder](#VeLivePlayer-setsurfaceholder) |
| abstract void | [setSurface](#VeLivePlayer-setsurface) |
| abstract void | [setPlayUrl](#VeLivePlayer-setplayurl) |
| abstract void | [setPlayStreamData](#VeLivePlayer-setplaystreamdata) |
| abstract void | [play](#VeLivePlayer-play) |
| abstract void | [pause](#VeLivePlayer-pause) |
| abstract void | [stop](#VeLivePlayer-stop) |
| abstract void | [destroy](#VeLivePlayer-destroy) |
| abstract boolean | [switchResolution](#VeLivePlayer-switchresolution) |
| abstract boolean | [isPlaying](#VeLivePlayer-isplaying) |
| abstract void | [setPlayerVolume](#VeLivePlayer-setplayervolume) |
| abstract void | [setMute](#VeLivePlayer-setmute) |
| abstract boolean | [isMute](#VeLivePlayer-ismute) |
| abstract void | [setUrlHostIP](#VeLivePlayer-seturlhostip) |
| abstract void | [setProperty](#VeLivePlayer-setproperty) |
| abstract int | [snapshot](#VeLivePlayer-snapshot) |
| abstract void | [enableVideoFrameObserver](#VeLivePlayer-enablevideoframeobserver) |
| abstract void | [enableAudioFrameObserver](#VeLivePlayer-enableaudioframeobserver) |
| abstract void | [setRenderRotation](#VeLivePlayer-setrenderrotation) |
| abstract void | [setRenderMirror](#VeLivePlayer-setrendermirror) |
| abstract void | [setEnableSuperResolution](#VeLivePlayer-setenablesuperresolution) |
| abstract void | [setEnableSharpen](#VeLivePlayer-setenablesharpen) |
| abstract ArrayList\<VeLivePlayerStreamInfo> | [getStreamList](#VeLivePlayer-getstreamlist) |

## Instructions
<span id="VeLivePlayer-getversion"></span>
### getVersion
```java
public static String com.ss.videoarch.liveplayer.VeLivePlayer.getVersion()
```
Gets the version number of the Player SDK.

**Return Value**



The version number of the Player SDK.
<span id="VeLivePlayer-setloglevel"></span>
### setLogLevel
```java
public static void com.ss.videoarch.liveplayer.VeLivePlayer.setLogLevel(VeLivePlayerLogConfig.VeLivePlayerLogLevel logLevel)
```
Sets the level of the output log.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| logLevel | VeLivePlayerLogConfig.VeLivePlayerLogLevel | The level of the output log. For details, see [VeLivePlayerLogLevel](docs-player-android-api-keytype#VeLivePlayerLogLevel). |

<span id="VeLivePlayer-setconfig"></span>
### setConfig
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setConfig(VeLivePlayerConfiguration config)
```
Initializes the player and configures whether to turn on SEI messaging, hardware decoding, local DNS prefetch, and other configurations.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| config | VeLivePlayerConfiguration | Player configurations. Refer to [VeLivePlayerConfiguration](docs-player-android-api-keytype#VeLivePlayerConfiguration) for details. |


**Notes**


Call this method to initialize the player before calling [play](#VeLivePlayer-play) .
<span id="VeLivePlayer-setobserver"></span>
### setObserver
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setObserver(VeLivePlayerObserver observer)
```
Sets the player observer to listen to the live player's events, such as playback errors or status updates, rendering of the first audio and video frame, and resolution switching.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| observer | VeLivePlayerObserver | The player observer. See [VeLivePlayerObserver](docs-player-android-api-callback#VeLivePlayerObserver) for details. |


**Notes**

Call this method before calling [play](#VeLivePlayer-play).
<span id="VeLivePlayer-setrenderfillmode"></span>
### setRenderFillMode
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setRenderFillMode(VeLivePlayerFillMode fillMode)
```
Sets the fill mode of the player screen.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| fillMode | VeLivePlayerFillMode | The fill mode of SurfaceView. The default value is `VeLivePlayerFillModeAspectFill`. For details, see [VeLivePlayerFillMode](docs-player-android-api-keytype#VeLivePlayerFillMode). |


**Notes**



- Call this method before calling [play](#VeLivePlayer-play) to set the initial fill mode of the player.
- You can call this method during playback to dynamically adjust the fill mode.
<span id="VeLivePlayer-setsurfaceholder"></span>
### setSurfaceHolder
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setSurfaceHolder(SurfaceHolder surfaceHolder)
```
Sets the `SurfaceHolder` object for video rendering and playback. Use this method if you use `SurfaceView` for playback.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| surfaceHolder | SurfaceHolder | The `SurfaceHolder` object. |


**Notes**

If you call both setSurfaceHolder and [setSurface](#VeLivePlayer-setsurface) to set the `Surface` object, the player will prioritize the configurations of `surfaceHolder`.
<span id="VeLivePlayer-setsurface"></span>
### setSurface
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setSurface(Surface surface)
```
Sets the `Surface` object for video rendering and playback. Use this method if you use `SurfaceView` or `TextureView` for playback.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| surface | Surface | The `Surface` object. |


**Notes**

If you call both [setSurfaceHolder](#VeLivePlayer-setsurfaceholder) and `setSurface` to set the `Surface` object, the player will prioritize the configurations of `surfaceHolder`.
<span id="VeLivePlayer-setplayurl"></span>
### setPlayUrl
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setPlayUrl(String url)
```
Sets a pull stream address.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| url | String | The pull stream address. |


**Notes**


Call this method before calling play.
<span id="VeLivePlayer-setplaystreamdata"></span>
### setPlayStreamData
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setPlayStreamData(VeLivePlayerStreamData streamData)
```
Sets multiple live streams. Call this method if you need to enable features requiring multiple live streams, such as adaptive bitrate (ABR), manual resolution switching, and primary and backup streams.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| streamData | VeLivePlayerStreamData | Configurations for multiple pull stream addresses. For details, see [VeLivePlayerStreamData](docs-player-android-api-keytype#VeLivePlayerStreamData). |


**Notes**


Call this method before calling play.
<span id="VeLivePlayer-play"></span>
### play
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.play()
```
Starts or resumes playback.

**Notes**

After you call this method, the [onPlayerStatusUpdate](docs-player-android-api-callback#VeLivePlayerObserver-onplayerstatusupdate) callback is triggered both when the player finishes preparing for stream pulling and when the first frame is rendered.
<span id="VeLivePlayer-pause"></span>
### pause
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.pause()
```
Pauses playback.

**Notes**

When playback is paused after you call this method, the [onPlayerStatusUpdate](docs-player-android-api-callback#VeLivePlayerObserver-onplayerstatusupdate) callback is triggered.
<span id="VeLivePlayer-stop"></span>
### stop
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.stop()
```
Stops playback. This method does not destroy the player.

**Notes**

When playback stops after you call this method, the [onPlayerStatusUpdate](docs-player-android-api-callback#VeLivePlayerObserver-onplayerstatusupdate) callback is triggered.
<span id="VeLivePlayer-destroy"></span>
### destroy
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.destroy()
```
Stops playback and destroys the player.
<span id="VeLivePlayer-switchresolution"></span>
### switchResolution
```java
public abstract boolean com.ss.videoarch.liveplayer.VeLivePlayer.switchResolution(VeLivePlayerResolution resolution)
```
Changes the video resolution.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| resolution | VeLivePlayerResolution | The video resolution. For details, refer to VeLivePlayerResolution |


**Return Value**



- true: Success;
- false: Failure.

**Notes**

- Call [setPlayStreamData](#VeLivePlayer-setplaystreamdata) to set multiple resolutions before calling this method.
- Once the player switches to the new resolution after you call this method, the [onResolutionSwitch](docs-player-android-api-callback#VeLivePlayerObserver-onresolutionswitch) callback is triggered.
<span id="VeLivePlayer-isplaying"></span>
### isPlaying
```java
public abstract boolean com.ss.videoarch.liveplayer.VeLivePlayer.isPlaying()
```
Checks whether the player is playing.

**Return Value**

Whether the player is playing. 

- true: The player is playing;
- false: The player is not playing.
<span id="VeLivePlayer-setplayervolume"></span>
### setPlayerVolume
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setPlayerVolume(float volume)
```
Sets the player volume.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| volume | float | The volume. The default value is `1.0`. The value range is [0.0, 1.0]. |

<span id="VeLivePlayer-setmute"></span>
### setMute
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setMute(boolean mute)
```
Sets whether to mute playback.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| mute | boolean | Whether to mute playback. The default value is `false`. <br/><ul><li>true: Mute;</li><li>false: Do not mute.</li></ul> |

<span id="VeLivePlayer-ismute"></span>
### isMute
```java
public abstract boolean com.ss.videoarch.liveplayer.VeLivePlayer.isMute()
```
Checks whether playback is muted.

**Return Value**

Whether playback is muted. 

- true: Muted;
- false: Not muted.
<span id="VeLivePlayer-seturlhostip"></span>
### setUrlHostIP
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setUrlHostIP(Map<String, List<String>> hostIpMap)
```
Sets the mapping of domain names to server IP addresses.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| hostIpMap | Map<String, List\<String>> | The mapping of domain names to server IP addresses. The `Map` object uses the domain name as the key, and the corresponding value is a list of IP addresses for the servers associated with that domain. The value is of the `List` type. |


**Notes**

- When using setUrlHostIP to map domain names and IP addresses, disable the DNS pre-resolution feature in the initial configuration by setting [enableLiveDNS](docs-player-android-api-keytype#VeLivePlayerConfiguration-enablelivedns) to false.
- Call this method to set the mapping of domain names and IP addresses before calling [play](#VeLivePlayer-play) to start playback.
<span id="VeLivePlayer-setproperty"></span>
### setProperty
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setProperty(
    String key,
    Object value
)
```
Configures advanced settings for the player, including offscreen rendering, maximum buffer duration, and adaptive bitrate (ABR) algorithms. [Create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact BytePlus technical support if you need further information.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| key | String | The parameter name of the advanced setting. |
| value | Object | The parameter value of the advanced setting. |

<span id="VeLivePlayer-snapshot"></span>
### snapshot
```java
public abstract int com.ss.videoarch.liveplayer.VeLivePlayer.snapshot()
```
Takes a screenshot of the video.

**Return Value**

- 0: Screenshot capturing is allowed.
- [VeLivePlayerErrorRefused](docs-player-android-api-errorcode#VeLivePlayerErrorCode-veliveplayererrorrefused) : Screenshot capturing is not allowed.

**Notes**

- This method only takes effect during playback.
- When a screenshot is captured after you call this method, the [onSnapshotComplete](docs-player-android-api-callback#VeLivePlayerObserver-onsnapshotcomplete) callback is triggered containing the Bitmap object of the screenshot.
<span id="VeLivePlayer-enablevideoframeobserver"></span>
### enableVideoFrameObserver
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.enableVideoFrameObserver(
    boolean enable,
    VeLivePlayerPixelFormat pixelFormat,
    VeLivePlayerVideoBufferType bufferType
)
```
Sets the video frame observer.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Whether to enable the video frame callback. The default value is `false`. <br/><ul><li>true: Enable;</li><li>false: Disable.</li></ul> |
| pixelFormat | VeLivePlayerPixelFormat | The pixel format of the video frame in the callback. See [VeLivePlayerPixelFormat](docs-player-android-api-keytype#VeLivePlayerPixelFormat) for details. |
| bufferType | VeLivePlayerVideoBufferType | The encapsulation format of the video data in the callback. For details, see [VeLivePlayerVideoBufferType](docs-player-android-api-keytype#VeLivePlayerVideoBufferType). |


**Notes**

- You can call this method to subscribe to decoded video data for external rendering.
- After you call this method, the [onRenderVideoFrame](docs-player-android-api-callback#VeLivePlayerObserver-onrendervideoframe) callback is triggered once the SDK receives a video frame. The callback contains detailed information about the video frame.
- If you use external rendering, you need to make sure the video and audio are synchronized.
<span id="VeLivePlayer-enableaudioframeobserver"></span>
### enableAudioFrameObserver
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.enableAudioFrameObserver(
    boolean enable,
    boolean enableRendering,
    VeLivePlayerAudioBufferType bufferType
)
```
Sets the audio frame observer.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Whether to enable the audio frame callback. The default value is `false`. <br/><ul><li>true: Enable;</li><li>false: Disable.</li></ul> |
| enableRendering | boolean | Whether to enable player rendering. The default value is `false`. <br/><ul><li>true: Enable;</li><li>false: Disable.</li></ul> |
| bufferType | VeLivePlayerAudioBufferType | Audio buffer type. For details, please refer to [VeLivePlayerAudioBufferType](docs-player-android-api-keytype#VeLivePlayerAudioBufferType). |


**Notes**

- You can call this method to subscribe to decoded audio data if you want to use external rendering.
- After you call this method, the [onRenderAudioFrame](docs-player-android-api-callback#VeLivePlayerObserver-onrenderaudioframe) callback is triggered once the SDK receives an audio frame. The callback contains detailed information about the audio frame.
- If you use external rendering, you need to make sure the video and audio are synchronized.
<span id="VeLivePlayer-setrenderrotation"></span>
### setRenderRotation
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setRenderRotation(VeLivePlayerRotation rotation)
```
Sets the clockwise rotation angle of the video.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| rotation | VeLivePlayerRotation | The clockwise rotation angle of the video. Rotation is disabled by default. See [VeLivePlayerRotation](docs-player-android-api-keytype#VeLivePlayerRotation) for details. |


**Notes**



- You can change the rotation angle before and during playback.
- Each time this method is called, the player rotates the video based on the original video.
- When you apply both rotation and mirroring to the video, the player will mirror the video and then rotate it.
<span id="VeLivePlayer-setrendermirror"></span>
### setRenderMirror
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setRenderMirror(VeLivePlayerMirror mirror)
```
Configures mirroring settings.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| mirror | VeLivePlayerMirror | Mirroring settings. Mirroring is disabled by default. See [VeLivePlayerMirror](docs-player-android-api-keytype#VeLivePlayerMirror) for details. |


**Notes**



- You can change the mirroring settings before and during playback.
- Each time this method is called, the player applies the mirroring settings to the original video.
- When you apply both rotation and mirroring to the video, the player will mirror the video and then rotate it.
<span id="VeLivePlayer-setenablesuperresolution"></span>
### setEnableSuperResolution
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setEnableSuperResolution(boolean enable)
```
Enables or disables super resolution. You must first contact BytePlus [technical support](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to activate the feature before using it.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Whether to enable super resolution. The default value is false.<ul><li>true: enable;</li><li>false: disable.</li></ul> |


**Notes**

- Call this method after receiving the [onFirstVideoFrameRender](docs-player-android-api-callback#VeLivePlayerObserver-onfirstvideoframerender) callback, or during playback.
- Support dynamically enabling and disabling super-resolution by calling this interface during playback.
- If the SDK fails to enable super resolution due to device model, video resolution or frame rate, you will receive the [onStreamFailedOpenSuperResolution](docs-player-android-api-callback#VeLivePlayerObserver-onstreamfailedopensuperresolution) callback.
<span id="VeLivePlayer-setenablesharpen"></span>
### setEnableSharpen
```java
public abstract void com.ss.videoarch.liveplayer.VeLivePlayer.setEnableSharpen(boolean enable)
```
Set whether to enable video sharpening.

**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| enable | boolean | Set whether to enable video sharpening. The default value is `false`.<ul><li>true: Enable;</li><li>false: Disable.</li></ul> |

<span id="VeLivePlayer-getstreamlist"></span>
### getStreamList
```java
public abstract ArrayList<VeLivePlayerStreamInfo> com.ss.videoarch.liveplayer.VeLivePlayer.getStreamList()
```
Gets the stream information.

**Return Value**

The stream information.

**Notes**

- Call this method when the [VeLivePlayerStatus](docs-player-android-api-keytype#VeLivePlayerStatus) (player status) is `VeLivePlayerStatusPrepared`.
- This method is currently only applicable to HLS format streams.

<span id="VeLivePlayerObserver"></span>
# VeLivePlayerObserver
```java
public interface com.ss.videoarch.liveplayer.VeLivePlayerObserver
```
The live player observer.

## Member Functions
| Return | Name |
| --- | --- |
| default void | [onError](#VeLivePlayerObserver-onerror) |
| default void | [onFirstVideoFrameRender](#VeLivePlayerObserver-onfirstvideoframerender) |
| default void | [onFirstAudioFrameRender](#VeLivePlayerObserver-onfirstaudioframerender) |
| default void | [onStallStart](#VeLivePlayerObserver-onstallstart) |
| default void | [onStallEnd](#VeLivePlayerObserver-onstallend) |
| default void | [onVideoRenderStall](#VeLivePlayerObserver-onvideorenderstall) |
| default void | [onAudioRenderStall](#VeLivePlayerObserver-onaudiorenderstall) |
| default void | [onResolutionSwitch](#VeLivePlayerObserver-onresolutionswitch) |
| default void | [onVideoSizeChanged](#VeLivePlayerObserver-onvideosizechanged) |
| default void | [onReceiveSeiMessage](#VeLivePlayerObserver-onreceiveseimessage) |
| default void | [onReceiveBinarySeiMessage](#VeLivePlayerObserver-onreceivebinaryseimessage) |
| default void | [onMainBackupSwitch](#VeLivePlayerObserver-onmainbackupswitch) |
| default void | [onPlayerStatusUpdate](#VeLivePlayerObserver-onplayerstatusupdate) |
| default void | [onStatistics](#VeLivePlayerObserver-onstatistics) |
| default void | [onSnapshotComplete](#VeLivePlayerObserver-onsnapshotcomplete) |
| default void | [onRenderVideoFrame](#VeLivePlayerObserver-onrendervideoframe) |
| default void | [onRenderAudioFrame](#VeLivePlayerObserver-onrenderaudioframe) |
| default void | [onStreamFailedOpenSuperResolution](#VeLivePlayerObserver-onstreamfailedopensuperresolution) |
| default void | [onStreamFailedOpenSharpen](#VeLivePlayerObserver-onstreamfailedopensharpen) |

## Instructions
<span id="VeLivePlayerObserver-onerror"></span>
### onError
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onError(
    VeLivePlayer player,
    VeLivePlayerError error
)
```
Occurs when a player error occurs.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| error | VeLivePlayerError | The error message. Refer to [VeLivePlayerError](docs-player-android-api-errorcode#VeLivePlayerError) for details. |


<span id="VeLivePlayerObserver-onfirstvideoframerender"></span>
### onFirstVideoFrameRender
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onFirstVideoFrameRender(
    VeLivePlayer player,
    boolean isFirstFrame
)
```
Occurs when the first video frame is rendered at the beginning of playback or after a retry during playback.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| isFirstFrame | boolean | Whether the video frame is the first video frame rendered at the beginning of playback.<br/><ul><li>true: The video frame is the first video frame rendered at the beginning of playback;</li></ul><ul><li>false: The video frame is the first video frame rendered after a retry during playback.</li></ul> |


<span id="VeLivePlayerObserver-onfirstaudioframerender"></span>
### onFirstAudioFrameRender
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onFirstAudioFrameRender(
    VeLivePlayer player,
    boolean isFirstFrame
)
```
Occurs when the first audio frame is rendered at the beginning of playback or after a retry during playback.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| isFirstFrame | boolean | Whether the audio frame is the first audio frame rendered at the beginning of playback.<br/><ul><li>true: The audio frame is the first audio frame rendered at the beginning of playback;</li></ul><ul><li>false: The audio frame is the first audio frame rendered after a retry during playback.</li></ul> |


<span id="VeLivePlayerObserver-onstallstart"></span>
### onStallStart
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onStallStart(VeLivePlayer player)
```
Occurs when a playback stutter starts.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |


<span id="VeLivePlayerObserver-onstallend"></span>
### onStallEnd
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onStallEnd(VeLivePlayer player)
```
Occurs when a playback stutter stops, that is, when playback resumes after there is enough audio buffer.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |


<span id="VeLivePlayerObserver-onvideorenderstall"></span>
### onVideoRenderStall
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onVideoRenderStall(
    VeLivePlayer player,
    long stallTime
)
```
Occurs when video rendering stutters.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| stallTime | long | The stutter duration, in milliseconds. |


<span id="VeLivePlayerObserver-onaudiorenderstall"></span>
### onAudioRenderStall
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onAudioRenderStall(
    VeLivePlayer player,
    long stallTime
)
```
Occurs when audio rendering stutters.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| stallTime | long | The stutter duration, in milliseconds. |


<span id="VeLivePlayerObserver-onresolutionswitch"></span>
### onResolutionSwitch
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onResolutionSwitch(
    VeLivePlayer player,
    VeLivePlayerResolution resolution,
    VeLivePlayerError error,
    VeLivePlayerResolutionSwitchReason reason
)
```
Occurs when the video resolution changes.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| resolution | VeLivePlayerResolution | The updated resolution. See [VeLivePlayerResolution](docs-player-android-api-keytype#VeLivePlayerResolution) for details. |
| error | VeLivePlayerError | Whether an error occurred during resolution switching. See [VeLivePlayerError](docs-player-android-api-errorcode#VeLivePlayerError) for details. |
| reason | VeLivePlayerResolutionSwitchReason | The reason for resolution switching. See [VeLivePlayerResolutionSwitchReason](docs-player-android-api-keytype#VeLivePlayerResolutionSwitchReason) for details. |


<span id="VeLivePlayerObserver-onvideosizechanged"></span>
### onVideoSizeChanged
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onVideoSizeChanged(
    VeLivePlayer player,
    int width,
    int height
)
```
Occurs when the video size changes.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| width | int | The updated width of the video, in pixels. |
| height | int | The updated height of the video, in pixels. |


<span id="VeLivePlayerObserver-onreceiveseimessage"></span>
### onReceiveSeiMessage
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onReceiveSeiMessage(
    VeLivePlayer player,
    String message
)
```
String SEI message callback. This callback is triggered when the player SDK receives an SEI message. It is necessary to enable the `enableSei` property in `VeLivePlayerConfiguration`. When the `enableBinarySei` property is enabled, the string SEI message will no longer be sent.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| message | String | The SEI message. |


<span id="VeLivePlayerObserver-onreceivebinaryseimessage"></span>
### onReceiveBinarySeiMessage
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onReceiveBinarySeiMessage(
    VeLivePlayer player,
    byte[] message
)
```
Binary SEI message callback. This callback is triggered when the player SDK receives an SEI message. It is necessary to enable the `enableBinarySei` property in `VeLivePlayerConfiguration`. When the `enableBinarySei` property is enabled, the string SEI message will no longer be sent.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| message | byte[] | The SEI message. |


<span id="VeLivePlayerObserver-onmainbackupswitch"></span>
### onMainBackupSwitch
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onMainBackupSwitch(
    VeLivePlayer player,
    VeLivePlayerStreamType streamType,
    VeLivePlayerError error
)
```
Occurs when the player switches between the primary stream and the backup stream.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| streamType | VeLivePlayerStreamType | The type of the updated stream. For details, see [VeLivePlayerStreamType](docs-player-android-api-keytype#VeLivePlayerStreamType). |
| error | VeLivePlayerError | The reason for the switch. For details, see [VeLivePlayerError](docs-player-android-api-errorcode#VeLivePlayerError). |


<span id="VeLivePlayerObserver-onplayerstatusupdate"></span>
### onPlayerStatusUpdate
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onPlayerStatusUpdate(
    VeLivePlayer player,
    VeLivePlayerStatus status
)
```
Occurs when the playback status changes.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| status | VeLivePlayerStatus | The updated status of the player. See [VeLivePlayerStatus](docs-player-android-api-keytype#VeLivePlayerStatus) for details. |


<span id="VeLivePlayerObserver-onstatistics"></span>
### onStatistics
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onStatistics(
    VeLivePlayer player,
    VeLivePlayerStatistics statistics
)
```
Occurs periodically to report information such as the current pull stream address, bitrate, and frame rate.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| statistics | VeLivePlayerStatistics | The playback statistics. For details, see [VeLivePlayerStatistics](docs-player-android-api-keytype#VeLivePlayerStatistics). |


<span id="VeLivePlayerObserver-onsnapshotcomplete"></span>
### onSnapshotComplete
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onSnapshotComplete(
    VeLivePlayer player,
    Bitmap bitmap
)
```
Occurs when a screenshot is taken after [snapshot](docs-player-android-api-reference#VeLivePlayer-snapshot) is called.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| bitmap | Bitmap | The Bitmap object of the screenshot. |


<span id="VeLivePlayerObserver-onrendervideoframe"></span>
### onRenderVideoFrame
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onRenderVideoFrame(
    VeLivePlayer player,
    VeLivePlayerVideoFrame videoFrame
)
```
Occurs when the player decodes a video frame. Call [enableVideoFrameObserver](docs-player-android-api-reference#VeLivePlayer-enablevideoframeobserver) to enable video frame callback.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| videoFrame | VeLivePlayerVideoFrame | The video frame, including the pixel format, encapsulation format, width and height of the video, and other information. See [VeLivePlayerVideoFrame](docs-player-android-api-keytype#VeLivePlayerVideoFrame) for details. |


**Notes**

If you use the texture format for external rendering, we recommend that you render the video in the callback thread.

<span id="VeLivePlayerObserver-onrenderaudioframe"></span>
### onRenderAudioFrame
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onRenderAudioFrame(
    VeLivePlayer player,
    VeLivePlayerAudioFrame audioFrame
)
```
Occurs when the player decodes an audio frame. Call [enableAudioFrameObserver](docs-player-android-api-reference#VeLivePlayer-enableaudioframeobserver) to enable audio frame callback.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| audioFrame | VeLivePlayerAudioFrame | The audio frame. See [VeLivePlayerAudioFrame](docs-player-android-api-keytype#VeLivePlayerAudioFrame) for details. |


**Notes**

The audio data returned by the callback is of type Float32 and in big-endian byte order.

<span id="VeLivePlayerObserver-onstreamfailedopensuperresolution"></span>
### onStreamFailedOpenSuperResolution
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onStreamFailedOpenSuperResolution(
    VeLivePlayer player,
    VeLivePlayerError error
)
```
Occurs when the SDK fails to enable super resolution after [setEnableSuperResolution](docs-player-android-api-reference#VeLivePlayer-setenablesuperresolution) is called.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| error | VeLivePlayerError | The reason of the failure. See [VeLivePlayerErrorCode](docs-player-android-api-errorcode#VeLivePlayerErrorCode) for details. |


<span id="VeLivePlayerObserver-onstreamfailedopensharpen"></span>
### onStreamFailedOpenSharpen
```java
default void com.ss.videoarch.liveplayer.VeLivePlayerObserver.onStreamFailedOpenSharpen(
    VeLivePlayer player,
    VeLivePlayerError error
)
```
Occurs when the SDK fails to enable sharpen after [setEnableSuperResolution](docs-player-android-api-reference#VeLivePlayer-setenablesuperresolution) is called.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| player | VeLivePlayer | The player object that triggers the callback function. |
| error | VeLivePlayerError | The reason of the failure. See [VeLivePlayerErrorCode](docs-player-android-api-errorcode#VeLivePlayerErrorCode) for details. |

<span id="VeLivePlayerResolution"></span>
# VeLivePlayerResolution
```java
public static class com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution
```
The player resolution.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| String | "origin" | [VeLivePlayerResolutionOrigin](#VeLivePlayerResolution-veliveplayerresolutionorigin) |
| String | "uhd" | [VeLivePlayerResolutionUHD](#VeLivePlayerResolution-veliveplayerresolutionuhd) |
| String | "hd" | [VeLivePlayerResolutionHD](#VeLivePlayerResolution-veliveplayerresolutionhd) |
| String | "sd" | [VeLivePlayerResolutionSD](#VeLivePlayerResolution-veliveplayerresolutionsd) |
| String | "ld" | [VeLivePlayerResolutionLD](#VeLivePlayerResolution-veliveplayerresolutionld) |
| String | VeLivePlayerResolutionOrigin | [resolutionStr](#VeLivePlayerResolution-resolutionstr) |

## Member Functions
| Return | Name |
| --- | --- |
| VeLivePlayerResolution | [VeLivePlayerResolution](#VeLivePlayerResolution-veliveplayerresolution) |

## Instructions
<span id="VeLivePlayerResolution-veliveplayerresolutionorigin"></span>
### VeLivePlayerResolutionOrigin
```java
public static final String com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution.VeLivePlayerResolutionOrigin = "origin"
```
Original.


<span id="VeLivePlayerResolution-veliveplayerresolutionuhd"></span>
### VeLivePlayerResolutionUHD
```java
public static final String com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution.VeLivePlayerResolutionUHD = "uhd"
```
Ultra high definition (UHD).


<span id="VeLivePlayerResolution-veliveplayerresolutionhd"></span>
### VeLivePlayerResolutionHD
```java
public static final String com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution.VeLivePlayerResolutionHD = "hd"
```
High definition (HD).


<span id="VeLivePlayerResolution-veliveplayerresolutionsd"></span>
### VeLivePlayerResolutionSD
```java
public static final String com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution.VeLivePlayerResolutionSD = "sd"
```
Standard definition (SD).


<span id="VeLivePlayerResolution-veliveplayerresolutionld"></span>
### VeLivePlayerResolutionLD
```java
public static final String com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution.VeLivePlayerResolutionLD = "ld"
```
Low definition (LD).


<span id="VeLivePlayerResolution-resolutionstr"></span>
### resolutionStr
```java
public String com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution.resolutionStr = VeLivePlayerResolutionOrigin
```
The initial resolution level passed in when creating the object.


## Instructions
<span id="VeLivePlayerResolution-veliveplayerresolution"></span>
### VeLivePlayerResolution
```java
public com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolution.VeLivePlayerResolution(String res)
```
Constructor method.


**Input Parameters**

| Name | Type | Instructions |
| --- | --- | --- |
| res | String | resolution level. |



<span id="VeLivePlayerConfiguration"></span>
# VeLivePlayerConfiguration
```java
public final class com.ss.videoarch.liveplayer.VeLivePlayerConfiguration
```
The configurations for player initialization.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| boolean | false | [enableSei](#VeLivePlayerConfiguration-enablesei) |
| boolean | false | [enableBinarySei](#VeLivePlayerConfiguration-enablebinarysei) |
| boolean | true | [enableHardwareDecode](#VeLivePlayerConfiguration-enablehardwaredecode) |
| int | 5_000 | [networkTimeoutMs](#VeLivePlayerConfiguration-networktimeoutms) |
| int | 5_000 | [retryIntervalTimeMs](#VeLivePlayerConfiguration-retryintervaltimems) |
| int | 5 | [retryMaxCount](#VeLivePlayerConfiguration-retrymaxcount) |
| boolean | false | [enableLiveDNS](#VeLivePlayerConfiguration-enablelivedns) |
| boolean | false | [enableStatisticsCallback](#VeLivePlayerConfiguration-enablestatisticscallback) |
| int | 5 | [statisticsCallbackInterval](#VeLivePlayerConfiguration-statisticscallbackinterval) |

## Instructions
<span id="VeLivePlayerConfiguration-enablesei"></span>
### enableSei
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.enableSei = false
```
Whether to enable the parsing of string SEI messages. The default value is `false`.
- true: Enable;
- false: Disable.


<span id="VeLivePlayerConfiguration-enablebinarysei"></span>
### enableBinarySei
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.enableBinarySei = false
```
Whether to enable the parsing of binary SEI messages. The default value is `false`.
- true: Enable;
- false: Disable.


**Notes**

After binary SEI is enabled, callbacks for string SEI will no longer be sent.

<span id="VeLivePlayerConfiguration-enablehardwaredecode"></span>
### enableHardwareDecode
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.enableHardwareDecode = true
```
Whether to turn on hardware decoding. The default value is `true`. When hardware decoding is enabled, if the player fails to start hardware decoding or if hardware decoding fails, the player automatically switches to software decoding.
- true: Enable;
- false: Disable.


<span id="VeLivePlayerConfiguration-networktimeoutms"></span>
### networkTimeoutMs
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.networkTimeoutMs = 5_000
```
Network timeout duration, in milliseconds. The default value is `5000`. Once the player sends a network request, if the player does not receive a response from the server after the timeout duration, the network request is considered failed.


<span id="VeLivePlayerConfiguration-retryintervaltimems"></span>
### retryIntervalTimeMs
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.retryIntervalTimeMs = 5_000
```
The retry time interval, in milliseconds. The default value is `5000`. This variable takes effect only when there is no backup stream.
- In the absence of a backup stream, if playback is interrupted due to network issues or other anomalies, the player will immediately initiate a retry. The player will make the first three retries immediately without any waiting time. However, for subsequent retries starting from the fourth attempt, the player will wait for the specified time interval between each attempt.
- In the presence of a backup stream, the time interval will not take effect because all retries will be executed immediately without any waiting time.


<span id="VeLivePlayerConfiguration-retrymaxcount"></span>
### retryMaxCount
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.retryMaxCount = 5
```
In the case of a network connection error, the maximum number of automatic retries of the player. The default value is `5`. If the value is `0`, the player will not automatically retry.
- In the absence of a backup stream, each retry will count as one retry attempt.
- In the presence of a backup stream, each switch between the primary stream and the backup stream will count as a retry attempt.


<span id="VeLivePlayerConfiguration-enablelivedns"></span>
### enableLiveDNS
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.enableLiveDNS = false
```
Whether to enable local DNS prefetch. The default value is `false`. Enabling local DNS prefetch can reduce the time required to start playback. If an abnormality occurs with local DNS prefetch, the player may not function properly.
- true: Enable;
- false: Disable.


<span id="VeLivePlayerConfiguration-enablestatisticscallback"></span>
### enableStatisticsCallback
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.enableStatisticsCallback = false
```
Whether to enable periodic callbacks for playback information. The default value is `false`. Refer to [VeLivePlayerStatistics](#VeLivePlayerStatistics) for more information on callback statistics. If `enableStatisticsCallback` is `true` and [statisticsCallbackInterval](#VeLivePlayerConfiguration-statisticscallbackinterval) is greater than `0`, the player will periodically report the player status information after the specified time interval.
- true: Enable;
- false: Disable.


<span id="VeLivePlayerConfiguration-statisticscallbackinterval"></span>
### statisticsCallbackInterval
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerConfiguration.statisticsCallbackInterval = 5
```
The time interval for periodic callbacks that provide playback information, in seconds. The default value is `5`. If [enableStatisticsCallback](#VeLivePlayerConfiguration-enablestatisticscallback) is `true` and `statisticsCallbackInterval` is greater than `0`, the player will periodically report the player status information after the specified time interval.



<span id="VeLivePlayerFormat"></span>
# VeLivePlayerFormat
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerFormat
```
The format of the live stream.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerFormatFLV | 0 | FLV. |
| VeLivePlayerFormatHLS | 1 | HLS. |
| VeLivePlayerFormatRTM | 2 | Real Time Media (RTM). |
| VeLivePlayerFormatCMAF | 3 | CMAF format |


<span id="VeLivePlayerProtocol"></span>
# VeLivePlayerProtocol
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerProtocol
```
The transmission protocol.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerProtocolTCP | 0 | TCP. |
| VeLivePlayerProtocolQUIC | 1 | QUIC. |
| VeLivePlayerProtocolTLS | 2 | TLS. |
| VeLivePlayerProtocolHTTP2 | 3 | HTTP2.0 protocol |


<span id="VeLivePlayerMirror"></span>
# VeLivePlayerMirror
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerMirror
```
The mirroring option.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerMirrorNone | 0 | No mirroring. |
| VeLivePlayerMirrorHorizontal | 1 | Horizontal mirroring. |
| VeLivePlayerMirrorVertical | 2 | Vertical mirroring. |


<span id="VeLivePlayerVideoBufferType"></span>
# VeLivePlayerVideoBufferType
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerVideoBufferType
```
The encapsulation format of the video data.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerVideoBufferTypeUnknown | 0 | Unknown format. |
| VeLivePlayerVideoBufferTypeByteBuffer | 1 | ByteBuffer. |
| VeLivePlayerVideoBufferTypeByteArray | 2 | ByteArray. |
| VeLivePlayerVideoBufferTypeTexture | 3 | Texture. |


<span id="VeLivePlayerStatus"></span>
# VeLivePlayerStatus
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerStatus
```
The status of the live player.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerStatusStopped | 0 | The playback is stopped. |
| VeLivePlayerStatusPaused | 1 | The playback is paused. |
| VeLivePlayerStatusPrepared | 2 | The player finishes preparing and is waiting to render the video. |
| VeLivePlayerStatusPlaying | 3 | Playback is currently in progress, meaning that the first frame has been rendered and no errors have occurred to the player. |
| VeLivePlayerStatusError | 4 | An error has occurred to the player. |


<span id="VeLivePlayerLogConfig"></span>
# VeLivePlayerLogConfig
```java
public class com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig
```
Log settings.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| String | - | [logPath](#VeLivePlayerLogConfig-logpath) |
| int | 100 | [maxLogSizeM](#VeLivePlayerLogConfig-maxlogsizem) |
| int | 2 | [singleLogSizeM](#VeLivePlayerLogConfig-singlelogsizem) |
| int | 7 * 24 * 60 * 60 | [logExpireTimeS](#VeLivePlayerLogConfig-logexpiretimes) |
| boolean | true | [enableConsole](#VeLivePlayerLogConfig-enableconsole) |
| boolean | true | [enableLogFile](#VeLivePlayerLogConfig-enablelogfile) |
| String | "" | [queryUrl](#VeLivePlayerLogConfig-queryurl) |
| boolean | true | [enableThreadLoop](#VeLivePlayerLogConfig-enablethreadloop) |
| int | 2 * 60 * 1000 | [intervalMS](#VeLivePlayerLogConfig-intervalms) |
| int | 0 | [httpTimeoutMS](#VeLivePlayerLogConfig-httptimeoutms) |
| int | 0 | [httpUploadFileTimeoutMS](#VeLivePlayerLogConfig-httpuploadfiletimeoutms) |
| VeLivePlayerLogLevel | VeLivePlayerLogLevel.VeLivePlayerLogLevelVerbose | [logLevel](#VeLivePlayerLogConfig-loglevel) |

## Instructions
<span id="VeLivePlayerLogConfig-logpath"></span>
### logPath
```java
public String com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.logPath
```
The log file directory path. The default value is `/cache/Log`.


<span id="VeLivePlayerLogConfig-maxlogsizem"></span>
### maxLogSizeM
```java
public int com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.maxLogSizeM = 100
```
The maximum size of log files, in MB. The default value is `100`.


<span id="VeLivePlayerLogConfig-singlelogsizem"></span>
### singleLogSizeM
```java
public int com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.singleLogSizeM = 2
```
The size of a single log file, in MB. The default value is `2`.


<span id="VeLivePlayerLogConfig-logexpiretimes"></span>
### logExpireTimeS
```java
public int com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.logExpireTimeS = 7 * 24 * 60 * 60
```
The log expiration time, in seconds. Once a log file expires, a new log file will be created and the existing file will be deleted. The default value is `604800`, or seven days.


<span id="VeLivePlayerLogConfig-enableconsole"></span>
### enableConsole
```java
public boolean com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.enableConsole = true
```
Whether to print log in the console. The default value is `true`.


<span id="VeLivePlayerLogConfig-enablelogfile"></span>
### enableLogFile
```java
public boolean com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.enableLogFile = true
```
Whether to save log to a file. The default value is `true`.


<span id="VeLivePlayerLogConfig-queryurl"></span>
### queryUrl
```java
public String com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.queryUrl = ""
```
The upload URL of the log file.


<span id="VeLivePlayerLogConfig-enablethreadloop"></span>
### enableThreadLoop
```java
public boolean com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.enableThreadLoop = true
```
Whether to enable thread polling.
- `true`: Enable
- `false`: Disable


<span id="VeLivePlayerLogConfig-intervalms"></span>
### intervalMS
```java
public int com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.intervalMS = 2 * 60 * 1000
```
The polling interval, in milliseconds. The value should be greater than 0.


<span id="VeLivePlayerLogConfig-httptimeoutms"></span>
### httpTimeoutMS
```java
public int com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.httpTimeoutMS = 0
```
The timeout for an HTTP request. Value range: \> 0.


<span id="VeLivePlayerLogConfig-httpuploadfiletimeoutms"></span>
### httpUploadFileTimeoutMS
```java
public int com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.httpUploadFileTimeoutMS = 0
```
The timeout for an HTTP request to upload a file. Value range: \> 0.


<span id="VeLivePlayerLogConfig-loglevel"></span>
### logLevel
```java
public VeLivePlayerLogLevel com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.logLevel = VeLivePlayerLogLevel.VeLivePlayerLogLevelVerbose
```
The output log level. The default value is `VeLivePlayerLogLevelDebug`. For details, see [VeLivePlayerLogLevel](#VeLivePlayerLogLevel).



<span id="VeLivePlayerStreamData"></span>
# VeLivePlayerStreamData
```java
public class com.ss.videoarch.liveplayer.VeLivePlayerStreamData
```
The configurations for the pull stream addresses.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| boolean | false | [enableABR](#VeLivePlayerStreamData-enableabr) |
| boolean | false | [enableMainBackupSwitch](#VeLivePlayerStreamData-enablemainbackupswitch) |
| VeLivePlayerResolution | new VeLivePlayerResolution(VeLivePlayerResolution.VeLivePlayerResolutionOrigin) | [defaultResolution](#VeLivePlayerStreamData-defaultresolution) |
| VeLivePlayerFormat | VeLivePlayerFormat.VeLivePlayerFormatFLV | [defaultFormat](#VeLivePlayerStreamData-defaultformat) |
| VeLivePlayerProtocol | VeLivePlayerProtocol.VeLivePlayerProtocolTCP | [defaultProtocol](#VeLivePlayerStreamData-defaultprotocol) |
| List\<VeLivePlayerStream> | null | [mainStreamList](#VeLivePlayerStreamData-mainstreamlist) |
| List\<VeLivePlayerStream> | null | [backupStreamList](#VeLivePlayerStreamData-backupstreamlist) |

## Instructions
<span id="VeLivePlayerStreamData-enableabr"></span>
### enableABR
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerStreamData.enableABR = false
```
Whether to enable adaptive bitrate (ABR). The default value is `false`.
- true: Enable;
- false: Disable.


<span id="VeLivePlayerStreamData-enablemainbackupswitch"></span>
### enableMainBackupSwitch
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerStreamData.enableMainBackupSwitch = false
```
Whether to enable switching between primary and backup streams. The default value is `false`.
- true: Enable;
- false: Disable.


<span id="VeLivePlayerStreamData-defaultresolution"></span>
### defaultResolution
```java
public VeLivePlayerResolution com.ss.videoarch.liveplayer.VeLivePlayerStreamData.defaultResolution = new VeLivePlayerResolution(VeLivePlayerResolution.VeLivePlayerResolutionOrigin)
```
The default resolution. The default value is `VeLivePlayerResolutionOrigin`, which indicates the original resolution. See [VeLivePlayerResolution](#VeLivePlayerResolution) for details.


<span id="VeLivePlayerStreamData-defaultformat"></span>
### defaultFormat
```java
public VeLivePlayerFormat com.ss.videoarch.liveplayer.VeLivePlayerStreamData.defaultFormat = VeLivePlayerFormat.VeLivePlayerFormatFLV
```
The default video format. The default value is `VeLivePlayerFormatFLV`. See [VeLivePlayerFormat](#VeLivePlayerFormat) for details.


<span id="VeLivePlayerStreamData-defaultprotocol"></span>
### defaultProtocol
```java
public VeLivePlayerProtocol com.ss.videoarch.liveplayer.VeLivePlayerStreamData.defaultProtocol = VeLivePlayerProtocol.VeLivePlayerProtocolTCP
```
The default transmission protocol. The default value is `VeLivePlayerProtocolTCP`. See [VeLivePlayerProtocol](#VeLivePlayerProtocol) for details.


<span id="VeLivePlayerStreamData-mainstreamlist"></span>
### mainStreamList
```java
public List<VeLivePlayerStream> com.ss.videoarch.liveplayer.VeLivePlayerStreamData.mainStreamList = null
```
A list of main stream addresses. See [VeLivePlayerStream](#VeLivePlayerStreamData-VeLivePlayerStream) for details.


<span id="VeLivePlayerStreamData-backupstreamlist"></span>
### backupStreamList
```java
public List<VeLivePlayerStream> com.ss.videoarch.liveplayer.VeLivePlayerStreamData.backupStreamList = null
```
A list of backup stream addresses. See [VeLivePlayerStream](#VeLivePlayerStreamData-VeLivePlayerStream) for details.



<span id="VeLivePlayerResolutionSwitchReason"></span>
# VeLivePlayerResolutionSwitchReason
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerResolutionSwitchReason
```
The reason why the video resolution has changed.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLiveplayerResolutionSwitchByAuto | 0 | The resolution is switched automatically through the adaptive bitrate (ABR) feature. |
| VeLiveplayerResolutionSwitchByManual | 1 | The resolution is changed after [switchResolution](docs-player-android-api-reference#VeLivePlayer-switchresolution) is called. |


<span id="VeLivePlayerStreamData-VeLivePlayerStream"></span>
# VeLivePlayerStream
```java
public static class com.ss.videoarch.liveplayer.VeLivePlayerStreamData.VeLivePlayerStream
```
The information about a pull stream address.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| String | null | [url](#VeLivePlayerStream-url) |
| VeLivePlayerResolution | new VeLivePlayerResolution(VeLivePlayerResolution.VeLivePlayerResolutionOrigin) | [resolution](#VeLivePlayerStream-resolution) |
| long | - | [bitrate](#VeLivePlayerStream-bitrate) |
| VeLivePlayerFormat | VeLivePlayerFormat.VeLivePlayerFormatFLV | [format](#VeLivePlayerStream-format) |
| VeLivePlayerStreamType | VeLivePlayerStreamType.VeLivePlayerStreamTypeMain | [streamType](#VeLivePlayerStream-streamtype) |

## Instructions
<span id="VeLivePlayerStream-url"></span>
### url
```java
public String com.ss.videoarch.liveplayer.VeLivePlayerStreamData.VeLivePlayerStream.url = null
```
The pull stream address.


<span id="VeLivePlayerStream-resolution"></span>
### resolution
```java
public VeLivePlayerResolution com.ss.videoarch.liveplayer.VeLivePlayerStreamData.VeLivePlayerStream.resolution = new VeLivePlayerResolution(VeLivePlayerResolution.VeLivePlayerResolutionOrigin)
```
The playback resolution. For details, see [VeLivePlayerResolution](#VeLivePlayerResolution).


<span id="VeLivePlayerStream-bitrate"></span>
### bitrate
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerStreamData.VeLivePlayerStream.bitrate
```
The playback bitrate, in Kbps.


<span id="VeLivePlayerStream-format"></span>
### format
```java
public VeLivePlayerFormat com.ss.videoarch.liveplayer.VeLivePlayerStreamData.VeLivePlayerStream.format = VeLivePlayerFormat.VeLivePlayerFormatFLV
```
The format of the live stream. See [VeLivePlayerFormat](#VeLivePlayerFormat) for details.


<span id="VeLivePlayerStream-streamtype"></span>
### streamType
```java
public VeLivePlayerStreamType com.ss.videoarch.liveplayer.VeLivePlayerStreamData.VeLivePlayerStream.streamType = VeLivePlayerStreamType.VeLivePlayerStreamTypeMain
```
Whether the stream is a main or backup stream. See [VeLivePlayerStreamType](#VeLivePlayerStreamType) for details.



<span id="VeLivePlayerFillMode"></span>
# VeLivePlayerFillMode
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerFillMode
```
The fill mode of the player screen.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerFillModeAspectFit | 0 | Display the full video. The video is uniformly scaled until one dimension of the video hits the boundary of the screen. Any remaining space on the screen will be filled with black. |
| VeLivePlayerFillModeFullFill | 1 | Stretch the video to fill the screen. The aspect ratio of the video might change. |
| VeLivePlayerFillModeAspectFill | 2 | Uniformly scale the video until the screen is completely filled. Part of the video may be cropped. |


<span id="VeLivePlayerPixelFormat"></span>
# VeLivePlayerPixelFormat
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerPixelFormat
```
The pixel format of the video frame.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerPixelFormatUnknown | 0 | Unknown format. |
| VeLivePlayerPixelFormatRGBA32 | 1 | RGBA8888. |
| VeLivePlayerPixelFormatTexture | 2 | Texture. |


<span id="VeLivePlayerStatistics"></span>
# VeLivePlayerStatistics
```java
public class com.ss.videoarch.liveplayer.VeLivePlayerStatistics
```
The playback statistics.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| String | - | [url](#VeLivePlayerStatistics-url) |
| boolean | - | [isHardwareDecode](#VeLivePlayerStatistics-ishardwaredecode) |
| String | - | [videoCodec](#VeLivePlayerStatistics-videocodec) |
| long | - | [stallTimeMs](#VeLivePlayerStatistics-stalltimems) |
| long | - | [bandwidthEstimation](#VeLivePlayerStatistics-bandwidthestimation) |
| long | - | [delayMs](#VeLivePlayerStatistics-delayms) |
| int | - | [width](#VeLivePlayerStatistics-width) |
| int | - | [height](#VeLivePlayerStatistics-height) |
| float | - | [fps](#VeLivePlayerStatistics-fps) |
| long | - | [bitrate](#VeLivePlayerStatistics-bitrate) |
| long | - | [videoBufferMs](#VeLivePlayerStatistics-videobufferms) |
| long | - | [audioBufferMs](#VeLivePlayerStatistics-audiobufferms) |
| String | - | [format](#VeLivePlayerStatistics-format) |
| String | - | [protocol](#VeLivePlayerStatistics-protocol) |

## Instructions
<span id="VeLivePlayerStatistics-url"></span>
### url
```java
public String com.ss.videoarch.liveplayer.VeLivePlayerStatistics.url
```
The current pull stream address.


<span id="VeLivePlayerStatistics-ishardwaredecode"></span>
### isHardwareDecode
```java
public boolean com.ss.videoarch.liveplayer.VeLivePlayerStatistics.isHardwareDecode
```
Whether hardware decoding is used.
- true: Hardware decoding is used;
- false: Hardware decoding is not used.


<span id="VeLivePlayerStatistics-videocodec"></span>
### videoCodec
```java
public String com.ss.videoarch.liveplayer.VeLivePlayerStatistics.videoCodec
```
The encoding format of the video.


<span id="VeLivePlayerStatistics-stalltimems"></span>
### stallTimeMs
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerStatistics.stallTimeMs
```
The cumulative duration of stutters that occurred since the beginning of playback, in milliseconds.


<span id="VeLivePlayerStatistics-bandwidthestimation"></span>
### bandwidthEstimation
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerStatistics.bandwidthEstimation
```
Bandwidth estimation, unit is kbps.


<span id="VeLivePlayerStatistics-delayms"></span>
### delayMs
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerStatistics.delayMs
```
The current playback latency, in milliseconds. The latency data is available only if you use the BytePlus MediaLive Broadcast SDK to push the live stream.


<span id="VeLivePlayerStatistics-width"></span>
### width
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerStatistics.width
```
The width of the video, in pixels.


<span id="VeLivePlayerStatistics-height"></span>
### height
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerStatistics.height
```
The height of the video, in pixels.


<span id="VeLivePlayerStatistics-fps"></span>
### fps
```java
public float com.ss.videoarch.liveplayer.VeLivePlayerStatistics.fps
```
The frame rate of the video, in fps.


<span id="VeLivePlayerStatistics-bitrate"></span>
### bitrate
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerStatistics.bitrate
```
The downlink bitrate, in Kbps.


<span id="VeLivePlayerStatistics-videobufferms"></span>
### videoBufferMs
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerStatistics.videoBufferMs
```
The video buffer, in milliseconds.


<span id="VeLivePlayerStatistics-audiobufferms"></span>
### audioBufferMs
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerStatistics.audioBufferMs
```
The audio buffer, in milliseconds.


<span id="VeLivePlayerStatistics-format"></span>
### format
```java
public String com.ss.videoarch.liveplayer.VeLivePlayerStatistics.format
```
The video format.


<span id="VeLivePlayerStatistics-protocol"></span>
### protocol
```java
public String com.ss.videoarch.liveplayer.VeLivePlayerStatistics.protocol
```
The transmission protocol of the live stream.



<span id="VeLivePlayerVideoFrame"></span>
# VeLivePlayerVideoFrame
```java
public class com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame
```
The video frame.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| VeLivePlayerVideoBufferType | - | [bufferType](#VeLivePlayerVideoFrame-buffertype) |
| VeLivePlayerPixelFormat | - | [pixelFormat](#VeLivePlayerVideoFrame-pixelformat) |
| int | - | [width](#VeLivePlayerVideoFrame-width) |
| int | - | [height](#VeLivePlayerVideoFrame-height) |
| long | - | [pts](#VeLivePlayerVideoFrame-pts) |
| VeLivePlayerVideoTexture | null | [texture](#VeLivePlayerVideoFrame-texture) |
| ByteBuffer | null | [buffer](#VeLivePlayerVideoFrame-buffer) |
| byte[] | null | [data](#VeLivePlayerVideoFrame-data) |

## Instructions
<span id="VeLivePlayerVideoFrame-buffertype"></span>
### bufferType
```java
public VeLivePlayerVideoBufferType com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.bufferType
```
The encapsulation format. See [VeLivePlayerVideoBufferType](#VeLivePlayerVideoBufferType) for details.


<span id="VeLivePlayerVideoFrame-pixelformat"></span>
### pixelFormat
```java
public VeLivePlayerPixelFormat com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.pixelFormat
```
The pixel format. See [VeLivePlayerPixelFormat](#VeLivePlayerPixelFormat) for details.


<span id="VeLivePlayerVideoFrame-width"></span>
### width
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.width
```
The video width, in pixels.


<span id="VeLivePlayerVideoFrame-height"></span>
### height
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.height
```
The video height, in pixels.


<span id="VeLivePlayerVideoFrame-pts"></span>
### pts
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.pts
```
The timestamp indicating the time when the video frame is rendered, in milliseconds.


<span id="VeLivePlayerVideoFrame-texture"></span>
### texture
```java
public VeLivePlayerVideoTexture com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.texture = null
```
The texture data for OpenGL rendering. The SDK returns this video data type if you set [VeLivePlayerPixelFormat](#VeLivePlayerPixelFormat) to `VeLivePlayerPixelFormatTexture` and set [VeLivePlayerVideoBufferType](#VeLivePlayerVideoBufferType) to `VeLivePlayerVideoBufferTypeTexture`. See [VeLivePlayerVideoTexture](#VeLivePlayerVideoTexture) for details.


<span id="VeLivePlayerVideoFrame-buffer"></span>
### buffer
```java
public ByteBuffer com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.buffer = null
```
The video data in ByteBuffer format. The SDK returns this video data type if you set [VeLivePlayerPixelFormat](#VeLivePlayerPixelFormat) to `VeLivePlayerPixelFormatRGBA32` and set [VeLivePlayerVideoBufferType](#VeLivePlayerVideoBufferType) to `VeLivePlayerVideoBufferTypeByteBuffer`.


<span id="VeLivePlayerVideoFrame-data"></span>
### data
```java
public byte [] com.ss.videoarch.liveplayer.VeLivePlayerVideoFrame.data = null
```
The video data in ByteArray format. The SDK returns this video data type if you set [VeLivePlayerPixelFormat](#VeLivePlayerPixelFormat) to `VeLivePlayerPixelFormatRGBA32` and set [VeLivePlayerVideoBufferType](#VeLivePlayerVideoBufferType) to `VeLivePlayerVideoBufferTypeByteArray`.



<span id="VeLivePlayerVideoTexture"></span>
# VeLivePlayerVideoTexture
```java
public class com.ss.videoarch.liveplayer.VeLivePlayerVideoTexture
```
The video texture.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| int | - | [texId](#VeLivePlayerVideoTexture-texid) |
| EGLContext | - | [eglContext](#VeLivePlayerVideoTexture-eglcontext) |

## Instructions
<span id="VeLivePlayerVideoTexture-texid"></span>
### texId
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerVideoTexture.texId
```
The video texture ID.


<span id="VeLivePlayerVideoTexture-eglcontext"></span>
### eglContext
```java
public EGLContext com.ss.videoarch.liveplayer.VeLivePlayerVideoTexture.eglContext
```
OpenGL ES context for custom rendering. After you bind EGLContext to GLSurfaceView or TextureView, you can perform custom OpenGL ES rendering on the bound View.



<span id="VeLivePlayerStreamType"></span>
# VeLivePlayerStreamType
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerStreamType
```
The type of the live stream.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerStreamTypeMain | 0 | The primary stream. |
| VeLivePlayerStreamTypeBackup | 1 | The backup stream. |


<span id="VeLivePlayerLogLevel"></span>
# VeLivePlayerLogLevel
```java
public enum com.ss.videoarch.liveplayer.log.VeLivePlayerLogConfig.VeLivePlayerLogLevel
```
The output log level of the player.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerLogLevelVerbose | 0 | Output logs at the VERBOSE, DEBUG, INFO, WARNING, and ERROR levels. |
| VeLivePlayerLogLevelDebug | 1 | Output logs at the DEBUG, INFO, WARNING, and ERROR levels. |
| VeLivePlayerLogLevelInfo | 2 | Output logs at the INFO, WARNING, and ERROR levels. |
| VeLivePlayerLogLevelWarn | 3 | Output logs at the WARNING and ERROR levels. |
| VeLivePlayerLogLevelError | 4 | Output logs at the ERROR level. |
| VeLivePlayerLogLevelNone | 5 | Disable log printing. |


<span id="VeLivePlayerAudioFrame"></span>
# VeLivePlayerAudioFrame
```java
public class com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame
```
The audio frame.

## Member Property
| Type | Default Value | Name |
| --- | --- | --- |
| VeLivePlayerAudioBufferType | - | [bufferType](#VeLivePlayerAudioFrame-buffertype) |
| int | - | [sampleRate](#VeLivePlayerAudioFrame-samplerate) |
| int | - | [channels](#VeLivePlayerAudioFrame-channels) |
| int | - | [bitDepth](#VeLivePlayerAudioFrame-bitdepth) |
| long | - | [pts](#VeLivePlayerAudioFrame-pts) |
| byte[] | null | [bufferArray](#VeLivePlayerAudioFrame-bufferarray) |
| ByteBuffer[] | null | [buffer](#VeLivePlayerAudioFrame-buffer) |
| int | - | [samples](#VeLivePlayerAudioFrame-samples) |

## Instructions
<span id="VeLivePlayerAudioFrame-buffertype"></span>
### bufferType
```java
public VeLivePlayerAudioBufferType com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.bufferType
```
The encapsulation format of the audio data. See [VeLivePlayerAudioBufferType](#VeLivePlayerAudioBufferType) for details.


<span id="VeLivePlayerAudioFrame-samplerate"></span>
### sampleRate
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.sampleRate
```
The audio sample rate, in Hz.


<span id="VeLivePlayerAudioFrame-channels"></span>
### channels
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.channels
```
The number of audio channels.
- 1: Mono;
- 2: Stereo.


<span id="VeLivePlayerAudioFrame-bitdepth"></span>
### bitDepth
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.bitDepth
```
The audio bit depth.


<span id="VeLivePlayerAudioFrame-pts"></span>
### pts
```java
public long com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.pts
```
The timestamp indicating the time when the audio is rendered, in milliseconds.


<span id="VeLivePlayerAudioFrame-bufferarray"></span>
### bufferArray
```java
public byte [] com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.bufferArray = null
```
The PCM audio data. byte[] type.


<span id="VeLivePlayerAudioFrame-buffer"></span>
### buffer
```java
public ByteBuffer [] com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.buffer = null
```
The PCM audio data. ByteBuffer[] type.


<span id="VeLivePlayerAudioFrame-samples"></span>
### samples
```java
public int com.ss.videoarch.liveplayer.VeLivePlayerAudioFrame.samples
```
The number of audio samples.



<span id="VeLivePlayerAudioBufferType"></span>
# VeLivePlayerAudioBufferType
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerAudioBufferType
```
The encapsulation format of the audio.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerAudioBufferTypeUnknown | 0 | Unknown format. |
| VeLivePlayerAudioBufferTypeByteArray | 1 | ByteArray. |


<span id="VeLivePlayerRotation"></span>
# VeLivePlayerRotation
```java
public enum com.ss.videoarch.liveplayer.VeLivePlayerDef.VeLivePlayerRotation
```
The clockwise video rotation angle.

## Enumerated Value
| Type | Value | Instructions |
| --- | --- | --- |
| VeLivePlayerRotation0 | 0 | No rotation. |
| VeLivePlayerRotation90 | 1 | Rotate 90 degrees clockwise. |
| VeLivePlayerRotation180 | 2 | Rotate 180 degrees clockwise. |
| VeLivePlayerRotation270 | 3 | Rotate 270 degrees clockwise. |


This topic describes how to implement the basic features of the Player SDK for Flutter.
<span id="b3349bc1"></span>
## Prerequisites
You have integrated and initialized the Player SDK for Flutter. For more information, see [Integrating the Player SDK for Flutter](/docs/byteplus-media-live/integrating-the-player-sdk-for-flutter) and [Initializing the Player SDK for Flutter](/docs/byteplus-media-live/initializing-the-player-sdk-for-flutter).
<span id="cd2e09da"></span>
## Creating a player and configuring a rendering view
To use the Player SDK for Flutter, you must first create a player. To display the video in the player, you must configure a rendering view.  
```Dart
// Create a player. In the following example, a player with a width equal to the screen width and a height equal to 9/16 of the screen height is created. 
VeLivePlayer manager = await VeLivePlayer.createManager();

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      height: MediaQuery.of(context).size.height * 9 / 16,
      width: MediaQuery.of(context).size.width,
      // Configure a rendering view.
      child: VeliveFlutterPlayerView(manager: manager),
    ),
  );
}
```

<span id="72224c5b"></span>
## Initializing player settings
After creating the player, you can initialize its settings using `VeLivePlayerConfiguration`. The following table lists the detailed parameters.

| | | | \
|Parameter |Type |Description |
|---|---|---|
| | | | \
|enableSei |boolean |Whether to enable parsing Supplemental Enhancement Information (SEI) messages. The default value is `false`. Valid values: |\
| | | |\
| | |* `true`: Enable. |\
| | |* `false`: Disable. |\
| | | |\
| | |:::tip |\
| | |SEI messages are a data channel synchronized with video frames, commonly used to display interactive content at specific time points, such as questions, bullet comments, and virtual props, providing the audience with a richer interactive experience. |\
| | |::: |\
| | | |
| | | | \
|enableHardwareDecode |boolean |Whether to enable hardware decoding. The default value is `true`. Valid values: |\
| | | |\
| | |* `true`: Enable. If hardware decoding fails, the player automatically switches to software decoding. |\
| | |* `false`: Disable. |
| | | | \
|enableLiveDNS |boolean |\
| | |Whether to enable local DNS pre-resolution. The default value is `false`. Valid values: |\
| | | |\
| | |* `true`: Enable. Enabling local DNS pre-resolution can optimize the player's playback start time. |\
| | |* `false`: Disable. |\
| | | |\
| | |:::tip |\
| | |Problems during pre-resolution may affect the player's normal operation. |\
| | |::: |
| | | | \
|enableStatisticsCallback |boolean |Whether to enable periodic callback of playback information. The default value is `false`. Valid values: |\
| | | |\
| | |* `true`: Enable. |\
| | |* `false`: Disable. |
| | | | \
|statisticsCallbackInterval |int |Time interval for the periodic callback of playback information. The unit is seconds. The default value is `5`. |
| | | | \
|networkTimeoutMs |int |\
| | |Network timeout period. The unit is milliseconds. The default value is `5000`. |\
| | |If the network request does not receive a server response within the timeout period, the player will consider the request as failed. |
| | | | \
|retryIntervalTimeMs |int |Retry interval. The unit is milliseconds. The default value is `5000`. |\
| | |During the live stream, if network errors or similar issues cause an interruption, the player will immediately attempt a retry. After a retry attempt fails, the player will retry again at each retry interval. |\
| | |:::tip |\
| | |This parameter takes effect only when no backup stream is present. If a backup stream is available, the system will directly switch to the backup stream and continue playback in the event of network errors or similar issues. |\
| | |::: |\
| | | |
| | | | \
|retryMaxCount |int |Maximum number of retries for the player in case of network connection errors. The default value is `5`. The value `0` disables the player's internal retry mechanism. |

```Dart
// Initialize the player settings. In the following example, SEI message parsing and hardware decoding are enabled.
VeLivePlayerConfiguration configuration = VeLivePlayerConfiguration(
      enableSei: true
      enableHardwareDecode: true
    );
manager.setConfig(configuration);    
```

<span id="9b96cdda"></span>
## Configuring the playback URL
Configure a playback URL supporting RTM, FLV, and HLS live streaming protocols.
```Dart
// Play via URL.
String playUrl = "http://pull.example.com/live/stream.flv"
// Configure the playback URL.
manager.setPlayUrl(playUrl)
```

:::tip
To configure different playback URLs for the player to switch between during playback, use the `setPlayStreamData` method. This method supports primary and backup streams and adaptive bitrate (ABR) features. For more information, see [Player SDK for Flutter: Advanced features](/docs/byteplus-media-live/player-sdk-for-flutter-advanced-features).
:::
<span id="180ccac5"></span>
## Starting playback
```Dart
Future<void> play();
```

<span id="23a7e6fe"></span>
## Getting whether the player is playing
```Dart
Future<bool?> isPlaying();
```

<span id="865bd15c"></span>
## Pausing playback
```Dart
Future<void> pause();
```

:::tip
During the live stream, pausing and stopping playback have the same effect. If you call the `play` method again after pausing playback, the player will pull stream again.
:::
<span id="e5800925"></span>
## Stopping playback
```Dart
Future<void> stop();
```

<span id="e46d574a"></span>
## Destroying the player
Destroy the player and release memory. To destroy the player after playback has stopped, call this method.
```Dart
Future<void> destroy();
```

<span id="19b4ddf5"></span>
## Setting the video scaling mode
You can use the player's `setRenderFillMode` method to set the video scaling mode. The player supports the following video scaling modes.

| | | \
|Video Scaling Mode |Description |
|---|---|
| | | \
|aspectfill |Maintain the video's original aspect ratio and fill the player. If the video's aspect ratio differs from that of the player, areas of the video that extend beyond the player's boundaries will be cropped, which may result in an incomplete view. |
| | | \
|aspectfit |Maintain the video's original aspect ratio until the video is fully displayed within the player. If the video's aspect ratio differs from that of the player, areas not filled by the video will appear black. |
| | | \
|fullfill |The video completely fills the player, but the video's aspect ratio may change. |

The following sample code sets the video scaling mode.
```Dart
Future<void> setRenderFillMode(VeLivePlayerFillMode fillMode);
```

<span id="343a19dc"></span>
## Setting whether to mute playback
Set whether to mute playback. By default, playback is not muted.
```Dart
Future<void> setMute(bool mute);
```

<span id="348f6dda"></span>
## Getting whether playback is muted
```Dart
Future<bool?> isMute();
```

<span id="83ca7099"></span>
## Setting video rotation angle
```Dart
enum VeLivePlayerRotation {
  // Disable rotation.
  rotation0,
  // Rotate 90 degrees clockwise.
  rotation90,
  // Rotate 180 degrees clockwise.
  rotation180,
  // Rotate 270 degrees clockwise.
  rotation270,
}

Future<void> setRenderRotation(VeLivePlayerRotation rotation);
```

<span id="18faede6"></span>
## Configuring event listeners
You can get internal player status information by configuring event listeners, including playback status, error information, audio/video first frame callbacks, and periodic statistical data. The sample code is as follows.

1. Configure the player callback.
   ```Dart
   Future<void> setObserver(VeLivePlayerObserver observer);
   ```

2. Handle player callbacks.
   ```Dart
     // This callback is triggered when the player encounters an error.
     void Function(VeLivePlayerError error)? onError;
     
     // This callback is triggered when the first video frame is rendered successfully, or when a retry occurs during playback and the first video frame is rendered successfully after the retry.
     void Function(bool isFirstFrame)? onFirstVideoFrameRender;
     
     // This callback is triggered when the first audio frame is rendered successfully, or when a retry occurs during playback and the first audio frame is rendered successfully after the retry.
     void Function(bool isFirstFrame)? onFirstAudioFrameRender;
     
     // This callback is triggered when the resolution changes.
     void Function(VeLivePlayerResolution resolution, VeLivePlayerError? error, VeLivePlayerResolutionSwitchReason reason)? onResolutionSwitch;
     
     // This callback is triggered when playback stuttering starts.
     void Function()? onStallStart;
     
     // Playback stuttering end callback. This callback is triggered when the audio buffer meets the playback condition and playback starts.
     void Function()? onStallEnd;
     
     // This callback is triggered when the video width or height changes.
     void Function(int width, int height)? onVideoSizeChanged;
     
     // This callback is triggered when video rendering stutters.
     void Function(int stallTime)? onVideoRenderStall;
     
     // This callback is triggered when audio rendering stutters.
     void Function(int stallTime)? onAudioRenderStall;
     
     // This callback is triggered when the playback status changes.
     void Function(VeLivePlayerStatus status)? onPlayerStatusUpdate;
     
     // Periodic callback for playback information. The SDK periodically triggers this callback. You can use this callback to get information such as the current player's playback URL, bitrate, and frame rate.
     void Function(VeLivePlayerStatistics statistics)? onStatistics;
     
     // This callback is triggered when the SDK receives SEI messages.
     void Function(String message)? onReceiveSeiMessage;
     
     // This callback is triggered when the primary and backup streams switch.
     void Function(VeLivePlayerStreamType streamType, VeLivePlayerError? error)? onMainBackupSwitch;
   ```


<span id="26f4730d"></span>
## Getting the SDK version
```Dart
static Future<String?> getVersion();
```

<span id="a65c2aaa"></span>
## Setting the log level
Set the log level for logs printed to the console.
```Dart
enum VeLivePlayerLogLevel {
  // Output logs at VERBOSE, DEBUG, INFO, WARNING, and ERROR levels.
  verbose,
  // Output logs at DEBUG, INFO, WARNING, and ERROR levels.
  debug,
  // Output logs at INFO, WARNING, and ERROR levels.
  info,
  // Output logs at WARNING and ERROR levels.
  warn,
  // Output logs at ERROR level.
  error,
  // Disable log output.
  none,
}

static Future<void> setLogLevel(VeLivePlayerLogLevel level);
```



This topic describes how to implement the advanced features of the Player SDK for Flutter. You can implement complex features as needed, according to actual business requirements.
<span id="dd785362"></span>
## Prerequisites

* You have integrated and initialized the Player SDK for Flutter. For more information, see [Integrating the Player SDK for Flutter](/docs/byteplus-media-live/integrating-the-player-sdk-for-flutter) and [Initializing the Player SDK for Flutter](/docs/byteplus-media-live/initializing-the-player-sdk-for-flutter).
* You have integrated the basic features. For more information, see [Player SDK for Flutter: Basic Features](/docs/byteplus-media-live/player-sdk-for-flutter-basic-features).

<span id="c955251c"></span>
## Configuring multiple streams
To use the primary and backup streams and adaptive bitrate (ABR) features, you must call this method to configure multiple streams for the player.
```Dart
Future<void> setPlayStreamData(VeLivePlayerStreamData streamData);
```

:::tip
For type definitions, see [VeLivePlayerStreamData](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#dfb9d282).
:::
<span id="97511097"></span>
## Using primary and backup streams
Primary and backup streams are mainly used for disaster recovery in live rooms. By configuring both primary and backup stream addresses, these streams are utilized during the streaming and distribution stages. When integrating the player, configure both primary and backup stream addresses. If the primary stream address fails or encounters playback errors, the player automatically switches to the backup stream address for playback. Similarly, if playback from the backup stream address fails, the player switches back to the primary stream address. Primary and backup stream addresses can originate from the same live stream service provider or from different providers.
<span id="fc2a7ac7"></span>
### Integration preparation
Get the primary and backup stream addresses. If you use the BytePlus MediaLive service, you can generate primary and backup stream addresses through the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) in the BytePlus MediaLive console.
<span id="83e07645"></span>
### Integration steps

1. Configure the primary and backup stream addresses for playback. The sample code is as follows.
   ```Java
   // Set the primary stream address.
   VeLivePlayerStream mainStream = VeLivePlayerStream(url: 'https://pull.example.com/live/主.flv');
   mainStream.format = VeLivePlayerFormat.flv;
   mainStream.resolution = VeLivePlayerResolution.origin;
   mainStream.type = VeLivePlayerStreamType.main;
   
   // Set the backup stream address.
   VeLivePlayerStream backupStream = VeLivePlayerStream(url: 'https://pull.example.com/live/备.flv');
   backupStream.format = VeLivePlayerFormat.flv;
   backupStream.resolution = VeLivePlayerResolution.origin;
   backupStream.type = VeLivePlayerStreamType.backup;
   
   // Create the playback source.
   VeLivePlayerStreamData streamData = VeLivePlayerStreamData();
   
   // Enable primary and backup stream switching.
   streamData.enableMainBackupSwitch = true;
   
   // Add the primary stream.
   streamData.mainStream = [mainStream];
   // Add the backup stream.
   streamData.backupStream = [backupStream];
   
   // Configure the playback source.
   manager.setPlayStreamData(streamData);
   
   // Start playback.
   manager.play();
   ```

   :::tip
   For type definitions, see [VeLivePlayerStreamData](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#dfb9d282) and [VeLivePlayerStream](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#6c9e31fd).
   :::
2. When the player switches between primary and backup streams, a notification is sent via the `onMainBackupSwitch` callback of `VeLivePlayerObserver`. The sample code is as follows.
   ```Dart
   // This callback is triggered when the primary and backup streams switch.
   VeLivePlayerObserver observer = VeLivePlayerObserver(onMainBackupSwitch: (VeLivePlayerStreamType streamType, VeLivePlayerError? error) {
         _addItem('onMainBackupSwitch: $streamType, error:$error');
       });
   manager.setObserver(observer);
   ```


<span id="ae69d1e9"></span>
## ABR stream pulling
ABR is a streaming media transmission technology that uses a series of algorithms to dynamically switch between streams of different resolutions. This enables adaptation to changes in network bandwidth, prevents playback stuttering during the live stream, and improves playback quality and viewing experience.
:::tip
The ABR feature only applies to FLV streams.
:::
<span id="c07520a7"></span>
### Integration preparation
 Get the source stream and transcoded stream addresses for each resolution. If you use the BytePlus MediaLive service, log in to the console and complete the [transcoding configuration](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-configuring-transcoding) first. Then, get the pull stream address as follows.

* **Feature debugging phase**: You can use the [address generator](https://docs.byteplus.com/en/byteplus-media-live/docs/address-generator) to get the pull stream address.
* **Feature officially released**: Get the pull stream address by calling the API [GeneratePlayURL](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-generateplayurl-2023) or using the [server SDK](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-server-sdk).


The integration steps in this topic use the following pull stream addresses as an example.

| | | | \
|Resolution |Pull stream address |Bitrate (kbps) |
|---|---|---|
| | | | \
|Source stream (Origin) |`https://pull.example.com/live/123456.flv` |2500 |
| | | | \
|Ultra High Definition (UHD) |`https://pull.example.com/live/123456_uhd.flv` |2500 |
| | | | \
|High Definition (HD) |`https://pull.example.com/live/123456_hd.flv` |1000 |
| | | | \
|Standard Definition (SD) |`https://pull.example.com/live/123456_sd.flv` |800 |
| | | | \
|Low Definition (LD) |`https://pull.example.com/live/123456_ld.flv` |500 |

:::warning
Ensure that the bitrate settings for each resolution are consistent with the bitrate configured in the [transcoding configuration](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-configuring-transcoding).
:::
<span id="097e0679"></span>
### Integration steps

1. Configure stream addresses of different resolutions for playback. The sample code is as follows.
   ```Dart
   // Configure stream addresses of different resolutions.
   VeLivePlayerStream playStreamOrigin = VeLivePlayerStream(url: 'https://pull.example.com/live/123456.flv');
   playStreamOrigin.format = VeLivePlayerFormat.flv;
   playStreamOrigin.resolution = VeLivePlayerResolution.origin; // Original stream resolution.
   playStreamOrigin.type = VeLivePlayerStreamType.main; 
   playStreamOrigin.bitrate = 2500;
   
   VeLivePlayerStream playStreamUHD = VeLivePlayerStream(url: 'https://pull.example.com/live/123456_uhd.flv');
   playStreamOrigin.format = VeLivePlayerFormat.flv;
   playStreamOrigin.resolution = VeLivePlayerResolution.uhd; // UHD resolution.
   playStreamOrigin.type = VeLivePlayerStreamType.main;
   playStreamOrigin.bitrate = 2500;
   
   VeLivePlayerStream playStreamHD = VeLivePlayerStream(url: 'https://pull.example.com/live/123456_hd.flv');
   playStreamOrigin.format = VeLivePlayerFormat.flv;
   playStreamOrigin.resolution = VeLivePlayerResolution.hd; // HD resolution.
   playStreamOrigin.type = VeLivePlayerStreamType.main;
   playStreamOrigin.bitrate = 1000;
   
   VeLivePlayerStream playStreamSD = VeLivePlayerStream(url: 'https://pull.example.com/live/123456_sd.flv');
   playStreamOrigin.format = VeLivePlayerFormat.flv;
   playStreamOrigin.resolution = VeLivePlayerResolution.sd; // SD resolution.
   playStreamOrigin.type = VeLivePlayerStreamType.main;
   playStreamOrigin.bitrate = 800;
   
   VeLivePlayerStream playStreamLD = VeLivePlayerStream(url: 'https://pull.example.com/live/123456_ld.flv');
   playStreamOrigin.format = VeLivePlayerFormat.flv;
   playStreamOrigin.resolution = VeLivePlayerResolution.ld; // LD resolution.
   playStreamOrigin.type = VeLivePlayerStreamType.main;
   playStreamOrigin.bitrate = 500;
   
   // Create the playback source.
   VeLivePlayerStreamData streamData = VeLivePlayerStreamData();
   
   // Add streams of different resolutions.
   List<VeLivePlayerStream> streamList = [];
   streamList.add(playStreamOrigin);
   streamList.add(playStreamUHD);
   streamList.add(playStreamHD);
   streamList.add(playStreamSD);
   streamList.add(playStreamLD);
   streamData.mainStream = streamList;
   
   // Configure the default resolution used when playback starts. In the following example, configure the default resolution to the original stream resolution.
   streamData.defaultResolution = VeLivePlayerResolution.origin;
   
   // Enable the ABR feature.
   streamData.enableABR = true;
   
   // Configure the playback source.
   manager.setPlayStreamData(streamData);
   
   // Start playback.
   manager.play();
   ```

   :::tip
   For type definitions, see [VeLivePlayerStreamData](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#dfb9d282) and [VeLivePlayerStream](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#6c9e31fd).
   :::
2. When the resolution switches automatically, a notification is sent via the  `onResolutionSwitch` callback of `VeLivePlayerObserver`. The sample code is as follows.
   ```Dart
   VeLivePlayerObserver observer = VeLivePlayerObserver(onResolutionSwitch:
           (VeLivePlayerResolution resolution, VeLivePlayerError? error,
               VeLivePlayerResolutionSwitchReason reason) {
         print('onResolutionSwitch: $resolution');
       });
   manager.setObserver(observer);
   ```




<span id="dfb9d282"></span>
# VeLivePlayerStreamData
```Dart
class VeLivePlayerStreamData {
  bool? enableABR;
  bool? enableMainBackupSwitch;
  VeLivePlayerResolution? defaultResolution;
  VeLivePlayerFormat? defaultFormat;
  VeLivePlayerProtocol? defaultProtocol;
  List<VeLivePlayerStream>? mainStream;
  List<VeLivePlayerStream>? backupStream;

  VeLivePlayerStreamData({
    this.enableABR,
    this.enableMainBackupSwitch,
    this.defaultResolution,
    this.defaultFormat,
    this.defaultProtocol,
    this.mainStream,
    this.backupStream,
  });
} 
```

The configurations for the playback URL.
<span id="453345bb"></span>
## Member Property
<span id="9d48e75c"></span>
### enableABR
```Dart
bool? enableABR;
```

Whether to enable the adaptive bitrate (ABR) feature. The default value is `false`. Valid values:

* `true`: Enable.
* `false`: Disable.

<span id="43df963c"></span>
### enableMainBackupSwitch
```Dart
bool? enableMainBackupSwitch;
```

Whether to enable the primary and backup streams feature. The default value is `false`. Valid values:

* `true`: Enable.
* `false`: Disable.

<span id="82b62d43"></span>
### defaultResolution
```Dart
VeLivePlayerResolution? defaultResolution;
```

The player's default resolution. The default value is the original stream resolution. For more information, see [VeLivePlayerResolution](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#42f7c972).
<span id="74cbd102"></span>
### defaultFormat
```Dart
VeLivePlayerFormat? defaultFormat;
```

The player's default playback format. The default value is FLV. For more information, see [VeLivePlayerFormat](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#53fdcf30).
<span id="ae27a644"></span>
### defaultProtocol
```Dart
VeLivePlayerProtocol? defaultProtocol;
```

The player's default transport layer protocol for playback. The default value is TCP. For more information, see [VeLivePlayerProtocol](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#0386f298).
<span id="229168d0"></span>
### mainStream
```Dart
List<VeLivePlayerStream>? mainStream;
```

A list of primary stream addresses. For more information, see [VeLivePlayerStream](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#6c9e31fd).
<span id="f3209eee"></span>
### backupStream
```Dart
List<VeLivePlayerStream>? backupStream;
```

A list of backup stream addresses. For more information, see [VeLivePlayerStream](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#6c9e31fd).
<span id="6c9e31fd"></span>
# VeLivePlayerStream
```Dart
class VeLivePlayerStream {
  String url;
  VeLivePlayerResolution? resolution;
  int? bitrate;
  VeLivePlayerProtocol? protocol;
  VeLivePlayerFormat? format;
  VeLivePlayerStreamType? type;

  VeLivePlayerStream({
    required this.url,
    this.resolution,
    this.bitrate,
    this.protocol,
    this.format,
    this.type,
  });
}
```

Stream address information.
<span id="e9bed6a9"></span>
## Member Property
<span id="5dfebbf4"></span>
### url
```Dart
String url;
```

Playback URL.
<span id="77fc1c4e"></span>
### resolution
```Dart
VeLivePlayerResolution? resolution;
```

The resolution. The default value is the original stream resolution. For more information, see [VeLivePlayerResolution](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#42f7c972).
<span id="2e233c67"></span>
### bitrate
```Dart
int? bitrate;
```

Playback bitrate, measured in kbps.
<span id="035cf9b4"></span>
### protocol
```Dart
VeLivePlayerProtocol? protocol;
```

Transport layer protocol. The default value is TCP. For more information, see [VeLivePlayerProtocol](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#0386f298).
<span id="abdb3c73"></span>
### format
```Dart
VeLivePlayerFormat? format;
```

Playback format. The default value is FLV. For more information, see [VeLivePlayerFormat](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#53fdcf30).
<span id="7772b028"></span>
### type
```Dart
VeLivePlayerStreamType? type;
```

The playback stream type, which is either primary stream or backup stream. The default value is primary stream. For more information, see [VeLivePlayerStreamType](/docs/byteplus-media-live/player-sdk-for-flutter-type-definitions#bcf3b0e9).
<span id="42f7c972"></span>
# VeLivePlayerResolution
```Dart
enum VeLivePlayerResolution {
  origin, 
  uhd, 
  hd, 
  sd, 
  ld, 
}
```

The player's resolution. 
<span id="effe48af"></span>
## Enumerated Value

| | | | \
|Type |Value |Description |
|---|---|---|
| | | | \
|origin |0 |Original stream. |
| | | | \
|uhd |1 |Ultra High Definition (UHD). |
| | | | \
|hd |2 |High Definition (HD). |
| | | | \
|sd |3 |Standard Definition (SD). |
| | | | \
|ld |4 |Low Definition (LD). |

<span id="53fdcf30"></span>
# VeLivePlayerFormat
```Dart
enum VeLivePlayerFormat {
  flv, 
  hls, 
  rtm, 
}
```

Playback format.
<span id="41d65f5e"></span>
## Enumerated Value

| | | | \
|Type |Value |Description |
|---|---|---|
| | | | \
|flv |0 |FLV format. |
| | | | \
|hls |1 |HLS format. |
| | | | \
|rtm |2 |RTM format. |

<span id="0386f298"></span>
# VeLivePlayerProtocol
```Dart
enum VeLivePlayerProtocol {
  tcp, 
  quic, 
  tls, 
}
```

Transport layer protocol.
<span id="303313fc"></span>
## Enumerated Value

| | | | \
|Type |Value |Description |
|---|---|---|
| | | | \
|tcp |0 |Transmission Control Protocol (TCP). |
| | | | \
|quic |1 |QUIC protocol. |
| | | | \
|tls |2 |TLS protocol. |

<span id="bcf3b0e9"></span>
# VeLivePlayerStreamType
```Dart
enum VeLivePlayerStreamType {
  main, 
  backup, 
}
```

Playback stream type.
<span id="93b62d79"></span>
## Enumerated Value

| | | | \
|Type |Value |Description |
|---|---|---|
| | | | \
|main |0 |Primary stream. |
| | | | \
|backup |1 |Backup stream. |


Interactive live streaming incorporates interactive features into the standard live streaming experience. This includes activities such as host PK battle and co-hosting with audience members, providing a more engaging experience than standard live streaming that only allows interaction through text chat and virtual gifts. Interactive live streaming brings the host and audience closer together, resulting in a more immersive and enjoyable experience for both parties.
<span id="10711d95"></span>
## Demo app and project
To experience interactive live streaming, you can download the [BytePlus VideoOne demo app](https://docs.byteplus.com/en/docs/byteplus-vos/docs-byteplus-videoone-demo-app_1). The interactive live streaming demo can be launched by clicking the **Interactive Live** tab on the homepage.
Furthermore, you have the option to access the source code of the demo app and create your own customized app. Refer to [Running VeLiveQuickStartDemo for Android](/docs/byteplus-media-live/docs-running-the-quickstartdemo-for-android) and [Running VeLiveQuickStartDemo for iOS](/docs/byteplus-media-live/docs-running-the-quickstartdemo-for-ios) for detailed instructions on running the demo.
<span id="faa3f50c"></span>
## Billing
This solution results in fees for both live-streaming and RTC services. For details, refer to [BytePlus MediaLive pricing overview](https://docs.byteplus.com/en/byteplus-media-live/docs/overview-1) and [RTC service fees](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-69871).
<span id="d4261921"></span>
## Highlights

* This solution is optimized for live streaming that involves occasional co-hosting.
* This solution is more cost-effective, as RTC service fees are charged only during co-hosting.

<span id="46673005"></span>
## Architecture
To implement the interactive live streaming solution, you need to integrate the BytePlus MediaLive SDK, [enable the RTC service](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-69865), and integrate the RTC SDK. This solution provides stream pushing and pulling capabilities through the BytePlus MediaLive SDK, and offers real-time interaction within rooms through the RTC SDK. It supports not only standard stream pushing and pulling, but also interactive features such as co-hosting with the audience and host PK battle.
This section introduces the technical architecture of the solution.
<span id="689b52c7"></span>
### Solo hosting
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/76e8cb884be342c387bf29c54565efb4~tplv-goo7wpa0wc-image.image =864x)
In solo hosting, the RTC engine handles the task of audio and video capture, preview, and beauty AR. The captured audio and video data is then sent to the live pusher, which is responsible for encoding and streaming the audio and video data.
<span id="58dc90a1"></span>
### Co-hosting with audience members
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/cc542f7e73d14bfa9b181c26d783d857~tplv-goo7wpa0wc-image.image =705x)

* When the host begins co-hosting with audience members, the live pusher stops encoding and streaming, and the RTC engine starts pushing the mixed stream to CDN, which involves mixing the host's and co-hosts' streams on the RTC server side and pushing the mixed stream to CDN.
* During this process, the host receives the audio and video sent from the co-hosts
* The audience can watch the mixed stream on their apps.
* Once co-hosting stops, `solo-hosting` mode resumes.

<span id="e95438c7"></span>
### Host PK battle
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/c451bb10d87d4a6e80887db5924c0ecf~tplv-goo7wpa0wc-image.image =864x)

* When the host begins a host PK battle, the live pusher stops encoding and streaming, and the RTC engine starts pushing the mixed stream to CDN, which involves mixing the streams of host A and B on the RTC server side and pushing the mixed stream to CDN.
* During this process, host A receives the audio and video sent from host B. 
* The audience can watch the mixed stream on their apps.
* Once the host PK battle stops, `solo-hosting` mode resumes.

<span id="bdf23751"></span>
## Implementation
For details about how to implement the solution in your own app, refer to the following topics:

* [Implementing interactive live for Android](/docs/byteplus-media-live/docs-implementing-interactive-live-for-android)
* [Implementing interactive live for iOS](/docs/byteplus-media-live/docs-implementing-interactive-live-for-ios)


This article introduces how to implement the interactive live streaming feature in your Android app.
<span id="250d8510"></span>
## Prerequisites

* A valid [BytePlus account](http://console.byteplus.com/) with [BytePlus MediaLive](https://console.byteplus.com/live) and [BytePlus RTC](https://console.byteplus.com/rtc/workplaceRTC) activated.
* You have completed the [basic setup for live streaming](https://docs.byteplus.com/en/byteplus-media-live/docs/getting-started).
* You have [integrated](https://docs.byteplus.com/en/byteplus-media-live/docs/integrating-the-broadcast-and-player-sdks-for-android) and [initialized](https://docs.byteplus.com/en/byteplus-media-live/docs/initializing-for-android) the BytePlus MediaLive Broadcast and Player SDKs. 

<span id="26ef7ec3"></span>
## Add RTC SDK
You need add RTC SDK related dependencies for using the interactive live function. Please [create a ticket](https://console.byteplus.com/workorder/create?step=2&SubProductID=P00000980) to contact technical support to get the integration method of the adapted version SDK.
:::tip
If there are conflicts between the Native libraries of BytePlus MediaLive SDK and RTC SDK, refer to the dependency management solution in [VeLiveQuickStartDemo](https://github.com/byteplus-sdk/VeLiveQuickStartDemo).
:::
<span id="443c7f23"></span>
## Implementing the feature for the host
This section provides instructions on implementing the interactive live streaming feature for the host.
<span id="33f82960"></span>
### Starting the live stream
The host uses both the RTC engine and the live pusher to start a stream.
**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/6d2468a6cfeb444b9899d8a4dc6c315c~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Create an RTC engine, set the local preview, and configure the encoding parameters.

```Java
// Initialize the RTCVideo object
mRTCVideo = RTCVideo.createRTCVideo(Env.getApplicationContext(), mAppId, mRTCVideoEventHandler, null, null);

// Set the local preview
VideoCanvas videoCanvas = new VideoCanvas();
// renderView is the local user preview view, which needs to be created, laid out, and assigned to videoCanvas
videoCanvas.renderView = renderView;
videoCanvas.renderMode = VideoCanvas.RENDER_MODE_HIDDEN;
mRTCVideo.setLocalVideoCanvas(StreamIndex.STREAM_INDEX_MAIN, videoCanvas);

// Set the video encoding parameters
VideoEncoderConfig config = new VideoEncoderConfig(
        mConfig.mVideoEncoderWidth, mConfig.mVideoEncoderHeight, mConfig.mVideoEncoderFps, mConfig.mVideoEncoderKBitrate * 1000);
mRTCVideo.setVideoEncoderConfig(config);   
```


2. Subscribe to the local audio and video data captured with the RTC engine.

```Java
// Subscribe to the local video data
mRTCVideo.setLocalVideoSink(StreamIndex.STREAM_INDEX_MAIN, mVideoFrameListener, IVideoSink.PixelFormat.I420);

// Subscribe to the local audio data
mRTCVideo.enableAudioFrameCallback(AudioFrameCallbackMethod.AUDIO_FRAME_CALLBACK_RECORD, new AudioFormat(changeSampleRate(mConfig.mAudioCaptureSampleRate), changeChannel(mConfig.mAudioCaptureChannel)));
mRTCVideo.registerAudioFrameObserver(mAudioFrameListener);
```


3. Create a live pusher and configure the encoding parameters for stream pushing.

```Java
// Create a live pusher
// Create the configuration for stream pushing 
VeLivePusherConfiguration config = new VeLivePusherConfiguration();
//  Configure the application context 
config.setContext(Env.getApplicationContext());
//  Number of times to reconnect after the initial attempts fail 
config.setReconnectCount(10);
//  Initialize the live pusher  
mLivePusher = config.build();

// Configure parameters for stream pushing
// Configure the encoding settings
VeLivePusherDef.VeLiveVideoEncoderConfiguration videoEncoderCfg = new VeLivePusherDef.VeLiveVideoEncoderConfiguration();
// Configure video resolution. The optimal bitrate parameters will be set automatically based on the configured resolution. 
videoEncoderCfg.setResolution(VeLiveVideoResolution720P);
//  Initial video encoding bitrate
videoEncoderCfg.setBitrate(mConfig.mVideoEncoderKBitrate);
//  Maximum video encoding bitrate
videoEncoderCfg.setMaxBitrate(mConfig.mVideoEncoderKBitrate);
//  Minimum video encoding bitrate 
videoEncoderCfg.setMinBitrate(mConfig.mVideoEncoderKBitrate);
//  Hardware encoding 
videoEncoderCfg.setEnableAccelerate(mConfig.mIsVideoHardwareEncoder);
//  Frame rate 
videoEncoderCfg.setFps(mConfig.mVideoEncoderFps);

VeLivePusherDef.VeLiveAudioEncoderConfiguration audioEncoderCfg = new VeLivePusherDef.VeLiveAudioEncoderConfiguration();
//  Audio sample rate
if (mConfig.mAudioEncoderSampleRate == 32000) {
    audioEncoderCfg.setSampleRate(VeLiveAudioSampleRate32000);
} else if (mConfig.mAudioEncoderSampleRate == 48000) {
    audioEncoderCfg.setSampleRate(VeLiveAudioSampleRate48000);
} else {
    audioEncoderCfg.setSampleRate(VeLiveAudioSampleRate44100);
}

//  Number of audio channels
if (mConfig.mAudioEncoderChannel == 1) {
    audioEncoderCfg.setChannel(VeLiveAudioChannelMono);
} else {
    audioEncoderCfg.setChannel(VeLiveAudioChannelStereo);
}

//  Audio encoding bitrate
audioEncoderCfg.setBitrate(mConfig.mAudioEncoderKBitrate);

//  Set the video encoding configurations  
mLivePusher.setVideoEncoderConfiguration(videoEncoderCfg);
//  Set the audio encoding configurations
mLivePusher.setAudioEncoderConfiguration(audioEncoderCfg);

//  Start video capture 
mLivePusher.startVideoCapture(VeLiveVideoCaptureExternal);
//  Start audio capture   
mLivePusher.startAudioCapture(VeLiveAudioCaptureExternal);
```


4. Start audio and video capture with the RTC engine.

```Java
// Start video capture
mRTCVideo.startVideoCapture();

// Start audio capture
mRTCVideo.startAudioCapture();
```


5. Start stream pushing with the live pusher.

```Java
// Start stream pushing. Set 'url' to an RTMP push stream address.
mLivePusher.startPush(url);
```


6. Send the local audio and video data captured with the RTC engine to the live pusher.

```Java
// Send the local video data to the live pusher
IVideoSink mVideoFrameListener = new IVideoSink() {
    @Override
    public void onFrame(com.ss.bytertc.engine.video.VideoFrame frame) {
        final int width = videoFrame.getWidth();
        final int height = videoFrame.getHeight();
        final int chromaHeight = (height + 1) / 2;
        final int chromaWidth = (width + 1) / 2;
        int bufferSize = width * height + chromaWidth * chromaHeight * 2;
        final ByteBuffer dstBuffer = ByteBuffer.allocateDirect(bufferSize);

        YuvHelper.I420Rotate(videoFrame.getPlaneData(0), videoFrame.getPlaneStride(0),
                videoFrame.getPlaneData(1), videoFrame.getPlaneStride(1),
                videoFrame.getPlaneData(2), videoFrame.getPlaneStride(2),
                dstBuffer,width, height,videoFrame.getRotation().value());

        dstBuffer.position(0);
        VeLiveVideoFrame videoFrame1 = new VeLiveVideoFrame(width, height, System.currentTimeMillis() * 1000, dstBuffer);
        mLivePusher.pushExternalVideoFrame(videoFrame1);
        videoFrame1.release();
        frame.release();
    }
};
// Send the local audio data to the live pusher
mAudioFrameListener = new IAudioFrameObserver() {
    @Override
    public void onRecordAudioFrame(IAudioFrame audioFrame) {
        VeLiveAudioFrame audioFrame = new VeLiveAudioFrame(VeLivePusherDef.VeLiveAudioSampleRate.fromValue(sampleRate, VeLiveAudioSampleRate44100),
        VeLivePusherDef.VeLiveAudioChannel.fromValue(channels, VeLiveAudioChannelStereo),
        timestamp,
        byteBuffer);
        mLivePusher.pushExternalAudioFrame(audioFrame);
    }

};
```

<span id="30638173"></span>
### Enabling beauty AR（Optional）
Refer to [Effects](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-114717) for detailed instructions on how to implement beauty AR by using the RTC engine.
<span id="8488d95c"></span>
### Enabling co-hosting
To co-host either with audience members or a host from another live room (host PK battle), do the following:

1. Stop streaming with the live pusher.
2. Join an RTC room.
3. Enable pushing mixed RTC streams to CDN.

**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/9e676e35020847a99a67940ae4d654d1~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Stop streaming with the live pusher.

```Java
mLivePusher.stopPush();
```


2. Create an RTC room, set the user information, and join the room. Refer to [Authentication with Token](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-70121) for details about how to get the token from the app server.

```Java
// Create an RTC room
mRTCRoom = mRTCVideo.createRTCRoom(roomId);
mRTCRoom.setRTCRoomEventHandler(mIRtcRoomEventHandler);

// Set the user information
mUserId = userId;
mRoomId = roomId;
UserInfo userInfo = new UserInfo(userId, null);
RTCRoomConfig roomConfig = new RTCRoomConfig(ChannelProfile.CHANNEL_PROFILE_COMMUNICATION,
        true, true, true);
        
// Join the room. Get the token from the app server.
mRTCRoom.joinRoom(token, userInfo, roomConfig);
```


3. Start pushing mixed RTC streams to CDN after receiving the notification of a successful join room.

```Java
// Notification of a successful join room
private RtcRoomEventHandlerAdapter mIRtcRoomEventHandler = new RtcRoomEventHandlerAdapter() {
    @Override
    public void onRoomStateChanged(String roomId, String uid, int state, String extraInfo) {
        // Create a stream mixing configuration instance
        mMixedStreamConfig = MixedStreamConfig.defaultMixedStreamConfig();
        mMixedStreamConfig.setRoomID(mRoomId);
        mMixedStreamConfig.setUserID(mUserId);
        
        // Configure to mix streams on the server side
        mMixedStreamConfig.setExpectedMixingType(STREAM_MIXING_BY_SERVER);
        
        // Set the URL to the RTMP push stream address
        mMixedStreamConfig.setPushURL(mPushUrl);
        
        // Set the video encoding parameters for the mixed stream. The parameters must be consistent with the encoding parameters for pushing the video stream.
        MixedStreamConfig.MixedStreamVideoConfig videoConfig = mMixedStreamConfig.getVideoConfig();
        // Set the width
        videoConfig.setWidth(mConfig.mVideoEncoderWidth);
        // Set the height
        videoConfig.setHeight(mConfig.mVideoEncoderHeight);
        // Set the frame rate
        videoConfig.setFps(mConfig.mVideoEncoderFps);
        // Set the bitrate
        videoConfig.setBitrate(mConfig.mVideoEncoderKBitrate);
        mMixedStreamConfig.setVideo(videoConfig);
        
        // Set the audio encoding parameters for the mixed stream. The parameters must be consistent with the encoding parameters for pushing audio stream.
        MixedStreamConfig.MixedStreamAudioConfig audioConfig = mMixedStreamConfig.getAudioConfig();
        // Set the sample rate
        audioConfig.setSampleRate(mConfig.mAudioEncoderSampleRate);
        // Set the number of channels
        audioConfig.setChannels(mConfig.mAudioEncoderChannel);
        // Set the bitrate
        audioConfig.setBitrate(mConfig.mAudioEncoderKBitrate);
        // Configure the audio parameters
        mMixedStreamConfig.setAudioConfig(audioConfig);
     
        MixedStreamConfig.MixedStreamLayoutConfig layout = new MixedStreamConfig.MixedStreamLayoutConfig();
        // Set the layout information for the host
        MixedStreamConfig.MixedStreamLayoutRegionConfig[] regions = new MixedStreamConfig.MixedStreamLayoutRegionConfig[1];
        MixedStreamConfig.MixedStreamLayoutRegionConfig region = new MixedStreamConfig.MixedStreamLayoutRegionConfig();
        region.setUserID(mUserId); // The user ID of the host
        region.setRoomID(mRoomId);
        region.setIsLocalUser(true);
        region.setLocationX(0.0); // For reference only
        region.setLocationY(0.0); // For reference only
        region.setWidthProportion(1); // For reference only
        region.setHeightProportion(1); // For reference only
        region.setZOrder(0); // For reference only
        region.setAlpha(1); // For reference only
        region.setRenderMode(MixedStreamConfig.MixedStreamRenderMode.MIXED_STREAM_RENDER_MODE_HIDDEN);
        
        regions[0] = region;
        layout.setRegions(regions);
                
        // Set the overall layout of the mixed stream
        mMixedStreamConfig.setLayout(layout);
        
        // Set the ID for the push to CDN task
        String taskId = "";
    
        // Start pushing the mixed RTC stream to CDN
        mRTCVideo.startPushMixedStreamToCDN(taskId, mMixedStreamConfig, mIMixedStreamObserver);
    }
}
```


4. Adjust the view and modify the layout of the mixed stream after receiving notifications about co-hosts' stream-publishing status.

```Java
private RtcRoomEventHandlerAdapter mIRtcRoomEventHandler = new RtcRoomEventHandlerAdapter() {
    @Override
    public void onUserPublishStream(String uid, MediaStreamType type) {
        if (type == RTC_MEDIA_STREAM_TYPE_VIDEO || type == RTC_MEDIA_STREAM_TYPE_BOTH) {
            // Add the view to render the co-host's video
            TextureView renderView = new TextureView(Env.getApplicationContext());
            VideoCanvas canvas = new VideoCanvas();
            canvas.renderView = renderView;
            canvas.renderMode = RENDER_MODE_HIDDEN;
            RemoteStreamKey key = new RemoteStreamKey(mRoomId, uid, StreamIndex.STREAM_INDEX_MAIN);
            mRTCVideo.setRemoteVideoCanvas(key, canvas);
        }

        MixedStreamConfig.MixedStreamLayoutRegionConfig[] regions = new MixedStreamConfig.MixedStreamLayoutRegionConfig[2];
        
        // Modify the layout information for the host
        MixedStreamConfig.MixedStreamLayoutRegionConfig region = new MixedStreamConfig.MixedStreamLayoutRegionConfig();
        region.setUserID(mUserId); // The user ID of the host
        region.setRoomID(mRoomId);
        region.setIsLocalUser(true);
        region.setLocationX(0.0); //For reference only
        region.setLocationY(0.0); //For reference only
        region.setWidthProportion(0.5); //For reference only
        region.setHeightProportion(0.5); //For reference only
        region.setAlpha(1.0); //For reference only
        region.setZOrder(0); //For reference only
        region.setRenderMode(MixedStreamConfig.MixedStreamRenderMode.MIXED_STREAM_RENDER_MODE_HIDDEN);
        regions[0] = region;
        
        // Modify the layout information for the users
        MixedStreamConfig.MixedStreamLayoutRegionConfig regionRemote = new MixedStreamConfig.MixedStreamLayoutRegionConfig();
        regionRemote.setUserID(uid); // The user ID
        regionRemote.setRoomID(mRoomId);
        regionRemote.setIsLocalUser(false);
        regionRemote.setLocationX(0.0); //For reference only
        regionRemote.setLocationY(0.0); //For reference only
        regionRemote.setWidthProportion(0.5); //For reference only
        regionRemote.setHeightProportion(0.5); //For reference only
        regionRemote.setAlpha(1.0); //For reference only
        regionRemote.setZOrder(0); //For reference only
        regionRemote.setRenderMode(MixedStreamConfig.MixedStreamRenderMode.MIXED_STREAM_RENDER_MODE_HIDDEN);
        regions[1] = regionRemote;
          
        // Set the overall layout of the mixed stream
        MixedStreamConfig.MixedStreamLayoutConfig layout = new MixedStreamConfig.MixedStreamLayoutConfig();
        layout.setRegions(regions);
        
         // Set the ID for the push to CDN task
        String taskId = "";
        
        mMixedStreamConfig.setLayout(layout);
        // Update the push to CDN task
        mRTCVideo.updatePushMixedStreamToCDN(taskId, mMixedStreamConfig);
    }

    @Override
    public void onUserUnpublishStream(String uid, MediaStreamType type, StreamRemoveReason reason) {
        if (type == RTC_MEDIA_STREAM_TYPE_VIDEO || type == RTC_MEDIA_STREAM_TYPE_BOTH) {
            // Remove the view that renders the co-host's video
            VideoCanvas canvas = new VideoCanvas();
            canvas.renderView = null;
            canvas.renderMode = RENDER_MODE_HIDDEN;
            RemoteStreamKey key = new RemoteStreamKey(mRoomId, uid, StreamIndex.STREAM_INDEX_MAIN);
            mRTCVideo.setRemoteVideoCanvas(key, canvas);
        }
        MixedStreamConfig.MixedStreamLayoutConfig layout = new MixedStreamConfig.MixedStreamLayoutConfig();
        // Modify the layout information of the host
        MixedStreamConfig.MixedStreamLayoutRegionConfig[] regions = new MixedStreamConfig.MixedStreamLayoutRegionConfig[1];
        MixedStreamConfig.MixedStreamLayoutRegionConfig region = new MixedStreamConfig.MixedStreamLayoutRegionConfig();
        region.setUserID(mUserId); // The user ID of the host
        region.setRoomID(mRoomId);
        region.setIsLocalUser(true);
        region.setLocationX(0.0); // For reference only
        region.setLocationY(0.0); // For reference only
        region.setWidthProportion(1); // For reference only
        region.setHeightProportion(1); // For reference only
        region.setZOrder(0); // For reference only
        region.setAlpha(1); // For reference only
        region.setRenderMode(MixedStreamConfig.MixedStreamRenderMode.MIXED_STREAM_RENDER_MODE_HIDDEN);
        
        regions[0] = region;
        layout.setRegions(regions);
                
        // Set the overall layout of the mixed stream
        mMixedStreamConfig.setLayout(layout);
        
        // Set the ID for the push to CDN task
        String taskId = "";
        
        // Update the push to CDN task
        mRTCVideo.updatePushMixedStreamToCDN(taskId, mLiveTranscoding);
    }
};
```

<span id="fe3b48c1"></span>
### Ending co-hosting
To stop co-hosting, do the following:

1. Stop pushing mixed RTC streams to CDN and leave the RTC room.
2. Start streaming with the live pusher.

**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/21d75f80fd6444bf879f0b344e3b86bc~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Stop pushing mixed RTC streams to CDN, leave the RTC room, and remove the view that renders the co-host's video.

```Java
// Stop pushing mixed RTC streams to CDN
mRTCVideo.stopPushStreamToCDN(taskId);

// Leave the RTC room
mRTCRoom.leaveRoom();

// Remove the view that renders the co-host's video
VideoCanvas canvas = new VideoCanvas();
canvas.renderView = null;
canvas.renderMode = RENDER_MODE_HIDDEN;
RemoteStreamKey key = new RemoteStreamKey(mRoomId, uid, StreamIndex.STREAM_INDEX_MAIN);
mRTCVideo.setRemoteVideoCanvas(key, canvas);
```


2. Start streaming with the live pusher.

```Java
mLivePusher.startPush(url);
```

<span id="378d4bff"></span>
### Ending the live stream
To end the live stream, stop the stream and destroy the RTC engine and the live pusher.
**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/62a2b0d6011845e28762b7003aa1d00f~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Stop pushing the live stream and destroy the live pusher.

```Java
// Stop pushing the live stream
mLivePusher.stopPush();

// Destroy the live pusher
mLivePusher.release();
mLivePusher = null;
```


2. Stop audio and video capture with the RTC engine and remove the local preview.

```Java
// Stop video capture
mRTCVideo.stopVideoCapture();

// Stop audio capture
mRTCVideo.stopAudioCapture();

// Remove the local preview
VideoCanvas videoCanvas = new VideoCanvas();
videoCanvas.renderView = null;
videoCanvas.renderMode = VideoCanvas.RENDER_MODE_HIDDEN;
mRTCVideo.setLocalVideoCanvas(StreamIndex.STREAM_INDEX_MAIN, videoCanvas);
```


3. Destroy the RTC room and RTC engine.

```Java
// Destroy the RTC room
mRTCRoom.destroy();
mRTCRoom = null;

// Destroy the RTC engine
RTCVideo.destroyRTCVideo();
mRTCVideo = null;
```

<span id="cc71d755"></span>
## Implementing the feature for the audience
This section provides instructions on implementing the interactive live streaming feature for the audience.
<span id="935dd891"></span>
### Playing the live stream
Use the live player to pull and play the live stream.
**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/07fe2ef1592e454ca66e7176e188d06b~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Create a live player and configure it.

```Java
// Create a player
VeLivePlayer mLivePlayer = new VideoLiveManager(Env.getApplicationContext());

// Set the player observer
mLivePlayer.setObserver(mLivePlayerObserver);

// Configure the player
VeLivePlayerConfiguration config = new VeLivePlayerConfiguration();
config.enableStatisticsCallback = true;
config.enableLiveDNS = true;
mLivePlayer.setConfig(config);
```


2. Set the view for the player, set the pull stream address, and start playing.

```Java
// Set the view for the player
mLivePlayer.setSurfaceHolder(holder);

// Set the pull stream address
mLivePlayer.setPlayUrl(mPullUrl);

// Start playing
mLivePlayer.play();
```

<span id="3d9d3f43"></span>
### Becoming a co-host
To become a co-host, stop playing the live stream with the live player, and co-host with the RTC engine.
**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/2798b93a5a4a4e3daa4e11761b51a68f~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Stop playing the live stream and remove the view for the live player.

```Java
// Stop playing the live stream
mLivePlayer.stop();

// Remove the view for the live player
mLocalVideoContainer.removeView(mPlayerView);
```


2. Create an RTC engine and set the local preview and video encoding parameters.

```Java
// Initialize the RTCVideo object
mRTCVideo = RTCVideo.createRTCVideo(Env.getApplicationContext(), mAppId, mRTCVideoEventHandler, null, null);

// Set the local preview
VideoCanvas videoCanvas = new VideoCanvas();
// renderView is a preview view for local users, which needs to be created, laid out and assigned to VideoCanvas by yourself.
videoCanvas.renderView = renderView;
videoCanvas.renderMode = VideoCanvas.RENDER_MODE_HIDDEN;
mRTCVideo.setLocalVideoCanvas(StreamIndex.STREAM_INDEX_MAIN, videoCanvas);

// Set the video encoding parameters
VideoEncoderConfig config = new VideoEncoderConfig(
        mConfig.mVideoEncoderWidth, mConfig.mVideoEncoderHeight, mConfig.mVideoEncoderFps, mConfig.mVideoEncoderKBitrate * 1000);
mRTCVideo.setVideoEncoderConfig(config);
```


3. Start audio and video capture with the RTC engine.

```Java
// Start video capture
mRTCVideo.startVideoCapture();

// Start audio capture
mRTCVideo.startAudioCapture();
```


4. Create an RTC room, set the user information, and join the RTC room. Refer to [Authentication with Token](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-70121) for details about how to get the token from the app server.

```Java
// Create an RTC room
mRTCRoom = mRTCVideo.createRTCRoom(roomId);
mRTCRoom.setRTCRoomEventHandler(mIRtcRoomEventHandler);

 // Set the user information
UserInfo userInfo = new UserInfo(userId, null);
RTCRoomConfig roomConfig = new RTCRoomConfig(ChannelProfile.CHANNEL_PROFILE_COMMUNICATION,
        true, true, true);
    
// Join the room. Get the token from the app server.
mRTCRoom.joinRoom(token, userInfo, roomConfig);
```


5. Add or remove the views for other co-hosts when receiving notifications about their stream-publishing status.

```Java
private RtcRoomEventHandlerAdapter mIRtcRoomEventHandler = new RtcRoomEventHandlerAdapter() {
    @Override
    public void onUserPublishStream(String uid, MediaStreamType type) {
        if (type == RTC_MEDIA_STREAM_TYPE_VIDEO || type == RTC_MEDIA_STREAM_TYPE_BOTH) {
            // Add the view to render the co-host's video
            TextureView renderView = new TextureView(Env.getApplicationContext());
            VideoCanvas canvas = new VideoCanvas();
            canvas.renderView = renderView;
            canvas.renderMode = RENDER_MODE_HIDDEN;
            RemoteStreamKey key = new RemoteStreamKey(mRoomId, uid, StreamIndex.STREAM_INDEX_MAIN);
            mRTCVideo.setRemoteVideoCanvas(key, canvas);
        }          
    }

    @Override
    public void onUserUnpublishStream(String uid, MediaStreamType type, StreamRemoveReason reason) {
        if (type == RTC_MEDIA_STREAM_TYPE_VIDEO || type == RTC_MEDIA_STREAM_TYPE_BOTH) {
            // Remove the view for the co-host
            VideoCanvas canvas = new VideoCanvas();
            canvas.renderView = null;
            canvas.renderMode = RENDER_MODE_HIDDEN;
            RemoteStreamKey key = new RemoteStreamKey(mRoomId, uid, StreamIndex.STREAM_INDEX_MAIN);
            mRTCVideo.setRemoteVideoCanvas(key, canvas);
        }
    }
};
```

<span id="b48aaf74"></span>
### Enabling beauty AR（Optional）
Refer to [Effects](https://docs.byteplus.com/en/docs/byteplus-rtc/docs-114717) for detailed instructions on how to implement beauty AR by using the RTC engine.
<span id="3769bba5"></span>
### Ending co-hosting
To return to being a regular audience member, stop co-hosting with the RTC engine and resume playing the live stream with the live player.
**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/52c74882d735487d97bf9b080854de4b~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Leave the RTC room, stop audio and video capture with the RTC engine, and remove the local and remote views.

```Java
// Leave the RTC room
mRTCRoom.leaveRoom();

// Stop video capture
mRTCVideo.stopVideoCapture();

// Stop audio capture
mRTCVideo.stopAudioCapture();

// Remove the local preview
VideoCanvas canvas = new VideoCanvas(null, RENDER_MODE_HIDDEN, mRoomId, mUserId, false);
mRTCVideo.setLocalVideoCanvas(mUserId, StreamIndex.STREAM_INDEX_MAIN, canvas);

// Remove the remote views
VideoCanvas canvas = new VideoCanvas();
canvas.renderView = null;
canvas.renderMode = RENDER_MODE_HIDDEN;
RemoteStreamKey key = new RemoteStreamKey(mRoomId, uid, StreamIndex.STREAM_INDEX_MAIN);
mRTCVideo.setRemoteVideoCanvas(key, canvas);
```


2. Set the view for the player and start playing the live stream.

```Java
// Set the view for the player
mLivePlayer.setSurfaceHolder(holder);
// Start playing the live stream
mLivePlayer.play();
```

<span id="ac44053d"></span>
### Leaving the live room
To leave the live room, do the following:

1. Stop playing the live stream and destroy the live player.
2. Destroy the RTC room and RTC engine.

**Sequence diagram**
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/8ff389c51c29460d8e50277ae7e2d904~tplv-goo7wpa0wc-image.image =1328x)
**Sample code**

1. Stop playing the live stream, remove the view for the player, and destroy the live player.

```Java
// Stop playing the live stream
mLivePlayer.stop();

// Remove the view for the player
mLocalVideoContainer.removeView(mPlayerView);

// Destroy the live player
mLivePlayer.destroy();
mLivePlayer = null;
```


2. Destroy the RTC room and RTC engine.

```Java
// Destroy the RTC room
mRTCRoom.destroy();
mRTCRoom = null;

// Destroy the RTC engine
RTCVideo.destroyRTCVideo();
mRTCVideo = null;
```





BytePlus MediaLive OpenAPI allows you to manage your domain names and streams, use value-added services such as transcoding and recording, query usage data and stream statistics, and more.
For a complete list of the BytePlus MediaLive OpenAPI endpoints, refer to [BytePlus MediaLive OpenAPI Overview](https://docs.byteplus.com/byteplus-media-live/docs/openapi-overview).
We recommend that you use the [Server SDK](https://docs.byteplus.com/byteplus-media-live/docs/server-sdk) to call the OpenAPI. The Server SDK offers capabilities such as signature generation and common OpenAPI operations.
<span id="Getting started"></span>
## Getting started

1. Activate BytePlus MediaLive for your BytePlus account. For details, refer to [Activating the service](/docs/byteplus-media-live/docs-getting-started#da5a6a63).
2. After your service is enabled, log in to the [BytePlus console](https://console.byteplus.com/), click your account name in the upper right corner of the page, and then select **IAM** > **Key management** to get the Access Key ID (AK) and Secret Access Key (SK) of your account, which are used for API request authentication.

<span id="Limitation"></span>
## Limitation
Each API endpoint has a call frequency that, if exceeded, causes throttling. Please refer to each endpoint's reference for the corresponding call frequency.

BytePlus MediaLive provides Server SDKs in multiple programming languages. Each Server SDK encapsulates the following capabilities, allowing you to quickly call the BytePlus MediaLive OpenAPI:

* Signature generation, which saves you the complicated calculation process.
* Common OpenAPI operations, including sending requests and handling responses. Each SDK provides a corresponding code sample.

<span id="17e2c1c8"></span>
## Get Access key
To use the Server SDK, you should first obtain the Access Key, which consists of an **Access Key ID** and a **Secret Access Key.** 
Leaking the Access Key of the main account may bring serious security risks. Therefore, we recommend that you use the Access Key of a sub-account.

* To use the admin account, you need to [obtain the Access Key of admin account](https://docs.byteplus.com/en/docs/byteplus-platform/docs-creating-an-accesskey#create-an-access-key-through-the-key-management-screen);
* To use the sub-account, you need to [obtain the Access Key of sub-account](https://docs.byteplus.com/en/docs/byteplus-platform/docs-creating-an-accesskey#create-an-access-key-through-the-user-details-screen).

<span id="SDKs"></span>
## Installation and usage

| | | | | \
|**SDK** |**Guide** |**Source Code** |**Demo** |
|---|---|---|---|
| | | | | \
|Java SDK |[Java SDK](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-java-sdk) |[Java SDK source code](https://github.com/byteplus-sdk/byteplus-sdk-java) |[Java Demo](https://github.com/byteplus-sdk/byteplus-sdk-java/tree/master/example/src/main/java/com/byteplus/example/live) |
| | | | | \
|Go SDK |[Go SDK](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-golang-sdk) |[Go SDK source code](https://github.com/byteplus-sdk/byteplus-sdk-golang) |[Go Demo](https://github.com/byteplus-sdk/byteplus-sdk-golang/tree/master/example/demo_live) |
| | | | | \
|Python SDK |[Python SDK](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-python-sdk) |[Python SDK source code](https://github.com/byteplus-sdk/byteplus-sdk-python) |[Python Demo](https://github.com/byteplus-sdk/byteplus-sdk-python/tree/master/byteplus_sdk/example/live) |
| | | | | \
|PHP SDK |[PHP SDK](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-php-sdk) |[PHP SDK source code](https://github.com/byteplus-sdk/byteplus-sdk-php) |[PHP Demo](https://github.com/byteplus-sdk/byteplus-sdk-php/tree/master/examples/Live) |
|Node.js SDK |[Node.js SDK](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-node-js-sdk) | None |None |

You can generate push and pull stream addresses by manually constructing the addresses or using the address generator.
<span id="259f72de"></span>
## Usage scenarios

* **Manual splicing**: Suitable for generating push/pull stream addresses in batches for the business. By using the rules provided by the live video, the live streaming service can be used without calling interfaces.
* **Generated by Address Generator tool**: Suitable for generating a single live stream. No code basis is required, and it can be operated directly on the page.
* **Generated by Using API**: Suitable for scenarios where the live streaming function is integrated in the application to achieve automatic generation of live streaming addresses.

<span id="2f0ce12a"></span>
## Context
<span id="59687c11"></span>
### Address information description
A live address typically consists of `Domain`, `AppName`, and `StreamName`, and if you have URL authentication enabled, it also includes authentication information.
![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/760f0061f25f4875ba068a1910305167~tplv-goo7wpa0wc-image.image =1416x)
The live address parameter description is shown in the following table.

| | | \
|Parameter |Description |
|---|---|
| | | \
|Domain |For the added domain name, use the push stream domain name when generating the push stream address, and use the pull stream domain name when generating the pull stream address. |
| | | \
|AppName |The AppName identifier of the live stream. When pulling the specified stream, the AppName of the push & pull streaming address must be the same. |
| | | \
|StreamName |The StreamName identifier of the live stream. When pulling the specified stream, the StreamName of the push & pull streaming address must be the same. |\
| |:::tip |\
| |The StreamName of a transcoding stream consists of the StreamName and suffix. The suffix is the transcoding suffix in your transcoding configuration. For example, stream_hd. |\
| |::: |
| | | \
|AuthInfo |Refer to [URL authentication](/docs/byteplus-media-live/docs-url-authentication) to understand the URL authentication composition and splice the authentication information. |

<span id="f7580405"></span>
### Address composition rules
Different transport protocols correspond to different address formats, and their composition rules are as follows:

```mixin-react
return (<Tabs>
<Tabs.TabPane title="Push stream address" key="zoKnglQYwI"><RenderMd content={`![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/0484a9ba60ce4cd4a9e9caf491116d45~tplv-goo7wpa0wc-image.image =864x)

`}></RenderMd></Tabs.TabPane>
<Tabs.TabPane title="Pull stream address" key="JRQ1jUiWZW"><RenderMd content={`![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/8393873fbd9c46d9b3ffc362b9cff95e~tplv-goo7wpa0wc-image.image =864x)

`}></RenderMd></Tabs.TabPane>
<Tabs.TabPane title="Transcoding stream address" key="jsEUN4lZHx"><RenderMd content={`![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/ec74ea98755241fa89396c75698ff389~tplv-goo7wpa0wc-image.image =864x)

`}></RenderMd></Tabs.TabPane>
<Tabs.TabPane title="ABR stream address" key="ZhWCq6Ls8R"><RenderMd content={`![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/99efd8370d64404f8059d2b994ede7dd~tplv-goo7wpa0wc-image.image =864x)

`}></RenderMd></Tabs.TabPane></Tabs>);
 ```

<span id="b009d8e3"></span>
## Prerequisites

* The push and pull streaming domain names have been added and CNAME configuration has been completed. Refer to [Add a domain name](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-domain) and [Adding a CNAME record](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-adding-a-cname-record).
* If you need the following functions, please complete [HTTPS configuration](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-https). 
   * Use the online push streaming tool provided by MediaLive console. 
   * Use the online pull Stream  tool provided by MediaLive console.
* If you need to perform URL authentication on the push stream address or pull stream address, please complete the [configuration URL authentication](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-url-authentication). 
* If you need to generate the pull stream address of the transcoding stream, please complete the [transcoding configuration](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-configuring-transcoding).
* If you need to generate the pull stream address of the encrypted stream, please complete the [encryption configuration](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-configuring-a-drm-encryption-task).

<span id="1fca6c65"></span>
## Method 1: Manual splicing
According to [Address composition rules](/docs/byteplus-media-live/docs-generating-live-stream-addresses#f7580405), you can:

* manually splice a single address; 
* use the code for batch generation, see the [Address generation code example](/docs/byteplus-media-live/docs-generating-live-stream-addresses#c8dfbaa6).

<span id="d5256b31"></span>
## Method 2: Using **Address Generator**

1. Log in to the [BytePlus MediaLive console](https://console.byteplus.com/live). 
2. In the left-side navigation pane, select **Toolkits** > **Address generator**.
3. Select the address type and domain name, and fill in the AppName, StreamName, and expiration time.
   :::warning
   The **Expiring on** option is only available when you have enabled [URL authentication](/docs/byteplus-media-live/docs-url-authentication).
   :::
   ![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/305f90015f364f2e8ce96f4f455612de~tplv-goo7wpa0wc-image.image =500x)
4. Click **Generate address**.
5. Get a push/pull stream address in the **Result** section, as shown in the figure below. You can:
   * Click the **Online streaming** button to stream online in a new page.
   * Click the **Copy** button to copy the address.
   * Save the QR code image.
   ![Image](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/1a08c45a4d65472689e7c8ea15844ea2~tplv-goo7wpa0wc-image.image =700x)
6. (Optional) Click the **History** button at the top right of the page to view recently generated address records.

<span id="447499ea"></span>
## Method 3: **Using API**

1. (Optional) Call [UpdateAuthKey](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-updateauthkey-2023) API, open and configure the authentication key for the domain name. 
2. Call [GeneratePushURL](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-generatepushurl-2023) API to generate the push address. 
3. Call [GeneratePlayURL](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-generateplayurl-2023) API to generate the pull address.

<span id="c8dfbaa6"></span>
## Address generation code example
This section provides you with native code examples for generating authenticated RTMP streaming addresses based on Go, Python, Java, and PHP languages. You can generate addresses for other protocols by yourself according to address stitching rules.

```mixin-react
return (<Tabs>
<Tabs.TabPane title="Go" key="svbjUOcrdD"><RenderMd content={`\`\`\`Go
package main

import (
   "crypto/md5"
   "fmt"
)

func main() {
   fmt.Println(GenAuthUrl("testDomain", "testApp", "testStream", "testKey", 1636963457))
}

func GenAuthUrl(domain, app, stream, secretKey string, unixtime int64) string {
   src := fmt.Sprintf("/%s/%s%s%d", app, stream, secretKey, expire)
   sign := fmt.Sprintf("%x", md5.Sum([]byte(src)))
   return fmt.Sprintf("rtmp://%s/%s/%s?expire=%d&sign=%s", domain, app, stream, unixtime, sign)
}
\`\`\`

`}></RenderMd></Tabs.TabPane>
<Tabs.TabPane title="Python" key="LufOK7ni1U"><RenderMd content={`\`\`\`Python
import hashlib

def GenAuthUrl(domain, app, stream, secretKey, unixtime):
    src = "/%s/%s%s%d" % (app, stream, secretKey, volcTime)
    sign = hashlib.md5(src.encode("utf8")).hexdigest()
    return "rtmp://%s/%s/%s?expire=%d&sign=%s" % (domain, app, stream, unixtime, sign)

if __name__ == '__main__':
    print(GenAuthUrl("testDomain", "testApp", "testStream", "testKey", 1636963457))
\`\`\`

`}></RenderMd></Tabs.TabPane>
<Tabs.TabPane title="Java" key="ZiFFooMLX3"><RenderMd content={`\`\`\`Java
package demo;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Demo1 {
    public static void main(String[] args) throws NoSuchAlgorithmException {
        System.out.println((GenAuthUrl("testDomain", "testApp", "testStream", "testKey", 1636963457)));
    }

    public static String GenAuthUrl(String domain, String app, String stream, String secretKey, int volcTime) throws NoSuchAlgorithmException {

        String src = String.format("/%s/%s%s%d", app, stream, secretKey, unixtime);
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        byte[] md5Bytes = md5.digest(src.getBytes(StandardCharsets.UTF_8));
        String sign = "";
        for (int i = 0; i < md5Bytes.length; i++) {
            sign += Integer.toHexString(md5Bytes[i] | 0xFFFFFF00).substring(6);
        }

        return String.format("rtmp://%s/%s/%s?expire=%d&sign=%s", domain, app, stream, unixtime, sign);
    }
}
\`\`\`

`}></RenderMd></Tabs.TabPane>
<Tabs.TabPane title="PHP" key="rKtc49dRw4"><RenderMd content={`\`\`\`PHP
function GenAuthUrl($domain, $app, $stream, $secretKey, $unixtime){

    $src = sprintf("/%s/%s%s%d", $app, $stream, $secretKey, $unixtime);
    $sign = sprintf("%s",md5($src));
    return sprintf("rtmp://%s/%s/%s?expire=%d&sign=%s",$domain, $app, $stream, $unixtime, $sign);
}

echo GenAuthUrl("testDomain", "testApp", "testStream", "testKey", 1636963457);
\`\`\`

`}></RenderMd></Tabs.TabPane></Tabs>);
 ```

This article introduces how to implement Digital Rights Management (DRM) encryption on your live streams with BytePlus MediaLive.
<span id="eb5c4df6"></span>
## Overview
DRM is a systematic approach to copyright protection for digital media. It prevents unauthorized redistribution of digital media and restricts how consumers can copy content they've purchased. By encrypting your live stream using DRM, you are adding an additional layer of security that ensures only authorized users can access and view your content.
BytePlus MediaLive supports the following DRM systems: Widevine, Fairplay and PlayReady.
<span id="d1baef6b"></span>
## Limitations

* BytePlus MediaLive only provides DRM-encrypted playback addresses in HLS with MPEG-TS and LL-DASH with CMAF.
* We recommend using standard DRM players to play DRM-encrypted live streams on web browsers. The performance of native Android players or other platforms may not be guaranteed.

<span id="7aed754a"></span>
## Procedure
The procedure primarily comprises the following steps:

1. Acquire the DRM key from your DRM licensing provider.
2. Complete the necessary configurations related to DRM in the BytePlus MediaLive console.
3. Generate a playback address that is encrypted with DRM.
4. Decrypt the content for authorized users.

<span id="941c05bb"></span>
### Acquiring the DRM key
You must first acquire a DRM key from [Intertrust](https://portal.expressplay.com/home). For detailed instructions on obtaining the key, please refer to [Acquiring a DRM key](/docs/byteplus-media-live/docs-acquiring-a-drm-key).
To enable encryption on Apple devices, it is also necessary to obtain a FairPlay certificate. You will then need to upload the certificate to BytePlus MediaLive console and Intertrust. For instructions on acquiring the certificate and other related information, please refer to [Acquiring a FairPlay certificate](/docs/byteplus-media-live/docs-acquiring-a-fairplay-certificate).
<span id="3b790e5c"></span>
### Configuring DRM in the BytePlus MediaLive Console

1. Upload the DRM key and FairPlay certificate to BytePlus MediaLive. Please refer to [Managing DRM licenses](/docs/byteplus-media-live/docs-managing-drm-licenses) for detailed instructions on how to upload the information.
2. In the BytePlus MediaLive console, configure a transcoding task for the domain name and AppName you want to encrypt. For details, refer to [Configuring a transcoding task](/docs/byteplus-media-live/docs-configuring-transcoding). As an example, suppose you want to encrypt Ultra-high-definition (UHD) streams for AppName "drm-test". Configure as follows:
   ![图片](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/107f86e4900b4fed9f8f81d50f162adb~tplv-goo7wpa0wc-image.image =864x)
   * **Domain name space**: example.push.com
   * **AppName**: drm-test
   * **Suffix**: _uhd
3. Configure DRM encryption for the domain name and AppName you want to encrypt. You can refer to [Configuring a DRM encryption task](/docs/byteplus-media-live/docs-configuring-a-drm-encryption-task) for detailed instructions on how to complete the configurations. In this example, configure as follows:
   ![图片](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/4a1ad5b655e54e6580fe768977e6354d~tplv-goo7wpa0wc-image.image =864x)
   * **Domain name space**: example.push.com
   * **AppName**: drm-test
   * **Transcoding**: _uhd

<span id="4763a627"></span>
### Generating an encrypted playback address
You can generate a DRM-encrypted playback address with the Address Generator.

1. Go to [Address Generator](https://console.byteplus.com/live/main/locationGenerate) and enter the corresponding information:
   * **Select a domain name**: example.pull.com. This should be the domain name for stream pulling that is associated with example.push.com, which you entered in the previous step. You can refer to [Domain name space](/docs/byteplus-media-live/docs-glossary#Vhost) for more information about the relationship between these concepts.
   * **AppName**: drm-test
   * **StreamName**: Enter your stream name
   * **Transcoding template**: _uhd
   ![图片](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/8e4db9069fee45f18bf37818642db0b7~tplv-goo7wpa0wc-image.image =327x)
2. Click **Generate address**.
3. Locate the M3U8 address which should be tagged by a DRM tag. Use this address as the playback address.
   ![图片](https://p9-arcosite.byteimg.com/tos-cn-i-goo7wpa0wc/c9d4b1f5a5f547d38e86d00745cbf60d~tplv-goo7wpa0wc-image.image =480x)

:::tip
* Playback addresses in other formats are not encrypted. To prevent users from accessing the live stream via these addresses, you can enable URL authentication for your domain name, or restrict user access to certain protocols. For details, see [URL authentication](/docs/byteplus-media-live/docs-url-authentication) and [Protocol restrictions](/docs/byteplus-media-live/docs-protocol-restrictions).
* If you want a playback address in the CMAF format, please [contact technical support](https://www.byteplus.com/en/support).
:::
<span id="70daa99f"></span>
### Decrypting the content
To allow authorized users to view encrypted live streams, the player needs to call the BytePlus OpenAPI to retrieve the DRM license. For iOS users, the player also needs to retrieve the FairPlay certificate.

* To retrieve the DRM license, call the [DescribeLicenseDRM](/docs/byteplus-media-live/docs-describelicensedrm) endpoint.
* To retrieve the FairPlay streaming certificate, call the [DescribeCertDRM](/docs/byteplus-media-live/docs-describecertdrm) endpoint.

Since your BytePlus AK/SK cannot be stored on your client devices, you need to first generate the OpenAPI authentication information on your server and then pass the information to your client devices. You can either follow the instructions in [Signing BytePlus MediaLive requests](/docs/byteplus-media-live/docs-signing-byteplus-medialive-requests) or use the [Server SDK](/docs/byteplus-media-live/docs-server-sdk) to calculate the signature.
Suppose you use the [Go SDK](https://github.com/byteplus-sdk/byteplus-sdk-golang) to call BytePlus MediaLive OpenAPI. Use the following code to generate the query URLs with which the client retrieves the DRM license and FairPlay certificate.

1. Define the parameter values.
   ```Go
   var (
     serviceInfo = &ServiceInfo{
      Timeout: 5 * time.Second,
      Host:    "open.byteplusapi.com",
      Header: http.Header{
       "Accept": []string{"application/json"},
      },
      Credentials: Credentials{Region: RegionApSingapore, Service: "live"},
     }
     
     // API endpoints that need to be signed
     apiList = map[string]*ApiInfo{
      "DescribeLicenseDRM": {
       Method: http.MethodPost,
       Path:   "/",
       Query: url.Values{
        "Action":     []string{"DescribeLicenseDRM"},
        "Version":    []string{"2023-01-01"},
        "Vhost":      []string{"drm.test.com"},
        "Domain":     []string{"drmpull.videoarch.com"},
        "App":        []string{"app-drm"},
        "StreamName": []string{"s-drm-1221"},
        "DRMType":    []string{"fp"}, // The DRM encryption type
       },
      },
      "DescribeCertDRM": {
       Method: http.MethodGet,
       Path:   "/",
       Query: url.Values{
        "Action":  []string{"DescribeCertDRM"},
        "Version": []string{"2023-01-01"},
        "Vhost":   []string{"drm.test.com"},
        "App":     []string{"app-drm"},
       },
      },
     }
   )
   ```

2. Generate the query URLs with which the client retrieves the DRM license and FairPlay certificate.
   ```Go
   func TestClient_GetSignUrl(t *testing.T) {
     client := NewClient(serviceInfo, apiList)
     client.SetAccessKey("your ak")
     client.SetSecretKey("your sk")
     urlStr, _ := client.GetSignUrl("DescribeLicenseDRM", nil)
     fmt.Println("https://medialive-ap-singapore-1.byteplusapi.com/drm_api/?" + urlStr)
     urlStr, _ = client.GetSignUrl("DescribeCertDRM", nil)
     fmt.Println("https://medialive-ap-singapore-1.byteplusapi.com/drm_api/?" + urlStr)
   }
   ```



This article introduces how to acquire a DRM key from Intertrust. You need to upload the API key to the BytePlus MediaLive console if you want to implement DRM encryption on your live streams.
<span id="9a84e96d"></span>
## Prerequisite
An [Intertrust](https://portal.expressplay.com/) account. You need to activate the required services for this account, and using the services will incur charges on the Intertrust platform. You can directly contact Intertrust or reach out to your [BytePlus sales representative](https://www.byteplus.com/en/contact) for further inquiries.
<span id="c77d3691"></span>
## Procedure

1. Log in to the [Intertrust](https://portal.expressplay.com/) console.
2. Click **Manage Account** in the left-side navigation.
3. Click **Subscriptions**.
4. Enable your desired DRM systems.
5. Click **Api Keys / Cust. Auth.** on the left-side navigation.
6. Click the **Add Api Key / Cust. Auth.** button to create an API key. Store it locally because you cannot retrieve it later. 


BytePlus MediaLive supports audio-only or video-only live streams. You can push audio-only or video-only live streams to the live stream edge nodes. You can also pull audio-only or video-only live streams directly from the live stream edge nodes.
<span id="c89e0453"></span>
## Procedure
<span id="8114c44c"></span>
### Pushing live streams
You can push audio-only and video-only live streams that use **RTMP**, **RTMPS**, and **QUIC** protocols.
The types of live streams that you can push will differ depending on your live stream method. The details are as follows.

* Audio-only live streams: Only regular or audio-only streams can be pushed.
* Video-only live streams: Only regular or video-only streams can be pushed.

<span id="bba6ca8c"></span>
### Pulling live streams
You can pull audio-only and video-only live streams that use **RTMP**, **FLV**, and **QUIC** protocols.
You will need to add a query parameter to the [pull stream address](https://docs.byteplus.com/en/docs/byteplus-media-live/docs-generating-live-stream-addresses) of the corresponding protocol to set it to audio-only or video-only mode.

* Audio-only: Add the query parameter "only_audio"
   * When `only_audio=1`, the stream will be pulled in audio-only mode.
   * When `only_audio` is 0 or the parameter is omitted, the stream will be pulled in regular mode.
* Video-only: Add the query parameter "only_video"
   * When `only_video=1`, the stream will be pulled in video-only mode. When it is 0 or omitted, the stream will be pulled in regular mode.

:::warning
`only_audio` and `only_video` cannot both be 1. If both parameters are 1, neither of them will take effect.
:::
The examples below show the pull stream address formats of audio-only streams that use RTMP, FLV, and RTM protocols.

* RTMP: `rtmp://{Domain}/{AppName}/{StreamName}?{AuthenticationInfo}&only_audio=1`
* FLV: `https://{Domain}/{AppName}/{StreamName}.flv?{AuthenticationInfo}&only_audio=1`
* RTM: `https://{Domain}/{AppName}/{StreamName}.sdp?{AuthenticationInfo}&only_audio=1`
