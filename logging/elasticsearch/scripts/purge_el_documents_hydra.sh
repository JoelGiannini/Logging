#!/bin/bash
hora=`date "+%H" `
min=`date "+%M" `
seg=`date "+%S" `
dia=`date "+%d" `
mes=`date "+%m" `
anio=`date "+%Y" `
user=elastic
pass=""
LOG="/var/log/el_purge/purge_newco.hydra-${dia}-${mes}-${anio}.log"

echo "START  ${anio}-${mes}-${dia} ${hora}:${min}:${seg}" >> ${LOG}

curl -k -s -XPOST -u ${user}:${pass} 'https://172.29.98.182:9200/newco.hydra/_delete_by_query?conflicts=proceed' -H 'Content-Type: application/json' -d'{"query": {"range": {"@timestamp": {"lt": "now-2M" }}}}'  > /tmp/output.txt 2>&1
if [ $? -eq 0 ]; then
OUTPUT=`cat /tmp/output.txt`
echo "" >> ${LOG}
echo "  Se ejecuto la peticion de delete al indice con exito" >> ${LOG}
echo "$OUTPUT " >> ${LOG}
echo "" >> ${LOG}
echo "END ${anio}-${mes}-${dia} ${hora}:${min}:${seg}" >> ${LOG}
else
OUTPUT=`cat /tmp/err.txt`
echo "" >> ${LOG}
echo "  Fallo la ejecucion  de delete al indice:" >> ${LOG}
echo "" >> ${LOG}
echo "$OUTPUT " >> ${LOG}
echo "" >> ${LOG}
echo "END ${anio}-${mes}-${dia} ${hora}:${min}:${seg}" >> ${LOG}
fi
rm /tmp/output.txt
