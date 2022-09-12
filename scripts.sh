#!/bin/sh
case $RUN_SCRIPT in
# Add your custom scripts here
	
	"my_script") # This line begins script `my_script`
		# Shell commands here
		echo "This script doesn't do very much at the moment."
	;; # Don't forget double semicolon `;;` to end script


# Here are some example scripts, edit away as you please.

	"test")
		# Compile src/test.cairo to build/test.json
		cairo-compile ./src/test.cairo --output ./build/test.json

		# Run build/test.json
		cairo-run \
		--program=./build/test.json --print_output \
		--print_info --relocate_prints --layout=small
	;;

	"contract_compile")
		starknet-compile ./src/my-contract.cairo \
		--output ./build/my-contract.json \
		--abi ./build/my-contract_abi.json
	;;

	"contract_deploy")
		# deploy_compiled_contract is a custom function to declare a class from a file
		# and then deploy a contract based on the class hash.
		deploy_compiled_contract ./build/my-contract.json
	;;

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
		echo "Script '$RUN_SCRIPT' is not defined.";
esac