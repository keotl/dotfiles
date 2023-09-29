
```
sudo apt install waybar sway fonts-font-awesome rofi rxvt-unicode papirus-icon-theme arc-theme lxappearance fonts-firacode feh swaylock

copy -r .config/ ~/
copy -r .xkb/ ~/
copy .Xresources ~/
sudo mkdir -p /etc/acpi/actions
sudo cp brightnesscontrol/actions/* /etc/acpi/actions/
sudo cp brightnesscontrol/events/* /etc/acpi/events/
sudo cp systemd/lockOnSleep.service /etc/systemd/system/
sudo systemctl enable lockOnSleep
```
