ARG VERSION=v3.5.6

FROM quay.io/coreos/etcd:${VERSION}

# COPY --from=minio/mc:latest /usr/bin/mc /usr/bin/mc
COPY --from=minio/mc:RELEASE.2025-02-15T10-36-16Z /usr/bin/mc /usr/bin/mc

COPY --chmod=0766 docker-entrypoint.sh /opt/docker-entrypoint.sh

ENTRYPOINT [ "bash", "/opt/docker-entrypoint.sh" ]
