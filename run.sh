#!/bin/sh

MAX_FEE=1600000000000
if [ $1 ];
	then _SCRIPT=$1;
	else _SCRIPT=$RUN_SCRIPT;
fi

HORIZONTAL_RULE="----------------------------------------------------------------------"
DATE=$(date +'%Y-%m-%dT%H:%M:%S%Z')
echo ""
echo -e "$DATE - Running script $_SCRIPT"
echo -e $HORIZONTAL_RULE

deploy_compiled_contract() {
	if [ $1 ]
		then
		echo "Declaring class..."

		DECLARED=$(starknet declare --contract ./build/my-contract_compiled.json --max_fee $MAX_FEE)
		echo "$DECLARED"

		CLASS_HASH=`echo "$DECLARED" | grep class | sed "s/Contract class hash: //"`

		echo "Deploying contract for class $CLASS_HASH..."
		DEPLOYED=`starknet deploy --class_hash $CLASS_HASH --max_fee $MAX_FEE`

		echo "$DEPLOYED"
		else
		echo "Filename to deploy is a required argument."
	fi
}

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
		--print_info --relocate_prints --layout=small
	;;

	"contract")
		starknet-compile ./src/my-contract.cairo \
		--output ./build/my-contract_compiled.json \
		--abi ./build/my-contract_abi.json
	;;

	"contract_deploy")
		# deploy_compiled_contract
		deploy_compiled_contract ./build/my-contract_compiled.json
	;;
# Stop editing, these are default scripts.

	"deploy_account")
		starknet deploy_account
	;;

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