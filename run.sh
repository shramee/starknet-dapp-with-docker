#!/bin/sh
if [ $1 ];
	then _SCRIPT=$1;
	else _SCRIPT=$RUN_SCRIPT;
fi


COLOR='\033[0;33m'
COLOR2='\033[0;31m'
HORIZONTAL_RULE="${COLOR}\
----------------------------------------------------------------------"

echo -e "${COLOR}Running script ${COLOR2}$_SCRIPT"
echo -e $HORIZONTAL_RULE

# You can call your scripts using `RUN_SCRIPT=script_name docker compose up`

case $_SCRIPT in

# Add your custom scripts here
	
	"script_name") # This line begins script `script_name`
		# Shell commands here
		echo "This script doesn't do very much at the moment."
	;; # Don't forget double semicolon `;;` to end script


# Here are some example scripts, edit away as you please.

	"test")
		# Compile src/test.cairo to build/test_compiled.json
		cairo-compile ./src/test.cairo --output ./build/test_compiled.json

		# Run build/test_compiled.json
		cairo-run \
		--program=./build/test_compiled.json --print_output \
		--print_info --relocate_prints
	;;

# Stop editing, these are default scripts.
	"install")
		# Add code here for setup/configuration (like installing packages)
		# This will be called when building the image
		# Can be called after changes with,
		# RUN_SCRIPT=install docker compose up
		# 
		echo "Installation done!";
	;;

	*)
		echo "Script '$_SCRIPT' is not defined.";
esac

echo -e $HORIZONTAL_RULE
echo -e "${COLOR}Finished running script ${COLOR2}$_SCRIPT"