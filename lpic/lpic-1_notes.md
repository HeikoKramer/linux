# LPIC-1 Notes
Notes I'm taking as a preparation for the LPIC-1 certificate. <br>
I'm using the [Rheinwerk LPIC-1 book by Harald Maaßen](https://www.rheinwerk-verlag.de/lpic-1-sicher-zur-erfolgreichen-linux-zertifizierung/) (German) and the [LPIC-1 - Linux System Administrator Masterclass](https://www.udemy.com/course/lpic-1-linux-system-administrator-masterclass/) Udemy course as the main source for my prep-work. <br>

## 101 System Architecture
The Linux kernel is the interface between hardware and software. <br>
Its architecture is **modular** – single components can be loaded / re-loaded during runtime, without re-loading the entire system. <br>
This is an advantage above *monolytic* kernels, which would require a complete re-load. <br>

### kernel version
#### uname
`uname -r` can be used to find the kernel version. <br>
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



