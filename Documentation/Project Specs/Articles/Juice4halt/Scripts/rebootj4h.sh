#!/bin/bash

#title           :rebootj4h
#description     :This script runs on Raspberry Pi equipped with the Juice4Halt module. It substitutes the default reboot command which is not compatible with the Juice4halt module.
#			      The rebootj4h script works only in cooperation with the shutdown_script. The shutdown_script must be started before executing the rebootj4h script.
#author		     :Nelectra s.r.o.
#date            :20190415
#version         :1.1  (bug fixed: missing comment sign on line 5) 
#usage		     :copy this file to /home/pi/juice4halt/bin/
#		          and make it executable: sudo chmod 755 rebootj4h 	
#notes           :www.juice4halt.com
#copyright	     :GNU GPL v3.0	
#==============================================================================

#the GPIO line must be configured in the shutdown_script before executing this script

sleep 0.2s
 
# use the pin as an open-drain output, send a short LOW pulse (means: deactivate the automatic shutdown at the J4H module)
# after that change to input
 
# set GPIO25 as output and set output to LOW
echo "out" > /sys/class/gpio/gpio25/direction
echo "0" > /sys/class/gpio/gpio25/value
sleep 0.1s
echo "in" > /sys/class/gpio/gpio25/direction
 
#wait until pin rises to HI
sleep 0.1s
 
# reboot the RPi
# wait for system reboot
# during reboot process the GPIO pin will not change it's state
# after rebooting the shutdown_script will be started again and enables the automatic shutdown at the J4H module by sending a short LOW pulse to the GPIO line.

echo ""
echo "Juice4halt: RPi will reboot now"
sudo reboot
