#!/bin/bash

#Runs through SmartCtl Hard Drive Test

#Outputs the
echo 
serial=`smartctl -i $1 | awk -F: '($1 ~ /Serial/){ print $2 } '` 
smartctl -i $1 >> $serial.txt
echo Drive Serial: $serial
echo

#Does a Health Test
health=`smartctl -H $1 | awk -F: '($1 ~ '/SMART/') { print $2 }'`
smartctl -H $1 >> $serial.txt
echo Drive Health: $health

smartctl -t short $1 > /dev/null

wait=`smartctl -t short /dev/sdd | awk '($1 ~ '/Please/') { print $3}'`
echo
echo The test will resume in $wait minute
sleep $wait'm'

smartctl -t short $1 > /dev/null
echo Results will print in $wait minute
echo
sleep $wait'm'

#Outputs the results of the test
smartctl -l selftest $1 >> $serial.txt

#Shows final output
tail $serial.txt
