#!/bin/bash

nasm -f elf -g -F dwarf $1.asm -o ./build/$1.o
