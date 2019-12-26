# bqos-cross

This makefile include is for a Makefile that will
generate a cross compiler I used for bqos.

It will generate this cross compiler in an adjacent
directory named `../cross-i386-elf` which is referred to as the
`$PREFIX`.

Inside which it will download a version of GCC and BinUtils.
Compile both and install both to this directory.

The downloaded `.tar.gz` files of each will be in `$PREFIX/downloads`.  They will be each extracted into `$PREFIX/src/binutils-x.y.z/` and `$PREFIX/gcc-x.y.z/`.

Both will be configured to build inside directories within `$PREFIX/build/binutils-x.y.z`... etc.  Inside said build directories both will be built.  Then both will be "installed" to `$PREFIX/` so that `$PREFIX/bin` can be added to `$PATH`.

The idea is that I can rebuild the compiler easily and maybe support the generation of multipule compiler targets in the future (thinking ARM/Raspberry Pi/etc.)

To see details of implementation, read the [Makefile](./Makefile)