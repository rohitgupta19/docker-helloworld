#!/bin/bash

# Check the CLOUD_PROVIDER environment variable
if [ "$CLOUD_PROVIDER" == "AWS" ]; then
    # If AWS, execute runner1.sh
    echo "Running runner.sh for AWS"
    exec /runner.sh
elif [ "$CLOUD_PROVIDER" == "Azure" ]; then
    # If Azure, execute runner2.sh
    echo "Running runner-azure.sh for Azure"
    exec /runner-azure.sh
else
    # If neither, exit with an error
    echo "Invalid CLOUD_PROVIDER value. Exiting..."
    exit 1
fi
