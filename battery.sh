#! /bin/bash
COUNTER=0
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

    BATTSTATUS=$(acpi -b | awk -F ' |,|-' '{print $3}')
    CHARGESTATUS=$(acpi -b | awk -F ', ' '{print $3}')

    if [ "$BATTSTATUS" = "Unknown" -o $BATTLEVEL == 100 ]; then
	STATCOL="green"
	ICON="power-ac.xbm"
	CHARGESTATUS="Running off AC power"
    else
	if [ "$BATTSTATUS" = "Charging" ]; then
	    STATCOL="green"
	    case $COUNTER in
		0)
		    ICON="bat_empty_cm.xbm"
		    ((COUNTER++))
		    ;;
		1)
		    ICON="bat_low_cm.xbm"
		    ((COUNTER++))
		    ;;
		2)
		    ICON="bat_mid_cm.xbm"
		    ((COUNTER++))
		    ;;
		3)
		    ICON="bat_full_cm.xbm"
		    COUNTER=0
		    ;;
	    esac
	fi
    fi


    echo "^fg($STATCOL)^i(/home/cassie/git/dzen/bitmaps/$ICON) $BATTLEVEL%"
    echo "$CHARGESTATUS"
    sleep 1
done | dzen2 -w 200 -tw 90 -ta c -sa c -l 1 -u -x 985 -e 'button1=togglecollapse'