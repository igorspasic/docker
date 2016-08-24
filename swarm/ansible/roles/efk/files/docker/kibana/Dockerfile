FROM kibana:latest

RUN apt-get update && apt-get install -y netcat

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY config/kibana.yml /opt/kibana/config/kibana.yml

RUN kibana plugin --install elastic/sense

CMD ["/entrypoint.sh"]
