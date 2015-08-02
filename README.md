# Transmission daemon container

Run transmission daemon allowing you to specify USER_UID and USER_GID, so you
will not have permission problems.

## Example

```
docker run \
  -e USER_ID=1000 \
  -e USER_GID=1000 \
  --rm \
  -p 9091:9091 \
  -p 12345:12345 -p 12345:12345/udp \
  -v `pwd`/downloads:/downloads \
  -v `pwd`/config:/etc/transmission
  chrodriguez/transmission
```

## Default settings

RPC username and password by default are: *admin* *admin*

Be careful changing download and port settings because they are related on how
you'll run the container
