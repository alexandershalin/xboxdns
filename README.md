```
git clone git@github.com:alexandershalin/xboxdns.git
cd xboxdns
systemctl stop systemd-resolved
docker build -t xboxdns .
docker run -d --name xboxdns \
  --restart unless-stopped \
  -p 53:53/udp -p 53:53/tcp \
  xboxdns
```
