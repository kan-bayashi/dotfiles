FROM centos:centos7
MAINTAINER Tomoki Hayashi <hayashi.tomoki@g.sp.m.is.nagoya-u.ac.jp>
ENV LANG='en_US.UTF-8'
RUN yum install -y epel-release git sudo
RUN git clone https://github.com/kan-bayashi/dotfiles.git && \
        cd dotfiles && bash setup.sh && bash install.sh
