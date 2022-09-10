#!/bin/sh

MAX_FEE=1600000000000
if [ $1 ];
	then _SCRIPT=$1;
	else _SCRIPT=$RUN_SCRIPT;
fi
LOG_FILE="./logs/script-$_SCRIPT.log"
HORIZONTAL_RULE="----------------------------------------------------------------------"
DATE=$(date +'%Y-%m-%dT%H:%M:%S%Z')

printf '\n%s\n%s\n' "$DATE - Running script $_SCRIPT" $HORIZONTAL_RULE | tee -a $LOG_FILE

deploy_compiled_contract() {
	if [ $1 ]
		then
		echo "Declaring class..."

		DECLARED=$(starknet declare --contract $1 --max_fee $MAX_FEE)
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

source ./scripts.sh | tee -a $LOG_FILE

printf '%s\n%s\n' $HORIZONTAL_RULE "Finished running script $_SCRIPT" | tee -a $LOG_FILE