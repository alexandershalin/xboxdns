Clone the repository to your VPS and go to the cloned directory:

```
git clone git@github.com:alexandershalin/xboxdns.git
cd xboxdns
```

Stop the system resolver. On your VPS, this command may differ.

``systemctl stop systemd-resolved``

Build Docker image:

``docker build -t xboxdns .``

Run the container:

```
docker run -d --name xboxdns \
  --restart unless-stopped \
  -p 53:53/udp -p 53:53/tcp \
  -p 443:443 \
  xboxdns
```
