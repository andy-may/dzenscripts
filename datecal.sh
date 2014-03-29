while true; do
    date
    cal | tail -n 7
    sleep 1
done | dzen2 -ta l -tw 205 -l 7 -u -w 200 -x 1075