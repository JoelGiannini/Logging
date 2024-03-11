#!/bin/bash
pass=""
echo "DISK CONSUMED"
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.134:9200/_cat/allocation?v=true&h=node,shards,disk.*'
echo ""
echo "WATERMARK DESCRIPTIONS:"
echo "cluster.routing.allocation.disk.watermark.low: Elasticsearch no asignará fragmentos a nodos que tengan más del 85 % del disco utilizado."
echo "cluster.routing.allocation.disk.watermark.high: Elasticsearch intentará reubicar los fragmentos lejos de un nodo cuyo uso del disco sea superior al 90 %."
echo "cluster.routing.allocation.disk.watermark.flood_stage: Elasticsearch impone un bloque de índice de solo lectura (index.blocks.read_only_allow_delete) en cada índice que tiene uno o más fragmentos asignados en el nodo y que tiene al menos un disco que supera el flood_stage"
echo ""
echo "WATERMARK STATUS:" 
curl -s -k -XGET -u  middsec:$pass 'https://172.29.98.134:9200/_cluster/settings?include_defaults&flat_settings'|jq |grep -e cluster.routing.allocation.disk.watermark.low -e cluster.routing.allocation.disk.watermark.high -e cluster.routing.allocation.disk.watermark.flood_stage
