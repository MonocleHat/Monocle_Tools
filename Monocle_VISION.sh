#!/bin/sh
########################################
####         Monocle Vision         ####
####     An Enumeration Script by   ####
####           Monocle Hat          ####
########################################
 if [ $# -eq 0 ]; then
 echo "Usage: Recursively mass scan directories and folders
 check directories for files and their permissions, storing each of these into a file
 for later review"
 echo "Takes two args."
 echo "Arg 1 = The directory listing to crawl through
 Arg 2 = The name of the scan session/user picked file name"
 echo "EX: ./Monocle_VISION.sh /var/www/ ServerScan
 Scans: All files in /var/www/, output files are spottedFiles_ServerScan, directoryDive_ServerScan, and fileDiver_ServerScan"
 echo "Sudo mode may be required"
 exit 1
fi

echo "[+] Beginning execution"
echo "[+] It is not recommended to run this from the / directory, as it may cause instability"
sleep 3s
echo "[+] Starting Mass Scan"
touch spottedFiles_$2.txt
echo "######################################" >> spottedFiles_$2.txt
echo "[+] Complete Crawl is below." >> spottedFiles_$2.txt
echo "######################################" >> spottedFiles_$2.txt
ls -R $1*  >> spottedFiles_$2.txt
echo "######################################" >> spottedFiles_$2.txt

echo "######################################" 
echo "[+] System Search Complete"
echo "######################################"
sleep 2s
echo "[+] Now executing directory dive"
echo "######################################"
touch directoryDive_$2.txt
echo "######################################" >> directoryDive_$2.txt
echo "[+] Directory Listings Below" >> directoryDive_$2.txt
echo "######################################" >> directoryDive_$2.txt
echo "[+] Beginning directory dive"
ls -lR $1* | grep -o "[d].........[' '].*" >> directoryDive_$2.txt
echo "######################################" >> directoryDive_$2.txt

echo "[+] Directories have been dumped recursively into directoryDive.txt"
sleep 2s
echo "[+] Scanning the text files within, this will display the contents and permissions"

touch fileDiver_$2.txt
echo "######################################" >> fileDiver_$2.txt
echo "[+] File Listings Below" >> fileDiver_$2.txt
echo "######################################" >> fileDiver_$2.txt
ls -lR $1* |  grep -o "[-].........[' '].*" >> fileDiver_$2.txt
echo "######################################" >> fileDiver_$2.txt

echo "[+] Script has completed"
echo "[+] Your results are present in spottedFiles/fileDiver/directoryDive.txt"
