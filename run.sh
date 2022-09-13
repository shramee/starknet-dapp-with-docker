#!/bin/sh
MAX_FEE=1600000000000

# This file runs scripts, this file shouldn't be edited directly.
# You can add your custom scripts in scripts.sh

if [ $1 ];
	then RUN_SCRIPT=$1;
fi
LOG_FILE="./logs/script-$RUN_SCRIPT.log"
HR="----------------------------------------------------------------------"
DATE=$(date +'%Y-%m-%dT%H:%M:%S%Z')

printf '\n%s\n%s\n' "$DATE - Running script $RUN_SCRIPT" $HR | tee -a $LOG_FILE

deploy_compiled_contract() {
	if [ $1 ]
		then
		echo "Declaring class..."

		DECLARED=$(starknet declare --contract $1 --max_fee $MAX_FEE)
		echo "$DECLARED"

		CLASS_HASH=`echo "$DECLARED" | grep class | sed "s/Contract class hash: //"`

		echo "Deploying contract for class $CLASS_HASH..."

		shift # Shift out the first argument from #@ to pass the rest as input
		DEPLOYED=`starknet deploy --class_hash $CLASS_HASH --max_fee $MAX_FEE  --inputs "$@"`

		echo "$DEPLOYED"
		else
		echo "Filename to deploy is a required argument."
	fi
}

# You can call your scripts using `RUN_SCRIPT=my_script docker compose up`

source ./scripts.sh | tee -a $LOG_FILE

printf '%s\n%s\n' $HR "Finished running script $RUN_SCRIPT" | tee -a $LOG_FILE