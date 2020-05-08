bits 32

global _start

section .data
ask_number db 'Entrez un nombre : '
number_is_prime db 'Est un nombre premier', 10
number_is_not_prime db "N'est pas un nombre premier", 10



section .bss
    number              resb 255
    loop_iteration      resb 255
    divisor             resb 255


section .text
_msg1:
    enter   0,0
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, ask_number
    mov     edx, 19
    int     0x80
    leave
    ret


_msg2_not_prime:
enter   0,0
mov     eax, 4
mov     ebx, 1
mov     ecx, number_is_not_prime
mov     edx, 28
int     0x80
leave
ret


_msg2_prime:
enter   0,0
mov     eax, 4
mov     ebx, 1
mov     ecx, number_is_prime
mov     edx, 22
int     0x80
leave
ret


_print_number:
enter   0,0
mov     eax, 4
mov     ebx, 1
mov     ecx, number
mov     edx, 255
int     0x80
leave
ret   


_prime_checker:
    enter   0,0
    L1:
        cmp     ecx, 1
        je      _is_prime
        mov     [divisor], ecx
        push    ecx
        mov     edx, 0
        mov     eax, [loop_iteration]
        mov     ecx, [divisor]
        div     ecx
        pop     ecx
        cmp     edx, 0
        je      _is_not_prime
        loop    L1
    leave
    ret


_is_prime:
    enter   0,0
    call    _print_number
    call    _msg2_prime
    call    _exit
    leave
    ret


_is_not_prime:
    enter   0,0
    call    _print_number
    call    _msg2_not_prime
    call    _exit
    leave
    ret


_get_number:
    enter   0,0
    mov     eax, 3
    mov     ebx, 1
    mov     ecx, number
    mov     edx, 255
    int     0x80
    leave
    ret


_atoi:
    enter 0,0
    xor eax, eax
    mov edi, number
    _next_char:
        movzx   edx, byte[edi]
        sub     edx,'0'
        jb      _return
        cmp     edx, '9'
        ja      _return
        lea     eax, [eax*4+eax]
        lea     eax, [eax*2+edx]
        inc     edi
        jmp     _next_char
    _return:
        mov     [loop_iteration], eax
        leave
        ret


_exit:
    enter   0,0
    mov     eax, 1
    xor     ebx, ebx
    int     0x80


_start:
    enter   0,0
    call    _msg1
    call    _get_number
    call    _atoi
    mov     ecx, [loop_iteration]
    cmp     ecx, 0
    je      _is_prime
    cmp     ecx, 1
    je      _is_not_prime
    mov     edx, 0
    mov     eax, [loop_iteration]
    mov     ecx, 2
    div     ecx
    mov     ecx, eax
    call    _prime_checker
    call    _exit