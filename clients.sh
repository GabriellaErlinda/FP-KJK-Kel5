# Static config for eth0 LAB-901
auto eth0
iface eth0 inet static
	address 192.168.1.2
	netmask 255.255.255.192
	gateway 192.168.1.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
    up echo nameserver 8.8.4.4 >> /etc/resolv.conf
    
# Static config for eth0 LAB-902
auto eth0
iface eth0 inet static
	address 192.168.1.3
	netmask 255.255.255.192
	gateway 192.168.1.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
    up echo nameserver 8.8.4.4 >> /etc/resolv.conf

# Static config for eth0 CLIENT 701
auto eth0
iface eth0 inet static
	address 192.168.0.2
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
    up echo nameserver 8.8.4.4 >> /etc/resolv.conf

# Static config for eth0 CLIENT 702
auto eth0
iface eth0 inet static
	address 192.168.0.3
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
    up echo nameserver 8.8.4.4 >> /etc/resolv.conf

# Static config for eth0 CLIENT 703
auto eth0
iface eth0 inet static
	address 192.168.0.4
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
    up echo nameserver 8.8.4.4 >> /etc/resolv.conf

# Static config for eth0 CLIENT 704
auto eth0
iface eth0 inet static
	address 192.168.0.5
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
    up echo nameserver 8.8.4.4 >> /etc/resolv.conf
