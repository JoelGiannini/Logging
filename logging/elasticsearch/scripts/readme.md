# Elasticsearch scripts
## Scripts:
### Execution example:
##
```sh
./es_cluster_disk.sh
```
### Output:
```sh
DISK CONSUMED
node   shards disk.indices disk.used disk.avail disk.total disk.percent
node-2     37      503.3gb   504.3gb    295.3gb    799.7gb           63
node-1     37      505.6gb   506.6gb      293gb    799.7gb           63

WATERMARK DESCRIPTIONS:
cluster.routing.allocation.disk.watermark.low: Elasticsearch no asignará fragmentos a nodos que tengan más del 85 % del disco utilizado.
cluster.routing.allocation.disk.watermark.high: Elasticsearch intentará reubicar los fragmentos lejos de un nodo cuyo uso del disco sea superior al 90 %.
cluster.routing.allocation.disk.watermark.flood_stage: Elasticsearch impone un bloque de índice de solo lectura (index.blocks.read_only_allow_delete) en cada índice que tiene uno o más fragmentos asignados en el nodo y que tiene al menos un disco que supera el flood_stage

WATERMARK STATUS:
    "cluster.routing.allocation.disk.watermark.flood_stage": "95%",
    "cluster.routing.allocation.disk.watermark.flood_stage.frozen": "95%",
    "cluster.routing.allocation.disk.watermark.flood_stage.frozen.max_headroom": "20GB",
    "cluster.routing.allocation.disk.watermark.high": "90%",
    "cluster.routing.allocation.disk.watermark.low": "85%",
```
## Purge elasticsearch documents
These scripts free up space in the cluster by removing old documents in the indexes.
##
| Script | Desc |
| ------ | ------ |
| purge_el_documents_haproxyc.sh | Purges documents from the haproxyc index |
| purge_el_documents_hydra.sh | Purges documents from the hydra index |
| purge_el_documents_intraoathkeeper.sh | Purges documents from the intraoathkeeper index |
| purge_el_documents_oathkeeper.sh | Purges documents from the oathkeeper index |
| force_marge.sh | Free up space used by deleted documents |

## Crontab
```sh
cat /etc/crontab
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root

#For details see man 4 crontabs

#Example of job definition:
#.---------------- minute (0 - 59)
#|  .------------- hour (0 - 23)
#|  |  .---------- day of month (1 - 31)
#|  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
#|  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
#|  |  |  |  |
#*  *  *  *  * user-name  command to be executed
0 0 * * * root /prod/purge/purge_el_documents_oathkeeper.sh
0 1 * * * root /prod/purge/purge_el_documents_hydra.sh
0 2 * * * root /prod/purge/purge_el_documents_haproxyc.sh
0 3 * * * root /prod/purge/purge_el_documents_intraoathkeeper.sh
0 6 * * * root /prod/purge/force_marge.sh
0 7 * * * find /var/log/el_purge -type f -mtime +15 -exec rm -f {} \; >/dev/null 2>&1
```
