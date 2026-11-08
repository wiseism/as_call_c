.text
.global _main
.global _asm_calls_c_entry
.extern _print_hello
.extern _print_number
.extern _add_numbers
.extern _print_string

_main:
_asm_calls_c_entry:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    bl      _print_hello
    
    mov     x0, #42
    bl      _print_number
    
    mov     x0, #10
    mov     x1, #20
    bl      _add_numbers
    mov     x0, x0
    bl      _print_number
    
    adrp    x0, msg@page
    add     x0, x0, msg@pageoff
    bl      _print_string
    
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret

.data
msg:
    .asciz "Assembly calling C functions!"
