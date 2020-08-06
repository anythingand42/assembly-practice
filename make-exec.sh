#!/bin/bash

nasm -f elf -g -F dwarf $1.asm -o ./build/$1.o
ld -m elf_i386 ./build/$1.o -o ./build/$1
