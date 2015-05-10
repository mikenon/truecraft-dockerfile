#!/bin/bash

iam=`basename $0`

DIR_SRC=${DIR_SRC:-"/src"}
DIR_TARGET=${DIR_TARGET:-"/target"}
DIR_DATA=${DIR_DATA:-"/data"}
URL_REPO=${URL_REPO:-"git://github.com/SirCmpwn/TrueCraft.git"}
GET_FORCE=${GET_FORCE:-""}
BUILDTYPE=${BUILDTYPE:-"Release"}
NAME_EXE=${NAME_EXE:-"TrueCraft.exe"}

mkdir -p $DIR_SRC $DIR_TARGET $DIR_DATA

printrow () {
    printf "%-20s %-20s %-20s\n" $1 $2 $3
}

help () {
    echo "$iam - TrueCraft Docker utility"
    echo ""
    echo "Commands:"
    echo "-h | --help:  Display help"
    echo "get:          Clone the TrueCraft repository Env var 'force_get' must be"
    echo "              present to overwrite not-empty $DIR_SRC"
    echo "build:        Invokes nuget and xbuild in $DIR_SRC. Stores output in $DIR_TARGET"
    echo "run:          Invokes mono against $DIR_TARGET/TrueCraft.exe"
    echo ""
    echo "Environment Variables:"
    printrow "Name" "Default" "Current"
    printrow "DIR_SRC" "/src" "$DIR_SRC"
    printrow "DIR_TARGET" "/target" "$DIR_TARGET"
    printrow "DIR_DATA" "/data" "$DIR_DATA"
    printrow "URL_REPO" "git://github.com/SirCmpwn/TrueCraft.git" "$URL_REPO"
    printrow "GET_FORCE" "" "$GET_FORCE"
    printrow "BUILDTYPE" "Release" "$BUILDTYPE"
    printrow "NAME_EXE" "TrueCraft.exe" "$NAME_EXE"
}

get () {
    echo "Cloning TrueCraft from $URL_REPO"
    cd $DIR_SRC
    if [ "$(ls -A)" ] ; then
        if [ -z "$GET_FORCE" ] ; then
            echo "[Error] $DIR_SRC is not empty!"
            echo "[Error] To force the 'get' operation see output of $iam --help"
            return
        fi
        echo "[Warning] $DIR_SRC is not empty!"
    fi
    git clone --recursive $URL_REPO .
    if [[ -n $checkout ]] ; then
        echo "Checkout commit $checkout"
        git checkout $checkout
    fi
}

build () {
    echo "Building TrueCraft"
    cd $DIR_SRC
    nuget restore -NonInteractive
    xbuild /property:Configuration=$BUILDTYPE /property:OutDir=$DIR_TARGET/
}

run () {
    cd $DIR_DATA
    mono $DIR_TARGET/$NAME_EXE
}

while [ $# -ge 1 ]; do
    case "$1" in
        -h|--help)
            help
            exit 0
            ;;
        get)
            get
            ;;
        build)
            build
            ;;
        run)
            run
            ;;
    esac
    shift
done


