# cairo-with-docker

Uses docker-compose to set up a cairo development environment to build, run and deploy cairo/starknet stuff.

The basic idea is to have a cairo environment in docker and some predeclared scripts to run inside the container.

Loosely copies `npm run script` functionality. But the scripts are declared in a bash switch instead of json. And run with `RUN_SCRIPT` environment variable while running `docker-compose up`.

## Setting up

0. Make sure you have docker installed.
1. Clone the repo. Or download zip file and extract.
2. Run `docker-compose up` in the directory in terminal.

This builds an image and sets up a container with everything you need to run cairo code and deploy starknet contracts.

Then it executed `run.sh` script. And you should also see some output like this,

```
cairo    | 2022-09-12T04:29:52UTC - Running script test
cairo    | ----------------------------------------------------------------------
cairo    | Number of steps: 4 (originally, 4)
cairo    | Used memory cells: 11
cairo    | Register values after execution:
cairo    | pc = 12
cairo    | ap = 12
cairo    | fp = 12
cairo    |
cairo    | ----------------------------------------------------------------------
cairo    | Finished running script test
```

#### Here is what just happened,

1. `run.sh` does some stuff related with logging but eventually calls `scripts.sh`.
2. `scripts.sh` contains a `switch` statement to figure out which script to run.
3. We specify the scripts to run with `RUN_SCRIPT=script_name` just before `docker-compose up` command.
4. But we didn't specify a script to run, but it defaults to `RUN_SCRIPT=test`. So it was equivalent to running `RUN_SCRIPT=test docker-compose up`.
5. So `scripts.sh` ran the bash commands under `test` case.

### Default Scripts

Scripts can be added like a switch case in bash, but we have some default ones. Here's what they do,

#### test

- `RUN_SCRIPT=test docker-compose up`
- Compiles and runs the code in `src/test.cairo`.
- You can use `src/test.cairo` as playground if you like.

#### contract_compile

- `RUN_SCRIPT=contract_compile docker-compose up`
- Compiles the contract in `src/my-contract.cairo`.
- Compiled to file `build/my-contract.json`.

#### contract_deploy

- `RUN_SCRIPT=contract_deploy docker-compose up`
- Declares the class and deploys the contract from `build/my-contract.json`.
- You should run this after compiling :wink:

#### deploy_account

- `RUN_SCRIPT=deploy_account docker-compose up`
- Deploys starknet account.
- Saves the account details in `.starknet_accounts/starknet_open_zeppelin_accounts.json` by default.

#### install

- `RUN_SCRIPT=install docker-compose up`
- This is run when building the image. If the image is built already, use `docker-compose up --build` or run this manually like other commands.
- Use this to install additional packages or stuff you might need.

#### my_script

- `RUN_SCRIPT=my_script docker-compose up`
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
