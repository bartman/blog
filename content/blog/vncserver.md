+++
title = 'multi user vncserver'
date = '2025-10-04T12:49:54-04:00'

categories = ["blog"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["linux", "vnc"]
keywords = ["linux", "vnc"]
description = ""
showFullContent = false
readingTime = true
hideComments = false
+++

Let's setup an Ubuntu 24.04 Server and give multiple users to it using VNC.

So, I have an Ubuntu 24.04 server in the lab, and I need to get multiple users
to VNC in.  Not my favourite way to use a UNIX system, but all the hardware
tools are graphical, and this is the way design is done.

To keep things light, we will use `lightdm` greeter and `xfce4` desktop.

<!--more-->

I'm assuming that you know how to setup Linux user accounts, SSH server,
SSH keys, and all that stuff.

## Initial System Preparation
- Update system:
  ```
  sudo apt update
  sudo apt upgrade -y
  ```

- Install lightweight desktop and display manager:
  ```
  sudo apt install xfce4 xfce4-goodies lightdm -y
  ```
  Select lightdm during installation.

- Install extra fonts:
  ```
  sudo apt install xfonts-base xfonts-75dpi xfonts-100dpi xfonts-scalable -y
  ```

- Install dummy video driver:
  ```
  sudo apt install xserver-xorg-video-dummy -y
  ```

- Configure `/etc/X11/xorg.conf`:
  ```
  Section "Device"
      Identifier "Configured Video Device"
      Driver "dummy"
      VideoRam 256000
  EndSection

  Section "Monitor"
      Identifier "Configured Monitor"
      HorizSync 5.0 - 1000.0
      VertRefresh 5.0 - 200.0
      Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
      Option "PreferredMode" "1920x1080_60.00"
  EndSection

  Section "Screen"
      Identifier "Default Screen"
      Monitor "Configured Monitor"
      Device "Configured Video Device"
      DefaultDepth 24
      SubSection "Display"
          Depth 24
          Viewport 0 0
          Virtual 1920 1080
          Modes "1920x1080_60.00"
      EndSubSection
  EndSection
  ```

- Enable graphical boot:
  ```
  sudo systemctl set-default graphical.target
  sudo reboot
  ```

- Disable LightDM (to avoid conflicts):
  ```
  sudo systemctl stop lightdm
  sudo systemctl disable lightdm
  ```
  ... this is optional, but I don't need any local logins.

- Purge GNOME/Ubuntu desktop:
  ```
  sudo apt purge gnome* ubuntu-desktop -y
  sudo apt autoremove -y
  ```
  ... it's slow over VNC.

- Purge Wayland packages:
  ```
  sudo apt purge wayland* libwayland* -y
  sudo apt autoremove -y
  ```

- Set XFCE as default session for all future users:
  ```
  echo -e "[Desktop]\nSession=xfce.desktop" > /etc/skel/.dmrc
  ```

- Set XFCE as default session (for each existing user):
  ```
  echo -e "[Desktop]\nSession=xfce.desktop" > ~/.dmrc
  ```

## Disable Suspend and Power Management
- Mask suspend targets:
  ```
  sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
  ```

- Configure XFCE power manager (`/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml`):
  ```
  <?xml version="1.0" encoding="UTF-8"?>

  <channel name="xfce4-power-manager" version="1.0">
    <property name="power-manager" type="empty">
      <property name="inactivity-on-ac" type="uint" value="0"/>
      <property name="inactivity-sleep-mode-on-ac" type="int" value="0"/>
    </property>
  </channel>
  ```
  ... without this change, XFCE would suspend the system when idle.

- Disable LightDM greeter suspend (install dbus-x11 first):
  ```
  sudo apt install dbus-x11 -y
  sudo -u lightdm dbus-launch gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
  sudo -u lightdm dbus-launch gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
  sudo -u lightdm dbus-launch gsettings set org.gnome.desktop.session idle-delay 0
  sudo systemctl restart lightdm
  ```
  ... if you disabled lightdm above you don't need this.

## Handle Notifications and Snap
- Fix xfce4-notifyd (`/etc/systemd/user/xfce4-notifyd.service.d/override.conf`):
  ```
  [Service]
  Environment="DISPLAY=:0"
  ```
  ```
  sudo systemctl daemon-reload
  sudo systemctl restart lightdm
  ```
  ... only restart if you still have lightdm enabled.

- Remove snapd-desktop-integration:
  ```
  sudo snap remove snapd-desktop-integration
  ```
  ... optional, but it spamming my logs with messages.

## TigerVNC Installation and Configuration
- Install TigerVNC:
  ```
  sudo apt install tigervnc-standalone-server tigervnc-common -y
  ```

- Make VNC start `xfce4` desktop for any future user:
  - Edit `/etc/skel/.vnc/xstartup`:
    ```
    #!/bin/sh
    unset SESSION_MANAGER
    unset DBUS_SESSION_BUS_ADDRESS
    exec startxfce4
    ```
    then
    ```
    chmod +x /etc/skel/.vnc/xstartup
    ```

- For each user:
  - Edit `~/.vnc/xstartup`:
    ```
    #!/bin/sh
    unset SESSION_MANAGER
    unset DBUS_SESSION_BUS_ADDRESS
    exec startxfce4
    ```
    then
    ```
    chmod +x ~/.vnc/xstartup
    ```

- Create `/etc/systemd/user/vncserver@.service`:
  ```
  [Unit]
  Description=VNC Server for display :%i
  After=network.target

  [Service]
  Type=simple
  ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :'
  ExecStart=/usr/bin/vncserver :%i -geometry 1920x1080 -depth 24 -localhost no -SecurityTypes Plain -pam_service login -fg
  ExecStop=/usr/bin/vncserver -kill :%i
  Restart=always

  [Install]
  WantedBy=default.target
  ```

- Enable linger for each user:
  ```
  sudo loginctl enable-linger <user>
  ```

- As each user, enable and start service (e.g., userA on :1, userB on :2, userC on :3):
  ```
  systemctl --user daemon-reload
  systemctl --user enable userN@<X>
  systemctl --user start userN@<X>
  ```
  (replace `N` and `X` with username and X session number)

## Firewall Configuration
- Allow VNC ports from VPN subnet:
  ```
  sudo ufw allow from 10.0.0.0/8 to any port 5900:5999 proto tcp
  sudo ufw reload
  ```

## Connection
- Connect with TigerVNC client: `vncviewer -SecurityTypes Plain <server-ip>:590<N>`
- Use system username and password for authentication.

