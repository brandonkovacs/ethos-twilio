#!/bin/bash

MESSAGE_TO_SEND="ERROR: Claymore GPU Miner has crashed. Need to restart mining rig."

# Directory containing our scripts
SCRIPTS_DIR=/home/ethos/scripts

# Log file containing miner output from "show miner" command
MINER_LOGS=/var/run/miner.output

# Error message to search for when Stratum / GPUs crash
ERROR_SEARCH_STRING_CLAYMORE="hangs in OpenCL call, you need to restart miner"

# Max number of errors until we reach threshold
MAX_ERROR_THRESHOLD=2

# Count number of errors so far
NUM_ERRORS=$(grep "$ERROR_SEARCH_STRING_CLAYMORE" $MINER_LOGS | wc -l)

# Send an SMS if we've exceeded the threshold
if [ "$NUM_ERRORS" -gt "$MAX_ERROR_THRESHOLD" ]; then
  $SCRIPTS_DIR/twilio-sms.sh "$MESSAGE_TO_SEND"
fi
