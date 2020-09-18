FROM mcr.microsoft.com/azureml/base:openmpi3.1.2-ubuntu16.04
MAINTAINER Colby T. Ford, Ph.D. "cford@bluegranite.com"

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    curl \
    apt-transport-https \
    ca-certificates

RUN conda install -c \
    biobuilds \
    tzdata && \
    conda clean -ay && \
    pip install --no-cache-dir \
    azureml-defaults \
    methylpy