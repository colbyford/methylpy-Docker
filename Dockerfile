FROM mcr.microsoft.com/azureml/base:openmpi3.1.2-ubuntu16.04
# FROM phusion/baseimage:0.9.16
# FROM broadinstitute/picard

MAINTAINER Colby T. Ford, Ph.D. "cford@bluegranite.com"

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    curl \
    git \
    wget \
    apt-transport-https \
    ca-certificates \
    build-essential

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

RUN mkdir -p /usr/share/man/man1

## Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

## Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

## Install Dependencies for pysam
RUN apt-get -y install \
    zlib1g-dev \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libssl-dev

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME


## install some generic system packages needed by other libraries 
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \\
#     zlib1g-dev \\
#     libcairo2-dev \\
#     libpango1.0-dev \\
#     libcurl4-openssl-dev \\
#     doxygen graphviz \\
#     libbz2-dev \\
#     libjpeg-dev \\
#     libatlas-base-dev \\
#     gfortran \\
#     fort77 \\
#     libreadline6-dev
#     #emacs23-nox


# ## install conda and dependencies
# ENV PATH="/root/miniconda3/bin:${PATH}"
# ARG PATH="/root/miniconda3/bin:${PATH}"

# RUN wget \
#     https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#     && mkdir /root/.conda \
#     && bash Miniconda3-latest-Linux-x86_64.sh -b \
#     && rm -f Miniconda3-latest-Linux-x86_64.sh 

# RUN conda config --set allow_conda_downgrades true
# RUN conda install conda=4.6.141
# RUN conda config --set auto_update_conda false

## Install Dependencies for methylpy
RUN conda install --yes -c bioconda \
    bowtie \
    bowtie2 \
    minimap2 \
		samtools \
    ucsc-wigtobigwig \
		nomkl

# RUN conda install -c \
#     biobuilds \
#     tzdata && \
#     conda clean -ay

RUN pip install --no-cache-dir \
    azureml-defaults \
    cutadapt
    #methylpy

## Install methylpy from git
RUN git clone https://github.com/yupenghe/methylpy.git && \
    cd methylpy/ && \
    python setup.py install && \
    cd methylpy/
    # cp run_rms_tests.out /opt/miniconda/lib/python3.7/site-packages/methylpy/ && \
    # cd ../..


## Install Dependencies for DMRfind
RUN apt-get -y install \
    libgsl-dev
RUN ln -s /usr/lib/x86_64-linux-gnu/libgsl.so.23 lib/libgsl.so.0

## Set Up DMRfind (rms.cpp)
# RUN cd methylpy/ && \
#     g++ -o run_rms_tests.out rms.cpp `gsl-config --cflags -libs` && \
#     cp run_rms_tests.out /opt/miniconda/lib/python3.7/site-packages/methylpy/ && \
#     cd ..

## Install Picard (from: https://github.com/broadinstitute/picard)
RUN git clone https://github.com/broadinstitute/picard.git && \
    cd picard/ && \
    ./gradlew shadowJar
#     #java -jar build/libs/picard.jar

## Install Flask (from: https://github.com/RodolfoFerro/docker-flask-api)
WORKDIR /app
COPY . /app

RUN pip --no-cache-dir install -r requirements.txt

## Expose Ports to Public
# EXPOSE 5000 8000 9881 22 3389
EXPOSE 5000 8000 9881 22 3389

CMD ["python", "app.py"]