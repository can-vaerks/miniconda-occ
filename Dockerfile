FROM continuumio/miniconda3:latest

ARG conda_env=dash

WORKDIR /backend

COPY environment.yml .
COPY requirements.txt .

RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y xorg xorgxrdp openbox xauth xserver-xorg-video-dummy
RUN apt-get install screen
#RUN apt-get install -y --no-install-recommends xserver-xorg-core
RUN apt-get install -y python3 python3-pip build-essential

SHELL [ "/bin/bash", "--login", "-c" ]
#RUN conda init bash
RUN conda update -y -c defaults conda
RUN conda env create -f environment.yml
ENV PATH /opt/conda/envs/$conda_env/bin:$PATH
ENV CONDA_DEFAULT_ENV $conda_env

RUN echo "defshell -bash" > ~/.screenrc
