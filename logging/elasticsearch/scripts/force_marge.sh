#!/bin/bash
hora=`date "+%H" `
min=`date "+%M" `
seg=`date "+%S" `
dia=`date "+%d" `
mes=`date "+%m" `
anio=`date "+%Y" `
user=elastic
pass=""
LOG="/var/log/el_purge/force_marge-${dia}-${mes}-${anio}.log"

echo "START  ${anio}-${mes}-${dia} ${hora}:${min}:${seg}" >> ${LOG}

curl -k -s -XPOST -u ${user}:${pass} 'https://172.29.98.182:9200/newco.oathkeeper,newco.hydra,haproxy,newco.intraoathkeeper/_forcemerge' > /tmp/output.txt 2>&1
if [ $? -eq 0 ]; then
OUTPUT=`cat /tmp/output.txt`
echo "" >> ${LOG}
echo "  Se ejecuto la fusion de fragmentos corresctamente" >> ${LOG}
echo "$OUTPUT " >> ${LOG}
echo "" >> ${LOG}
echo "END ${anio}-${mes}-${dia} ${hora}:${min}:${seg}" >> ${LOG}
else
OUTPUT=`cat /tmp/err.txt`
echo "" >> ${LOG}
echo "  Fallo  la fusion de fragmentos:" >> ${LOG}
echo "" >> ${LOG}
echo "$OUTPUT " >> ${LOG}
echo "" >> ${LOG}
echo "END ${anio}-${mes}-${dia} ${hora}:${min}:${seg}" >> ${LOG}
fi
rm /tmp/output.txt
