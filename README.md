# Monocle_Tools
a set of simple tools and scripts

# Monocle_VISION
Allows the user to scan an entirety of a directory, recursively, and list off each directory, and each file within.
User can provide arguments to specify directories, and through options will be able to list if they want to store outputs into seperate files, or into a singular file.
2020-01-21
Right now the program has a basic set up. it WORKS. just not very well. Im working on improving it in between classes when i can. 


# Monocle_COMPILER
Im currently working through a set of books on cybersecurity. One such book is the Art of Exploitation, which has a series of scripts that can be compiled and analyzed by a user. Since i figured i repeatedly would be compiling these scripts in a bulk fashion, i decided to make a script that would automate this for me without having to enter multiple gcc commands
Heres how it works
The user runs the script, providing arguments to enable or disable ASLR protections on the script (not system wide), takes a directory, then takes a set of filenames that are present in the directory. Then the user is prompted to enter the names of the output files for these scripts, then the system compiles and dumps them in an output directory provided by the user.

syntax looks like: ./Monocle_COMPILER.sh -En ~/Documents/Code/notCompiled ~/Documents/Code/Compiled fileone.c filetwo.c filethree.c
or
./Monocle_Compiler.sh -<aslr on/off> <source directory (not ending in '/')> <destination directory (not ending in '/')> <files>

# Monocle_SERVER
Simple python server that can be used to remotely execute commands on a server, check the time, and test connectivity to said server. Very basic, not much utility, but a decent experiment in python stuff. 
