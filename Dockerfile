FROM alpine:latest
MAINTAINER Shawn Hwei <shawn@shawnh.net>

ARG timezone=UTC

RUN apk update && apk upgrade

RUN apk add --no-cache rtorrent supervisor tzdata

RUN cp /usr/share/zoneinfo/$timezone /etc/localtime && echo "$timezone" > /etc/timezone && date && apk del tzdata

COPY supervisord.conf /config/

COPY rtorrent.rc /root/.rtorrent.rc

VOLUME /root /rtorrent /rtorrent/session /rtorrent/downloads

EXPOSE 6881/udp 5000 49198

ENTRYPOINT ["supervisord", "-c", "/config/supervisord.conf"]
