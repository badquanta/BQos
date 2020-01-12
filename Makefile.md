# Makefile, UPPERS.mk, & lowers.mk

The Makefile is what it says it is.  UPPER CASE `.mk` files are where the project configuration is stored/computed and lower case `.mk` files are where the project rules are defined.



##### Conventions: Top level developer/uer Makefile "Goals" (aka:`Targets`)
###### `all` (aka:`default`)
The idea is to build the minimal useful thing.  I think at the moment it's just the bootable kernel image; usable with qemu or something.

###### `clean`
This will delete kernel files and iso files.
###### `mostlyclean`
This will delete the above and obj files.
###### `maintainer-clean`
This will reset the sysroot.
######  `dist-clean`
This will reset all ditributables.
###### `real-clean`
This will reset every EXCEPT the XBINUTILS and XGCC cross built envrionment.
###### `clobber`
This will delete everything within PREFIX??????????!? (whoa,whatifthats/usr?orsomethign?)
__WARNING:__
This will require a rebuild of GCC/BINUTILS which could take a long time!
##### Conventions: Variables

Top level ALL_CAPS variables without the below prefixes try to follow GNU standards.

Variables beginning with `X` define the GCC-Cross build environment;
a directory where all files within are expected to be for the target environment.

Variables beginning with `SYS` define the BQos filesystem "Root"; but this is also known as the GCC-Cross build `SYSROOT` directory; it is where files produced for the operating system, including the kernel, kernel and system headers, ready to use BQos libc and other libraries, user space programs, and configuration will reside.  This environment will be used to generate the distributable ISO, TAR, etc.

Within the `COMMON.mk` Makefile include, there are blank variables declared beginning with `ALL_`.  These define collections that will be added too by other various include files.  Then these collections will be used defined global rules in the Makefile.

Variables beginning with `DOC` define settings for documention generation. I plan on using doxygen.

##### `BQos.mk`, `LIBBQ.mk`, `LIBC.mk`, `LIBK.mk`

Top level "projects."  Each of these defines how to go about building them.  The order they need to be built:

1. `libc`'s headers must be copied to `XGCC`'s `configure`d `SYSROOT`
2. `XGCC` is `configure`d, `make`d, and `install`ed.
3. `libc` is actually `make`d and `install`ed now, using the fresh `XCC`.
4. `XGPP` is `make`d and `install`ed.
5. `libBQ` is `make`d and `install`ed.
6. `libk` is `make`d and `install`ed.
7. `BQos` is `make`d and `install`ed.

Make should resolve this order automatically.

##### `XBINUTILS.mk` & `XGCC.mk`

These define the process of building cross compilers for BQos.  I've followed the tutorials for defining a GNU target specific to BQos; and this will check out a version of BINUTILS & GCC project source code that includes this target.

The rest of the build system is designed assuming you use this target; but maybe it'll still work with just i386-elf??

##### `XGCC` & `LIBC`

XGCC needs to be built in a specific order vis-a-vis `libc`,