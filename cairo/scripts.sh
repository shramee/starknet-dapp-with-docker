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
		pytest ./src/contract_test.py
	;;

	"deploy")
		starknet-compile ./src/contract.cairo \
		--output ./build/contract.json \
		--abi ./build/contract_abi.json

		# deploy_compiled_contract
		# Declares a class from compiled code and deploys the contract with
		# trailing arguments passed as input.
		deploy_compiled_contract ./build/contract.json
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