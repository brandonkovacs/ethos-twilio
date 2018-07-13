#!/bin/bash

MESSAGE_TO_SEND="ERROR: GPUs have crashed."

# Log file containing miner output from "show miner" command
MINER_LOGS=/var/run/miner.output

# Error message to search for when Stratum / GPUs crash
ERROR_SEARCH_STRING_CCMINER="retry after 30 seconds"
ERROR_SEARCH_STRING_CLAYMORE="hangs in OpenCL call, you need to restart miner"

# Tail logs for 'n' lines
MAX_RECENT_LINES=20

# Max number of errors until we reach threshold
MAX_ERROR_THRESHOLD=3

# Count number of errors so far
NUM_ERRORS=$(tail -n $MAX_RECENT_LINES $MINER_LOGS | grep "$ERROR_SEARCH_STRING_CLAYMORE" | wc -l)

# Send an SMS if we've exceeded the threshold
if [ "$NUM_ERRORS" -gt "$MAX_ERROR_THRESHOLD" ]; then
  DIR="$(cd "$(dirname "$0")" && pwd)"
  $DIR/twilio-sms.sh "$MESSAGE_TO_SEND"
fi
