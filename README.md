# Power-Brightness-Wake-Fix
Magisk module to fix screen brightness issues with aftermarket displays on Redmi Note 10 Pro

The issue occurred when turning off the screen. Pressing the power button would keep the screen black, even though the system actually woke up as if the brightness was stuck at 0%. This was likely caused by the aftermarket display or driver issues in LineageOS. This Magisk module applies a minor brightness adjustment right after the power button is pressed, forcing the display to turn on.

This module is just a workaround, not a fix for the underlying issue.

Place the files in /data/adb/modules/power_brightness_fix and set 755 permissions for the service.sh file.
