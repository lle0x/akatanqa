#!/bin/bash
echo "--------------------------------------------"
echo "--------------------------------------------"
echo " Docker plumbing                            "
echo " backup all tags for a docker image         "
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "Creating backup for all tags from registry  "

# Configuration

CONFIG_DIR='.config'
SOURCE_REGISTRY=$(cat $CONFIG_DIR/source_registry)
SOURCE_IMAGE=$1
BUR_TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
TAGS_FILE="inbox/$SOURCE_IMAGE"_list_"$BUR_TIMESTAMP"

#call script to get all tags for current image and save them in TAGS_FILE

bash dockerpl_pull.sh $SOURCE_IMAGE

bash dockerpl_clean.sh

while IFS= read -r CURRENT_TAG
do
  CURRENT_IMAGE="$SOURCE_REGISTRY/$SOURCE_IMAGE:$CURRENT_TAG"
  echo "Creating backup for: $CURRENT_IMAGE"
  docker save $CURRENT_IMAGE | gzip -c > ".backups/$SOURCE_IMAGE"_"$CURRENT_TAG"_backup_"$BUR_TIMESTAMP.tar.gz"
done < "$TAGS_FILE"



date
