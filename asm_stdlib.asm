; 平台符号兼容: Mach-O 符号加下划线前缀, ELF 不加; ELF 对动态符号调用使用 ..plt
%ifidn __OUTPUT_FORMAT__, macho64
section .text
        global _asm_stdlib_entry
        extern _printf
        extern _puts
        extern _strlen
        extern _strcpy
        extern _strcmp
        extern _malloc
        extern _free
        extern _atoi

_asm_stdlib_entry:
        push rbp
        mov rbp, rsp
        
        sub rsp, 32
        
        lea rdi, [rel msg_welcome]
        call _puts
        lea rdi, [rel msg_printf]
        mov rsi, 42
        mov rdx, 100
        xor eax, eax
        call _printf
        lea rdi, [rel test_string]
        call _strlen
        mov rsi, rax
        lea rdi, [rel msg_strlen]
        xor eax, eax
        call _printf
        lea rdi, [rel buffer]
        lea rsi, [rel source_string]
        call _strcpy
        lea rdi, [rel msg_strcpy]
        lea rsi, [rel buffer]
        xor eax, eax
        call _printf
        lea rdi, [rel str1]
        lea rsi, [rel str2]
        call _strcmp
        mov rsi, rax
        lea rdi, [rel msg_strcmp]
        xor eax, eax
        call _printf
        mov rdi, 64
        call _malloc
        test rax, rax
        jz .malloc_failed
        mov [rbp-8], rax
        
        mov byte [rax], 'A'
        mov byte [rax+1], 'S'
        mov byte [rax+2], 'M'
        mov byte [rax+3], 0
        
        lea rdi, [rel msg_malloc]
        mov rsi, rax
        xor eax, eax
        call _printf
        mov rdi, [rbp-8]
        call _free
        lea rdi, [rel msg_free]
        call _puts
        lea rdi, [rel number_str]
        call _atoi
        mov rsi, rax
        lea rdi, [rel msg_atoi]
        xor eax, eax
        call _printf
        xor eax, eax
        leave
        ret

.malloc_failed:
        lea rdi, [rel msg_malloc_fail]
        call _puts
        xor eax, eax
        leave
        ret

section .data
        msg_welcome db "=== Assembly calling C Standard Library ===", 0
        msg_printf db "printf: number=%d, second=%d", 10, 0
        msg_strlen db "strlen: 'Hello, Assembly!' length = %d", 10, 0
        msg_strcpy db "strcpy: copied '%s'", 10, 0
        msg_strcmp db "strcmp: result = %d", 10, 0
        msg_malloc db "malloc: allocated memory, first 3 bytes: %s", 10, 0
        msg_free db "free: memory released", 10, 0
        msg_atoi db "atoi: '12345' = %d", 10, 0
        msg_malloc_fail db "malloc: allocation failed!", 10, 0
        
        test_string db "Hello, Assembly!", 0
        source_string db "Copied from source", 0
        str1 db "hello", 0
        str2 db "hello", 0
        number_str db "12345", 0

section .bss
        buffer resb 64
%elifidn __OUTPUT_FORMAT__, elf64
section .text
        global asm_stdlib_entry
        extern printf
        extern puts
        extern strlen
        extern strcpy
        extern strcmp
        extern malloc
        extern free
        extern atoi

asm_stdlib_entry:
        push rbp
        mov rbp, rsp
        
        sub rsp, 32
        
        lea rdi, [rel msg_welcome]
        call puts wrt ..plt
        lea rdi, [rel msg_printf]
        mov rsi, 42
        mov rdx, 100
        xor eax, eax
        call printf wrt ..plt
        lea rdi, [rel test_string]
        call strlen wrt ..plt
        mov rsi, rax
        lea rdi, [rel msg_strlen]
        xor eax, eax
        call printf wrt ..plt
        lea rdi, [rel buffer]
        lea rsi, [rel source_string]
        call strcpy wrt ..plt
        lea rdi, [rel msg_strcpy]
        lea rsi, [rel buffer]
        xor eax, eax
        call printf wrt ..plt
        lea rdi, [rel str1]
        lea rsi, [rel str2]
        call strcmp wrt ..plt
        mov rsi, rax
        lea rdi, [rel msg_strcmp]
        xor eax, eax
        call printf wrt ..plt
        mov rdi, 64
        call malloc wrt ..plt
        test rax, rax
        jz .malloc_failed
        mov [rbp-8], rax
        
        mov byte [rax], 'A'
        mov byte [rax+1], 'S'
        mov byte [rax+2], 'M'
        mov byte [rax+3], 0
        
        lea rdi, [rel msg_malloc]
        mov rsi, rax
        xor eax, eax
        call printf wrt ..plt
        mov rdi, [rbp-8]
        call free wrt ..plt
        lea rdi, [rel msg_free]
        call puts wrt ..plt
        lea rdi, [rel number_str]
        call atoi wrt ..plt
        mov rsi, rax
        lea rdi, [rel msg_atoi]
        xor eax, eax
        call printf wrt ..plt
        xor eax, eax
        leave
        ret

.malloc_failed:
        lea rdi, [rel msg_malloc_fail]
        call puts wrt ..plt
        xor eax, eax
        leave
        ret

section .data
        msg_welcome db "=== Assembly calling C Standard Library ===", 0
        msg_printf db "printf: number=%d, second=%d", 10, 0
        msg_strlen db "strlen: 'Hello, Assembly!' length = %d", 10, 0
        msg_strcpy db "strcpy: copied '%s'", 10, 0
        msg_strcmp db "strcmp: result = %d", 10, 0
        msg_malloc db "malloc: allocated memory, first 3 bytes: %s", 10, 0
        msg_free db "free: memory released", 10, 0
        msg_atoi db "atoi: '12345' = %d", 10, 0
        msg_malloc_fail db "malloc: allocation failed!", 10, 0
        
        test_string db "Hello, Assembly!", 0
        source_string db "Copied from source", 0
        str1 db "hello", 0
        str2 db "hello", 0
        number_str db "12345", 0

section .bss
        buffer resb 64
%else
section .text
        global asm_stdlib_entry
        extern printf
        extern puts
        extern strlen
        extern strcpy
        extern strcmp
        extern malloc
        extern free
        extern atoi

asm_stdlib_entry:
        push rbp
        mov rbp, rsp
        
        sub rsp, 32
        
        lea rdi, [rel msg_welcome]
        call puts wrt ..plt
        lea rdi, [rel msg_printf]
        mov rsi, 42
        mov rdx, 100
        xor eax, eax
        call printf wrt ..plt
        lea rdi, [rel test_string]
        call strlen wrt ..plt
        mov rsi, rax
        lea rdi, [rel msg_strlen]
        xor eax, eax
        call printf wrt ..plt
        lea rdi, [rel buffer]
        lea rsi, [rel source_string]
        call strcpy wrt ..plt
        lea rdi, [rel msg_strcpy]
        lea rsi, [rel buffer]
        xor eax, eax
        call printf wrt ..plt
        lea rdi, [rel str1]
        lea rsi, [rel str2]
        call strcmp wrt ..plt
        mov rsi, rax
        lea rdi, [rel msg_strcmp]
        xor eax, eax
        call printf wrt ..plt
        mov rdi, 64
        call malloc wrt ..plt
        test rax, rax
        jz .malloc_failed
        mov [rbp-8], rax
        
        mov byte [rax], 'A'
        mov byte [rax+1], 'S'
        mov byte [rax+2], 'M'
        mov byte [rax+3], 0
        
        lea rdi, [rel msg_malloc]
        mov rsi, rax
        xor eax, eax
        call printf wrt ..plt
        mov rdi, [rbp-8]
        call free wrt ..plt
        lea rdi, [rel msg_free]
        call puts wrt ..plt
        lea rdi, [rel number_str]
        call atoi wrt ..plt
        mov rsi, rax
        lea rdi, [rel msg_atoi]
        xor eax, eax
        call printf wrt ..plt
        xor eax, eax
        leave
        ret

.malloc_failed:
        lea rdi, [rel msg_malloc_fail]
        call puts wrt ..plt
        xor eax, eax
        leave
        ret

section .data
        msg_welcome db "=== Assembly calling C Standard Library ===", 0
        msg_printf db "printf: number=%d, second=%d", 10, 0
        msg_strlen db "strlen: 'Hello, Assembly!' length = %d", 10, 0
        msg_strcpy db "strcpy: copied '%s'", 10, 0
        msg_strcmp db "strcmp: result = %d", 10, 0
        msg_malloc db "malloc: allocated memory, first 3 bytes: %s", 10, 0
        msg_free db "free: memory released", 10, 0
        msg_atoi db "atoi: '12345' = %d", 10, 0
        msg_malloc_fail db "malloc: allocation failed!", 10, 0
        
        test_string db "Hello, Assembly!", 0
        source_string db "Copied from source", 0
        str1 db "hello", 0
        str2 db "hello", 0
        number_str db "12345", 0

section .bss
        buffer resb 64
%endif
