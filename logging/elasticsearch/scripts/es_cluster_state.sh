#!/bin/bash
pass=""
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.182:9200/_cluster/state'|jq
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.182:9200/_cluster/state?filter_path=metadata.cluster_coordination.last_committed_config'|jq
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.134:9200/_cluster/state?filter_path=metadata.cluster_coordination.last_committed_config'|jq
