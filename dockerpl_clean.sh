
#!/bin/bash
echo "--------------------------------------------"
echo "--------------------------------------------"
echo " Docker plumbing                            "
echo " House cleaning                             "
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "--------------------------------------------"
echo "Remove all images with tag <none>           "

# Configuration

CONFIG_DIR='.config'
LOGS_DIR='.logs'
BUR_TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

docker rmi $(docker images -f dangling=true -q) | tee $LOGS_DIR"/"$BUR_TIMESTAMP


date