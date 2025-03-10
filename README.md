# Final Project KJK(B) Kelompok 5

| Nama                            | NRP          |
| ------------------------------- | ------------ |
| Marcelinus Alvinanda Chrisantya | `5027221012` |
| Gabriella Erlinda Wijaya        | `5027221018` |
| Bintang Ryan Wardana            | `5027221022` |
| Nicholas Marco Weinandra        | `5027221042` |
| Jonathan Adithya Baswara        | `5027221062` |

## Daftar Isi
- [Study Case](#study-case)
- [Topologi](#Topologi-GNS3)
- [Pembagian IP](#Pembagian-IP)
- [Routing](#Routing)
	- [Ping Test](#Ping-Test)
   	- [Konfigurasi Web Server](#Konfigurasi-Webserver)
- [Implementasi ACL](#Implementasi-ACL-(Access-Control-List))
	- [Testing ACL](#Testing-ACL)
- [Implementasi SSH](#Implementasi-SSH)
	- [Testing SSH](#Testing-SSH)

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

# interface
interface f0/0
ip address dhcp
no sh

interface f1/0
ip address 192.68.1.73 255.255.255.252
no sh

interface f2/0
ip address 192.168.1.81 255.255.255.252
no sh

# route
ip route 0.0.0.0 0.0.0.0 192.168.122.1
ip route 192.168.1.64 255.255.255.248 192.168.1.74
ip route 192.168.0.0 255.255.255.0 192.168.1.74
ip route 192.168.1.0 255.255.255.192 192.168.1.74
ip route 192.168.1.77 255.255.255.252 192.168.1.82

# dns
ip name-server 8.8.8.8 8.8.4.4
ip domain lookup

# internet access
ip nat inside source list 1 interface f0/0 overload
access-list 1 permit 192.168.0.0 0.0.255.255

interface f0/0
ip nat outside

interface f1/0
ip nat inside

interface f2/0
ip nat inside

write memory
```
### Router-L6
```
enable
conf t

# interface
int f0/0
ip address 192.168.1.82 255.255.255.252
no sh

int f1/0
ip address 192.168.1.77 255.255.255.252
no sh

# route
ip route 0.0.0.0 0.0.0.0 192.168.1.81

# dns
ip name-server 8.8.8.8 8.8.4.4
ip domain lookup

write memory
```

### Router-TW2
```
enable
conf t

# interface
int f0/0
ip address 192.168.1.74
no sh

# route
ip route 0.0.0.0 0.0.0.0 192.168.1.73
ip route 192.168.0.0 255.255.255.0 192.168.1.66
ip route 192.168.1.0 255.255.255.192 192.168.1.67

# dns
ip name-server 8.8.8.8 8.8.4.4
ip domain lookup

write memory
```

### Router-L7
```
enable
conf t

# interface
int f0/0
ip address 192.168.1.66 255.255.255.248
no sh

int f1/0
ip address 192.168.0.1 255.255.255.0
no sh

# route
ip route 0.0.0.0 0.0.0.0 192.168.1.65

# dns
ip name-server 8.8.8.8 8.8.4.4
ip domain lookup

write memory
```

### Router-L9
```
enable
conf t

# interface
int f0/0
ip address 192.168.1.67 255.255.255.248
no sh

int f1/0
ip address 192.168.1.1 255.255.255.192
no sh

# route
ip route 0.0.0.0 0.0.0.0 192.168.1.65

# dns
ip name-server 8.8.8.8 8.8.4.4
ip domain lookup

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
    up echo nameserver 8.8.8.8 > /etc/resolv.conf
    up echo nameserver 8.8.4.4 >> /etc/resolv.conf
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

## Ping Test
#### DPTSI
![DPTSI](https://github.com/user-attachments/assets/0311101d-d4b0-4e9d-9078-76de782c72bc)
#### TW2
![TW2](https://github.com/user-attachments/assets/2a4c42dd-1bbc-4e48-928a-53244bb508fd)
#### Router-L6
![Router-L6](https://github.com/user-attachments/assets/abcbba7b-d0d5-43ad-a85d-0338538feac5)
#### Router-L7
![Router-L7](https://github.com/user-attachments/assets/616af495-061f-490a-8ed3-8b8ebfc97edf)
#### Router-L9
![Router-L9](https://github.com/user-attachments/assets/9028ca8e-588f-44a0-96ee-58ec30eef808)
#### Client 701, 702, 703, 704
![701](https://github.com/user-attachments/assets/4a2a6fbd-fb2e-4d2f-a1c6-3ebb5fa75960)
![702](https://github.com/user-attachments/assets/eb9d7205-95f8-4857-b6d6-db23a0c15864)
![703](https://github.com/user-attachments/assets/e39a070e-9e2d-439c-8637-0d8e62ab8812)
![704](https://github.com/user-attachments/assets/31e34219-1364-4e49-9e95-596ee4491a6f)
#### Lab 901, 902
![901](https://github.com/user-attachments/assets/658a0f3f-f95d-43a4-b96c-6f0f04acb3da)
![902](https://github.com/user-attachments/assets/07aacabe-0eb0-4bd0-b70a-941bc14f3090)

## Konfigurasi WebServer
File python `server.py` dapat dijalankan pada `/root` maka server akan dapat dihubungi oleh client
- Pada console WebServer
```
cd root
python3 server.py
```
![image](https://github.com/user-attachments/assets/62455146-0ff8-42ad-adf5-53335e97981a)

- Pada console client
```
curl 192.168.1.78
```
![image](https://github.com/user-attachments/assets/364da601-d62e-4cb3-9d79-42743b258758)
![image](https://github.com/user-attachments/assets/cc5eaa34-0f86-4a02-9a9a-3e5dabd4fb40)

## Implementasi ACL (Access Control List)
Implementasi ACL pada sistem jaringan ini berguna untuk:
- Hanya mengizinkan lalu lintas HTTP/HTTPS ke WebServer
- Memblokir semua protokol lain ke WebServer
- Mengizinkan semua lalu lintas lain untuk melewatinya

### Konfigurasi Router Lantai 6
```
Router-L6(config)# ip access-list extended PROTECT-WEBSERVER
Router-L6(config-ext-nacl)# permit tcp any host 192.168.1.78 eq 80
Router-L6(config-ext-nacl)# permit tcp any host 192.168.1.78 eq 443
Router-L6(config-ext-nacl)# deny ip any host 192.168.1.78
Router-L6(config-ext-nacl)# permit ip any any
Router-L6(config)# interface f1/0
Router-L6(config-if)# ip access-group PROTECT-WEBSERVER in
```

## Testing ACL
### Memperbolehkan koneksi HTTP/HTTPS ke Webserver
- Membuka web

![image](https://github.com/user-attachments/assets/ac50b115-b8ca-4dba-afc5-2e1a81ecf2ca)

- Melakukan koneksi menggunakan telnet

![image](https://github.com/user-attachments/assets/997e23b7-ea41-4c94-8c89-47bfb33f191a)

- Melakukan ping ke webserver

![image](https://github.com/user-attachments/assets/0d510ab1-09bf-4662-b3a0-b66464b8b4b6)

### Mensimulasikan percobaan serangan ke Webserver (akan diblokir oleh ACL)
- SSH attempt
  
![image](https://github.com/user-attachments/assets/3587bde2-5fd2-4b58-a40d-9006bf4c4924)


- RDP attempt
  
![image](https://github.com/user-attachments/assets/cd6d5db9-dc3f-4a74-8049-50b822d59db4)

- Ping Flood

![image](https://github.com/user-attachments/assets/6a508a5e-2815-4b08-84c9-c9280ee5ceec)

Dari hasil percobaan serangan yang telah dilakukan, dapat disimpulkan bahwa konfigurasi ACL bekerja dengan benar dan seperti yang diharapkan. Dengan menerapkan ACL, hanya port HTTP(80) dan HTTPS(443) yang diizinkan untuk tersambung dengan server. Selain itu, implementasi ACL tersebut juga memberi proteksi terhadap `Port Scanning`, serangan `Distributed Denial of Service (DDoS)`, dan `unauthorized protocol`.

## Implementasi SSH
Dikarenakan Router lantai 6 memiliki tugas untuk melindungi langsung Webserver, maka penting untuk memproteksi koneksi agar router lantai 6 hanya dapat diakses oleh orang tertentu saja, seperti admin. Apabila ada celah bagi orang yang tidak terautorisasi berhasil melakukan koneksi kepada Router tersebut, maka orang itu dapat dengan mudah mengubah konfigurasi ACL dan mengambil alih sistem server. Oleh karena itu, SSH memastikan agar router tidak dapat diakses oleh sembarang orang dengan mengimplementasikan username dan password untuk dapat melakukan koneksi.

### Konfigurasi Router Lantai 6
```
Router-L6(config)# ip access-list extended PROTECT-WEBSERVER
Router-L6(config-ext-nacl)# permit tcp any host 192.168.1.78 eq 80
Router-L6(config-ext-nacl)# permit tcp any host 192.168.1.78 eq 443
Router-L6(config-ext-nacl)# deny ip any host 192.168.1.78
Router-L6(config-ext-nacl)# permit ip any any
Router-L6(config)# interface f1/0
Router-L6(config-if)# ip access-group PROTECT-WEBSERVER in

Router-L6(config)#username admin secret  kelompok5
Router-L6(config)# line vty 0 4
Router-L6(config-line)# login local
Router-L6(config-line)# transport input ssh


Router-L6(config)# ip domain-name example.com
Router-L6(config)# crypto key generate rsa modulus 2048
Router-L6(config)# ip ssh version 2

Router-L6(config)# banner motd #
Selamat Datang di Router Lantai 6
#

Router-L6(config)# logging buffered 16384
Router-L6(config)# logging console
Router-L6(config)# service timestamps log datetime msec

Router-L6(config)# enable secret kelompok5
```

## Testing SSH
Pada Client, kita dapat melakukan koneksi ke Router lt 6 dengan menggunakan command
```
ssh -l admin -c aes128-cbc,3des-cbc,aes192-cbc 192.168.1.77
```

![image](https://github.com/user-attachments/assets/f0ee6054-8364-4ca5-b14e-34571ab11c26)

Masukkan password : `kelompok5` dan kita telah berhasil melakukan koneksi SSH ke router. Disini kita dapat melakukan konfigurasi pada router.

![image](https://github.com/user-attachments/assets/dc1f72b0-eeb9-4e57-8730-1d9b85bb4c74)







