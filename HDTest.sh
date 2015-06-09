#!/bin/bash

#Runs through SmartCtl Hard Drive Test


#Makes the Serial Number the File Header 
serial=`smartctl -i $1 | awk -F: '($1 ~ /Serial/){ print $2 } '` 
smartctl -i $1 >> $serial.txt
echo $serial

#Does a Health Test
smartctl -H $1 >> $serial.txt

#Runs SHORT tests 
smartctl -t short $1
echo
echo Wait until first test is done then press [Enter]

read line

smartctl -t short $1
echo
echo Second test is starting wait until complete

read line2

#Outputs the results of the test
smartctl -l selftest $1 >> $serial.txt

#Shows final output
cat $serial.txt
