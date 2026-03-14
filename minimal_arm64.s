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
    
    adrp    x1, msg_result@page
    add     x1, x1, msg_result@pageoff
    mov     x2, x0
    mov     x0, x1
    bl      _printf
    
    mul     x0, x19, x20
    
    adrp    x1, msg_multiply@page
    add     x1, x1, msg_multiply@pageoff
    mov     x2, x0
    mov     x0, x1
    bl      _printf
    
    mov     w0, #0
    ldp     x29, x30, [sp], #32
    ret

.data
msg_result:
    .asciz "Sum: %d\n"
msg_multiply:
    .asciz "Product: %d\n"
