# cairo-docker-container

Uses docker-compose to set up a cairo development environment to build, run and deploy cairo stuff.

The basic idea is to have a cairo environment in docker and some predeclared scripts to run inside the container.

Loosely copies `npm run script` functionality. But the scripts are declared in a bash switch instead of json. And run with `RUN_SCRIPT` environment variable while running `docker-compose up cairo`.

## Setting up

0. Make sure you have docker installed.
1. Clone the repo. Or download zip file and extract.
2. Run `docker-compose up cairo` in the directory in terminal.

This builds an image and sets up a container with everything you need to run cairo code and deploy starknet contracts.

Then it executes `run.sh` script. And you should also see some output like this,

```
cairo-with-docker-cairo-1  | 2022-09-14T10:48:38UTC - Running script test
cairo-with-docker-cairo-1  | ----------------------------------------------------------------------
cairo-with-docker-cairo-1  | ============================= test session starts ==============================
cairo-with-docker-cairo-1  | platform linux -- Python 3.9.13, pytest-7.1.3, pluggy-1.0.0
cairo-with-docker-cairo-1  | rootdir: /code
cairo-with-docker-cairo-1  | plugins: asyncio-0.19.0, web3-5.30.0, typeguard-2.13.3
cairo-with-docker-cairo-1  | asyncio: mode=strict
cairo-with-docker-cairo-1  | collected 1 item
cairo-with-docker-cairo-1  |
cairo-with-docker-cairo-1  | src/contract_test.py .                                                   [100%]
...
...
cairo-with-docker-cairo-1  | ========================= 1 passed, 1 warning in 2.35s =========================
cairo-with-docker-cairo-1  | ----------------------------------------------------------------------
```

#### Here is what just happened,

1. `run.sh` does some stuff related with logging but eventually calls `scripts.sh`.
2. `scripts.sh` contains a `switch` statement to figure out which script to run.
3. We specify the scripts to run with `RUN_SCRIPT=script_name` just before `docker-compose up cairo` command.
4. But we didn't specify a script to run, but it defaults to `RUN_SCRIPT=test`. So it was equivalent to running `RUN_SCRIPT=test docker-compose up cairo`.
5. So `scripts.sh` ran the bash commands under `test` case.

### Default Scripts

Scripts can be added like a switch case in bash, but we have some default ones. Here's what they do,

#### test

- `RUN_SCRIPT=test docker-compose up cairo`
- Runs test in `src/contract_test.py` with `pytest`.
- Tests can really save you lots of time writing Starknet contracts.
- With tests you can catch bugs and also fix them, all this while your neighbour is still waiting for his contract to be accepted on L2.
- Read more about writing tests for Starknet contract,  
  https://www.cairo-lang.org/docs/hello_starknet/unit_tests.html

#### deploy

- `RUN_SCRIPT=deploy docker-compose up cairo`
- Compiles the contract in `src/contract.cairo` to `build/contract.json`.
- Declares the contract class and deploys it from `build/contract.json`.

#### deploy_account

- `RUN_SCRIPT=deploy_account docker-compose up cairo`
- Deploys starknet account.
- Saves the account details in `.starknet_accounts/starknet_open_zeppelin_accounts.json` by default.

#### install

- `RUN_SCRIPT=install docker-compose up cairo`
- This is run when building the image. If the image is built already, use `docker-compose up cairo --build` or run this manually like other commands.
- Use this to install additional packages or stuff you might need.

#### my_script

- `RUN_SCRIPT=my_script docker-compose up cairo`
- This doesn't do anything, you can use this as a template to write your own.

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
- `../shared/.starknet_accounts`
  - Holds your wallet credentials (including private key).
- `./scripts.sh`
  - This is where all your scripts reside.
  - This is basically a bash switch statement.
- `./run.sh`
  - Runs the scripts and manages logging.
- `/.env`
  - All environment variables defined here are set on your container.
  - Variables defined here can be used in scripts.
