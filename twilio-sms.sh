#!/bin/bash

# Twilio credentials
TWILIO_ACCOUNT_SID=""
TWILIO_AUTH_TOKEN=""
TWILIO_FROM_NUMBER=""
TWILIO_TO_NUMBER=""

# Function to send an SMS message
function sendSMSMessage() {
  curl "https://api.twilio.com/2010-04-01/Accounts/${TWILIO_ACCOUNT_SID}/Messages.json" -X POST \
  --data-urlencode "To=$TWILIO_TO_NUMBER" \
  --data-urlencode "From=$TWILIO_FROM_NUMBER" \
  --data-urlencode "Body=$1" \
  -u "$TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN" > /dev/null 2>&1
}

# Exit script if no argument (sms message body) was passed
if [[ $# -eq 0 ]]; then
    exit 1
fi

# Send the message
sendSMSMessage "$1"
