# How to configure OpenVPN in raspberry pi

## Change your DNS servers to be static

Check /etc/resolv.conf for the DNS server and change them to use public servers. The google ones work:

- 8.8.8.8
- 8.8.4.4

If DNS server is set to be your router, some ISPs may block some of your traffic
You may need to modify some other configuration files, for example /etc/network/interfaces so your config does not get reset at each rebot/start of interfaces. I have this:

```
iface eth0 inet manual
   dns-nameservers 8.8.8.8 8.8.4.4
```

## Configuring the connection

I am explaining how to do it in PIA, but openvpn configuration should be fairly similar. You can download https://www.privateinternetaccess.com/openvpn/openvpn.zip, but you can configure the openvpn file without it.

First, install openvpn with 

```
sudo apt-get install openvpn
```

Then go to /etc/openvpn and set your config file like this one:

```
client
auth-user-pass pia.data
fast-io
script-security 2
dev tun
proto udp
resolv-retry infinite
nobind
persist-key
persist-tun
ca ca.crt
tls-client
remote-cert-tls server
comp-lzo
verb 4
reneg-sec 0
crl-verify /etc/openvpn/crl.pem
route-up route-up.sh
down-pre
down route-down.sh
daemon
log-append /var/log/piavpn.log
remote nl.privateinternetaccess.com 1194
```

The important lines on this file are:

- *script-security 2* - will allow you to run external scripts
- *route-up route-up.sh* - script tp be run when VPN starts 
- *down-pre* - set the down script to run just before VPN gets shut down
- *down route-down.sh* - script to be run when VPN stops
- *remote HOSTNAME PORT* - server configuration

## Scripts to run before and after the connection

Mostly here you will start and stop services, and other similar things, but the command you need to run to route all traffic through the VPN:

```
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
```

when the VPN gets shut down, you should remove this rule using -D instead of -A

