#!/bin/sh
if [ $1 ];
	then _SCRIPT=$1;
	else _SCRIPT=$RUN_SCRIPT;
fi


HORIZONTAL_RULE="----------------------------------------------------------------------"
DATE=$(date +'%Y-%m-%dT%H:%M:%S%Z')
echo ""
echo -e "$DATE - Running script $_SCRIPT"
echo -e $HORIZONTAL_RULE

# You can call your scripts using `RUN_SCRIPT=my_script docker compose up`

case $_SCRIPT in

# Add your custom scripts here
	
	"my_script") # This line begins script `my_script`
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
echo -e "Finished running script $_SCRIPT"
echo ""