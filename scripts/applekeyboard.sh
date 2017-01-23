echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
echo options hid_apple iso_layout=0 | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all
sudo reboot
