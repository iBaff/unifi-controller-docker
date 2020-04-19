FROM ubuntu:18.04

# Commands from:
# https://help.ui.com/hc/en-us/articles/220066768-UniFi-How-to-Install-and-Update-via-APT-on-Debian-or-Ubuntu
RUN apt-get update && \
    apt-get install -y ca-certificates apt-transport-https haveged gnupg wget apt-utils && \
    apt-get clean && \
    wget https://dl.ui.com/unifi/unifi-repo.gpg && \
    apt-key add unifi-repo.gpg && \
    echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list && \
    wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | apt-key add - && \
    echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && \
    apt-mark hold openjdk-11-* && \
    apt-get update && \
    apt-get install unifi -y && \
    apt-get clean

# Volumes and Ports
WORKDIR /usr/lib/unifi
VOLUME /config

EXPOSE 6789 8080 8443 8843 8880 3478/udp 10001/udp
