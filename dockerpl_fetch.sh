#!/bin/bash
echo "-----------------------------------------"
echo "-----------------------------------------"
echo " Docker plumbing                         "
echo " get images list from a docker registry  "
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "-----------------------------------------"
echo "Listing all images from docker registry  "

# Configuration

CONFIG_DIR='.config'
SOURCE_REGISTRY=$(cat $CONFIG_DIR/source_registry)
IMAGES_FILE=$(date +"%Y%m%d-%H%M%S")'_fetch_images'
IMAGES_FILE_JSON=$IMAGES_FILE.json
LIST_URL="http://$SOURCE_REGISTRY/v2/_catalog"


curl $LIST_URL | python -m json.tool | tee inbox/$IMAGES_FILE_JSON
cat inbox/$IMAGES_FILE_JSON | jq --raw-output -S '.repositories' | sed 's/",//g' | sed 's/"//g' | tr -d ' ' | tr -d ']' | tr -d '[' | sed '/^$/d' > inbox/$IMAGES_FILE'.dockerpl'


echo "-----------------------------------------"
echo "-----------------------------------------"
date