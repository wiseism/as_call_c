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
