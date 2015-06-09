#!/bin/bash

#Runs through SmartCtl Hard Drive Test

#Outputs the the drives Serial Number as the identifier
echo 
serial=`smartctl -i $1 | awk -F: '($1 ~ /Serial/){ print $2 } '` 
smartctl -i $1 >> $serial.txt
echo Drive Serial: $serial
echo

#Does a Health Test and outputs the status
health=`smartctl -H $1 | awk -F: '($1 ~ '/SMART/') { print $2 }'`
smartctl -H $1 >> $serial.txt
echo Drive Health: $health

#Starts a short test (#2)
smartctl -t short $1 > /dev/null

#Waits for the first test to complete
wait=`smartctl -t short /dev/sdd | awk '($1 ~ '/Please/') { print $3 }'`
echo
echo The test will resume in $wait minute
sleep $wait'm'

#Starts the second short test and also waits for it to complete (#1)
smartctl -t short $1 > /dev/null
echo Results will print in $wait minute
echo
sleep $wait'm'

#Outputs the results of the test to a file named by the serial number
smartctl -l selftest $1 >> $serial.txt

#Shows the final test output. The reuslts show up in descending order so the test will the #1 and #2
tail $serial.txt
