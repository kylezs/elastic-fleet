# Creates custom kibana image, so it has the elastalert plugin
# Stored at docker.io/kylezs/kibana-elastalert

FROM docker.elastic.co/kibana/kibana:7.5.0

RUN bin/kibana-plugin install https://github.com/bitsensor/elastalert-kibana-plugin/releases/download/1.1.0/elastalert-kibana-plugin-1.1.0-7.5.0.zip