# python-container-with-starknet

## Setting up

This builds an image and sets up a container with everything you need to run cairo code and deploy starknet contracts.

Then it executes `run.sh` script. And you should also see some output like this,

## Directory structure

- `./src`
  - Your contract code or other directly compiled code goes here.
  - Reusable modules go in `./libs`
- `/.env`
  - All environment variables defined here are set on your container.
- `../shared/.starknet_accounts`
  - Holds your wallet credentials (including private key).
  - This directory is ignored in `.gitignore`.
