# FROM python:3.9.13-bullseye
FROM python:3.9.13-alpine3.16
WORKDIR /code
RUN apk add gmp-dev g++ gcc
RUN pip3 install ecdsa fastecdsa sympy
RUN pip3 install cairo-lang
EXPOSE 8100
ENV CAIRO_PATH=/code/libs:/tmp/cairo_libs
ENV STARKNET_NETWORK=alpha-goerli
ENV STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
COPY ./run.sh ./run.sh
COPY ./scripts.sh ./scripts.sh
COPY ./src ./src
COPY ./logs ./logs
COPY ./libs ./libs
RUN chmod +x ./scripts.sh ./run.sh
# Installation
RUN ./run.sh install

CMD ./run.sh
