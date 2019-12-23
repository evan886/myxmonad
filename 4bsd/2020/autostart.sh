#!/bin/bash
# 
# xmonad "startup hook" script. This gets run after xmonad is initialized,
# via the startupHook facility provided by xmonad. It's useful for 
# running any programs which you want to use within xmonad but
# which don't need to be initialized before xmonad is running. 
#
# Author: David Brewer
# Repository: https://github.com/davidbrewer/xmonad-ubuntu-conf

#
# TRAY ICON SOFTWARE  on bsd 

#but not workspa name 
#xmobar -d ~/.xmonad/xmobarrc

#stalonetray  &
stalonetray \
  --icon-gravity E \
 --geometry 5x1-0+0 \
  --max-geometry 5x1-0+0 \
  --background '#000000' \
  --skip-taskbar \
  --icon-size 24 \
  --kludges force_icons_size \
  --window-strut none \
  &
#
#  这个在bsd上会被全屏盖住
#  apt install trayer  Set up an icon tray   2016-09-07pm
#trayer --edge top --align right --SetDockType true --SetPartialStrut true \
#      --expand true --width 9 --transparent true --tint 0x191970 --height 26 &

## mouse xmonad默认不设定鼠标光标，因此光标一直呈“X”形可能会让新用户误以为xmonad还没启动完毕或启动出错。将下面的命令添加到启动脚本，就可以将光标设置成常见的左键头形状: 
xsetroot -cursor_name left_ptr

# Empathy chat client (-h: start hidden, -n: don't connect on launch)
if [ -z "$(pgrep xscreensaver)" ] ; then
#    empathy -h -n &
xscreensaver -no-splash &
fi
# redshift
if [ -z "$(pgrep redshift)" ] ; then
    redshift   &
    #redshift  -i &
fi
#  201910 Remmina remote desktop connection client (-i: start hidden)
#if [ -z "$(pgrep remmina)" ] ; then
#    remmina -i &
#fi

# Network manager, so we don't have to configure wifi at the command line.
if [ -z "$(pgrep nm-applet)" ] ; then
    #nm-applet 
    nm-applet --sm-disable &
    /usr/sbin/NetworkManager --no-daemon
fi

# Applet for managing print jobs from the tray.
if [ -z "$(pgrep system-config-printer-applet)" ] ; then
    system-config-printer-applet &
fi

#
# APPLICATION LAUNCHER
#

#http://do.cooperteam.net/
# Use fcitx
#if [ -z "$(pgrep fcitx)" ] ;
#then
    fcitx  -r &
#fi

# Use synapse as our app launcher. (-s: don't display until requested) 
#if [ -z "$(pgrep kupfer)" ] ; then
#    kupfer -s 
#    kupfer -s &
#fi

# Use synapse as our app launcher. (-s: don't display until requested) 
if [ -z "$(pgrep synapse)" ] ; then
    synapse -s &
fi

# On login, we unlock the ssh keychain so we're not prompted for 
# passphrases later. We pipe /dev/null to ssh-add to make it realize 
# it's not running in a terminal. Otherwise, it won't launch the prompt.
# 
# If you don't use the ssh keychain you may not want this. Commented
# by default as it is assumed many users will not want this feature.

# export SSH_ASKPASS="/usr/bin/ssh-askpass"
# cat /dev/null | ssh-add &

# I disable the middle mouse button because otherwise I constantly 
# accidentally paste unwanted text in the middle of my code while scrolling. 
# Note that the id of the mouse device may be different depending on 
# which usb port it is plugged into! To find it, use:
# xinput list |grep 'id='
# In the following command, the id is the first argument, the rest is 
# the remapping.

# Commented by default as it is assumed many users will not want this.
# xinput set-button-map 10 1 0 3 4 5 6 7

#关闭touchpad
# I disabled my touchpad because I hate those things. You can find the id
# of a device you want to disable using "xinput list"; unfortunately it can
# change depending on what devices you have plugged into USB. We extract the
# id of the device from the output of xinput, then use it to disable the
# device
#by evan  触摸板 看起来无效的 201910 sysmouse is mouse
#TOUCHPAD_ID=`xinput | grep 'Synaptics TouchPad' | cut -f 2 | cut -f 2 -d =`
#TOUCHPAD_ID=`xinput | grep 'core' | cut -f 2 | cut -f 2 -d =`
#xinput set-prop $TOUCHPAD_ID "Device Enabled" 0
