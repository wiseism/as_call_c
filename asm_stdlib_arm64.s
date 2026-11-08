.text
.global _asm_stdlib_entry
.extern _printf
.extern _puts
.extern _strlen
.extern _strcpy
.extern _strcmp
.extern _malloc
.extern _free
.extern _atoi

_asm_stdlib_entry:
    stp     x29, x30, [sp, #-32]!
    mov     x29, sp
    
    adrp    x0, msg_welcome@page
    add     x0, x0, msg_welcome@pageoff
    bl      _puts
    
    adrp    x0, msg_printf@page
    add     x0, x0, msg_printf@pageoff
    sub     sp, sp, #16
    mov     x10, #42
    mov     x11, #100
    stp     x10, x11, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x0, test_string@page
    add     x0, x0, test_string@pageoff
    bl      _strlen
    mov     x10, x0
    adrp    x0, msg_strlen@page
    add     x0, x0, msg_strlen@pageoff
    sub     sp, sp, #16
    str     x10, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x0, buffer@page
    add     x0, x0, buffer@pageoff
    adrp    x1, source_string@page
    add     x1, x1, source_string@pageoff
    bl      _strcpy
    adrp    x10, buffer@page
    add     x10, x10, buffer@pageoff
    adrp    x0, msg_strcpy@page
    add     x0, x0, msg_strcpy@pageoff
    sub     sp, sp, #16
    str     x10, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x0, str1@page
    add     x0, x0, str1@pageoff
    adrp    x1, str2@page
    add     x1, x1, str2@pageoff
    bl      _strcmp
    mov     x10, x0
    adrp    x0, msg_strcmp@page
    add     x0, x0, msg_strcmp@pageoff
    sub     sp, sp, #16
    str     x10, [sp]
    bl      _printf
    add     sp, sp, #16
    
    mov     x0, #64
    bl      _malloc
    cbz     x0, .malloc_failed
    str     x0, [x29, #16]
    
    mov     w1, #'A'
    strb    w1, [x0]
    mov     w1, #'S'
    strb    w1, [x0, #1]
    mov     w1, #'M'
    strb    w1, [x0, #2]
    mov     w1, #0
    strb    w1, [x0, #3]
    
    adrp    x1, msg_malloc@page
    add     x1, x1, msg_malloc@pageoff
    mov     x0, x1
    bl      _printf
    
    ldr     x0, [x29, #16]
    bl      _free
    
    adrp    x0, msg_free@page
    add     x0, x0, msg_free@pageoff
    bl      _puts
    
    adrp    x0, number_str@page
    add     x0, x0, number_str@pageoff
    bl      _atoi
    mov     x10, x0
    adrp    x0, msg_atoi@page
    add     x0, x0, msg_atoi@pageoff
    sub     sp, sp, #16
    str     x10, [sp]
    bl      _printf
    add     sp, sp, #16
    
    mov     w0, #0
    ldp     x29, x30, [sp], #32
    ret

.malloc_failed:
    adrp    x0, msg_malloc_fail@page
    add     x0, x0, msg_malloc_fail@pageoff
    bl      _puts
    mov     w0, #0
    ldp     x29, x30, [sp], #32
    ret

.data
msg_welcome:
    .asciz "=== Assembly calling C Standard Library ==="
msg_printf:
    .asciz "printf: number=%d, second=%d\n"
msg_strlen:
    .asciz "strlen: 'Hello, Assembly!' length = %d\n"
msg_strcpy:
    .asciz "strcpy: copied '%s'\n"
msg_strcmp:
    .asciz "strcmp: result = %d\n"
msg_malloc:
    .asciz "malloc: allocated memory\n"
msg_free:
    .asciz "free: memory released\n"
msg_atoi:
    .asciz "atoi: '12345' = %d\n"
msg_malloc_fail:
    .asciz "malloc: allocation failed!\n"

test_string:
    .asciz "Hello, Assembly!"
source_string:
    .asciz "Copied from source"
str1:
    .asciz "hello"
str2:
    .asciz "hello"
number_str:
    .asciz "12345"

.bss
buffer:
    .space 64
