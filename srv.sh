HOSTPORT=27015
CONTAINERPORT=27015

USERNAME=improvshark
NAME=csgo

DIRECTORY=csgo
APP=740

STEAMINFO=false


function request_steam_info {
    if $STEAMINFO; then
        read -p "Username: " uname
        read -p "Password: "  -s passw
        returnVal="login $uname $passw"
    else
        returnVal="login anonymous"
    fi
}

function install_steamcmd {

    if [ !  -d steamcmd ]; then
        mkdir steamcmd
        cd steamcmd
        curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz
        cd ..
    fi
}

function update {

    request_steam_info

    ./steamcmd/steamcmd.sh \
    +$returnVal \
    +force_install_dir ../$DIRECTORY \
    +app_update $APP validate \
    +exit
}

function install_game {

    if [ !  -d $DIRECTORY ]; then
        mkdir $DIRECTORY

        request_steam_info

        ./steamcmd/steamcmd.sh \
            +$returnVal \
            +force_install_dir ../$DIRECTORY \
            +app_update $APP validate \
            +exit
    fi
}

function launch {
    docker rm $NAME
    docker run  --name $NAME  -i -t -p $CONTAINERPORT:$HOSTPORT -v=$(pwd)/$DIRECTORY:/opt/$DIRECTORY $USERNAME/$NAME
}

function build {
    docker build -t improvshark/$NAME .
}








case $1 in


    ''|'-h'|'help')
        echo "usage:  srv.sh <option>"
        echo "  update"
        echo "  download"
        echo "  build"
        echo "  launch"
    ;;

    'download')
        echo "download!"
        install_steamcmd
        install_game
        build
    ;;
    'build')
        echo "building!"
        build
    ;;
    'start'|'launch')
        echo "launching!"
        launch
    ;;
    'update')
    echo "updating!"
        update
        build
    ;;
    'clean')
        rm -rf ./steamcmd
        rm -rf ./$DIRECTORY
    ;;

esac
