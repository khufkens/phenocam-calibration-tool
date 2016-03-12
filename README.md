# PhenoCam Calibration Tool (PCT)

PhenoCam Calibration Tool (PCT) is a set of scripts for Linux/Mac OSX and Windows taking care of characterizing the colour respons of cameras installed by or associated with the [PhenoCam network](http://phenocam.sr.unh.edu).

## Installation

clone the project to your home computer using the following command (with git installed)

	git clone https://github.com/khufkens/phenocam-calibration-tool.git

alternatively, download the project using download button.

Unzip the downloaded files or use the files cloned by git as is.

## Use

The installation script runs within a terminal on all platforms. To open a terminal search for “Terminal” in OSX spotlight or “cmd” in the program search field (under the Start button) in Windows. For linux users I assume a familiarity with opening a terminal.

### Windows
On the command prompt of a terminal the scripts have the same syntax, for Windows script this would be:

	PCT.bat IP USER PASSWORD

You will need the telnet.exe program to be installed on your computer. As of Windows 7 this isn't installed by default anymore but can still be downloaded from the Microsoft website. Full instructions can be found [here](http://technet.microsoft.com/en-us/library/cc771275%28v=ws.10%29.aspx).

### Linux / OSX
On Linux / Mac OSX systems this would read:

	sh PCT.sh IP USER PASSWORD
or

	./PCT.sh IP USER PASSWORD

with:

Parameter     | Description                    	
------------- | ------------------------------ 	
IP	      | ip address of the camera 		
USER	      | user name (admin - if not set) 	
PASSWORD      | user password (on a new Stardot NetCam this is admin) 

[all parameters are required!]

An example of our in lab test camera configuration:

	./PCT.sh 140.247.89.xx admin admin

This runs the calibration script for the camera at the given IP address.

## Additional information

For a proper calibration you will need a photo colour checker card (see below) and a stable light source (which does not vary between calibration sessions).

![colour checker](http://xritephoto.com/images/products/MSCCC_M1.jpg)

Images should be taken in a location free of interfering light sources (cardboard box).

