#!/bin/sh
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