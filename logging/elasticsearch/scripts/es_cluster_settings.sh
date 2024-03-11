#!/bin/bash
pass=""
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.134:9200/_cluster/settings'|jq
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.182:9200/_cluster/settings'|jq
