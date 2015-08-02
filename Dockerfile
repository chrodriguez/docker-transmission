FROM ubuntu:14.04
MAINTAINER chrodriguez <chrodriguez@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root
# Don't ask user options when installing
env   DEBIAN_FRONTEND noninteractive
RUN echo APT::Install-Recommends "0"; >> /etc/apt/apt.conf
RUN echo APT::Install-Suggests "0"; >> /etc/apt/apt.conf

# Update system
RUN apt-get -y update && apt-get -y dist-upgrade

RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:transmissionbt/ppa && \
    apt-get update && \
    apt-get install -y transmission-daemon python-demjson

COPY docker-entrypoint.sh /entrypoint.sh
COPY default-settings.json /default-settings.json

VOLUME ["/downloads"]
VOLUME ["/incomplete"]
VOLUME ["/etc/transmission"]

EXPOSE 9091
EXPOSE 12345

ENTRYPOINT ["/entrypoint.sh"]

