FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    dnsutils \
    sniproxy \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Копируем шаблоны конфигов и скрипт
COPY Corefile.template /etc/coredns/Corefile.template
COPY sniproxy.conf.template /etc/sniproxy.conf.template
COPY proxied_hosts /etc/sniproxy/proxied_hosts
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY setup.sh /setup.sh

RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
