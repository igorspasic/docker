FROM fluent/fluentd:latest

USER root
WORKDIR /
RUN apk add --update netcat-openbsd && rm -rf /var/cache/apk/*
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PATH /home/ubuntu/ruby/bin:$PATH
RUN gem install fluent-plugin-elasticsearch

ADD fluent.conf /fluentd/etc/fluent.conf

CMD ["sh", "-c", "/entrypoint.sh"]