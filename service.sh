#!/system/bin/sh

BACKLIGHT="/sys/class/backlight/panel0-backlight/brightness"
BL_POWER="/sys/class/backlight/panel0-backlight/bl_power"
EVENT="/dev/input/event0"

sleep 10

while true; do
    getevent -lt "$EVENT" 2>/dev/null | while read -r line; do

        case "$line" in
            *"KEY_POWER"*"DOWN"*)
                i=0

                while [ "$i" -lt 30 ]; do
                    bl_power=$(cat "$BL_POWER" 2>/dev/null)
                    brightness=$(cat "$BACKLIGHT" 2>/dev/null)

                    if [ "$bl_power" = "0" ] && [ "$brightness" != "0" ] && [ -n "$brightness" ]; then
                        break
                    fi

                    sleep 0.05
                    i=$((i + 1))
                done

                case "$brightness" in
                    ''|*[!0-9]*)
                        continue
                        ;;
                esac

                if [ "$bl_power" = "0" ] && [ "$brightness" -gt 0 ]; then
                    if [ "$brightness" -eq 2047 ]; then
                        echo 2046 > "$BACKLIGHT"
                        sleep 0.05
                        echo 2047 > "$BACKLIGHT"
                    else
                        echo $((brightness + 1)) > "$BACKLIGHT"
                        sleep 0.05
                        echo "$brightness" > "$BACKLIGHT"
                    fi
                fi
                ;;
        esac

    done

    sleep 1
done
