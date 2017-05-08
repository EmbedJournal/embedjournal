#!/bin/bash

CONFIG_FILE=_config.yml,_config_dev.yml
DEST_PATH=/var/www/embedjournal.com/public_html
SRC_PATH=$(git rev-parse --show-toplevel)
export JEKYLL_ENV=development

if [ ! -d $DEST_PATH ]; then
    echo "$DEST_PATH doesn't exist. Create it first"
    exit
fi

if [ -f /home/$USER/.rvm/scripts/rvm ]; then
    # In some shells, rvm scripts are not sourced. Do this
    # avoid not being able to find jekyll.
    source  /home/$USER/.rvm/scripts/rvm
fi


if [ "$1" == "production" ]; then
    # When building for production, override some variables.
    CONFIG_FILE=_config.yml
    JEKYLL_ENV=production
fi

jekyll build --config $CONFIG_FILE -s $SRC_PATH -d $DEST_PATH
