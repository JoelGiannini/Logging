#!/bin/bash
pass=""
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.134:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason'
