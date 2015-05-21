FROM cpuguy83/docker-grand-ambassador

MAINTAINER Caleb Land <caleb@land.fm>

# Mark this container as an ambassador
ENV __TAGS__=ambassador

ADD ./docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ambassador"]
