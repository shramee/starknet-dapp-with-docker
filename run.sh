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

source ./scripts.sh

echo -e $HORIZONTAL_RULE
echo -e "Finished running script $_SCRIPT"
echo ""