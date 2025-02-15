# Simple reverse HTTP proxy with nginx

This image contains a [nginx](https://nginx.org/) proxy configured to act as reverse proxy to all HTTP requests.

## Usage

Start proxy:

```bash
$ docker run -p 127.0.0.1:8000:8000 --env TARGET_PORT=80 jarppe/reverse-proxy:latest
```

Use proxy with [curl](https://curl.se/):

```bash
$ export http_proxy=http://127.0.0.1:8000
$ curl -v http://metosin.fi
* Uses proxy env variable http_proxy == 'http://127.0.0.1:8000'
*   Trying 127.0.0.1:8000...
* Connected to 127.0.0.1 (127.0.0.1) port 8000
> GET http://metosin.fi/ HTTP/1.1
> Host: metosin.fi
> User-Agent: curl/8.7.1
> Accept: */*
> Proxy-Connection: Keep-Alive
> 
* Request completely sent off
< HTTP/1.1 308 Permanent Redirect
< Date: Sat, 15 Feb 2025 13:07:05 GMT
< Content-Type: text/plain
< Transfer-Encoding: chunked
< Connection: keep-alive
< Location: https://metosin.fi/
```

Note from curl output and reverse-proxy logs how the request was routed via proxy container.

## Ok, but why?

I have used this with Kubernetes systems where I have many services and pods that I would like access via HTTP. Instead of opening a [kubectl port-forward](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_port-forward/) to each an every endpoint, I can run container of this image in cluster, and create a port-forward tunnel from my host to this containers port 8000.

## Configuration

There are two configuration variables, both set with environment variables.

| Name        | Description                                                                      |
| ----------- | -------------------------------------------------------------------------------- |
| TARGET_PORT | The target port where requests are proxied to, defaults to `8000`                |
| RESOLVERS   | DNS server IP addess, defaults to nameserver arress read from `/etc/resolv.conf` |

### About that PORT

The proxy uses the host name from the request, but not the port number. I would love to use the port number from the request URL, so I could use the same proxy instance and direct to what ever port number is in request URL. Unfortunately, I do not know how to get that port number from URL in nginx config. Therefore the current implementation uses the port number set by the `TARGET_PORT` environment. If you have any ideas how get the port number from URL please ping me with mailto:jarppe@hgmail.com.

## LICENSE

This work is copyright (c) Jarppe Länsiö 2025 and is licensed under [CC0](http://creativecommons.org/publicdomain/zero/1.0/.)
