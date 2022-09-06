# syntax=docker/dockerfile:1
FROM python:3.9.13-bullseye
WORKDIR /code
RUN pip3 install ecdsa fastecdsa sympy
RUN pip3 install cairo-lang
EXPOSE 5000
COPY ./run.sh ./scripts/run.sh
RUN chmod +x ./scripts/run.sh
CMD ./scripts/run.sh