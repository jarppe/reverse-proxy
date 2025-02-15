FROM nginx:1-alpine

COPY 90-set-resolver.sh nginx.conf.template \
    /docker-entrypoint.d/