# LPIC-1 Notes
Notes I'm taking as a preparation for the LPIC-1 certificate. <br>
I'm using the [Rheinwerk LPIC-1 book by Harald Maaßen](https://www.rheinwerk-verlag.de/lpic-1-sicher-zur-erfolgreichen-linux-zertifizierung/) (German) as the main source for my prep-work. <br>

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
`insmod` is a simple program to insert a module into the Linux Kernel. <br>
It requires the whole file path of the module that should be loaded into memory. <br>
`insmod` won't automatically load any dependencies. <br>
