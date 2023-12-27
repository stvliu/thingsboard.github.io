#!/bin/sh

# Set ThingsBoard host to "demo.docs.codingas.com" or "localhost"
THINGSBOARD_HOST="demo.docs.codingas.com"
# Replace YOUR_ACCESS_TOKEN with one from Device details panel.
ACCESS_TOKEN="YOUR_ACCESS_TOKEN"
# Publish serial number and firmware version attributes
mosquitto_pub -d -h "$THINGSBOARD_HOST" -t "v1/devices/me/attributes" -u "$ACCESS_TOKEN" -f "attributes-data.json"
# Publish timeseries data as an object without timestamp (server-side timestamp will be used)
mosquitto_pub -d -h "$THINGSBOARD_HOST" -t "v1/devices/me/telemetry" -u "$ACCESS_TOKEN" -f "telemetry-data.json"
