FROM ubuntu:14.04
MAINTAINER improvshark <improvshark@gmail.com>

# Install base packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl lib32gcc1 -y

# install steamcmd
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz


# install csGo
RUN mkdir -p /opt/csgo
RUN /opt/steamcmd/steamcmd.sh \
            +login anonymous \
            +force_install_dir /opt/csgo \
            +app_update 740 validate \
            +quit

# add settings file
ADD server.cfg /opt/csgo/csgo/cfg/server.cfg
# create volume
VOLUME /opt/csgo    
# Expose ports
EXPOSE 27015/udp
EXPOSE 27015/tcp


WORKDIR /opt/csgo
#CMD ["/opt/csgo/srcds_run", "-usercon", "-ip 0.0.0.0"]
CMD ["/opt/csgo/srcds_run", "-usercon", "-ip 0.0.0.0","+host_workshop_collection","429707790","-authkey", "620902E79FE346C9979E073A15674114"]
#ENTRYPOINT ["./srcds_run"]
