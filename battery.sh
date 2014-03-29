while true; do 
    BATTLEVEL=$(acpi -b | awk -F ', |%' '{print $2}')
    if [ $BATTLEVEL \> 75 ]; then
	STATCOL="green"
	ICON="bat_full_cm.xbm"
    else 
	if [ $BATTLEVEL \> 50 ]; then
	    STATCOL="yellow"
	    ICON="bat_mid_cm.xbm"	
	else 
	    if [ $BATTLEVEL \> 25 ]; then
		STATCOL="orange"
		ICON="bat_low_cm.xbm"
	    else
		STATCOL="red"
		ICON="bat_empty_cm.xbm"
	    fi
	fi
    fi
    BATTSTATUS=$(acpi -b | awk -F ' |,' '{print $3}')
    if [ "$BATTSTATUS" = "Charging" ]; then
	STATCOL="green"
	ICON="power-ac.xbm"
    fi
    echo "^fg($STATCOL)^i(/home/cassie/git/dzen/bitmaps/$ICON) $BATTLEVEL%"
    acpi -b | awk -F ', ' '{print $3}'
    sleep 1
done | dzen2 -w 180 -tw 100 -ta c -sa c -l 1 -u -x 975 