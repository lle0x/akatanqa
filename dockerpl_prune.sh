#!/bin/bash
echo "--------------------------------------------"
echo "--------------------------------------------"
echo " Docker plumbing                            "
echo " prune all tags for a docker image          "
echo " [locally saved]                            "
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "Removing images from local computer         "

# Configuration

CONFIG_DIR='.config'
SOURCE_REGISTRY=$(cat $CONFIG_DIR/source_registry)
SOURCE_IMAGE=$1
BUR_TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
TAGS_FILE="inbox/$SOURCE_IMAGE"_prunelist_"$BUR_TIMESTAMP"

docker images "$SOURCE_REGISTRY/$SOURCE_IMAGE" | awk '{ print $3 }' | sed 's/IMAGE//g' | sed '/^$/d' | tee $TAGS_FILE

while IFS= read -r CURRENT_TAG
do
  CURRENT_IMAGE="$SOURCE_REGISTRY/$SOURCE_IMAGE:$CURRENT_TAG"
  echo "Removing image, with ID: $CURRENT_TAG"
  docker rmi $CURRENT_TAG
done < "$TAGS_FILE"

date