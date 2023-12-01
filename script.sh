#!/bin/bash

while true; do
  if [ -e "weekly_reboot.sh"]; then
    read -p "Test reboot script before installing? (y/n): " testCheck
  else:
    echo "/sbin/reboot" > weekly_reboot.sh
    chmod +x weekly_reboot.sh
  fi


