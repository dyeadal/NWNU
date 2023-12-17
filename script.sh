#!/bin/bash

# variable for BASH script file name
scriptFile="weekly_reboot.sh"

resetText='\033[0m'
greenText='\033[0;32m'
redText='\033[0;31m'

# function to prompt admin if they want to test reboot script before moving file to cron directory
testScript() {
  # prompt to test reboot script
  read -p "Test reboot script before installing on system? (y/n)" testInput
  case "$testInput" in
    [yY])
      echo "Rebooting"
      ./weekly_reboot.sh
      ;;
    [nN])
      echo "Not rebooting"
      # prompt to install script to cronjob
      read -p "Install script on system? (y/n)" installInput
      case "$installInput" in
      
        [yY])
          installScript
          ;;
        [nN])
          echo "Exiting script"
          ;;
        esac
      ;;
  esac    
}

#function to create the script
createScript(){
  # create the script
    echo "Creating reboot script"
    echo "reboot" > $scriptFile
    chmod +x weekly_reboot.sh
}

# function to install script
installScript() {
  # invoke the createDir function
  createDir
  # prompt for hour and day
  echo " 0 - Sunday\n 1 - Monday\n 2 - Tuesday\n 3 - Wednesday\n 4 - Thursday\n 5 - Friday\n 6 - Saturday"
  read -p "Reboot on which day?: " day
  read -p "Reboot on which hour? (0-23): " hour

  # add cron entry using user input 
  cron_task = "0 $hour * * $day 0 $HOME/.scripts/$scriptfile"
  (crontab -l ; echo "$crontask") | crontab
}

# function to create directory
createDir() {
  # if directory does not exist then
  if [ -d "~/.scripts" ]; then 
    #creates .scripts directory on the running users home profile
    mkdir $HOME/.scripts
    # copy scriptfile to .scripts/ in user's home directory
    cp $scriptfile $HOME/.scripts/
  fi
}

scriptExists(){
  if [ -e $scriptFile ]; then 
    return 0
  else 
    return 1
  fi
}

startMenu(){
  echo -e "${greenText}      New Week, New Uptime (NWNU)${resetText}"
  echo "Schedule Weekly Reboot cron jobs easily"
  echo ""
  echo ""
  echo "1) Create reboot script"
  echo "2) Test adding reboot job"
  echo "3) Install reboot job"
  echo "4) Remove reboot job"
  echo ""

  

  if scriptExists; then
    echo -e "${greenText}Script: created${resetText}"
  else
    echo -e "${redText}Script: not found${resetText}"
  fi
}

startMenu