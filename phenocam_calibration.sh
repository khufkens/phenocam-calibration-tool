#!/bin/sh
# Upload rapid sequence of images for RGB calibration
# Koen Hufkens (2015)


# set the default time and time zone

# set to EST
TIMEOFFSET="-5"

# set time zone
# dump setting to config file
SIGN=`echo $TIMEOFFSET | cut -c'1'`

if [ "$SIGN" = "+" ]; then
	echo "UTC$TIMEOFFSET" | sed 's/+/-/g' > /etc/config/TZ
else
	echo "UTC$TIMEOFFSET" | sed 's/-/+/g' > /etc/config/TZ
fi

# export to current clock settings
export TZ=`cat /etc/config/TZ`

# configure time server
echo "time.nist.gov" > /etc/config/ntp.server

# update the clock settings
sh /etc/rc.ntpdate

# set the configuration device
config="/dev/video/config0"

# set the sleep time
sleep_period="20"

# set the exposure range to cycle through
exposures="1 2 3 6 12 24 48 96 192 384 768 1536 2400 4800"

# initiate default camera settings
# dump video configuration to /dev/video/config0
# device to adjust in memory settings
nrfiles=`awk 'END {print NR}' calibration_video0.conf`

for i in `seq 1 $nrfiles` ;
do
 # assign a shell variable to a awk parameter with
 # the -v statement
 awk -v p=$i 'NR==p' calibration_video0.conf > $config
done

# save video configuration
config save &> /dev/null

# grab the MAC address
hardware_address=`ifconfig | grep HWaddr | awk '{print $5}' | sed 's/://g'`

# Disable IR, and auto exposure
# IR blocked from image
echo "ir_enable=0" > $config
echo "auto_exposure=0" > $config
sleep ${sleep_period}

# some feedback
echo "============================================"
echo "Parameters set, acquiring calibration images"
echo "--------------------------------------------"
echo ""

for i in $exposures; do

	# grab the current date / time
	year=`date +"%Y"`
	month=`date +"%m"`
	day=`date +"%d"`
	hour=`date +"%H"`
	min=`date +"%M"`
	sec=`date +"%S"`

	datetime=`echo $year $month $day $hour:$min:$sec`
	ftp_datetime=`echo ${year}_${month}_${day}_${hour}${min}${sec}`

	# format the exposure numbering correctly
	my_exposure=`printf "%04d" $i`

	# The following line dumps the current time in the correct format
	# to an overlay0_tmp.conf file
	cat calibration_overlay0.conf  | sed "s/MACADDR/${hardware_address}/g" | sed "s/CUSTOMDATE/$datetime/g" | sed "s/MYEXP/${my_exposure}/g" > overlay0_tmp.conf

	# alter the ftp script to reflect the MAC address
	cat calibration_ftp.scr | sed "s/MACADDR/${hardware_address}/g" | sed "s/CUSTOMDATE/${ftp_datetime}/g" | sed "s/MYEXP/${my_exposure}/g"> ftp.scr

	# set fixed exposure
	echo "exposure=$i" > $config

	# sleep for some time to let exposure settle on the
	# set value
	sleep ${sleep_period}

	# dump overlay configuration to /dev/video/config0
	# device to adjust in memory settings
	# first grab the number of lines in the overlay0_tmp.conf
	# file, then write line by line to the video device
	nrlines=`awk 'END {print NR}' overlay0_tmp.conf`

	for k in `seq 1 $nrlines` ;
	do
	 awk -v p=$k 'NR==p' overlay0_tmp.conf > $config
	done

	# now grab and upload the image
	ftpscript ftp.scr > /dev/null 2>&1

	# provide some feedback on progress
	echo "uploaded image with exposure: $i"

done

echo "Calibration images acquired"
echo "============================================"

exit
