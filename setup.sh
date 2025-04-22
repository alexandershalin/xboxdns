#!/bin/bash

# Получаем IP VPS внутри контейнера (внешний интерфейс)
VPS_IP=$(ip route get 1.1.1.1 | awk '{print $7; exit}')

echo "[INFO] Detected VPS IP: $VPS_IP"

# Генерируем конфиг для CoreDNS
envsubst '${VPS_IP}' < /etc/coredns/Corefile.template > /etc/coredns/Corefile

# Генерируем конфиг для SNIProxy
envsubst '${VPS_IP}' < /etc/sniproxy.conf.template > /etc/sniproxy.conf

# Запускаем supervisor (запустит CoreDNS и SNIProxy)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
