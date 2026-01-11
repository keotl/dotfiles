# Append input group to /etc/group
grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
sudo groupadd --system uinput

# Create udev rule
/etc/udev/rules.d/99-input.rules
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"

# Create kanata user
sudo useradd kanata
sudo usermod -a -G uinput kanata
sudo usermod -a -G input kanata

## Set up files
- /home/kanata/bin/kanata
- /home/kanata/kanata.kbd

# Systemd unit
sudo cp kanata.service /etc/systemd/system/kanata.service

# SELinux setup
```
sudo dnf install policycoreutils-python-utils

sudo ausearch -m avc -ts recent | audit2allow -M kanata_policy
# Review the policy
cat kanata_policy.te

# Install the policy
sudo semodule -i kanata_policy.pp
```

# Disable network access for kanata user
```
FW_UID="$(id -u kanata)"
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter \
    OUTPUT 0 ! -o lo -m owner --uid-owner ${FW_UID} -j REJECT
sudo firewall-cmd --permanent --direct --add-rule ipv6 filter \
    OUTPUT 0 ! -o lo -m owner --uid-owner ${FW_UID} -j REJECT
sudo firewall-cmd --reload
```
