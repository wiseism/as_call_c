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
