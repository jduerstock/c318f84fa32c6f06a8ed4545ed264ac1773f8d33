#!/bin/bash
m68k-linux-gnu-as -o boot.0003.o boot.0003.s
m68k-linux-gnu-ld --oformat=binary -e 0x00000000 -o boot.0003.bin boot.0003.o
sha1sum -c boot.0003.sha1
