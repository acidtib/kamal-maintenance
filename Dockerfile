FROM caddy:2.7.6-alpine

RUN apk --no-cache add curl

COPY web/maintenance.html /usr/share/caddy/index.html

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]