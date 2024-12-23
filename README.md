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
```
enable
configure terminal

# Route ke network lantai 7 (Kelas)
ip route 192.168.0.0 255.255.255.0 192.168.1.65     # via Router-L7

# Route ke network lantai 9 (Lab)
ip route 192.168.1.0 255.255.255.192 192.168.1.65   # via Router-L9

# Default route ke DPTSI
ip route 0.0.0.0 0.0.0.0 192.168.1.70

write memory
```

### Router-L7
```
enable
configure terminal

# Default route ke TW2
ip route 0.0.0.0 0.0.0.0 192.168.1.66

write memory
```

### Router-L9
```
enable
configure terminal

# Default route ke TW2
ip route 0.0.0.0 0.0.0.0 192.168.1.66

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
### Kelas-702
### Kelas-703
### Kelas-704
### Lab-901
### Lab-902
