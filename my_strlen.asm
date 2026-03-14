section .text
        global _my_strlen

_my_strlen:
        xor rax, rax
.loop:
        cmp byte [rdi + rax], 0
        je .done
        inc rax
        jmp .loop
.done:
        ret
