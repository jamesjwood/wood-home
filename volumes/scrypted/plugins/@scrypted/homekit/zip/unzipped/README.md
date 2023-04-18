# HomeKit Plugin for Scrypted

The HomeKit Plugin bridges compatible devices in Scrypted to HomeKit.

## Camera Codec Settings

You can use the admin page provided by your camera manufacturer to configure codec settings as required by HomeKit. It is highly recommended to configure the codec settings for *all* the camera substreams by using the [Scrypted Codec Settings guide](https://github.com/koush/scrypted/wiki/Codec-Settings). This will yield optimal local and remote streaming reliability.

## Troubleshooting

### HomeKit Secure Video Not Recording

If recordings dont work, it's generally because of a few reasons, **follow the steps to determine where it is failing before asking for help**:

1) The motion wasn't triggered. You can view if there are motion events in the camera `Events` section (a small icon button next to the `Console` button`. If no motion event was delivered to Scrypted this may be for several reasons which may depend on the camera type, including:
  * Local cameras:
    * Motion detection is disabled in the camera. Enable in the camera manufacturer admin app/webpage.
    * There are no motion zone configured on the camera, and there is no default zone. Configure in the camera manufacturer admin app/webpage.
    * The camera may not support motion detection via that plugin (ie, an ONVIF camera not supporting the ONVIF-T profile). Using another delivery mechanism such as mail (SMTP) or webhook is an alernative and reliable option.
  * Cloud cameras:
    * Motion delivery issue from the cloud service.

2) After a motion trigger, the home hub will start recording. Verify that HomeKit is requesting recording by looking in the Camera's Console: you will see logs such as `[HomeKit]: Camera recording session starting`. If you do not see this, there are a few possible causes and solutions:
  * The Home Hubs are bugged out and have stopped responding to motion. Reboot all Home Hubs when this happens. **iPads and HomePods, which are wireless, are not reliable Home Hubs.** If you have an iPad as a Home Hub, remove it from acting as a Home Hub from within the iOS Home app. Unfortunately this is not possible to do with HomePods.
  * Your iCloud account is in a bad state. Log out of iCloud on your iPhone, and log back in. Then disable and reenable HomeKit Secure Video on your cameras again.
  * Your Scrypted server is on a different subnet from your home hub(s). This may work for live streaming, but home hubs will not initiate recording if they are on a different subnet. Ensure your Scrypted server is on the same subnet as the home hubs. 

3) If HomeKit requested the video, but nothing showed up in the timeline:
  * HomeKit may have decided the motion wasn't worth recording. Set your HomeKit recording options to all motion when testing.
  * The recordings are in a bad format that can't be used by HomeKit. See below for optimal HomeKit Codec Settings. Enabling Transcode Debug Mode in the HomeKit settings for that camera may fix this for testing purposes, but long term usage is not recommended as it reduces quality and increases CPU load.
  * Try rebooting your Home Hubs (HomePods and AppleTVs). Make sure they are fully up to date.

### HomeKit Discovery and Pairing Issues

If HomeKit is not discoverable, make sure LAN/WLAN multicast is enabled on your router.
If HomeKit fails while pairing during a Docker install, ensure host networking is being used.

### HomeKit Live Streaming Timeout (Recordings may be working)

This is always a issue with the network setup. 
  * Ensure you are not connected to a VPN.
  * You may have multiple network interfaces, such as wired and wireless, and HomeKit is preferring the wireless interface. Use the [`Scrypted Server Address` setting](/endpoint/@scrypted/core/public/#/component/settings), and set it to your wired IP address manually.
  * Flatten your network topology. If your camera/server/iOS are on a separate VLANs, try disabling VLANs to determine if that is the issue.
  * You wifi network is saturated, resulting in heavy packet loss. Enabling Transcode Debug Mode in the HomeKit settings for that camera may fix this for testing purposes, but long term usage is not recommended as it reduces quality and increases CPU load.
  * This is *may* be a codec issue (but as mentioned earlier, is usually a network issue). Try enabling Transcoding on both Live and Remote streams.

### HomeKit Remote Streaming not Working

This almost always due to your camera bitrate being too high for remote streaming through Apple's servers. Workarounds:
1) Use a lower bitrate substream for Remote Streaming.
2) Enable Transcoding on Remote Streaming.



<br/><br/><details>
<summary>Changelog</summary>

### 1.2.12

ring: added night mode support to arm with sensor bypass (#577)


### 1.2.11

Adding support for siren in homekit (#578)
Add WindowCovering to HomeKit (#571)
project: update lockfiles
homekit: add support for notification toggle switches


### 1.2.8

homekit: device info cleanup
Revert "homekit: multiprocess accessory mode devices"
h264-repacketizer: add missing method
h264-repacketizer: publish
homekit/webrtc: partially revert h264 repacketizer change


### 1.2.9

homekit: remove buggy console.time call
homekit: multiprocess accessory mode devices


### 1.2.6

homekit: add default option for advertiser


### 1.2.5

homekit: respect Server Address setting


### 1.2.4

homekit: publish


### 1.2.3

homekit: allow custom bind


### 1.2.2

homekit: clean up address bind
homekit: fix advertiser interface settings


### 1.2.1

homekit: publish advertiser restricted to server interface change


### 1.1.99

homekit: fixup project files
homekit: add adcertiser address setting


### 1.1.98

homekit: advertiser should respect address override


### 1.1.97

homekit: add changelog to gitignore
homekit: fix garage state


### 1.1.96

homekit: fix cleanup error in log


### 1.1.95

homekit: use address api
homekit: fix destination bug


### 1.1.94

h264: refactor for reusability
homekit: fix audio cuts


### 1.1.93

homekit: remove dead rollover code
homekit: remove file
homekit: clean up return audio code
homekit: typo
homekit: fixup two way audio teardown


### 1.1.92

homekit: publish


### 1.1.91

homekit: modernize two way audio code
homekit: update to new media stream feedback method
Update README.md
Additional HKSV troubleshooting tips (#517)
homekit: fix/add missing server address alert


### 1.1.90

homekit: dont error out when homekit receives an adaptive bitrate request


### 1.1.89

update lockfiles
homekit: alert if server address is not set.


### 1.1.88

homekit: publish thermostat changes, debug mode reorganization


### 1.1.87

plugins: update tsconfig.json
homekit/rebroadcast: use new onMixinEvent signature
homekit: beta


### 1.1.86

homekit: use HeatCool mode for independent heat/cool setpoints (#470)
various: add support for settings subgroups


### 1.1.85

homekit: fix missing outlet type


### 1.1.84

homekit: improve h264 packetizer
homekit: sdk update fixup


### 1.1.83

publish server update


### 1.1.82

Some quality-of-life fixes for the HomeKit plugin (#448)
homekit: do not allow snapshot pileups


### 1.1.80

homekit: cleanup dead code
homekit/core/sdk: use global setting for server address and transcoding
homekit: clean up snapshot timeout code


### 1.1.78

homekit: fix doorbell delivery


### 1.1.76

homekit: prevent hksv local copy from interfering with other video clip providers


### 1.1.75

homekit: readme


### 1.1.73

Update README.md
Update README.md
Update README.md
Update README.md
Update README.md
webrtc/homekit: publish


### 1.1.72

homekit: port live555 aac fix


### 1.1.71

homekit: cleanup
homekit: make doorbell button optional since it confuses people.


### 1.1.70

homekit: fix typo
homekit: fix ffmpeg sender when no audio is present


### 1.1.68

homekit/webrtc: send raw receiver reports


### 1.1.63

homekit/webrtc/sdk: report packet loss to adaptive bitrate streamer
webrtc/homekit: publish


### 1.1.62

homekit: add support for nvr plugin adaptive bitrate


### 1.1.60

homekit/rtp: fix potential tcp to udp packet loss due to large packets


### 1.1.59

homekit: new beta


### 1.1.58

homekit: fix missing codec information


### 1.1.57

homekit: better warning message
homekit: fix audio transcode bug. in new streamer. remove spurious logging.


### 1.1.56

homekit: switch to new rtp parsing/streaming architecture.


### 1.1.55

homekit: fix bridge mode bug


### 1.1.54

homekit: fix default accessory mode bugs


### 1.1.53

homekit: increase send buffer sizes


### 1.1.52

homekit: Direct users to troubleshooting guide in camera readme


### 1.1.51

homekit: Direct users to troubleshooting guide in camera readme


### 1.1.50

homekit: make accessory mode the default for cameras


### 1.1.49

homekit: promisify more io to prevent blocking


### 1.1.48

homekit: remove low disk space warning


### 1.1.46

homekit: use dummy aac audio track to avoid transcoding dummy audio when camera has no audio
homekit: log intercom crash
homekit: log intercom crash
Merge branch 'main' of github.com:koush/scrypted
homekit: fix opus audio on remote connections https://github.com/koush/scrypted/issues/398#issuecomment-1272459980


### 1.1.45

added support for greater capabilities in HomeKit for Fan's (#395)
homekit: publish sensor fixes


### 1.1.44

updated the sensor bindings (#392)
homekit: use async file operations
homekit: swap periods with spaces in mdns name


### 1.1.43

homekit: Do not allow periods in accessory names. Causes HomeKit pairing to fail.


### 1.1.41

homekit: fix security system nullref bug causing bridge to not start
homekit: improved opus repacketization


### 1.1.40

Added `NOXSensor` and `PM10Sensor` for use (#384)
Update README.md
homekit: watch for sps/pps parse error. show accessory mode port in settings.


### 1.1.38

homekit: revert publisher bind
homekit: beta version that limits mdns to server address


### 1.1.37

homekit: beta version that limits mdns to server address


### 1.1.36

homekit: dead code
homekit: publish


### 1.1.35

homekit: remove dead code
homekit: fix race condition reported by @bzoel


### 1.1.34

homekit: warn when server address is not set


### 1.1.31

homekit: update launch.json
homekit: update imports
prefer EntrySensor over BinarySensor if device has both (#332)
homekit: fix jitter buffer bug
homekit: publish color temperature bulb. fix snapshot spam bug.


### 1.1.30

Implement ColorSettingTemperature in HomeKit plugin (#318)
homekit: fix doorbell readme generation on devices with no camera.
homekit: fix accessory mode pairing code bug where it was using the bridge pairing code


### 1.1.29

homekit: publish


### 1.1.28

homekit: fix erroneous pin code
homekit/common: fix jitter buffer sequence number distance calculation bug
homekit: publish node v18 fixes, merges from upstream


### 1.1.27

homekit: fix node v18 beta plugin


### 1.1.25

common: rtp utils
plugins: remove postinstall
plugins: add tsconfig.json
homekit: fix readme formatting
homekit: set security system state valid values (#268)
Merge branch 'main' of github.com:koush/scrypted
homekit: add pincode to accessory mode devices
homekit: respect filters. consolidate transcoding steps.
Update README.md
homekit: move jitter buffer into the h264 packetizer


### 1.1.24

Update README.md
homekit/webrtc: simplify h264 packetizer, add jitter buffer


### 1.1.23

homekit: wip
homekit: fix fua sps quirk


### 1.1.21

homekit: beta packetizer stuff


### 1.1.18

homekit: fix h264 packetization for small fua packets


### 1.1.14

homekit: publish


### 1.1.13

homekit: fix issue with current temperature display (#264)
homekit: fixup settings groups
homekit: remove qr code in console generation, allow ui to handle it.


### 1.1.12

homekit: fix qr code accessory race condition. add slow connection setting to add all home hubs.


### 1.1.9

homekit: add CO2Sensor to supportedSensors (#260)
homekit: add co2sensor (#259)
homekit: dont hard fail on bad address override, provide a console warning


### 1.1.8

homekit: watch and alert for invalid scrypted server addresses.


### 1.1.7

homekit: airquality sensor updates (#258)
homekit: disable accessory mode mirroring camera online status. buggy.


### 1.1.6

homekit: watch for invalid address override


### 1.1.5

Merge branch 'main' of github.com:koush/scrypted
homekit: ensure device is published before generating the qr code


### 1.1.2

Update iOS-15.5.md
Update iOS-15.5.md
Update iOS-15.5.md
Update iOS-15.5.md
homekit: publish


### 1.1.1

homekit: make accessory mode the guided default. add qrcode print button.


### 1.0.21

homekit: home hub requests will now use the medium resolution stream. recommend accessory mode.


### 1.0.18

homekit: publish security system beta


### 1.0.17

Merge branch 'main' of github.com:koush/scrypted
homekit: logging and debug code


### 1.0.11

homekit: add security system type (#251)
homekit: watch for h264 sps/pps/idr fua quirk. pretty sure this is non compliant. seen on xiaomi camera.


### 1.0.10

homekit: fix audio demuxer by cleaning sdp


### 1.0.8

homekit: comments


### 1.0.6

homekit/rebroadcast: properly handle rtsp servers that accept both basic and digest auth


### 1.0.5

homekit: Fix nre


### 1.0.4

bind TamperSensor interface to StatusTampered Characteristic (#248)
rebroadcast/homekit: better h264 oddity handling


### 1.0.3

homekit: dont use ffmpeg if h264 oddities are reported. wait for rtcp packet if home hub is unknown.


### 0.0.284

homekit: fix accessory mode publishing bugs


### 0.0.282

homekit: watch for empty rtp/h264 packets
homekit: reenable ios hub proxy workaround.
homekit: accessory mode fixes


### 0.0.281

homekit: repbublish with some reverts to the low bandwidth forcing due to ios 15.5 rc bug still being present


### 0.0.280

homekit: send stream tool hint


### 0.0.279

homekit: settings refactor. new setting to track active home hub.


### 0.0.278

homekit: undo waitForFirstVideoRtcp hack, no longer seems necessary


### 0.0.277

homekit: publish beta


### 0.0.275

homekit: support IntrusionSensor as ContactSensor service (#244)
homekit: publish


### 0.0.274

homekit: better segment valdation on secure videos
homekit/rebroadcast: document weird ffmpeg rtsp skip issue
homekit: use werift src
homekit/webrtc: werift dependency fixups
homekit: use werift package instead of long rel paths
sdk: security system
homekit: refactor/prevent race conditions around streaming session termination
homekit/rebroadcast/common: refactored rtsp client
homekit: fix error message typos
homekit: map EntrySensor to homekit ContactSensor (#241)
homekit: video rtcp timeout


### 0.0.271

homekit: only start intercom once audio starts flowing back. this addresses issues where doorbell chimes get muted if two way mode is activated.


### 0.0.270

homekit: docs


### 0.0.269

homekit: sei filtering is now in rebroadcast.


### 0.0.268

homekit: fix sequence number check in rtp sender


### 0.0.267

homekit: document homekit video slow startup bug
homekit: wait for homekit to send a video RTCP packet before sending video.


### 0.0.266

homekit: publish more sensors


### 0.0.265

homekit: add support for air quality sensor (#236)
homekit: make scrypted the default rtp sender
Merge branch 'main' of github.com:koush/scrypted
homekit: fix scrypted rtp sendor for weird cameras.


### 0.0.263

all: prune package.json
homekit/rebroadcast: rtsp client setup may return interleave values that are not what was reqwuested. todo: leverage this ourselves.


### 0.0.264

homekit: fix srtp fast path usage. add docs.
homekit: audio process cleanup


### 0.0.262

homekit: remove rebroadcast dependency for srtp sender fast path. audio is now demuxed in homekit plugin. only require h264 bitstream compatibility.


### 0.0.259

homekit/rebroadcast: make the rtp sender a configuration option until the stability issues can be worked out.


### 0.0.258

Revert "homekit: experimental packetizer work"
homekit: experimental packetizer work
homekit: send codec information on normal idr frame too
homekit: fix various ffmpeg repacketizer bugs, auto detect missing codec information.


### 0.0.253

homekit: restrict ffmpeg-free fast path to opus only. add comments.


### 0.0.252

homekit/rebroadcast: code and log cleanups


### 0.0.251

homekit/rebroadcast: add ffmpeg free fast path for all all cameras that do not need ffmpeg filtering or video transcoding


### 0.0.250

homekit: remove ffmpeg usage for h264 cameras that dont have any audio.


### 0.0.249

homekit: srtp sender should bind to address override. rtsp parser should use channel to determine destination. fix h264 packetizer max length bug.


### 0.0.246

homekit: opus is now the only audio option (setting removed)


### 0.0.245

homekit: fix remote detection


### 0.0.244

homekit: typo
Update README.md
Update README.md
plugins: publish various betas


### 0.0.243

plugins: respect destination bitrate hint
homekit/rebroadcast: refactor transcoding
homekit: fix dynamic bitrate
global: rename FFMpeg to FFmpeg
homekit: log packet loss
homekit: switch to sdp parser
homekit: fix h264 repacketizer marker calculation
homekit: srtp path should respect max packet size
homekit: properly repacketize stap-a packets.
homekit: fix opus timetstamp regression
homekit: unifi protect no longer requires ffmpeg
rebroadcast/homekit: wip scrypted parser path that eliminates ffmpeg
homekit: no-ffmpeg fast path wip
homekit: not actually possible to stream a perfect aac eld stream...
homekit: send codec hints for streaming and recording
homekit: support codec copy for opus via repacketizer
various plugins: consolidate stream selection in rebroadcast
homekit: fix rtp rollover bug


### 0.0.242

homekit: fix reconfigure crash


### 0.0.241

Update README.md
Update README.md
Update README.md
Update README.md
homekit: fix error spam
homekit: potential mp4 session parsing fix


### 0.0.240

sdk/homekit/rebroadcast: update mediastreamoptions. use safeKillFFmpeg. publish beta.


### 0.0.239

homekit: update troubleshooting
homekit: cap videos at 3 minutes. have seen runaway videos.


### 0.0.238

homekit: fix decoder arg order, publish


### 0.0.235

homekit: add watch specific settings, cleanup settings handling


### 0.0.233

homekit: fix bug where null audio track was inserted in the wrong spot.


### 0.0.232

core/homekit: filtering fixes


### 0.0.231

homekit: publish


### 0.0.230

homekit: trigger event on clip deletion
homekit/sdk: make video clips accessible as an overview
homekit: note smart codec
homekit: simplify thumb/video media handling
homekit: prune videos
homekit: move save clips to a separate thing
homekit: save clips
homekit: use trimmed down hap
homekit: revert tree shaking


### 0.0.228

homekit: tree shaking to reduce memory footprint


### 0.0.227

homekit: comments
homekit: reenable prebuffer on remote streams, turns out ffmpeg does not send the prebuffer until a key frame is found, which is exactly the behavior we want.


### 0.0.226

homekit: log first packet from opus
homekit/amcrest: dynamic streaming


### 0.0.224

homekit: dynamic bitrate improvements


### 0.0.222

homekit: dynamic bitrate.


### 0.0.220

homekit: move -bsf:v dump_extra into a flag


### 0.0.219

rebroadcast/homekit: fix possible streaming and recording regressions


### 0.0.217

homekit: rollover rtp timestamps. add video extra data to some rtsp streams.


### 0.0.216

homekit/rebroadcast: document weird h264 sps/pps issue and new filter


### 0.0.215

homekit: always dump extra data into the rtp streams
homekit: fix truncated qr code


### 0.0.214

homekit: organize imports, publish


### 0.0.213

plugins: refactor with new mixin api
homekit: launch.json
homekit: handle all opus sample rate and bitrate options


### 0.0.212

homekit: publish


### 0.0.211

homekit: enable all audio options.
homekit: put opus behind a setting.


### 0.0.209

homekit: various settings cleanups and explanations
homekit: fix confusion around built in motion sensor
homekit: reset accessory support


### 0.0.208

rebroadcast: fix rtsp mode idr interval detection. accomodate mp4 container bug in ffmpeg.
homekit: fixup mp4 parsing cruft
homekit: formatting
homekit: disable whatever this flush packet thing does
homekit: snapshot reason logging
homekit: fix misleading error


### 0.0.207

homekit: fix socket leak


### 0.0.206

homekit: fix identifying material being used due to null coalescing operator


### 0.0.205

homekit: opus fixes


### 0.0.202

homekit/rebroadcast: report online/offline state per accessory mode camera


### 0.0.200

homekit: standalone accessories


### 0.0.199

homekit: standalone accessories


### 0.0.197

homekit: remove some old code


### 0.0.196

homekit: use ffmpeg pipe for mp4 parsing
homekit: talkback also supports opus!


### 0.0.194

homekit: switch to opus by default!
homekit: missing files
homekit: opus support via ffmpeg
homekit: document opus quirk
homekit: more doc
homekit: document opus quirk
homekit: opus code path flag
homekit: rtsp to srtp support
homekit: beta


### 0.0.193

homekit: initial support for eliminating ffmpeg and support opus audio
homekit: add flood sensor
homekit: dont transcode live stream audio if it is in the exact spec we need it
homekit: opus tests
homekit: init hap properly
homekit: different qr code lib
homekit: transcoding audio shouldnt attempt to set aac filters on non aac codecs


### 0.0.192

homekit: fix text


### 0.0.191

homekit: better explanation of remote streaming


### 0.0.190

homekit: ffmpeg path logging


### 0.0.187

rtsp/all: normalize args further. remove usage of problematic reorder_queue_size. only use rtsp_transport and max_delay. consider removing max_delay too.


### 0.0.186

Update README.md
homekit: filter out motion objects


### 0.0.185

homekit: fix logging leaks


### 0.0.184

homekit: readme


### 0.0.183

homekit: better instructions on scrypted server address


### 0.0.182

plugins: various readmes


### 0.0.180

homekit/rebroadcast: publish


### 0.0.179

dummy/homekit: fixup sensor support


### 0.0.178

homekit: fix bug where bufsize was crazy small


### 0.0.177

onvif/homekit/rebroadcast: fix settings error suppression


### 0.0.176

homekit: fix build breaks
sdk/homekit/server: ambient light sensor support


### 0.0.175

homekit: audio sensor


### 0.0.174

homekit: add more supported sensors


### 0.0.173

homekit: make status light indicator an option


### 0.0.172

plugins: cleanup package sizes


### 0.0.171

homekit: detected objects use occupancy sensors rather than contact sensors. doorbell button is a programmable switch rather than contact sensor.


### 0.0.170

homekit: thermostat temp display unit. intercom cleanup.


### 0.0.166

homekit: doorbell button available as a contact sensor


### 0.0.165

homekit: failsafe default transcoding args


### 0.0.162

homekit: wip


### 0.0.161

google-device-access: nre fix


### 0.0.160

homekit: faster libx264 transcode


### 0.0.159

homekit: fixup hwaccel


### 0.0.158

rebroadcast: sanitize passwords from logs


### 0.0.157

homekit/unifi-protect: status light support


### 0.0.156

unifi-protect: package camera fixes. homekit transcoding defaults fixes.


### 0.0.155

homekit: transcode default should set fps
general pending changes


### 0.0.154

homekit/amcrest/unifi: dynamic bitrate support
homekit/unifi: dynamic bitrate support on remote streaming
homekit: add support for dynamically reconfiguring stream bitrates!


### 0.0.153

homekit: fix busted mtu. accidental deletion?


### 0.0.152

server: fix rpc device creation spam. publish
homekit: docs and publish


### 0.0.151

homekit: docs and publish


### 0.0.149

homekit: opus test code
homekit: opus test code
homekit: mtu fixes


### 0.0.148

homekit: recordings through rebroadcast fast path


### 0.0.147

homekit: fix reversed logic


### 0.0.146

Revert "plugins: experimental"
plugins: experimental
homekit: revert prior changes, document reasoning better


### 0.0.145

homekit: boolean properties are 0/1
homekit: npm audit fix and prune
package.json updates


### 0.0.144

homekit: wip
homekit: publish


### 0.0.143

homekit: readme
homekit: fix reversed logic when there is no audio


### 0.0.142

homekit: settings.json update
homekit: thermometer


### 0.0.141

homekit: Improve live streaming address default


### 0.0.139

homekit: use the same hap port to work around cached mdns advertisiment issues


### 0.0.138

homekit: make ciao default advertiser


### 0.0.137

various plugins: rebuild with settings mixin crash resistance


### 0.0.135

homekit: recording logging
homekit: fix missing opencv motion detector


### 0.0.134

homekit: autopopulate bridge addresses from recording requests.


### 0.0.133

plugins: rebuild various plugins using settings mixin


### 0.0.132

homekit: fix ffmpeg process leak


### 0.0.131

homekit: fix object detection denoising


### 0.0.130

homekit: fix motion sensor double callback when audio sensor exists


### 0.0.129

objectdetector: publish new architecture
homekit: h265 stubs, albeit it does not seem to actually be supported.
homekit: object detection sensor timeout


### 0.0.128

homekit: auto restart on add/remove
update package-lock.json
homekit/unifi: update sdk breaking changes


### 0.0.127

homekit: property detections renamed classes


### 0.0.126

homekit: put transcoding behind a warning


### 0.0.125

homekit: fix invalid values on thermostat
thermostat: support thermostat range
sdk/homekit: fix humidity typo


### 0.0.124

homekit: humidifier setpoints


### 0.0.123

homekit: more humidity setting fixes


### 0.0.120

homekit: change active state behavior


### 0.0.119

sdk/server/homekit: humidity


### 0.0.118

sdk/server/homekit: fan
homekit: reduce storage spam
homekit: characteristic persistence
homekit: shot recording options if using a linked motion sensor


### 0.0.117

homekit: transcode cleanup


### 0.0.115

homekit: fix reversed object detect contact sensor bug


### 0.0.114

homekit: fix dangling object detection contact sensors.


### 0.0.113

homekit: publish


### 0.0.112

homekit: publish


### 0.0.111

homekit: fix streaming/recording transcode options working when they should and should not
homekit: release refresh fix


### 0.0.110

homekit: fixup fan service on thermostat


### 0.0.102

homekit: refresh on user interaction. add fan service to thermostat when possible.


### 0.0.101

google-device-access/homekit: thermostatActiveMode update


### 0.0.100

homekit: restructure
server: add exports to plugin scope
homekit: add various network tweaks


### 0.0.97

homekit: better bridge address detection


### 0.0.96

sdk: update dependencies
homekit: populate override address options


### 0.0.95

homekit: fix misleading log
plugins: trim unneceesary packaged files


### 0.0.94

homekit: enable object detector even if people are not detected


### 0.0.93

homekit: do not use mac address as the bridge id, problematic when running on non-docker side by side with anything else. also would break multi-instance.


### 0.0.92

tensorflow/homekit/rebroadcast: release


### 0.0.88

homekit: disable resolution reporting, use hard coded values.


### 0.0.85

homekit: clear alerts on startup
homekit: watch for no media stream being returned.


### 0.0.84

homekit: ffmpeg encoder suggestions


### 0.0.83

homekit: reencode secure video recording audio if not aac.


### 0.0.82

homekit: add hub streaming behavior


### 0.0.81

homekit: beta


### 0.0.80

homekit: select streams
homekit: remove logging
homekit: respect video resolutions
homekit: rearrange code
homekit: object detection contact sensor implementation
homekit: hap update
homekit: rtp talkback logging


### 0.0.79

homekit: add prepareRecording call
homekit: send snapshot hints along


### 0.0.78

plugins: rebuild with new mixin console support


### 0.0.77

core: log cleanup
plugins/common/server: hide ffmpeg banners
homekit: HardwareRevision instead of Version


### 0.0.76

homekit: fixup garage door state


### 0.0.75

homekit: increase connection limit


### 0.0.74

homekit: publish


### 0.0.73

homekit: random pincode
homekit: cleanups
prebuffer: refactor
homekit: motion sensor bug


### 0.0.71

homekit: prototype device change notification
homekit: standalone motion sensors


### 0.0.70

homekit: customize linked motion sensor


### 0.0.69

homekit: dummy audio for recordings


### 0.0.68

homekit: blank snapshot perf option. add blank audio track to HKSV.


### 0.0.65

homekit: fixup snapshot regression


### 0.0.64

release: camera plugins


### 0.0.63

homekit: dummy audio track if necessary
homekit: transcode options
homekit: reenable no audio path


### 0.0.62

homekit: wip reconfigure
homekit: fix streaming if audio is missing
homekit: reconfigure stream handler


### 0.0.61

core: copy to clipboard


### 0.0.60

homekit: update HAP
homekit: remove dead code


### 0.0.58

Merge branch 'main' of github.com:koush/scrypted into main
homekit: log spam and codec revert


### 0.0.57

Delete plugins/homekit/docs directory
core: ui fixups


### 0.0.56

homekit: camera talk back support
missing files
path fixups
homekit: snapshot perf fix


### 0.0.54

homekit & prebuffer: Discard ffmpeg data after frames start.
change default debug port
server/homekit/google-home: watch for device descriptor changes
homekit: watch video fix


### 0.0.52

homekit update


### 0.0.51

plugin updates


### 0.0.49

Define the category for the bridge explicitly
homekit: add accessory information
homekit: remove junk restart log
homekit: doorbell and version fix


### 0.0.48

homekit doorbell fix


### 0.0.46

perform npm build during the docker build process


### 0.0.45

rebroadcast: watch for dead processes


### 0.0.42

homekit mtu tweak


### 0.0.39

update


### 0.0.37

update for volume


### 0.0.34

homekit mac fix


### 0.0.26

ui fixups


### 0.0.25

restart on accessory change


### 0.0.24

mixinprovider ui


### 0.0.23

api proxy


### 0.0.22

update


### 0.0.21

remove cruft
fix homekit set vs update
homekit refacotr
version


### 0.0.20

mpegts and mp4 prebuffer
arg order


### 0.0.19

fixup missing maps api call
releases


### 0.0.18

homekit: remove frag duration for now. put it behind config later.
homekit transcoding
homekit: audio detection


### 0.0.17

homekit: audio sensor support for camera motion events
mixin fixups


### 0.0.15

mixin improvements, homekit settings


### 0.0.14

fixups
bug fixes
rebuild on stripped down sdk


### 0.0.13

rebuild on stripped down sdk


### 0.0.10

publish plugins


### 0.0.9

.eslintrc.json
garage type on homekit
initial commit


</details>
