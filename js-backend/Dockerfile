# FROM python:3.9.13-bullseye
FROM python:3.9.13-alpine3.16
WORKDIR /code

COPY . .

ENV STARKNET_NETWORK=alpha-goerli
ENV STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
ENV NODE_VERSION=18.9.0

# RUN apk add gmp-dev g++ gcc
# RUN pip3 install -r requirements.txt

RUN apk add --update npm
RUN node --version
RUN npm --version
RUN npm install
CMD npm start
