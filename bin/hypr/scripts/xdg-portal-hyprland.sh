#!/bin/bash

sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall  xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 1
/usr/libexec/xdg-desktop-portal &
sleep 1
/usr/libexec/xdg-desktop-portal-wlr &
