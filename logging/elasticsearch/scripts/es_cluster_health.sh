#!/bin/bash
pass=""
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.182:9200/_cluster/health'|jq
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.182:9200/_nodes'|jq
