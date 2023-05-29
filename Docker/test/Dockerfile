FROM python:3.9-slim as runner

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONBUFFERED True

RUN apt update && apt install -y make gcc

WORKDIR /usr/local/src

COPY Makefile Makefile
COPY requirements.txt requirements.txt
COPY setup.cfg setup.cfg
COPY pyproject.toml pyproject.toml

COPY package_name package_name
COPY tests tests

RUN	pip install -e .[dev]
