ARG VERSION=v3.5.6

FROM alpine:3.21

# COPY --from=minio/mc:latest /usr/bin/mc /usr/bin/mc
COPY --from=minio/mc:RELEASE.2025-02-15T10-36-16Z /usr/bin/mc /usr/bin/mc
COPY --from=quay.io/coreos/etcd:${VERSION} /usr/local/bin/etcdctl /usr/bin/etcdctl

COPY --chmod=0766 docker-entrypoint.sh /opt/docker-entrypoint.sh

ENTRYPOINT [ "bash", "/opt/docker-entrypoint.sh" ]
