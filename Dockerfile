FROM alpine:latest
MAINTAINER Shawn Hwei <shawn@shawnh.net>

ARG timezone=UTC

RUN apk update && apk upgrade

RUN apk add --no-cache rtorrent screen supervisor tzdata

RUN cp /usr/share/zoneinfo/$timezone /etc/localtime && echo "$timezone" > /etc/timezone && date && apk del tzdata

COPY *.conf /

COPY rtorrent.rc /root/.rtorrent.rc

VOLUME /rtorrent

EXPOSE 6881/udp 5000 49198

ENTRYPOINT ["supervisord", "-c", "/supervisord.conf"]
