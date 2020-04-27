#!/bin/bash
filearr=()
outputnames=()
if [ $# -eq 0 ];
then
	echo "USAGE: To compile scripts present in the booksrc directory and output them to compiledExamples directory "
	echo "Example: "
	echo "./compiler.sh -A ~/Documents/Code/UncompiledFiles filename.c filename.c filename.c "
elif [ $1 == "-h" ];
then
	echo "DOCUMENTATION"
	echo "This program can be used to compile multiple scripts present in a directory"
	echo "Programs can be compiled based on if a user would like ASLR enabled or disabled. 
This is done using the -En flag for normal compiling, and -Dis to disable ASLR checks for the program. Its worth noting that this just disables the 'canaries' and not actually disable ASLR system wide. please enable this on your system if you intend to use the Dis flag."
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


