```
sudo dd if=/dev/zero of=/swapfile bs=1024 count=10000k
sudo chown root:root /swapfile
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
findmnt -no UUID -T /swapfile
sudo swap-offset /swapfile
```

fstab
```
/swapfile	none	swap	sw	0	0
```

/etc/default/grub
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=24a8823d-9927-4515-8806-dce0a45e3a12 resume_offset=160503808 mem_sleep_default=deep"
```

```
sudo update-grub
```

/etc/initramfs-tools/conf.d/resume
```
RESUME=UUID=24a8823d-9927-4515-8806-dce0a45e3a12 resume_offset=160503808
```

```
sudo update-initramfs -c -k all
```

/etc/systemd/logind.conf
```
HandleLidSwitch=suspend-then-hibernate
```
/etc/systemd/sleep.conf
```
HibernateDelaySec=60min
```

