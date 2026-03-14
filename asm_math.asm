section .text
        global _asm_math_entry
        extern _printf
        extern _puts
        extern _sin
        extern _cos
        extern _tan
        extern _sqrt
        extern _pow
        extern _fabs
        extern _floor
        extern _ceil
        extern _exp
        extern _log
        extern _log10

_asm_math_entry:
        push rbp
        mov rbp, rsp
        
        sub rsp, 32
        
        lea rdi, [rel msg_welcome]
        call _puts
        
        movsd xmm0, [rel angle_45]
        call _sin
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_sin]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel angle_45]
        call _cos
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_cos]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel angle_45]
        call _tan
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_tan]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel number_16]
        call _sqrt
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_sqrt]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel base_2]
        movsd xmm1, [rel exponent_10]
        call _pow
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_pow]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel neg_number]
        call _fabs
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_fabs]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel number_pi]
        call _floor
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_floor]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel number_pi]
        call _ceil
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_ceil]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel number_1]
        call _exp
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_exp]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel number_e]
        call _log
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_log]
        mov eax, 1
        call _printf
        
        movsd xmm0, [rel number_100]
        call _log10
        movsd [rbp-8], xmm0
        movsd xmm0, [rbp-8]
        lea rdi, [rel msg_log10]
        mov eax, 1
        call _printf
        
        xor eax, eax
        leave
        ret

section .data
        msg_welcome db "=== Assembly calling C Math Library ===", 0
        msg_sin db "sin(45 deg) = %.6f", 10, 0
        msg_cos db "cos(45 deg) = %.6f", 10, 0
        msg_tan db "tan(45 deg) = %.6f", 10, 0
        msg_sqrt db "sqrt(16) = %.6f", 10, 0
        msg_pow db "pow(2, 10) = %.6f", 10, 0
        msg_fabs db "fabs(-3.14) = %.6f", 10, 0
        msg_floor db "floor(3.14) = %.6f", 10, 0
        msg_ceil db "ceil(3.14) = %.6f", 10, 0
        msg_exp db "exp(1) = %.6f", 10, 0
        msg_log db "log(2.718) = %.6f", 10, 0
        msg_log10 db "log10(100) = %.6f", 10, 0
        
        angle_45 dq 0.7853981634
        number_16 dq 16.0
        base_2 dq 2.0
        exponent_10 dq 10.0
        neg_number dq -3.14
        number_pi dq 3.1415926535
        number_1 dq 1.0
        number_e dq 2.718281828
        number_100 dq 100.0
