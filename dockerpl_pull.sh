#!/bin/bash
echo "-------------------------------------"
echo "-------------------------------------"
echo " Docker plumbing                     "
echo " pull all tags for a docker image  "
echo "-------------------------------------"
echo "-------------------------------------"

echo "-------------------------------------"

echo "-------------------------------------"
echo "Pulling all tags from registry       "

# Configuration

CONFIG_DIR='.config'
SOURCE_REGISTRY=$(cat $CONFIG_DIR/source_registry)
SOURCE_IMAGE=$1
#TAGS_FILE="inbox/$SOURCE_IMAGE"_list_"$(date +"%Y%m%d-%H%M%S")"
TAGS_FILE='inbox/'$(date +"%Y%m%d-%H%M%S")'_'$1'_get-tags.dockerpl'

#call script to get all tags for current image and save them in TAGS_FILE

bash dockerpl_get.sh $SOURCE_IMAGE $TAGS_FILE


while IFS= read -r CURRENT_TAG
do
  echo "Processing: $CURRENT_TAG"
  docker pull "$SOURCE_REGISTRY/$SOURCE_IMAGE:$CURRENT_TAG"
done < "$TAGS_FILE"

echo "-------------------------------------"

echo "-------------------------------------"
echo "The following tags are saved locally:"

docker images | grep "$SOURCE_REGISTRY/$SOURCE_IMAGE"

date
