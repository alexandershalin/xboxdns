FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    dnsutils \
    sniproxy \
    supervisor \
    iproute2 \
    gettext-base && \
    rm -rf /var/lib/apt/lists/*

# Установка CoreDNS (пример для версии 1.10.1)
RUN curl -L https://github.com/coredns/coredns/releases/download/v1.10.1/coredns_1.10.1_linux_amd64.tgz | tar -xz -C /usr/local/bin

# Копируем файлы
COPY Corefile.template /etc/coredns/Corefile.template
COPY sniproxy.conf.template /etc/sniproxy.conf.template
COPY proxied_hosts /etc/sniproxy/proxied_hosts
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY setup.sh /setup.sh

RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
