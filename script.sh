#!/bin/bash

# variable for BASH script file name
scriptFile="weekly_reboot.sh"

# function to prompt admin if they want to test reboot script before moving file to cron directory
testScript() {
  read -p "Test reboot script before installing on system? (y/n)" testInput
  case "$testInput" in
    [yY])
      echo "Rebooting"
      ./weekly_reboot.sh
    [nN])
      echo "Not rebooting"
      read -p "Test reboot script before installing on system? (y/n)" installInput
      case "$installInput" in
        [yY])
          installScript
        [nN])
          echo "Exiting script"
        esac
  esac    
}

# function to install script
installScript() {
  createDir
  # prompt for hour and day
  echo " 0 - Sunday\n 1 - Monday\n 2 - Tuesday\n 3 - Wednesday\n 4 - Thursday\n 5 - Friday\n 6 - Saturday"
  read -p "Reboot on which day?: " day
  read -p "Reboot on which hour? (0-23): " hour

  # add cron entry
  cron_task = "0 $hour * * $day 0 $HOME/.scripts/$scriptfile"
  (crontab -l ; echo "$crontask") | crontab
}

# function to create directory
createDir() {
  if [ -d "~/.scripts" ]; then 
  #creates .scripts directory on executing users home profile
  mkdir $HOME/.scripts
  cp $scriptfile $HOME/.scripts/
}

# function to remove cron job
removeJob(){
  # code
}

# checks if file exists, if not it creates it, also prompts if admin wants to test script
while true; do 
  if [ -e $scriptFile ]; then # file exists
    testScript
  else # file does NOT exist
    echo "/sbin/reboot" > weekly_reboot.sh
    chmod +x weekly_reboot.sh
  fi


