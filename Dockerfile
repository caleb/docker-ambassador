FROM cpuguy83/docker-grand-ambassador

MAINTAINER Caleb Land <caleb@land.fm>

ADD ./docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
