xrdb .Xresources-no-dpi
xrandr --output eDP-1 --scale 0.75x0.75
xrandr --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output eDP-1 --primary --pos 224x1080 --rotate normal --output DP-2 --off
killall compton
