FROM alpine

RUN set -x && \
    mkdir -p /var/log/cron && \
    mkdir -m 0644 -p /var/spool/cron/crontabs && \
    touch /var/log/cron/cron.log && \
    mkdir -m 0644 -p /etc/cron.d

ADD crontab /var/spool/cron/crontabs/root

CMD [ "crond", "-f"]
