export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
PATH='/usr/local/sbin:/usr/local/bin:/usr/bin:~/apps/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl'
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
if [[ "$(tty)" == '/dev/tty1' ]]; then
	exec i3
fi
if [[ "$(tty)" == '/dev/tty2' ]]; then
	exec cinnamon-session
	exec sh .startup
	exec --no-startup-id exec fcitx
fi

