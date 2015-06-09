#!/bin/bash

#Runs through SmartCtl Hard Drive Test

#
echo smartctl -i $1 | awk -F: '($1 ~ /Serials/){ print $2 } ' 


#Does a Health Test
smartctl -H $1 >> smartctl.txt

smartctl -t short $1
echo
echo Wait until first test is done then press [Enter]
read line


smartctl -t short $1
echo
echo Second test is starting wait until complete
read line2

#Outputs the results of the test
smartctl -l selftest $1 >> smartctl.txt

#Shows final output
cat smartctl.txt

#rm smartctl.txt
