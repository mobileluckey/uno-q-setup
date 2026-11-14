# UNO Q + Media Carrier setup

Scripts and settings for running an IMX219 camera through the Arduino UNO Media Carrier on the Arduino UNO Q (Debian image)

## Enable the camera

~~~
sudo arduino-linux-config hw enable media-carrier camera0=type1-2lanes
~~~

Reboot, then confirm the camera is detected:

~~~
ls /sys/bus/i2c/drivers/imx219/
~~~

An entry like `1-0010` means the camera was found

## Display fix

With the carrier attached, the USB-C video output reports 1920x1080 but the monitor shows "No signal." 1280x720 at 60Hz works.  These two files apply that mode at every boot:

~~~
sudo cp fix-display-mode.sh /usr/local/bin
~~~
~~~
sudo chmod +x /usr/local/bin/fix-display-mode.sh
~~~
~~~
sudo cp fix-display-mode.service /etc/systemd/system
~~~
~~~
sudo systemctl daemon-reload
~~~
~~~
sudo systemctl enable fix-display-mode.service
~~~

## Taking a picture

Requires ImageMagick:
~~~
sudo apt install imagemagick
~~~
~~~
mkdir -p ~/bin
~~~
~~~
cp snap.sh ~/bin
~~~
~~~
chmod +x ~/bin/snap.sh
~~~
~~~
snap.sh myphoto
~~~

Pictures are saved to `~/Pictures`.  Captures are 632x480; full sensor resolution fails with a memory allocation error.

## Notes

- Colors may have a slight green tint because there is no IMX219 tuning file for libcamera on this image.
- Tested November 2026.

