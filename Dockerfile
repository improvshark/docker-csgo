FROM ubuntu:14.10

# Install base packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl lib32gcc1 -y

# Expose ports
EXPOSE 27015

# Define default command.
ENTRYPOINT '/opt/csgo/srcds_run'
#ENTRYPOINT '/opt/starbound/linux32/starbound_server'
