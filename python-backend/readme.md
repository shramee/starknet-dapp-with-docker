# python-container-with-starknet

## Setting up

This builds an image and sets up a container with everything you need to run cairo code and deploy starknet contracts.

Then it executes `run.sh` script. And you should also see some output like this,

## Directory structure

- `./src`
  - Your contract code or other directly compiled code goes here.
  - Reusable modules go in `./libs`
- `./libs`
  - Reusable modules go here.
  - Cairo will search in this directory when importing modules.
  - This directory is added to `CAIRO_PATH`.
- `./build`
  - Contains build files for your project.
  - Contract ABIs and other compiled Cairo stuff can be found here.
  - This directory is ignored in `.gitignore`.
- `./logs`
  - Contains logs for all your scripts.
  - Logs are organised by script name.
- `./.starknet_accounts`
  - Holds your wallet credentials (including private key).
  - This directory is ignored in `.gitignore`.
- `./scripts.sh`
  - This is where all your scripts reside.
  - This is basically a bash switch statement.
- `./run.sh`
  - Runs the scripts and manages logging.
- `/.env`
  - All environment variables defined here are set on your container.
  - Variables defined here can be used in scripts.
