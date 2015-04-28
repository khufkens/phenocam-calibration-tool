#!/bin/bash

#--------------------------------------------------------------------
# This script installs all necessary configuration
# files as required to upload images to the PhenoCam server
# (phenocam.sr.unh.edu) on your NetCam SC/XL camera REMOTELY with
# minimum interaction with the camera
#
# Koen Hufkens (January 2014) koen.hufkens@gmail.com
#--------------------------------------------------------------------

echo ""
echo "#--------------------------------------------------------------------"
echo "#"
echo "# Uploading all settings to the NetCam camera!"
echo "# [Ignore all garbage on the command line]"
echo "#"
echo "#--------------------------------------------------------------------"
echo ""

#--------UPLOAD INSTALLATION SCRIPT / EXECUTE -----------------------
(
echo open $1 2> /dev/null
sleep 2 
echo "$2"
sleep 1
echo "$3"
sleep 1
echo "cd /etc/config"
sleep 1
echo "wget ftp://140.247.98.64/calibration/phenocam_calibration.sh"
sleep 1
echo "wget ftp://140.247.98.64/calibration/calibration_ftp.scr"
sleep 1
echo "wget ftp://140.247.98.64/calibration/calibration_video0.conf"
sleep 1
echo "wget ftp://140.247.98.64/calibration/calibration_overlay0.conf"
sleep 1
echo "sh phenocam_calibration.sh"
sleep 500 ) | telnet 2> /dev/null
exit 0
