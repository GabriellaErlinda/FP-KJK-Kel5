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
![WhatsApp Image 2024-12-23 at 15 39 50_78edd46a](https://github.com/user-attachments/assets/14ce0151-f2b7-416f-ac47-d43be6dc96d1)

## Pembagian IP
![image](https://github.com/user-attachments/assets/c5994b5f-ddb9-4f64-85cd-083c4c534f45)
![image](https://github.com/user-attachments/assets/f795c0a5-3bf1-4459-b919-879279963088)


## Routing
### Router-DPTSI
```
enable
configure terminal

# Route ke network lantai 7 (Kelas)
ip route 192.168.0.0 255.255.255.0 192.168.1.66     # via TW2

# Route ke network lantai 9 (Lab)
ip route 192.168.1.0 255.255.255.192 192.168.1.66   # via TW2

# Route ke network server
ip route 192.168.1.76 255.255.255.248 192.168.1.74  # via Router-L6

write memory
```
### Router-L6
```
enable
configure terminal

# Default route ke DPTSI
ip route 0.0.0.0 0.0.0.0 192.168.1.73

write memory
```

### Router-TW2
![image](https://github.com/user-attachments/assets/d94de209-079b-42e7-8aa2-1744cde64464)

```
conf t
interface f0/0
 ip address 192.168.0.10 255.255.255.252
 no shutdown

interface f1/0
 ip address 192.168.0.17 255.255.255.248
 no shutdown

interface f2/0
 ip address 192.168.0.65 255.255.255.192
 no shutdown

ip route 192.168.0.0 255.255.255.252 192.168.0.9
ip route 192.168.0.4 255.255.255.252 192.168.0.9
ip route 192.168.1.0 255.255.255.0 192.168.0.18
exit

write memory
```

### Router-L7
![image](https://github.com/user-attachments/assets/8ed93093-5f7d-4162-b894-09c2d2974e43)

```
conf t
interface f0/0
 ip address 192.168.0.18 255.255.255.248
 no shutdown

interface f1/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown

ip route 192.168.0.0 255.255.255.252 192.168.0.17
ip route 192.168.0.4 255.255.255.252 192.168.0.17
ip route 192.168.0.64 255.255.255.192 192.168.0.17
exit

write memory

```

### Router-L9
![image](https://github.com/user-attachments/assets/07aa004c-e8e2-4c6d-8048-d0ba8df32858)

```
conf t
interface f0/0
 ip address 192.168.0.66 255.255.255.192
 no shutdown

interface f1/0
 ip address 192.168.0.129 255.255.255.192
 no shutdown

ip route 192.168.0.0 255.255.255.252 192.168.0.65
ip route 192.168.0.4 255.255.255.252 192.168.0.65
ip route 192.168.1.0 255.255.255.0 192.168.0.65
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
    netmask 255.255.255.248
    gateway 192.168.1.77
    up echo nameserver 8.8.8.8 > /etc/resolv.conf
```

### Kelas-701
```
# Static config for eth0
auto eth0
iface eth0 inet static
	address 192.168.1.2
	netmask 255.255.255.0
	gateway 192.168.1.1
	up echo nameserver 192.168.0.1 > /etc/resolv.conf
```

### Kelas-702
### Kelas-703
### Kelas-704
### Lab-901
### Lab-902
