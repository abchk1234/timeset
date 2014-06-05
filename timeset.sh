#!/bin/bash
##timeset- A script to configure the system date and time on Linux
#Copyright (C) 2013-2014 Aaditya Bagga aaditya_gnulinux@zoho.com
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  any later version.
#
#  This program is distributed WITHOUT ANY WARRANTY;
#  without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  See the GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##

ver=1.3 # Version

# Gettext internationalization
export TEXTDOMAIN="timeset"
export TEXTDOMAINDIR="/usr/share/locale"

ROOT_UID=0 # Only users with $UID 0 have root privileges.
E_NOTROOT=87 # Non-root exit error.

#Colors
Blue="\e[1;34m"
Yel="\e[1;33m"
Green="\e[1;32m"
Red="\e[1;31m"
BOLD="\e[1m"
CLR="\e[0m"

# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ] ; then
	echo "$(gettext 'Must be root to run this script')"
	exit $E_NOTROOT
fi

# Check if timedatectl can be used and systemd is running
if [ -f /usr/bin/timedatectl && pidof systemd ]; then
	systd=1
fi

# Command List
if [ $systd ]; then
	#Systemd specific commands
	get_time() {
		timedatectl status
	}
	list_timezones() {
		timedatectl list-timezones
	}
	set_timezone() {
		timedatectl set-timezone "$1"
		echo "$(gettext 'Timezone set to') $1"
	}
	set_hwclock_local="timedatectl set-local-rtc 1"
	set_hwclock_utc="timedatectl set-local-rtc 0"
	set_time() {
		timedatectl set-time "$1"
	}
else
	#Generic Linux commands
	get_time() {
		echo -e "`date` (`date +%z`)" $BOLD "<-Local time" $CLR "\n`date -u` (UTC)"
	}
	list_timezones() {
		find /usr/share/zoneinfo/posix -type f -mindepth 2 -printf "%P\n" | sort |  less
	}
	set_timezone() {
		if [ -f "/usr/share/zoneinfo/posix/$1" ]; then
			ln -sf "/usr/share/zoneinfo/posix/$1" /etc/localtime	
			echo "$(gettext 'Timezone set to') $1"
		else
			echo "$(gettext 'Wrong timezone entered.')"
		fi
	}
	set_hwclock_local="hwclock --systohc --localtime"
	set_hwclock_utc="hwclock --systohc --utc"
	set_time() {
		if [[ "$1" == [0-9]*:[0-9]* ]] || [[ "$1" == "[0-9]*-[0-9]*-[0-9]* [0-9]*:[0-9]*:[0-9]*" ]] || [[ "$1" == "[0-9]*-[0-9]*-[0-9]* [0-9]*:[0-9]*" ]]; then date -s "$1"
		else echo "$(gettext 'Time not entered properly.')"
		fi
	}
fi

# Menu

ent=$(echo -e $BOLD "\n$(gettext 'Press Enter to continue...')" $CLR)

while :
do
    clear
    echo "----------------------------------------------------------------------"
    echo -e $Blue " $(gettext 'TimeSet(tings) - Configure system date and time')" $CLR
    echo "----------------------------------------------------------------------"
    echo 
    echo -e $Yel "[1]" $CLR $BOLD "$(gettext 'Show current date and time configuration')" $CLR
    echo -e $Yel "[2]" $CLR $BOLD "$(gettext 'Show known timezones (press q to return to menu)')" $CLR 
    echo -e $Yel "[3]" $CLR $BOLD "$(gettext 'Set system timezone')" $CLR
    echo -e $Yel "[4]" $CLR $BOLD "$(gettext 'Synchronize time from the network (NTP)')" $CLR
    echo -e $Yel "[5]" $CLR $BOLD "$(gettext 'Choose whether NTP is enabled or not')" $CLR 
    echo -e $Yel "[6]" $CLR $BOLD "$(gettext 'Control whether hardware clock is in UTC or local time')" $CLR
    echo -e $Yel "[7]" $CLR $BOLD "$(gettext 'Show the time and settings for the hardware clock')" $CLR
    echo -e $Yel "[8]" $CLR $BOLD "$(gettext 'Synchronize hardware clock to system time')" $CLR
    echo -e $Yel "[9]" $CLR $BOLD "$(gettext 'Synchronize system time to hardware clock time')" $CLR
    echo -e $Yel "[10]" $CLR$BOLD "$(gettext 'Set system time manually')" $CLR
    echo 
    echo -e $Red "[q] $(gettext 'Exit/Quit')\n" $CLR
    echo "======================================================================"
    echo -ne $Green "$(gettext 'Enter your choice') [1-10,q]:" $CLR
    read -e choice
    if [ ! "$choice" ]; then choice=0; fi;

# Commands

    case $choice in
      1) echo -e $BOLD "$(gettext 'Current date and time')" $CLR ; get_time ; echo $ent ; read;;
      2) list_timezones ;;
      3) echo -ne $BOLD "$(gettext 'Enter the timezone (It should be like Continent/City):')" $CLR ; read -e tz ; set_timezone $tz ; echo $ent ; read ;;
      4) echo -e $Green "$(gettext 'Synchronizing time from the network')\n $(gettext 'NTP should be installed for this to work.')\n" $CLR "$(gettext 'Please wait a few moments while the time is being synchronised...')" ; ntpdate -u 0.pool.ntp.org ; echo $ent ; read ;;
      5) if [ $sysd ]; then echo -ne $Green "$(gettext 'If NTP is enabled the system will periodically synchronize time from the network.')\n" $CLR $BOLD "$(gettext 'Enter 1 to enable NTP and 0 to disable NTP') :" $CLR ; read ntch; timedatectl set-ntp $ntch; else echo -e "$(gettext 'For this to work the ntp daemon (ntpd) needs to be installed.')\n$(gettext 'Furthur you may need need to edit /etc/ntp.conf (or similar) file, and then enable the ntp daemon to start at boot.')\n$(gettext 'This feature is distribution specific and not handled by this script.')"; fi; echo $ent; read ;;
      6) echo -ne $BOLD "$(gettext 'Enter 0 to set hardware clock to UTC and 1 to set it to local time :')" $CLR ; read rtcch; if [[ "$rtcch" == "1" ]]; then `$set_hwclock_local`; elif [[ "$rtcch" == "0" ]]; then `$set_hwclock_utc`; else echo "$(gettext 'Incorrect choice entered.')"; fi;  echo $ent; read ;;
      7) hwclock -D ; echo $ent; read ;;
      8) hwclock -w ; echo $ent; read ;;
      9) hwclock -s ; echo $ent; read ;;
      10) echo -ne $Green "$(gettext 'Enter the time.')\n $(gettext 'The time may be specified in the format 2012-10-30 18:17:16')\n $(gettext 'Only hh:mm can also be used.')" $CLR "\n" $BOLD "$(gettext 'Enter the time:')" $CLR ; read -e time; set_time "$time"; echo $ent; read ;;
      q) exit 0 ;;
      0) ;;
      *) echo -e $Red "$(gettext 'Oops!!! Please a valid choice!')" $CLR ;
         echo $ent ; read ;;
    esac
done
exit 0
