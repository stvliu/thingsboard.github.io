#!/bin/sh

# Set ThingsBoard host to "demo.docs.codingas.com" or "localhost"
export THINGSBOARD_HOST=demo.docs.codingas.com

# Replace YOUR_ACCESS_TOKEN with one from Device details panel.
export ACCESS_TOKEN=YOUR_ACCESS_TOKEN

# Read serial number and firmware version attributes
ATTRIBUTES=$( cat attributes-data.json )
export ATTRIBUTES

# Read timeseries data as an object without timestamp (server-side timestamp will be used)
TELEMETRY=$( cat telemetry-data.json )
export TELEMETRY

# publish attributes and telemetry data via mqtt client
node publish.js
