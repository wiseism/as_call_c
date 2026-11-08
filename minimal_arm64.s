.text
.global _minimal_entry
.extern _printf

_minimal_entry:
    stp     x29, x30, [sp, #-32]!
    mov     x29, sp
    
    str     x19, [sp, #24]
    str     x20, [sp, #16]
    str     x21, [sp, #8]
    
    mov     x19, #10
    mov     x20, #20
    mov     x21, #30
    
    add     x0, x19, x20
    add     x0, x0, x21
    
    mov     x10, x0
    adrp    x0, msg_result@page
    add     x0, x0, msg_result@pageoff
    sub     sp, sp, #16
    str     x10, [sp]
    bl      _printf
    add     sp, sp, #16
    
    mul     x0, x19, x20
    
    mov     x10, x0
    adrp    x0, msg_multiply@page
    add     x0, x0, msg_multiply@pageoff
    sub     sp, sp, #16
    str     x10, [sp]
    bl      _printf
    add     sp, sp, #16
    
    mov     w0, #0
    ldp     x29, x30, [sp], #32
    ret

.data
msg_result:
    .asciz "Sum: %d\n"
msg_multiply:
    .asciz "Product: %d\n"
