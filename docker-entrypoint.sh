#!/bin/bash
set -e
CONFIG_DIR=/etc/transmission
TRANSMISSION=transmission-daemon
USER=debian-transmission

if [ ! -z "$USER_ID" ]; then
  usermod -u $USER_ID $USER
fi

if [ ! -z "$USER_GID" ]; then
  getent group $USER_GID || groupadd -g $USER_GID g_"$USER_GID"
  usermod -g $USER_GID $USER
fi

[ -d "$CONFIG_DIR" ] || mkdir -p "$CONFIG_DIR"

if [ ! -f $CONFIG_DIR/settings.json ]; then
  cp default-settings.json $CONFIG_DIR/settings.json
fi


INCOMPLETE=`jsonlint -f $CONFIG_DIR/settings.json | grep \"incomplete-dir\" | cut -d : -f 2 | sed 's/[",]//g'`
DOWNLOAD=`jsonlint -f $CONFIG_DIR/settings.json | grep \"download-dir\" | cut -d : -f 2 | sed 's/[",]//g'`

chown -R $USER:$USER_GID $CONFIG_DIR $INCOMPLETE $DOWNLOAD

exec su - $USER -s /bin/bash -c "$TRANSMISSION -f --no-portmap --config-dir $CONFIG_DIR --log-info"
