# Publish data as an object without timestamp (server-side timestamp will be used). Replace $THINGSBOARD_HOST_NAME and $ACCESS_TOKEN with corresponding values.
mqtt pub -v -q 1 -h "$THINGSBOARD_HOST_NAME" -t "v1/devices/me/telemetry" -u '$ACCESS_TOKEN' -m "{"temperature":42}"
# For example, $THINGSBOARD_HOST_NAME reference live demo server, $ACCESS_TOKEN is ABC123:
mqtt pub -v -q 1 -h "demo.docs.codingas.com" -t "v1/devices/me/telemetry" -u 'ABC123' -m "{"temperature":42}"

# Publish data as an object without timestamp (server-side timestamp will be used). Replace $THINGSBOARD_HOST_NAME and $ACCESS_TOKEN with corresponding values.
cat telemetry-data-as-object.json | mqtt pub -v -h "$THINGSBOARD_HOST_NAME" -t "v1/devices/me/telemetry" -u '$ACCESS_TOKEN' -s -m ""
# For example, $THINGSBOARD_HOST_NAME reference live demo server, $ACCESS_TOKEN is ABC123:
cat telemetry-data-as-object.json | mqtt pub -v -h "demo.docs.codingas.com" -t "v1/devices/me/telemetry" -u 'ABC123' -s -m ""

# Publish data as an array of objects without timestamp (server-side timestamp will be used). Replace $THINGSBOARD_HOST_NAME and $ACCESS_TOKEN with corresponding values.
cat telemetry-data-as-array.json | mqtt pub -v -h "$THINGSBOARD_HOST_NAME" -t "v1/devices/me/telemetry" -u '$ACCESS_TOKEN' -s -m ""
# For example, $THINGSBOARD_HOST_NAME reference live demo server, $ACCESS_TOKEN is ABC123:
cat telemetry-data-as-array.json | mqtt pub -v -h "demo.docs.codingas.com" -t "v1/devices/me/telemetry" -u 'ABC123' -s -m ""

# Publish data as an object with timestamp (telemetry timestamp will be used). Replace $THINGSBOARD_HOST_NAME and $ACCESS_TOKEN with corresponding values.
cat telemetry-data-with-ts.json | mqtt pub -v -h "$THINGSBOARD_HOST_NAME" -t "v1/devices/me/telemetry" -u '$ACCESS_TOKEN' -s -m ""
# For example, $THINGSBOARD_HOST_NAME reference live demo server, $ACCESS_TOKEN is ABC123:
cat telemetry-data-with-ts.json | mqtt pub -v -h "demo.docs.codingas.com" -t "v1/devices/me/telemetry" -u 'ABC123' -s -m ""