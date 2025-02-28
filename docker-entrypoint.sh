#!/bin/bash
set -e -o pipefail

NOW=$(date +%Y-%m-%d_%H:%M:%S)

mc alias set "$MINIO_ALIAS_NAME" "$MINIO_SERVER" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY"

etcdctl --endpoints=$ENDPOINTS --cacert=/certs/ca.crt --cert=/certs/healthcheck-client.crt --key=/certs/healthcheck-client.key snapshot save /tmp/etcd_backup_${NOW}.db

mc cp /tmp/etcd_backup_${NOW}.db ${MINIO_ALIAS_NAME}/${MINIO_BUCKET} || { echo "Backup failed"; mc rm "${MINIO_ALIAS_NAME}/$ARCHIVE"; exit 1; }
