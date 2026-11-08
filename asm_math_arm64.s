.text
.global _asm_math_entry
.extern _printf
.extern _puts
.extern _sin
.extern _cos
.extern _tan
.extern _sqrt
.extern _pow
.extern _fabs
.extern _floor
.extern _ceil
.extern _exp
.extern _log
.extern _log10

_asm_math_entry:
    stp     x29, x30, [sp, #-32]!
    mov     x29, sp
    
    adrp    x0, msg_welcome@page
    add     x0, x0, msg_welcome@pageoff
    bl      _puts
    
    adrp    x8, angle_45@page
    add     x8, x8, angle_45@pageoff
    ldr     d0, [x8]
    bl      _sin
    adrp    x0, msg_sin@page
    add     x0, x0, msg_sin@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, angle_45@page
    add     x8, x8, angle_45@pageoff
    ldr     d0, [x8]
    bl      _cos
    adrp    x0, msg_cos@page
    add     x0, x0, msg_cos@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, angle_45@page
    add     x8, x8, angle_45@pageoff
    ldr     d0, [x8]
    bl      _tan
    adrp    x0, msg_tan@page
    add     x0, x0, msg_tan@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, number_16@page
    add     x8, x8, number_16@pageoff
    ldr     d0, [x8]
    bl      _sqrt
    adrp    x0, msg_sqrt@page
    add     x0, x0, msg_sqrt@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, base_2@page
    add     x8, x8, base_2@pageoff
    ldr     d0, [x8]
    adrp    x8, exponent_10@page
    add     x8, x8, exponent_10@pageoff
    ldr     d1, [x8]
    bl      _pow
    adrp    x0, msg_pow@page
    add     x0, x0, msg_pow@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, neg_number@page
    add     x8, x8, neg_number@pageoff
    ldr     d0, [x8]
    bl      _fabs
    adrp    x0, msg_fabs@page
    add     x0, x0, msg_fabs@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, number_pi@page
    add     x8, x8, number_pi@pageoff
    ldr     d0, [x8]
    bl      _floor
    adrp    x0, msg_floor@page
    add     x0, x0, msg_floor@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, number_pi@page
    add     x8, x8, number_pi@pageoff
    ldr     d0, [x8]
    bl      _ceil
    adrp    x0, msg_ceil@page
    add     x0, x0, msg_ceil@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, number_1@page
    add     x8, x8, number_1@pageoff
    ldr     d0, [x8]
    bl      _exp
    adrp    x0, msg_exp@page
    add     x0, x0, msg_exp@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, number_e@page
    add     x8, x8, number_e@pageoff
    ldr     d0, [x8]
    bl      _log
    adrp    x0, msg_log@page
    add     x0, x0, msg_log@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    adrp    x8, number_100@page
    add     x8, x8, number_100@pageoff
    ldr     d0, [x8]
    bl      _log10
    adrp    x0, msg_log10@page
    add     x0, x0, msg_log10@pageoff
    sub     sp, sp, #16
    str     d0, [sp]
    bl      _printf
    add     sp, sp, #16
    
    mov     w0, #0
    ldp     x29, x30, [sp], #32
    ret

.data
msg_welcome:
    .asciz "=== Assembly calling C Math Library ==="
msg_sin:
    .asciz "sin(45 deg) = %.6f\n"
msg_cos:
    .asciz "cos(45 deg) = %.6f\n"
msg_tan:
    .asciz "tan(45 deg) = %.6f\n"
msg_sqrt:
    .asciz "sqrt(16) = %.6f\n"
msg_pow:
    .asciz "pow(2, 10) = %.6f\n"
msg_fabs:
    .asciz "fabs(-3.14) = %.6f\n"
msg_floor:
    .asciz "floor(3.14) = %.6f\n"
msg_ceil:
    .asciz "ceil(3.14) = %.6f\n"
msg_exp:
    .asciz "exp(1) = %.6f\n"
msg_log:
    .asciz "log(2.718) = %.6f\n"
msg_log10:
    .asciz "log10(100) = %.6f\n"

angle_45:
    .double 0.7853981634
number_16:
    .double 16.0
base_2:
    .double 2.0
exponent_10:
    .double 10.0
neg_number:
    .double -3.14
number_pi:
    .double 3.1415926535
number_1:
    .double 1.0
number_e:
    .double 2.718281828
number_100:
    .double 100.0
