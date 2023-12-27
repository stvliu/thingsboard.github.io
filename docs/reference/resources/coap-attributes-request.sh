# Send CoAP attributes request. Replace $THINGSBOARD_HOST_NAME and $ACCESS_TOKEN with corresponding values.
coap-client -m get "coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
# For example, $THINGSBOARD_HOST_NAME reference live demo server, $ACCESS_TOKEN is ABC123:
coap-client -m get "coap://demo.docs.codingas.com/api/v1/ABC123/attributes?clientKeys=attribute1,attribute2&sharedKeys=shared1,shared2"
