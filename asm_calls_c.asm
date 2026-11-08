; 平台符号兼容: Mach-O 符号加下划线前缀, ELF 不加; ELF 对动态符号调用使用 ..plt
%ifidn __OUTPUT_FORMAT__, macho64
section .text
        global _main
        extern _printf
        extern _print_hello
        extern _print_number
        extern _add_numbers
        extern _print_string

_main:
        push rbp
        mov rbp, rsp
        
        sub rsp, 16
        
        call _print_hello
        mov rdi, 42
        call _print_number
        mov rdi, 10
        mov rsi, 20
        call _add_numbers
        mov rdi, rax
        call _print_number
        lea rdi, [rel msg]
        call _print_string
        mov rdi, 0
        call _printf
        xor eax, eax
        leave
        ret

section .data
        msg db "Assembly calling C functions!", 0
%elifidn __OUTPUT_FORMAT__, elf64
section .text
        global main
        extern printf
        extern print_hello
        extern print_number
        extern add_numbers
        extern print_string

main:
        push rbp
        mov rbp, rsp
        
        sub rsp, 16
        
        call print_hello wrt ..plt
        mov rdi, 42
        call print_number wrt ..plt
        mov rdi, 10
        mov rsi, 20
        call add_numbers wrt ..plt
        mov rdi, rax
        call print_number wrt ..plt
        lea rdi, [rel msg]
        call print_string wrt ..plt
        mov rdi, 0
        call printf wrt ..plt
        xor eax, eax
        leave
        ret

section .data
        msg db "Assembly calling C functions!", 0
%else
section .text
        global main
        extern printf
        extern print_hello
        extern print_number
        extern add_numbers
        extern print_string

main:
        push rbp
        mov rbp, rsp
        
        sub rsp, 16
        
        call print_hello wrt ..plt
        mov rdi, 42
        call print_number wrt ..plt
        mov rdi, 10
        mov rsi, 20
        call add_numbers wrt ..plt
        mov rdi, rax
        call print_number wrt ..plt
        lea rdi, [rel msg]
        call print_string wrt ..plt
        mov rdi, 0
        call printf wrt ..plt
        xor eax, eax
        leave
        ret

section .data
        msg db "Assembly calling C functions!", 0
%endif
