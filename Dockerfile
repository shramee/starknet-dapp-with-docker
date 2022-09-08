# FROM python:3.9.13-bullseye
FROM python:3.9.13-alpine3.16
WORKDIR /code
RUN apk add gmp-dev g++ gcc
RUN pip3 install ecdsa fastecdsa sympy
RUN pip3 install cairo-lang
EXPOSE 8100
COPY ./run.sh ./scripts/run.sh
COPY ./src ./src
COPY ./cairo_libs ./cairo_libs
RUN export CAIRO_PATH="/code/cairo_libs:/tmp/cairo_libs"
RUN chmod +x ./scripts/run.sh
# Installation
RUN ./scripts/run.sh install

CMD ./scripts/run.sh