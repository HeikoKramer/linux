# LPIC-1 Notes
Notes I'm taking as a preparation for the LPIC-1 certificate. <br>
I'm using the [Rheinwerk LPIC-1 book by Harald Maaßen](https://www.rheinwerk-verlag.de/lpic-1-sicher-zur-erfolgreichen-linux-zertifizierung/) (German) as the main source for my prep-work. <br>

## 101 System Architecture
The Linux kernel is the interface between hardware and software. <br>
Its architecture is **modular** – single components can be loaded / re-loaded during runtime, without re-loading the entire system. <br>
This is an advantage above *monolytic* kernels, which would require a complete re-load. <br>

### kernel version
`uname -r` can be used to find the kernel version. <br>
The directory */lib/modules* contains (this depends on the distro) the full history of former installed kernel versions. <br>
*/usr/src/* contains directories named after kernel version – which contain the source code of the appropriate kernel. <br>
<br>
A kernel version looks like this: *5.13.0-28-generic* <br>
* The first number (5) represents the **major release**.
* The second number (13) represents a **minor release**.
* The third number (0) represents the **patch level**.

Everything after the third number (-28-generic) is specified in the kernel's **make file** and has no fixed meaning (can be changed). <br>

