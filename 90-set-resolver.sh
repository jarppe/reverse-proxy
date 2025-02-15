#! /bin/sh

if [ -z "$TARGET_PORT" ]; then
  TARGET_PORT=8080
fi

if [ -z "$RESOLVERS" ]; then
  RESOLVERS=$(awk 'BEGIN{ORS=" "} $1=="nameserver" {if ($2 ~ ":") {print "["$2"]"} else {print $2}}' /etc/resolv.conf)
fi

echo "$0: resolver: ${RESOLVERS}, target port: ${TARGET_PORT}"

cat $(dirname "$0")/nginx.conf.template | \
  TARGET_PORT=$TARGET_PORT RESOLVERS=$RESOLVERS envsubst '$RESOLVERS,$TARGET_PORT' | \
  cat > /etc/nginx/nginx.conf
