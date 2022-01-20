A bash script to manage system date and time.

# Requires

* ntp (for using ntpdate to synchronise time from the network)

# Installation

Install it (as root):

~~~~
 # make install
~~~~

For Manjaro Linux users its available in the Manjaro repositories.

For Arch Linux users check out http://aur.archlinux.org/packages/timeset/

# Usage

Run the script as root.

~~~~
 # timeset
~~~~

# Program output

~~~~
----------------------------------------------------------------------
  TimeSet(tings) - Configure system date and time 
----------------------------------------------------------------------

 [1]   Show Current Date and Time Configuration 
 [2]   Show Known Timezones (press q to return to menu) 
 [3]   Set System Timezone 
 [4]   Synchronize Time from the Network (NTP) 
 [5]   Control whether NTP is used or not 
 [6]   Control whether hardware clock is in UTC or local time 
 [7]   Show the time and settings for the hardware clock 
 [8]   Synchronize Hardware Clock to System Time 
 [9]   Synchronize system time to hardware clock time 
 [10]  Set System Time manually 

 [q] Exit/Quit
 
======================================================================
~~~~

# Links

https://classicforum.manjaro.org/index.php?topic=7067.0

https://github.com/abchk1234/timeset-gui
