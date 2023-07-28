FROM alpine:edge
RUN set -ex; \
    adduser -S pgbouncer; \
    apk add --no-cache pgbouncer envsubst; \
    chown -R pgbouncer:nogroup /etc/pgbouncer
COPY pgbouncer.ini.tmpl /etc/pgbouncer/pgbouncer.ini.tmpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER pgbouncer
ENTRYPOINT [ "/entrypoint.sh" ]