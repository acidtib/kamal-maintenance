#!/bin/sh

# Set default health check path to /up if not provided
HEALTHCHECK_PATH=${HEALTHCHECK_PATH:-/up}

# Check if LOGS_ENABLED environment variable is set to turn on or off logging
if [ "${LOGS_ENABLED}" = "true" ]; then
  LOG_CONFIG="log {
    output stdout
  }"
else
  LOG_CONFIG="# Logging is turned off"
fi

# Dynamically generate the Caddyfile
cat <<EOF > /etc/caddy/Caddyfile
http://:80 {
  root * /usr/share/caddy

  # Define a route for the /up path
  route $HEALTHCHECK_PATH {
    respond "OK" 200
  }

  encode gzip

  $LOG_CONFIG

  file_server
}
EOF

# ensure Caddyfile format
caddy fmt --overwrite /etc/caddy/Caddyfile

# Start Caddy with the generated Caddyfile
exec caddy run --config /etc/caddy/Caddyfile
