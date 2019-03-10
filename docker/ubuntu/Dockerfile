FROM ubuntu:18.04
MAINTAINER Tomoki Hayashi <hayashi.tomoki@g.sp.m.is.nagoya-u.ac.jp>
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y tzdata zsh git wget locales sudo
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
RUN git clone https://github.com/kan-bayashi/dotfiles.git && \
        cd dotfiles && bash setup.sh && bash install.sh
