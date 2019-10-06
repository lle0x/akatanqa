#!/bin/bash
echo "-------------------------------------"
echo "-------------------------------------"
echo " Docker plumbing                     "
echo " get tags list for a docker image  "
echo "-------------------------------------"
echo "-------------------------------------"
echo "-------------------------------------"
echo "-------------------------------------"
echo "Listing all tags from registry       "

# Configuration

CONFIG_DIR='.config'
SOURCE_REGISTRY=$(cat $CONFIG_DIR/source_registry)
SOURCE_IMAGE=$1
TAGS_FILE=$(date +"%Y%m%d-%H%M%S")'_'$1'_get-tags'
TAGS_FILE_JSON=$TAGS_FILE.json
LIST_URL="https://$SOURCE_REGISTRY/v2/$SOURCE_IMAGE/tags/list"


curl $LIST_URL | python -m json.tool | tee $TAGS_FILE_JSON
cat $TAGS_FILE_JSON | jq --raw-output -S '.tags' | sed 's/",//g' | sed 's/"//g' | tr -d ' ' | tr -d ']' | tr -d '[' | sed '/^$/d' > inbox/$TAGS_FILE'.dockerpl'


echo "-------------------------------------"
echo "-------------------------------------"
date
