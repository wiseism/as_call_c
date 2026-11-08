; 平台符号兼容: Mach-O 符号加下划线前缀, ELF 不加; ELF 对动态符号调用使用 ..plt
%ifidn __OUTPUT_FORMAT__, macho64
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
%elifidn __OUTPUT_FORMAT__, elf64
section .text
        global my_strlen

my_strlen:
        xor rax, rax
.loop:
        cmp byte [rdi + rax], 0
        je .done
        inc rax
        jmp .loop
.done:
        ret
%else
section .text
        global my_strlen

my_strlen:
        xor rax, rax
.loop:
        cmp byte [rdi + rax], 0
        je .done
        inc rax
        jmp .loop
.done:
        ret
%endif
