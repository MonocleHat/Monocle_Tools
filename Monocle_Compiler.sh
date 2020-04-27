#!/bin/bash
filearr=()
outputnames=()
if [ $# -eq 0 ];
then
	echo "USAGE: for bulk compilation of scripts from one directory to be output to another "
	echo "Example: "
	echo "./Monocle_Compiler.sh -En ~/Documents/Code/UncompiledFiles filename.c filename.c filename.c "
elif [ $1 == "-h" ];
then
	echo "[+] '-h' Display this list"
	echo "[+] '-En' Regularly compile the files using gcc with stack protections/canaries"
	echo "[+] '-Dis' Disable stack protections for gcc compiled programs, will not work if ASLR not disabled"
	echo "[+] Disabling ASLR on a system: 'sudo bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space'"
	echo "[+] If it doesnt work for your system then there may be different instructions in place for your kernel. Read your manuals"
elif [ $# -gt 0 ];
then
	if [ $1 == '-En' ];
	then
		shift
		directory=$1
		shift
		echo -n "Enter output directory (relative path, dont end with '/'): "
		read userdir
		dest=$userdir
		for y in $@
		do
			filearr+=($y)
		done
		for x in ${filearr[@]}
		do
			echo -n  "Please enter an output filename for $x: "
			read filename
			outputnames+=($filename)
		done
		i=0
		for z in ${filearr[@]}
		do
			
			gcc $directory/$z -o $dest/${outputnames[$i]}
			((i++))
		done
	fi
	if [ $1 == '-Dis' ];
	then
		shift
		directory=$1
		shift
		echo -n "Enter output directory (relative path, dont end with '/'): "
		read userdir
		dest=$userdir
		for y in $@
		do
			filearr+=($y)
		done
		for x in ${filearr[@]}
		do
			echo -n  "Please enter an output filename for $x: "
			read filename
			outputnames+=($filename)
		done
		i=0
		for z in ${filearr[@]}
		do
			
			gcc $directory/$z -o $dest/${outputnames[$i]} -fno-stack-protector
			((i++))
		done
	echo "[+] Remember to disable ASLR before testing your scripts"
	echo "[+] Use: sudo bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space' to disable it"
	echo "[+] Renable after testing to prevent unintentional overflows of programs that could be critical to system functions or production networks"
	fi
	
fi


