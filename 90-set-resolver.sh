#! /bin/sh

if [ -z "$RESOLVERS" ]; then
  RESOLVERS=$(awk 'BEGIN{ORS=" "} $1=="nameserver" {if ($2 ~ ":") {print "["$2"]"} else {print $2}}' /etc/resolv.conf)
fi

echo "$0: using resolver: ${RESOLVERS}"

cat $(dirname "$0")/nginx.conf.template | \
  RESOLVERS=$RESOLVERS envsubst '$RESOLVERS' | \
  cat > /etc/nginx/nginx.conf
