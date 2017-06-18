#!/bin/bash

CONFIG_FILE=_config.yml,_config_dev.yml
DEST_PATH=/var/www/embedjournal.com/public_html
SRC_PATH=$(git rev-parse --show-toplevel)
INCREMENTAL=""
export JEKYLL_ENV=development

if [ ! -d $DEST_PATH ]; then
    echo "$DEST_PATH doesn't exist. Create it first"
    exit
fi

if [ -f /home/$USER/.rvm/scripts/rvm ]; then
    # In some shells, rvm scripts are not sourced. Do this to
    # avoid not being able to find jekyll.
    source  /home/$USER/.rvm/scripts/rvm
fi

die_usage(){
    echo "EmbedJournal.com build utility"
    echo ""
    echo "usage: $0 [[-p] [-i]]"
    echo -e "\t-p\tBuild for production environment defaults"
    echo -e "\t\tto building for development environment"
    echo -e "\t-i\tPerform incremental build in jekyll"
    echo -e "\t-h\tDispaly this help text"
    echo ""
    exit
}

while getopts ":iph" opt; do
    case $opt in
    p)
        echo "Building for production.."
        # When building for production, override some variables.
        CONFIG_FILE=_config.yml
        JEKYLL_ENV=production
        ;;
    i)
        echo "-i was triggered!" >&2
        INCREMENTAL=--incremental
        ;;
    h)
        die_usage
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        die_usage
        ;;
    esac
done

# We don't want to accidentally build dev over a production environment.
# So this is an additional check that gives us and opportunity to take
# corrective actions if any.

if [ "$JEKYLL_ENV" != "production" ]; then
    while true; do
        echo "Building for development.."
        read -p "Do you wish to continue? [y/N]: " yn
        case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
        esac
    done
fi

jekyll build --config $CONFIG_FILE -s $SRC_PATH -d $DEST_PATH $INCREMENTAL
