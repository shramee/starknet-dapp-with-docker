# starknet-web3-dapp-boilerplate

Uses docker-compose to set up containers to build, test, run, deploy and serve stuff for your Starknet dapp.

1. [`./cairo`](cairo) - A cairo dev environment to build/run cairo and deploy starknet contracts.
2. [`./python-backend`](python-backend) - Python environment with cairo and starknet ready.

## Setting up

0. Make sure you have docker installed.
1. Clone the repo. Or download zip file and extract.
2. Run `docker-compose up` in the directory in terminal.
3. This should spin up backends and frontend.
4. Cairo is more of an on demand container, and can be run with `docker-compose up cairo` or `RUN_SCRIPT=script_name docker-compose up cairo`, See [./cairo](cairo) for more details.
