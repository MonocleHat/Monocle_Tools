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
		echo "[DEBUG] Dir: $directory"
		shift
		for y in $@
		do
			filearr+=($y)
			echo "[DEBUG] ArrFiles:  ${filearr[@]}"
		done
		for x in ${filearr[@]}
		do
			echo -n  "Please enter an output filename for $x: "
			read filename
			outputnames+=($filename)
			echo "[DEBUG] output: ${outputnames[@]}"
		done
	fi

fi


