# starknet-web3-dapp-with-docker

Uses docker-compose to set up containers to build, test, run, deploy and serve stuff for your Starknet dapp.

## Services

1. [`./cairo`](cairo) - A cairo dev environment to build/run cairo and deploy starknet contracts.
2. [`./python-backend`](python-backend) - Python environment with cairo and starknet ready.
3. [`./js-backend`](js-backend) - NodeJS backend with Python3 and cairo ready for invoking with CLI.
4. [`./frontend`](frontend) - Frontend, runs npm package in `./frontend`. Includes `gh-pages` for quick deployment to GitHub pages.

## Prepare Frontend

Replace the contents in `./frontend` dir with your frontend NPM package and the files will be available and run from inside the container.

Example with React CRA:

```bash
npx create-react-app frontend
```

## Setting up

0. Make sure you have docker installed.
1. Clone the repo. Or download zip file and extract.
2. Run `docker-compose up` in the directory in terminal.
3. This should spin up backends and frontend.

Cairo is more of an on demand container, and can be run with `docker-compose up cairo` or `RUN_SCRIPT=script_name docker-compose up cairo`, See [./cairo](cairo) for more details.

Change command in `compose.yml` as needed. Comment out/Delete unused service(s).
