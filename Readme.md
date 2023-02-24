# Setup instructions

## Setup
1. Ensure git is installed `sudo apt install git`
1. Clone this repository using `git clone https://github.com/jamesjwood/wood-home.git`
1. Navigate to this folder `cd wood-home`
1. Run the install script `sh install.sh`, this should reboot the pi
1. Run the setup scriot `sh setup.sh`

## Scrypted
1. Log in at `http://[ip address of the rasberry pi]:11080`
1. Install Homekit plugin
1. Install RTSP plugin
1. Add each camera under the RTSP config
- Each camera needs VFIP enabling and a password setting using whatever configuration software supplied with it.
- You will need to look up the specific URL for the camera on [ispyconnect](https://www.ispyconnect.com "ispyconnect").
- Then add a new camera under the RTSP settings
- enter the url you looked up on ispyconnect along with the username password and the ip address of the camera. The url should look like `rtsp://192.168.0.1:554/h364`
- enable the homekit extension for this camera un extensions
- scan the QR code here in your home app on iPhone

## Homebridge