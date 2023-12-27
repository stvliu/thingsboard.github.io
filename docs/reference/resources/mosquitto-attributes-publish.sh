# Publish client-side attributes update. Replace $THINGSBOARD_HOST_NAME and $ACCESS_TOKEN with corresponding values.
mosquitto_pub -d -h "$THINGSBOARD_HOST_NAME" -t "v1/devices/me/attributes" -u "$ACCESS_TOKEN" -m "{"attribute1": "value1", "attribute2": true}"
# For example, $THINGSBOARD_HOST_NAME reference live demo server, $ACCESS_TOKEN is ABC123:
mosquitto_pub -d -h "demo.docs.codingas.com" -t "v1/devices/me/attributes" -u "ABC123" -m "{"attribute1": "value1", "attribute2": true}"

# Publish client-side attributes update from file. Replace $THINGSBOARD_HOST_NAME and $ACCESS_TOKEN with corresponding values.
mosquitto_pub -d -h "$THINGSBOARD_HOST_NAME" -t "v1/devices/me/attributes" -u "$ACCESS_TOKEN" -f "new-attributes-values.json"
# For example, $THINGSBOARD_HOST_NAME reference live demo server, $ACCESS_TOKEN is ABC123:
mosquitto_pub -d -h "demo.docs.codingas.com" -t "v1/devices/me/attributes" -u "ABC123" -f "new-attributes-values.json"
