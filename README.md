# DO NOT USE THIS OPERATING SYSTEM
you've been warned. I don't know what I'm doing.
It doesn't work. 

Feedback is welcome.

## About BQos

The goal is to learn.  I've programmed a lot; but rarely in C or C++.  This will force me to learn things from the ground up.

My current implementation goals are:

# Status

Barely boots.

## Upcoming:

More functions.

# How to build:

        someone@somewhere:~/.../BQos$ make

### Running the OS

        someone@somewhere:~/.../BQos$ make run-BQos-KERNEL

Or one can run:

        someone@somewhere:~/.../BQos$ make run-BQos-iso

which will run the operating system. Which one should probably not do. As I have no idea what will happen.

##### On real hardware.

One should never use this command:

        someone@somewhere:~/.../BQos$ dd if=../BQos-i386-elf.iso of=/dev/sdXXX bs=1M

because that would destroy any data on said "/dev/sdXXX" block device and write an iso image that may damage any hardware it is later inserted and then booted to.


## Tutorials followed:

unless otherwise stated these are from [OSDev](OSDev.org)

 * [Getting started.](https://wiki.osdev.org/Getting_Started)
 * [Bare Bones](https://wiki.osdev.org/Bare_Bones)
 * [Meaty Skeleton](https://wiki.osdev.org/Meaty_Skeleton)
 * [GCC Cross Compiler](https://wiki.osdev.org/Hosted_GCC_Cross-Compiler)

## References
 * [ELF (Executable and Linkable Format)](https://wiki.osdev.org/ELF)
 * [Protected Mode (x86-32)](https://wiki.osdev.org/Protected_Mode)
 * [Long Mode (x86-64)](https://wiki.osdev.org/Long_Mode)
 * [Beginner Mistakes](https://wiki.osdev.org/Beginner_Mistakes)
 

 [Real Mode][https://wiki.osdev.org/Real_Mode]

 [Real Mode][https://wiki.osdev.org/Real_Mode]
 https://wiki.osdev.org/Unreal_Mode


 #### Way future topics:
[ELF details pdf](http://www.skyfree.org/linux/references/ELF_Format.pdf)
 [Modular Kernel](https://wiki.osdev.org/Modular_Kernel)