#!/bin/sh

##################
#Proof of concept#
##################
if [ $# -eq 0 ]; then
 echo "Usage: Enter a set of folders to search"
 echo "EX: ./script.sh /var/"
 echo "Do not append a '*' to the search, as this script does it for you"
 echo "add a second argument if you wish to search a set of keywords"
 exit 1
fi

echo "[+] Beginning execution"
echo "[+] It is not recommended to run this from the / directory, as it may cause instability"
touch spottedFiles.txt
ls -R $1/*  > spottedFiles.txt
echo "######################################" >> spottedFiles.txt
echo "[+] System Search Complete"
echo "######################################"
echo "[+] Now executing directory dive"
touch directoryDive.txt
ls -lR $1/* | grep -o "[d].........[' '].*" >> directoryDive.txt
echo "[+] Directories have been dumped recursively into directoryDive.txt"
echo "[+] Scanning the text files within"
touch fileDiver.txt
echo "######################################" >> fileDiver.txt
echo "These are the files present in each directory" >> fileDiver.txt
echo "######################################" >> fileDiver.txt
ls -lR $1/* |  grep -o "[-].........[' '].*" >> fileDiver.txt
