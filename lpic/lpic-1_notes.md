# LPIC-1 Notes
Notes I'm taking as a preparation for the LPIC-1 certificate. <br>
I'm using the [Rheinwerk LPIC-1 book by Harald Maaßen](https://www.rheinwerk-verlag.de/lpic-1-sicher-zur-erfolgreichen-linux-zertifizierung/) (German) and the [LPIC-1 - Linux System Administrator Masterclass](https://www.udemy.com/course/lpic-1-linux-system-administrator-masterclass/) Udemy course as the main source for my prep-work. <br>
Other sources will be linked appropriate. <br>

## CLI basics 
### pwd
`pwd` *print working directory* – prints complete path for the entered directory (full directory tree). <br>

```sh
10:08:51:heiko@tiny:~
$ pwd
/home/heiko
```

In this case `pwd` shows that we're in a subdirectory of the */home* directory. <br>
*heiko* is my **username** and therewith also the name of my **personal home directory** */heiko*. <br>
In this personal home directory I'm authorized to **create, delete, copy**, etc. files and directories **without root privileges**. <br>
**root** is the **administrator** on a Linux system. <br>
Our personal home directory is represented by the **tilde symbol** – **~** – in the command prompt. <br>

## ls
`ls` *list* displays the contents of the directory in which we are currently located. <br>
There are many useful options for `ls`, here are my favourites, which I usually include in an `ls` alias: <br>
* -a – lets you see **all** files (include hidden files)
* -l – shows contents in list format, with additional information
* -h – shows file size in **human readable** format
* -t – sorts filed by modification time, newest first

## cd
`cd` *change directory* is used to navigate the directory tree. <br>
`cd ~/Downloads` brings us to the *Downloads* directory. <br>
`cd ..` takes us **one step back** in the directory tree. <br>
`cd` or `cd  ~` take us back to our **personal home** directory. <br>
`cd -` lets us jump to the **last** directory we have visited before the current directory. <br>
`cd /` brings us to the **root** directory. <br>

## / the root directory
*/* – the *root directory* is our **1st directory** in the file tree. <br>

```sh
11:22:10:heiko@tiny:/
$ ls
bin   cdrom  etc   lib    lib64   lost+found  mnt  proc  run   srv       sys        tmp  var
boot  dev    home  lib32  libx32  media       opt  root  sbin  swapfile  timeshift  usr
```

It contains a lot of system directories – also the *home* directory, where every user registered on the system has its sub-directory. <br>
Those files and directories outside of the user's personal home directory might require **root privileges** for interaction. <br>
To navigate the file tree outside the root directory (withing the personal home dir) **~/** is needed. Within root the tilde is not needed. <br>

## Man & help pages
The most commands have a **manual** which can be entered by typing `man` + the command name – `man ls` for example. <br>
The **man pages** show all the available options for a command and sometimes also examples. <br>
Some commands have **help pages** which can be entered with command name + `-h` or `--help`. <br>



## 101 System Architecture
The Linux kernel is the interface between hardware and software. <br>
Its architecture is **modular** – single components can be loaded / re-loaded during runtime, without re-loading the entire system. <br>
This is an advantage above *monolytic* kernels, which would require a complete re-load. <br>

## 101.1 Determine and configure hardware settings
### kernel version
#### uname
`uname -r` can be used to find the kernel version. The **-r** option stands for **release**. <br>
`uname -m` for **machine** will provide information in regards to the underlying system architecture. <br>
`uname -a` will show **all** information `uname` hast to offer. <br>
<br>
Output: *Linux tiny 5.13.0-35-generic #40~20.04.1-Ubuntu SMP Mon Mar 7 09:18:32 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux* <br>
Let's break this down into sections: <br>
* Linux – *Kernel Name*
* tiny – *Host Name*
* 5.13.0-35-generic – *Kernel Release*
* #40~20.04.1-Ubuntu SMP Mon Mar 7 09:18:32 UTC 2022 – *Kernel Version*
* x86_64 – *Processor Type*
* x86_64 – *Hardware Platform*
* x86_64 – *Architecture of the Processor*
* GNU/Linux – *Operating System*


The directory */lib/modules* contains (this depends on the distro) the full history of former installed kernel versions. <br>
*/usr/src/* contains directories named after kernel version – which contain the source code of the appropriate kernel. <br>
<br>
A kernel version looks like this: *5.13.0-28-generic* <br>
* The first number (5) represents the **major release**.
* The second number (13) represents a **minor release**.
* The third number (0) represents the **patch level**.

Everything after the third number (-28-generic) is specified in the kernel's **make file** and has no fixed meaning (can be changed). <br>

### kernel modules
#### lsmod
`lsmod` prints the status of modules of the running kernel. <br>
This information comes from the file */proc/modules*. <br>
So `cat /proc/modules` would provide identical information, but `lsmod` presents it in a more readable format. <br>
<br>
The format of `lsmod` looks like this: <br>

```sh
videobuf2_common       61440  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
```

On the left we see the **module name**, followed by its **size in bytes**, then the **number of dependent modules** + a **list of their names**. <br>

#### modinfo
Those modules from that list can be inspected further with the `modinfo` command. <br>
`modinfo btrfs` for example will provide details for the *btrfs* module: <br>

```sh
filename:       /lib/modules/5.13.0-30-generic/kernel/fs/btrfs/btrfs.ko
license:        GPL
alias:          devname:btrfs-control
alias:          char-major-10-234
alias:          fs-btrfs
depends:        libcrc32c,zstd_compress,raid6_pq,xor
name:           btrfs
vermagic:       5.13.0-30-generic SMP mod_unload modversions 
sig_id:         PKCS#7
```

The extension *.ko* stands for *Kernel Object*, sometimes you also might see only *.o* for *Object*. <br>
The information shown differ from module to module, but can for example contain: <br>

* module version
* module author information + contact data
* module description
* dependencies to other modules

`modinfo` has multiple options, to show only specific information: <br>
* `modinfo -a` shows the **author** of the module
* `modinfo -d` shows the **description** of the module
* `modinfo -l` shows the **license** of the module
* `modinfo -p` shows required **parameters** for the module
* `modinfo -n` shows the **filename** of the module

#### insmod
`insmod` is a simple program to **insert a module** into the Linux Kernel. <br>
It requires the whole file path of the module that should be loaded into memory. <br>
`insmod` won't automatically load any dependencies and it doesn't show success messages. <br>

#### rmmod
`rmmod` can be used to **remove modules** from memory. <br>
It takes in the module name as a parameter. <br>
`rmmod` doesn't provide success messages, but it shows an error if a module is required by an other active module. <br>
Dependencies can be ignored and remove be forced with `rmmod -f`. <br>

#### modprobe
`modprobe` is a combination of `insmod` and `rmmod` with some additional features. <br>
It is capable of finding and loading required modules from a module's dependency tree. <br>
`modprobe` doesn't require the full module path like `insmod` – it uses `uname -r` to find the kernel's base directory. <br>
It can load all modules of a certain type: <br>

```sh
modprobe -at net

# -a for "all"
# -t for "type"
# net for type "network" 
```

Modules can be removed with `modprobe -r` – multiple module names can be passed at the same time (separated by space). <br>
RETIRED: Modules can be listed with `modprobe -l` – this shows not only loaded but also loadable modules. <br> 

To test this, let's remove the *ip_tables* module, which runs our firewall. <br>
First let's check with `lsmod` if *ip_tables* is running, here we restrict the list output with the `grep` command: <br>

```sh
$ lsmod | grep ip_tables
ip_tables              32768  0
```

A normal user has not the required permission to unload a module, so we have to run this with **sudo**: <br>

```sh
sudo modprobe -r ip_tables
```

If we run `lsmod | grep ip_tables` again, it won't show any results, the module has been removed from the running kernel. <br>
To load *ip_tables* again, we can run `sudo modprobe ip_tables` – **sudo** is also required to load modules into the kernel. <br> 

#### depmod
The dependencies between modules are stored in the file *modules.dep*. <br>
That file is stored in */lib/modules/5.13.0-30-generic* (5.13.0-30-generic is my current kernel version. <br>
`depmod` creates a list of module dependencies (*modules.dep*) by reading each module under the current kernel version. <br>
`depmod` replaces the existing *modules.dep* with a newer version. <br>
`depmod -n` can be used to dry run, results will only be shown in *stdout*, not saved in a file. <br>
`depmod -A` performs a check on *modules.dep* and executed `depmod` only if new modules exist. <br>

### Kernel directories and files
#### /proc/sys/kernel
During runtime the kernel stores its config files in */proc/sys/kernel*. <br>
Config information can be gathered by using the `cat` command on the files in this folder. <br>

```sh
cat /proc/sys/kernel/osrelease
# > 5.13.0-30-generic

cat /proc/sys/kernel/ostype
# > Linux

cat /proc/sys/kernel/hostname
# > tiny

cat /proc/sys/kernel/modprobe
# > /sbin/modprobe
```

All changes to files in this directory will be lost after reboot, as they contain information loaded from memory. <br>

#### /usr/src
*/usr/src* contains the **source files** of available kernels in sub-directories for the appropriate kernel version. <br>

#### /boot
This directory contains everything required for the boot process except for configuration files not needed at boot time. <br>
The */boot* directory stores data that is used before the kernel begins executing user-mode programs. <br>
Programs necessary to arrange for the boot loader to be able to boot a file are placed in */sbin*. <br> 
Configuration files for boot loaders are placed in */etc*. <br>
The system kernel is located in either */* or */boot* (under Debian */boot* but is symbolically linked at */*). <br>
[Source: tldp.org](https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/boot.html)

### CPU info
#### lscpu
We can query cpu information with the command `lscpu`. <br>
`lscpu` will provide information about the system cpu, such as *model name, architecture or number of cores (CPU(S))*. <br>

### Pseudo-/Virtual-Filesystems
#### /proc
The */proc* directory is a **virtual directory** which is only available during runtime. <br>
It represents the currently running processes. Files and folders of this directory are stored in memory, not on the hard disk. <br>
When the system shuts down, the directory is deleted. Most files are only readable, there is no point in changing them. <br>
There are further directories in */proc* with **numbers as their names**. Those numbers are called **PIDs**, for *Process IDs*. <br>
Each started process has its own PID. There are also files in */proc* – for example *modules*, which lists all loaded kernel modules. <br>
#### /sys
The */sys* directory is also virtual, its content is only stored in memory. <br> 
It contains information of system hardware and kernel modules.  <br>

### Device filesystem
#### /dev
**dev** stands for **devices** – the */dev* directory is the **device diretory**. <br>
There is a lot of content in this directory .. <br>
* tty files (pre-fabricated consoles) [What is a TTY on Linux?](https://www.howtogeek.com/428174/what-is-a-tty-on-linux-and-how-to-use-the-tty-command/)
* dvd
* cdrom
* sda (hard disc) – hd partitions are named sda1, sda2, …
* sr0
#### udev
**udev** stands for **userspace dev** and is a program with which Linux automatically manages the device files in the */dev* directory. <br>
If e.g. a USB stick is plugged in, **udev** gets that information from the */sys* directory and reports this to the **dbus** system, that way a new device file in */dev* gets created. <br>
#### dbus
**dbus** is a program that sends messages back and forward between different applications and informs them about events. <br>
#### hotplug vs coldplug
A **hotplug** device is a hardware that can be connected to a system and be used immediately via runtime (like a USB stick). <br> 
A **coldplug** device is a hardware that can only be connected when the computer has been switched off. <br>

### Display ardware
#### lspci
The `lspci` command displays information about PCI buses in the system and devices connected to them. <br>
Notable is that `lspci` has **three levels of verbose**: <br>
* `lspci -v` will already provide you much more info as the pure `lspci`
* `lspci -vv` will add further displayed information to the output
* `lspci -vvv` will provide the most information available on the attached hardware

Example of the graphics card, displayed with pure `lspci`: <br>

```sh
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 630 (Desktop)
```

Compared to the most detailed view with `lspci -vvv`: <br>

```sh
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 630 (Desktop) (prog-if 00 [VGA controller])
	DeviceName: Onboard - Video
	Subsystem: Lenovo UHD Graphics 630 (Desktop)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 133
	Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at a0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 3000 [size=64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: i915
	Kernel modules: i915
```

`lspci -k` shows the PCI devices + the module they're using. So for our *VGA compatible controller* it looks like this: <br>

```sh
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 630 (Desktop)
	DeviceName: Onboard - Video
	Subsystem: Lenovo UHD Graphics 630 (Desktop)
	Kernel driver in use: i915
	Kernel modules: i915
```

#### lsusb
The `lsusb` command displays information about USB buses in the system and devices connected to them. <br>
The output of `lsusb` looks like this: <br>

```sh
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 006: ID 046d:0836 Logitech, Inc. B525 HD Webcam
Bus 001 Device 005: ID 05ac:0250 Apple, Inc. Aluminium Keyboard (ISO)
Bus 001 Device 004: ID 0b0e:245d GN Netcom 
Bus 001 Device 003: ID 046d:c069 Logitech, Inc. M-U0007 [Corded Mouse M500]
Bus 001 Device 002: ID 1a40:0101 Terminus Technology Inc. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

Now we can see which devices are connected to which USB Bus. <br>
If we want to restrict our search only to bus 2, we could do that with the **-s** option: <br>

```sh
$ lsusb -s 002:
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
```

Or could search only the 3rd device of bus 1, which is my corded mouse: <br>

```sh
$ lsusb -s 001:003
Bus 001 Device 003: ID 046d:c069 Logitech, Inc. M-U0007 [Corded Mouse M500]
```

There is also a **verbose** option `lsusb -v`. That option provides much more details on those devices. <br>
The output of the verbose version is actually quite huge. Here for example only the entry for the connected mouse: <br>

```sh
Bus 001 Device 003: ID 046d:c069 Logitech, Inc. M-U0007 [Corded Mouse M500]
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc069 M-U0007 [Corded Mouse M500]
  bcdDevice           56.01
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0022
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      71
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0006  1x 6 bytes
        bInterval              10
```

The shown ID contains two parts: The **vendor** and the **product** code. <br>
In our example *046d* is the code for *Logitech* and *c069* is the cord for that *corded mouse*. <br>
We can search for devices of a certain manufacturer with the option **-d**: <br>

```sh
$ lsusb -d 046d:
Bus 001 Device 006: ID 046d:0836 Logitech, Inc. B525 HD Webcam
Bus 001 Device 003: ID 046d:c069 Logitech, Inc. M-U0007 [Corded Mouse M500]
```

The colon has to be added in that case. If we know the product ID, we can search it by placing it on the other side of the colon: <br>

```sh
$ lsusb -d :0836
Bus 001 Device 006: ID 046d:0836 Logitech, Inc. B525 HD Webcam
```

An other notable option is `lsusb -t` – which will provide a tree view on available USB ports. <br>

## 101.2 Boot the system

### The boot process
BIOS–>MBR–>Bootloader–>Kernel–>InitialRamDisk–>init (PID 1) <br>
<br>
* the computer is turned on
* the BIOS performs simple hardware test (e.g. whether there is a hard disk)
* the BIOS looks in the Master Boot Record (MBR) for a Bootloader
* the Bootloader is a program responsible to start the Linux Kernel


