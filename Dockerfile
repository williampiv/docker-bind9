FROM ubuntu:latest
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  bind9 curl
RUN rm -rf /etc/bind/* \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /etc/bind/zones \
  && curl -L -o /etc/bind/zones/db.root https://www.internic.net/domain/named.cache
ADD zones/db.local /etc/bind/zones/db.local
EXPOSE 53 953
RUN mkdir -p /var/run/named \
  && mkdir -p /var/log/named \
  && touch /var/log/named/bind.log
ENTRYPOINT ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "root"]
