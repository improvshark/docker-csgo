FROM ubuntu:14.10

# Install base packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl lib32gcc1 -y

# Expose ports
EXPOSE 27015/udp
EXPOSE 27015/tcp

WORKDIR /opt/csgo
CMD ["/opt/csgo/srcds_run", "-usercon", "-ip 0.0.0.0"]
