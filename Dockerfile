# FROM python:3.9.13-bullseye
FROM python:3.9.13-alpine3.16
WORKDIR /code
RUN apk add gmp-dev g++ gcc
RUN pip3 install ecdsa fastecdsa sympy
RUN pip3 install cairo-lang
EXPOSE 8100
COPY ./run.sh ./scripts/run.sh
COPY ./scripts.sh ./scripts/scripts.sh
COPY ./src ./src
COPY ./logs ./logs
COPY ./cairo_libs ./cairo_libs
ENV CAIRO_PATH=/code/cairo_libs:/tmp/cairo_libs
ENV STARKNET_NETWORK=alpha-goerli
ENV STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
RUN chmod +x ./scripts/run.sh
RUN chmod +x ./scripts/scripts.sh
# Installation
RUN ./scripts/run.sh install

CMD ./scripts/run.sh | tee -a ./logs/scripts.log
