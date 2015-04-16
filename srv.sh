HOSTPORT=27015
CONTAINERPORT=27015

USERNAME=improvshark
NAME=csgo


function launch {
    docker rm $NAME
    docker run  --name $NAME  -i -t -p $CONTAINERPORT:$HOSTPORT/udp -p $CONTAINERPORT:$HOSTPORT/tcp $USERNAME/$NAME
}

function build {
    docker build -t improvshark/$NAME .
}

case $1 in
    'build')
        echo "building!"
        build
    ;;
    'start'|'launch')
        echo "launching!"
        launch
    ;;
    ''|'-h'|'help'|'*')
      echo "usage:  srv.sh <option>"
      echo "  build"
      echo "  launch"
    ;;
esac
