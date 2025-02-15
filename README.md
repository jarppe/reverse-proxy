# Simple reverse HTTP proxy with nginx

This image contains a [nginx](https://nginx.org/) proxy configured to act as reverse proxy to all HTTP requests.

## Usage

Start proxy:

```bash
$ docker run -p 127.0.0.1:8000:8000 jarppe/reverse-proxy:latest
```

Use proxy with [curl](https://curl.se/):

```bash
$ export http_proxy=http://127.0.0.1:8000
$ curl http://metosin.fi
```

Note from reverse-proxy logs how the request was routed via it.

## Ok, but why?

I have used this with Kubernetes systems where I have many services and pods that I would like access via HTTP. Instead of opening a [kubectl port-forward](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_port-forward/) to each an every endpoint, I can run container of this image in cluster, and create a port-forward tunnel from my host to this containers port 8000.

## LICENSE

This work is copyright (c) Jarppe Länsiö 2025 and is licensed under [CC0](http://creativecommons.org/publicdomain/zero/1.0/.)
