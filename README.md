# Final Project KJK(B) Kelompok 5

| Nama                            | NRP          |
| ------------------------------- | ------------ |
| Marcelinus Alvinanda            | `5027221012` |
| Gabriella Erlinda Wijaya        | `5027221018` |
| Bintang Ryan Wardana            | `5027221022` |
| Nicholas Marco Weinandra        | `5027221042` |
| Jonathan Aditya                 | `5027221062` |

## Study Case
Teknologi Informasi memiliki sebuah jaringan komputer dengan detail sebagai berikut:
- 1 buah server di lantai 6 gedung perpustakaan. dalam server ini memiliki web service yang bisa diakses dari internal network.
- di lantai 7, memiliki 4 ruang kelas dengan fasilitas wifi, dengan kapasitas masing 40 mahasiswa.
- di lantai 9, memiliki 2 ruang lab, yang terdiri dari 25 komputer (lab 1) dan 25 komputer (lab 2) dengan koneksi ethernet. selain itu juga memiliki konektivitas wifi.
- semua jaringan terhubung oleh router utama (backbone) yang diletakkan di gedung riset center di DPTSI.

## Topologi GNS3
![image](https://github.com/user-attachments/assets/07b01910-f4a6-4de1-b478-9efbf8a4f4b1)

## Pembagian IP
![image](https://github.com/user-attachments/assets/f795c0a5-3bf1-4459-b919-879279963088) <br>
![image](https://github.com/user-attachments/assets/868e8763-597b-40a6-a13e-461e19cd70b3)

Perhitungan Subnet dapat diakses pada: 
[Sheets Perhitungan](https://docs.google.com/spreadsheets/d/1x6jne5dLVpQbpKo1pIfwNDZ7qPB0WZCtEuqpbexVY_I/edit?usp=sharing)

## Routing
### Router-DPTSI
```
enable
conf t
Router-DPTSI(config)# interface f0/0
Router-DPTSI(config-if)# ip address DHCP
Router-DPTSI(config-if)# no shutdown
Router-DPTSI(config-if)# exit

Router-DPTSI(config)# interface f1/0
Router-DPTSI(config-if)# ip address 192.168.1.81 255.255.255.252
Router-DPTSI(config-if)# no shutdown
Router-DPTSI(config-if)# exit

Router-DPTSI(config)# interface f2/0
Router-DPTSI(config-if)# ip address 192.168.1.73 255.255.255.252
Router-DPTSI(config-if)# no shutdown
Router-DPTSI(config-if)# exit

Router-DPTSI(config)# ip route 0.0.0.0 0.0.0.0 f0/0

# Route ke jaringan A5 melalui Router-L7
Router-DPTSI(config)# ip route 192.168.0.0 255.255.255.0 192.168.1.66
  
# Route ke jaringan A4 melalui TW2
Router-DPTSI(config)# ip route 192.168.1.64 255.255.255.248 192.168.1.65
  
# Route ke jaringan A6 melalui Router-L9
Router-DPTSI(config)# ip route 192.168.1.0 255.255.255.192 192.168.1.67

Router-DPTSI# write memory
```
### Router-L6
```
enable
conf t
  # Route ke jaringan A5 melalui Router-L7
  ip route 192.168.0.0 255.255.255.0 192.168.1.66

  # Route ke jaringan A4 melalui TW2
  ip route 192.168.1.64 255.255.255.248 192.168.1.65

  # Route ke jaringan A6 melalui Router-L9
  ip route 192.168.1.0 255.255.255.192 192.168.1.67

  # Route ke jaringan A3 melalui Router-DPTSI
  ip route 192.168.1.72 255.255.255.252 192.168.1.73

write memory
```

### Router-TW2
```
conf t
interface f0/0
 ip address 192.168.1.74 255.255.255.252
 no shutdown

interface f1/0
 ip address 192.168.1.65 255.255.255.248
 no shutdown

# Route ke jaringan A5 melalui Router-L7
ip route 192.168.0.0 255.255.255.0 192.168.1.66

# Route ke jaringan A6 melalui Router-L9
ip route 192.168.1.0 255.255.255.192 192.168.1.67

# Route ke jaringan A1 melalui Router-DPTSI
ip route 192.168.1.80 255.255.255.252 192.168.1.73

# Route ke jaringan A2 melalui Router-L6
ip route 192.168.1.76 255.255.255.252 192.168.1.77

write memory
```

### Router-L7
![image](https://github.com/user-attachments/assets/8ed93093-5f7d-4162-b894-09c2d2974e43)

```
enable
conf t
interface f0/0
 ip address 192.168.0.18 255.255.255.248
 no shutdown
 exit

interface f1/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown
 exit

# Route ke jaringan A4 melalui TW2
ip route 192.168.1.64 255.255.255.248 192.168.1.65

# Route ke jaringan A6 melalui Router-L9
ip route 192.168.1.0 255.255.255.192 192.168.1.67

# Route ke jaringan A1 melalui Router-DPTSI
ip route 192.168.1.80 255.255.255.252 192.168.1.73

# Route ke jaringan A2 melalui Router-L6
ip route 192.168.1.76 255.255.255.252 192.168.1.77

write memory
```

### Router-L9
```
enable
conf t
interface f0/0
 ip address 192.168.1.67 255.255.255.248
 no shutdown
 exit

interface f1/0
 ip address 192.168.1.1 255.255.255.192
 no shutdown
 exit

# Route ke jaringan A5 melalui Router-L7
ip route 192.168.0.0 255.255.255.0 192.168.1.66

# Route ke jaringan A4 melalui TW2
ip route 192.168.1.64 255.255.255.248 192.168.1.65

# Route ke jaringan A1 melalui Router-DPTSI
ip route 192.168.1.80 255.255.255.252 192.168.1.73

# Route ke jaringan A2 melalui Router-L6
ip route 192.168.1.76 255.255.255.252 192.168.1.77
exit

write memory
```
### WebServer
Konfigurasi di file /etc/network/interfaces:
```
# Static config for eth0
auto eth0
iface eth0 inet static
    address 192.168.1.78
    netmask 255.255.255.252
    gateway 192.168.1.77
    up echo nameserver 192.168.1.77 > /etc/resolv.conf
```

### Kelas-701
```
auto eth0
iface eth0 inet static
	address 192.168.0.2
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
        up echo nameserver 8.8.4.4 >> /etc/resolv.conf
```

### Kelas-702
```
auto eth0
iface eth0 inet static
	address 192.168.0.3
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
        up echo nameserver 8.8.4.4 >> /etc/resolv.conf
```

### Kelas-703
```
auto eth0
iface eth0 inet static
	address 192.168.0.4
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
        up echo nameserver 8.8.4.4 >> /etc/resolv.conf
```

### Kelas-704
```
auto eth0
iface eth0 inet static
	address 192.168.0.5
	netmask 255.255.255.0
	gateway 192.168.0.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
        up echo nameserver 8.8.4.4 >> /etc/resolv.conf
```

### Lab-901
```
auto eth0
iface eth0 inet static
	address 192.168.1.2
	netmask 255.255.255.192
	gateway 192.168.1.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
        up echo nameserver 8.8.4.4 >> /etc/resolv.conf
```

### Lab-902
```
auto eth0
iface eth0 inet static
	address 192.168.1.3
	netmask 255.255.255.192
	gateway 192.168.1.1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
        up echo nameserver 8.8.4.4 >> /etc/resolv.conf
```
