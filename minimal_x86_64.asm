; 平台符号兼容: Mach-O 符号加下划线前缀, ELF 不加; ELF 对动态符号调用使用 ..plt
%ifidn __OUTPUT_FORMAT__, macho64
section .text
        global _minimal_entry
        extern _printf

_minimal_entry:
        push rbp
        mov rbp, rsp
        
        sub rsp, 32
        
        mov qword [rbp-8], 10
        mov qword [rbp-16], 20
        mov qword [rbp-24], 30
        
        mov rax, [rbp-8]
        add rax, [rbp-16]
        add rax, [rbp-24]
        
        lea rdi, [rel msg_result]
        mov rsi, rax
        xor eax, eax
        call _printf
        mov rax, [rbp-8]
        imul rax, [rbp-16]
        
        lea rdi, [rel msg_multiply]
        mov rsi, rax
        xor eax, eax
        call _printf
        xor eax, eax
        leave
        ret

section .data
        msg_result db "Sum: %d", 10, 0
        msg_multiply db "Product: %d", 10, 0
%elifidn __OUTPUT_FORMAT__, elf64
section .text
        global minimal_entry
        extern printf

minimal_entry:
        push rbp
        mov rbp, rsp
        
        sub rsp, 32
        
        mov qword [rbp-8], 10
        mov qword [rbp-16], 20
        mov qword [rbp-24], 30
        
        mov rax, [rbp-8]
        add rax, [rbp-16]
        add rax, [rbp-24]
        
        lea rdi, [rel msg_result]
        mov rsi, rax
        xor eax, eax
        call printf wrt ..plt
        mov rax, [rbp-8]
        imul rax, [rbp-16]
        
        lea rdi, [rel msg_multiply]
        mov rsi, rax
        xor eax, eax
        call printf wrt ..plt
        xor eax, eax
        leave
        ret

section .data
        msg_result db "Sum: %d", 10, 0
        msg_multiply db "Product: %d", 10, 0
%else
section .text
        global minimal_entry
        extern printf

minimal_entry:
        push rbp
        mov rbp, rsp
        
        sub rsp, 32
        
        mov qword [rbp-8], 10
        mov qword [rbp-16], 20
        mov qword [rbp-24], 30
        
        mov rax, [rbp-8]
        add rax, [rbp-16]
        add rax, [rbp-24]
        
        lea rdi, [rel msg_result]
        mov rsi, rax
        xor eax, eax
        call printf wrt ..plt
        mov rax, [rbp-8]
        imul rax, [rbp-16]
        
        lea rdi, [rel msg_multiply]
        mov rsi, rax
        xor eax, eax
        call printf wrt ..plt
        xor eax, eax
        leave
        ret

section .data
        msg_result db "Sum: %d", 10, 0
        msg_multiply db "Product: %d", 10, 0
%endif
