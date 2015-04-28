::--------------------------------------------------------------------
:: This script installs all necessary configuration
:: files as required to upload images to the PhenoCam server
:: (phenocam.sr.unh.edu) on your NetCam SC/XL camera REMOTELY with
:: minimum interaction with the camera
::
:: last updated and maintained by:
:: Koen Hufkens (January 2014) koen.hufkens@gmail.com
::--------------------------------------------------------------------
@echo off

:: if the timezone is positive +
:: replace + with the escaped {+} character
set timezone=%5%
set timezone=%timezone:+={+}%

:: Create VBS script

echo set OBJECT=WScript.CreateObject("WScript.Shell") > sendCommands.vbs
echo WScript.sleep 500 >> sendCommands.vbs
echo OBJECT.SendKeys "%2%{ENTER}" >> sendCommands.vbs
echo WScript.sleep 500 >> sendCommands.vbs
echo OBJECT.SendKeys "%3%{ENTER}" >> sendCommands.vbs
echo WScript.sleep 500 >> sendCommands.vbs
echo OBJECT.SendKeys "cd /etc/config{ENTER}" >> sendCommands.vbs
echo WScript.sleep 500 >> sendCommands.vbs
echo OBJECT.SendKeys "wget ftp://140.247.98.64/calibration/phenocam_calibration.sh{ENTER}" >> sendCommands.vbs
echo WScript.sleep 1000 >> sendCommands.vbs
echo OBJECT.SendKeys "wget ftp://140.247.98.64/calibration/calibration_ftp.scr{ENTER}" >> sendCommands.vbs
echo WScript.sleep 1000 >> sendCommands.vbs
echo OBJECT.SendKeys "wget ftp://140.247.98.64/calibration/calibration_video0.conf{ENTER}" >> sendCommands.vbs
echo WScript.sleep 1000 >> sendCommands.vbs
echo OBJECT.SendKeys "wget ftp://140.247.98.64/calibration/calibration_overlay0.conf{ENTER}" >> sendCommands.vbs
echo WScript.sleep 1000 >> sendCommands.vbs
echo OBJECT.SendKeys "sh phenocam_calibration.sh{ENTER}" >> sendCommands.vbs
echo WScript.sleep 400000 >> sendCommands.vbs
echo OBJECT.SendKeys "exit{ENTER}" >> sendCommands.vbs
echo WScript.sleep 50 >> sendCommands.vbs
echo OBJECT.SendKeys " " >> sendCommands.vbs

:: Open a Telnet window
start telnet.exe %1

:: Run the script
cscript sendCommands.vbs

:: remove VBS script
del sendCommands.vbs
