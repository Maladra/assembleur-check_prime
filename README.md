nasm -f elf32 prime_checker.asm -o prime_checker.o
ld -m elf_i386 -o prime_checker prime_checker.o