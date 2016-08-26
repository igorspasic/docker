FROM fluent/fluentd:latest

WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root
RUN apk --no-cache --update add sudo build-base ruby-dev && \
    sudo -u fluent gem install fluent-plugin-elasticsearch fluent-plugin-record-reformer && \
    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

USER fluent

COPY entrypoint.sh /entrypoint.sh

ADD fluent.conf /fluentd/etc/fluent.conf

VOLUME /data:/fluentd/log

ENTRYPOINT [ "/entrypoint.sh" ]