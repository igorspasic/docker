FROM elasticsearch:2.2

COPY ./config /usr/share/elasticsearch/config

# plugins
RUN /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ/v2.0.3
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
