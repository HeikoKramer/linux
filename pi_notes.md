# My Raspberry Pi related notes

## wpa_supplicant.conf
The **wpa_supplicant.conf** file is a way to pre-configure WiFi on a Raspi. <br>
Such a file has the advantage that your Raspi will be connected to your WiFi after boot without keyboard interaction. <br>
<br>
Follow these steps to setup your wpa_supplicant.conf on a fresh Raspi: <br>
### Step 1
Create a boot sd from image or insert an existing one to your main machine before inserting it to the Raspi. <br>
### Step 2
Use the `lsblk` command to identify the **boot** partition of the sd card. <br>
```sh
$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 465,8G  0 disk 
sdb           8:16   1  14,9G  0 disk 
├─sdb1        8:17   1   256M  0 part /media/heiko/boot
└─sdb2        8:18   1   7,3G  0 part
```

### Step 3
Enter the partition `cd /media/heiko/boot` and create the conf file `touch wpa_supplicant.conf`. <br>
Open the file with your editor of choice `vim wpa_supplicant.conf`. <br>
```sh
country=de
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 scan_ssid=1
 ssid="Your_WiFi_Name"
 psk="Your_WiFi_Password"
}
```

### Step 4
Eject the sd card, insert it into the Raspi and boot. <br>
The device should be connected to your WiFi already. <br>

## Enable SSH on boot sd
You can enable SSH before booting your Raspi by simply creating an empty file with `touch ssh` in the same boot partition as in the example above. <br>

